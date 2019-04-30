package cn.wuxia.project.admin.view.auth.web;

import java.awt.*;
import java.io.UnsupportedEncodingException;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.common.support.Constants;
import cn.wuxia.common.util.EncodeUtils;
import cn.wuxia.common.util.PropertiesUtils;
import cn.wuxia.project.security.core.user.entity.AdminUser;
import cn.wuxia.project.security.core.user.service.AdminUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Maps;

import cn.wuxia.common.util.StringUtil;
import nl.captcha.Captcha;
import nl.captcha.backgrounds.GradiatedBackgroundProducer;
import nl.captcha.gimpy.BlockGimpyRenderer;
import nl.captcha.noise.StraightLineNoiseProducer;
import nl.captcha.servlet.CaptchaServletUtil;

@Controller("extendsAuthController")
@RequestMapping("/auth/*")
public class AuthController extends BaseController {
    private Properties prop = PropertiesUtils.loadProperties("classpath:/security.properties");

    private String loginUrl = prop.getProperty("cas.loginUrl");

    private String casReturn = prop.getProperty("cas.service");

    private String platform = prop.getProperty("cas.platform");

    @Autowired
    private AdminUserService userDoctorService;

    // 进入注册页面
    @RequestMapping(value = "/register")
    public String register(Model model) {
        return "auth/register";
    }

    // 进入忘记/重置密码页面
    @RequestMapping(value = "/pwreset")
    public String resePassword() {
        return "auth/pwreset";
    }

    /**
     * 检查手机是否已注册
     * 
     * @author songlin.li
     * @param mobile
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/mobile/uniqe")
    @ResponseBody
    public boolean checkUniqueMobile(@RequestParam(required = true) String mobile, String oldmobile) {
        if (StringUtil.equalsIgnoreCase(mobile, oldmobile) && StringUtil.isNotBlank(oldmobile)) {
            return true;
        }
        if (StringUtil.isEmpty(mobile)) {
            return false;
        } else {
            Pattern pattern = Pattern.compile(Constants.MOBILE_PATTERN);
            Matcher matcher = pattern.matcher(mobile);
            if (!matcher.matches()) {
                return false;
            } else {
                AdminUser user = userDoctorService.findByMobile(getWxAppid(), mobile);
                if (user != null) {
                    return false;
                }
            }
        }
        return true;
    }

    /**
     * 检查手机是否已注册
     * 
     * @author huangzhihua
     * @param mobile
     * @param oldUserMobile
     *            若旧手机号不是当前登录账户的手机号，就要输入
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/mobile/verify")
    @ResponseBody
    public Map<String, String> checkUniqueMobile(Model model, @RequestParam(required = false) String mobile,
            @RequestParam(required = false) String oldUserMobile) {
        Map<String, String> retMap = Maps.newHashMap();
        String code = "00000";
        String msg = "";
        if (StringUtil.isEmpty(mobile)) {
            // return "请输入手机号";
            // throw new AppWebException("请输入手机号");
            code = "00001";
            msg = "请输入手机号！";
        } else {
            Pattern pattern = Pattern.compile(Constants.MOBILE_PATTERN);
            Matcher matcher = pattern.matcher(mobile);
            if (!matcher.matches()) {
                // throw new AppWebException("您输入的手机号格式有误！");
                code = "00001";
                msg = "您输入的手机号格式有误！";
            } else {
                AdminUser user = userDoctorService.findByMobile(getWxAppid(), mobile);
                if (user != null) {
                    // throw new AppWebException("此手机号已被使用，请重新输入");
                    code = "00001";
                    msg = "此手机号已被使用，请重新输入!";
                }
            }
        }

        retMap.put("code", code);
        retMap.put("msg", msg);
        return retMap;
    }

    public static final String PRE_ = "verifyMobileCode_";

    private static final String TIMES_ = "SEND_TIME_TIMES_";

    /**
     * 检查手机验证码是否正确
     * 
     * @author huangzhihua
     * @param mobile
     * @param oldUserMobile
     *            若旧手机号不是当前登录账户的手机号，就要输入
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/captcha/verify")
    @ResponseBody
    public Map<String, String> checkVerifyCode(HttpSession session, @RequestParam(required = false) String mobile,
            @RequestParam(required = false) String verifycode) throws UnsupportedEncodingException {
        Map<String, String> retMap = Maps.newHashMap();
        if (StringUtil.isBlank(verifycode)) {
            retMap.put("code", "00001");
            retMap.put("msg", "请输入验证码！");
            return retMap;
        }
        String verifyCode = (String) session.getAttribute("verifyMobileCode_" + mobile);
        if (StringUtil.isBlank(verifyCode)) {
            retMap.put("code", "00001");
            retMap.put("msg", "请检查接收验证码的手机是否已改变！");
            return retMap;
        }
        String[] verifyMobileCode = StringUtil.split(verifyCode, "#");
        String sessionCode = verifyMobileCode[0];
        // long rong = Long.parseLong(verifyMobileCode[1]);
        if (StringUtil.isBlank(verifyCode)) {
            retMap.put("code", "00001");
            retMap.put("msg", "您的验证码已经失效！");
            return retMap;
        }
        if (!StringUtil.equalsIgnoreCase(verifycode, sessionCode)) {
            retMap.put("code", "00001");
            retMap.put("msg", "您的验证码错误！");
            return retMap;
        }
        retMap.put("code", "00000");
        return retMap;
    }

    /**
     * 注册的验证码
     * @param session
     * @param resp
     * @author Wind.Zhao
     * @date 2015/06/12
     */
    @RequestMapping(value = "/genRegisterVerifyCode", method = RequestMethod.GET)
    public void registerVerifyCode(HttpSession session, HttpServletResponse resp) {
        Captcha.Builder builder = new Captcha.Builder(160, 50);
        GradiatedBackgroundProducer gbp = new GradiatedBackgroundProducer();
        gbp.setFromColor(Color.LIGHT_GRAY);
        gbp.setToColor(Color.WHITE);
        builder.addBackground(gbp);
        builder.addNoise(new StraightLineNoiseProducer(new Color(251, 91, 3), 3));
        // 字体边框齿轮效果 默认是3
        builder.gimp(new BlockGimpyRenderer(-10));
        Captcha captcha = builder.addText().build();
        CaptchaServletUtil.writeImage(resp, captcha.getImage());
        session.setAttribute("register_captcha", captcha);
    }

    /**
     * 检测注册验证码是否正确
     * @param verifycode 控件生成的验证码
     * @param answer 用户填写的验证码
     * @return 成功返回true，是否返回false
     * @author Wind.Zhao
     * @date 2015/06/12
     */
    @RequestMapping(value = "/checkRegisterVerifyCode", method = RequestMethod.POST)
    public @ResponseBody boolean checkRegisterVerifyCode(HttpSession htp, String verifycode) {
        Captcha cap = (Captcha) request.getSession().getAttribute("register_captcha");
        boolean checkResult = false;
        if (cap != null)
            checkResult = StringUtil.equalsIgnoreCase(cap.getAnswer().toLowerCase(), verifycode.toLowerCase());
        return checkResult;
    }


    @RequestMapping("changepassword")
    public String toChangePassword() {
        return "/auth/changePassword";
    }

    /***
     * 注册
     * @author huangzhihua
     * @param request
     * @param session
     * @param model
     * @param rv
     * @return
     */
//    @RequestMapping(value = "/register/submit", method = { RequestMethod.POST, RequestMethod.GET })
//    public String doRegister(HttpServletRequest request, HttpSession session, Model model, RegisterVo rv, RedirectAttributes ra) {
//
//        RegisterDoctorDto dto = new RegisterDoctorDto();
//        BeanUtils.copyProperties(rv, dto);
//
//        String errorMsg = "";
//        try {
//            logger.info("注册手机号码：" + rv.getMobile());
//            if (StringUtil.isNotBlank(rv.getMobile())) {
//                /*
//                 * TODO 暂无需短信验证码验证注册
//                 * String verifyCode = (String) session.getAttribute("verifyMobileCode_" + rv.getMobile());
//                if (StringUtil.isBlank(verifyCode)) {
//                    errorMsg = "请检查接收验证码的手机是否已改变！";
//                    throw new AppWebException("请检查接收验证码的手机是否已改变！");
//                }
//                String[] verifyMobileCode = StringUtil.split(verifyCode, "#");
//                String sessionCode = verifyMobileCode[0];
//                //            long rong = Long.parseLong(verifyMobileCode[1]);
//                if (StringUtil.isBlank(verifyCode)) {
//                    errorMsg = "您的短信验证码已经失效！";
//                    throw new AppWebException("您的短信验证码已经失效！");
//                }
//                if (!StringUtil.equalsIgnoreCase(rv.getVerifycode(), sessionCode)) {
//                    errorMsg = "您的短信验证码错误！";
//                    throw new AppWebException("您的短信验证码错误！");
//                }*/
//            }
//            /* Captcha cap = (Captcha) request.getSession().getAttribute("register_captcha");
//            if (cap != null) {
//                if (!StringUtil.equalsIgnoreCase(cap.getAnswer().toLowerCase(), rv.getRegisterVerifyCode().toLowerCase())) {
//                    errorMsg = "您的验证码错误！";
//                    throw new AppWebException("您的验证码错误！");
//                }
//            } else {
//                errorMsg = "请输入验证码！";
//                throw new AppWebException("请输入验证码！");
//            }*/
//            /**
//             * 如果为微信授权用户，则获取微信用户基础信息
//             */
//            /*if (StringUtil.isNotBlank(LoginUtil.getOpenId(request))) {
//                //LoginUtil.au
//                //dto.setOpenid(LoginUtil.getOpenId(request));
//                //pc端注册的openId保存在pc端的openId字段
//                dto.setPcOpenId(LoginUtil.getOpenId(request));
//                OAuthTokeVo oauthToken = (OAuthTokeVo) request.getSession().getAttribute("oauthToken");
//                if (oauthToken != null) {
//                    try {
//                        AuthUserInfoBean authInfo = LoginUtil.getAuthUserInfo(oauthToken);
//                        dto.setDisplayName(authInfo.getNickname());
//                        dto.setCity(authInfo.getCity());
//                        dto.setLogo(authInfo.getHeadimgurl());
//                        dto.setUnionId(authInfo.getUnionid());
//                        switch (authInfo.getSex()) {
//                            case MAN:
//                                dto.setGender(UserGenderEnum.MEN);
//                                break;
//                            case WOMEN:
//                                dto.setGender(UserGenderEnum.WOMEN);
//                                break;
//                            default: {
//                                break;
//                            }
//                        }
//                    } catch (Exception e) {
//                        logger.warn("微信基础数据无法获取", e);
//                    }
//                }
//            }*/
//
//            // 注册账号同时推送到CAS
//            userDoctorService.registerUser(dto);
//
//            // 完成注册之后失效改验证码
//            session.removeAttribute("verifyMobileCode_" + rv.getMobile());
//            //        Msg.info("您已成功注册，欢迎加入分豆豆大家庭！");
//            return autologin(rv.getMobile(), rv.getPassword(), false);
//        } catch (Exception e) {
//            //e.printStackTrace();
//            logger.error("PC端注册异常：" + e.getMessage());
//            if (StringUtils.isBlank(errorMsg)) {
//                errorMsg = "您注册失败了，手机号已存在。";
//            }
//            ra.addAttribute("errorMsg", errorMsg);
//            return "redirect:/auth/register";
//        }
//
//    }

    /**
     * 用户自动登录功能，分两种情况，微信授权登录和非费心授权登录
     * 1）微信授权登录，isWeChatLogin为true， username则为casUserId，否则为mobile
     * @param username 该值为casUserId或mobile
     * @param password 登录密码
     * @param isWeChatLogin 是否微信登录，true为是，false为否
     * @return 返回登录成功后的页面
     * @author Wind.Zhao
     * @date 2015/08/21
     */
    @RequestMapping(value = "/autologin", method = { RequestMethod.POST, RequestMethod.GET })
    public String autologin(String username, String password, boolean isWeChatLogin) {
        //自动登录至用户中心
        String serverUrl = prop.getProperty("cas.serverUrl");
        int end = StringUtil.indexOf(casReturn, "/", 3);
        String loginSuccessUrl = StringUtil.substring(casReturn, 0, end) + prop.getProperty("loginSuccessUrl");
        if (!isWeChatLogin) {
            //FIXME 临时采用简单encode方式加密
            password = EncodeUtils.hexEncode(EncodeUtils.base64UrlSafeEncode(password.getBytes()).getBytes());
            return "redirect:" + serverUrl + "registerLogin?username=" + username + "&password=" + password + "&service=" + loginSuccessUrl;
        } else {
            //微信用户密码为随意字符但不能为空
            return "redirect:" + serverUrl + "registerLogin?username=" + username + "&password=wechat&service=" + loginSuccessUrl;
        }
    }

    /**
     * 检查手机是否已注册
     *
     * @author 金
     * @param mobile
     * @param oldUserMobile
     *            若旧手机号不是当前登录账户的手机号，就要输入
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/mobile/checkUniqueMobile")
    @ResponseBody
    public boolean checkUniqueMobile(Model model, String mobile) {
        boolean result = false;
        if (StringUtil.isNotBlank(mobile)) {
            Pattern pattern = Pattern.compile(Constants.MOBILE_PATTERN);
            Matcher matcher = pattern.matcher(mobile);
            if (matcher.matches()) {
                AdminUser user = userDoctorService.findByMobile(getWxAppid(), mobile);
                if (user == null) {
                    result = true;
                }
            }
        }
        return result;
    }

    /**
     * 检查手机验证码是否正确
     *
     * @author 金
     * @param mobile
     * @param oldUserMobile
     *            若旧手机号不是当前登录账户的手机号，就要输入
     * @return
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/captcha/checkVerifyCode")
    @ResponseBody
    public boolean checkVerifyCode(String mobile, String verifycode) throws UnsupportedEncodingException {
        boolean result = false;
        if (StringUtil.isNotBlank(verifycode)) {
            String verifyCode = (String) request.getSession().getAttribute("verifyMobileCode_" + mobile);
            if (StringUtil.isNotBlank(verifyCode)) {
                String[] verifyMobileCode = StringUtil.split(verifyCode, "#");
                String sessionCode = verifyMobileCode[0];
                if (StringUtil.equalsIgnoreCase(verifycode, sessionCode)) {
                    result = true;
                }
            }
        }
        return result;
    }

    /**
     * 检查手机用户是否存在
     *
     * @author 金
     * @param mobile
     * @return
     */
    @RequestMapping(value = "/mobile/checkMobileisTrue")
    @ResponseBody
    public boolean checkMobileisTrue(String mobile) {
        boolean result = false;
        if (StringUtil.isNotBlank(mobile)) {
            Pattern pattern = Pattern.compile(Constants.MOBILE_PATTERN);
            Matcher matcher = pattern.matcher(mobile);
            if (matcher.matches()) {
                AdminUser user = userDoctorService.findByMobile(getWxAppid(), mobile);
                if (user != null) {
                    result = true;
                }
            }
        }
        return result;
    }
}
