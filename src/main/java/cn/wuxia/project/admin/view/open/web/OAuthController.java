package cn.wuxia.project.admin.view.open.web;

import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.util.StringUtil;
import cn.wuxia.common.util.reflection.BeanUtil;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.security.common.MyUserDetails;
import cn.wuxia.project.security.common.SpringSecurityUtils;
import cn.wuxia.project.security.core.user.entity.AdminUser;
import cn.wuxia.project.security.core.user.service.AdminUserService;
import cn.wuxia.project.weixin.core.open.entity.AuthorizerAccount;
import cn.wuxia.project.weixin.core.open.service.AuthorizerAccountService;
import cn.wuxia.wechat.WeChatException;
import cn.wuxia.wechat.open.util.ProxyOAuthUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

/**
 * 网页授权
 * [ticket id]
 * Description of the class
 *
 * @author guwen
 * @ Version : V<Ver.No> <2015年6月19日>
 */
@RequestMapping(value = "/wxopen/oauth/*")
@Controller
public class OAuthController extends BaseController {

    @Autowired
    private AuthorizerAccountService authAccountService;

    @Autowired
    private AdminUserService doctorService;

    /**
     * 公众号授权列表
     *
     * @author songlin.li
     */
    @RequestMapping(value = "/list")
    public String list(Model model) {
        Pages pages = authAccountService.findAll(new Pages<>(1, 15));

        request.setAttribute("pages", pages);

        return "/open/oauthlist";
    }

    /**
     * 公众号授权信息
     *
     * @author guwen
     */
    @RequestMapping(value = "/edit/{id}")
    public String edit(Model model, @PathVariable String id) {
        AuthorizerAccount authAccount = authAccountService.findById(id);
        if (authAccount == null || StringUtil.isBlank(authAccount.getAuthorizerRefreshToken())) {
            AdminUser us = doctorService.findById(((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid());
            model.addAttribute("user", us);
            return "/open/oauth";
        }
        request.setAttribute("account", authAccount);
        return "/open/detail";
    }

    /**
     * 保存公众号授权信息
     *
     * @author guwen
     */
    @RequestMapping(value = "/submit")
    public String edit(Model model, AuthorizerAccount authAccount) {
        AuthorizerAccount sourceAccount = authAccountService.findById(authAccount.getId());
        BeanUtil.copyPropertiesWithoutNullValues(sourceAccount, authAccount);
        authAccountService.save(sourceAccount);
        return "redirect:/wxopen/oauth/list";
    }

    /**
     * 重定向到 公众平台授权给第三方平台 页面
     *
     * @return
     * @throws WeChatException
     * @throws IOException
     * @throws UnsupportedEncodingException
     * @author Administrator
     */
    @RequestMapping(value = "/create")
    public String jumpAccountOAuth(Model model, String ticketValue) throws IOException, WeChatException {
        String redirectUri = getServerHttpPath() + "/wxopen/oauth/authback";
        logger.info("redirectUri:" + redirectUri);
        String url = ProxyOAuthUtil.genAccountOAuthUrl(redirectUri);
        logger.info("url:" + url);
        model.addAttribute("jumpOauthUrl", url);
        return "open/gotoOauth";
    }

    /**
     * 公众平台授权给第三方平台
     */
    @RequestMapping(value = "/authback")
    public String accountAuth(String auth_code, Integer expires_in) {
        logger.info("参数:" + request.getQueryString());
        AuthorizerAccount authorizerAccount = authAccountService.addAuthorizerAccount(auth_code, request.getServerName());
        return "redirect:/wxopen/oauth/edit/" + authorizerAccount.getId();
    }

    /////////////////////

    /**
     * 重定向到OAuth页面
     * @author Administrator
     * @return
     * @throws UnsupportedEncodingException
     */
    /* @RequestMapping(value = "/jumpoauth")
     public String jumpOAuth() throws UnsupportedEncodingException {
         String redirectUri = PropertiesUtils.getPropertiesValue("ctx.fdd")+"/oauth/getcode";
         logger.info("redirectUri:"+redirectUri);
         String url = OAuthUtil.genOAuthUrl(redirectUri, "wx8c625ac17367e886");     // APPID 固定,将改为数据库保存
         logger.info("url:"+url);
         return "redirect:" + url; 
     }*/

    /**
     * 得到code
     */
    /*@RequestMapping(value = "/getcode")
    public String getCode(String code) {
        logger.info("参数:"+request.getQueryString());
        logger.info("code:"+code);
        return PropertiesUtils.getPropertiesValue("ctx.fdd");
    }*/
}
