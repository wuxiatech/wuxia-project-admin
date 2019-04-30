/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.view.admin.web;

import cn.wuxia.project.admin.view.auth.bean.RegisterVo;
import cn.wuxia.project.basic.api.WsApiMethodEnum;
import cn.wuxia.project.basic.api.WsApiUtil;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.exception.AppWebException;
import cn.wuxia.common.orm.query.Conditions;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.orm.query.Sort;
import cn.wuxia.common.util.StringUtil;
import cn.wuxia.common.util.reflection.BeanUtil;
import cn.wuxia.project.security.common.MyUserDetails;
import cn.wuxia.project.security.common.SpringSecurityUtils;
import cn.wuxia.project.security.core.user.bean.RegisterUserDto;
import cn.wuxia.project.security.core.user.entity.AdminUser;
import cn.wuxia.project.security.core.user.enums.UserTypeEnum;
import cn.wuxia.project.security.core.user.service.AdminUserService;
import cn.wuxia.project.security.core.user.service.DepartmentService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/admin/user/**")
public class AdminController extends BaseController {

    @Autowired
    private AdminUserService adminUserService;


    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "list", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model, Pages page) {
        page = page == null ? new Pages(15) : page;
        if (page.getPageSize() < 0) {
            page.setPageSize(15);
        }
//        page.addCondition(new Conditions("isObsoleteDate", MatchType.ISN, null));
        page.addCondition(new Conditions("type", UserTypeEnum.NORMAL.name()));
//        page.addCondition(new Conditions("appid", getWxAppid()));
        page = adminUserService.findForUserList(page);
        model.addAttribute("pages", page);
        return "admin/list";

    }


    @RequestMapping(value = "locklist", method = {RequestMethod.GET, RequestMethod.POST})
    public String lockuserList(Model model, Pages page) {
        page = page == null ? new Pages(15) : page;
        if (page.getPageSize() < 0) {
            page.setPageSize(15);
        }
        page.addCondition(new Conditions("type", UserTypeEnum.NORMAL.name()));
//        page.addCondition(new Conditions("appid", getWxAppid()));
        page.setSort(new Sort(Sort.Direction.DESC, "is_obsolete_date"));
        page = adminUserService.findLockUser(page);
        model.addAttribute("pages", page);
        return "admin/locklist";
    }


    /**
     * 医生修改个人资料
     *
     * @param model
     * @return
     * @author songlin
     */
    @RequestMapping(value = "profile", method = RequestMethod.GET)
    public String profile(Model model) {
        return edit(model, ((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid(), true);
    }

    @RequestMapping(value = "edit/{id}", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable String id, boolean profile) {
        AdminUser ud = adminUserService.findById(id);
        RegisterVo rv = new RegisterVo();
        BeanUtil.copyProperties(rv, ud);
        model.addAttribute("userInfo", rv);
        model.addAttribute("profile", profile);
        model.addAttribute("depts", departmentService.findAll(getWxAppid()));
        return "admin/edit";
    }

    @RequestMapping(value = "delete/{id}", method = RequestMethod.GET)
    public @ResponseBody
    String delete(Model model, @PathVariable String id) throws AppWebException {
        AdminUser ud = adminUserService.deleteDoctor(id);


        return "success";
    }

    @RequestMapping(value = "fallbackdel/{id}", method = RequestMethod.GET)
    public @ResponseBody
    String fallbackdel(Model model, @PathVariable String id) {
        AdminUser ud = adminUserService.fallbackDeleteDoctor(id);
        return "success";
    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(Model model) {
        model.addAttribute("depts", departmentService.findAll(getWxAppid()));
        return "admin/create";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public void saveEdit(RegisterVo rv) {
        RegisterUserDto dto = new RegisterUserDto();
        BeanUtil.copyPropertiesWithoutNullValues(dto, rv);
        dto.setAppid(getWxAppid());
        adminUserService.updateInfo(dto);
    }

    @RequestMapping(value = "changepw", method = RequestMethod.POST)
    @ResponseBody
    public void changepw(RegisterVo rv) {
        if (!StringUtil.equalsIgnoreCase(rv.getPassword(), rv.getRepassword())) {
            throw new AppWebException("两次输入的密码不一致！");
        }
        RegisterUserDto dto = new RegisterUserDto();
        BeanUtil.copyPropertiesWithoutNullValues(dto, rv);
        /**
         * 临时借用这个字段存储
         */
        dto.setDescription(rv.getOldpassword());
        adminUserService.updatePasswd(dto);
    }

    /***
     * 注册
     *
     * @author songlin.li
     * @param request
     * @param session
     * @param model
     * @param rv
     * @return
     */
    @RequestMapping(value = "register/submit", method = {RequestMethod.POST, RequestMethod.GET})
    public String doRegister(HttpServletRequest request, HttpSession session, Model model, RegisterVo rv, RedirectAttributes ra) throws Exception {

        RegisterUserDto dto = new RegisterUserDto();
        BeanUtils.copyProperties(rv, dto);
        dto.setType(rv.getType());
        dto.setAppid(getWxAppid());
        String errorMsg = "";
        logger.info("注册手机号码：" + rv.getMobile());
        if (StringUtil.isNotBlank(rv.getMobile())) {
            /*
             * TODO 暂无需短信验证码验证注册 String verifyCode = (String)
             * session.getAttribute("verifyMobileCode_" + rv.getMobile()); if
             * (StringUtil.isBlank(verifyCode)) { errorMsg =
             * "请检查接收验证码的手机是否已改变！"; throw new
             * AppWebException("请检查接收验证码的手机是否已改变！"); } String[] verifyMobileCode
             * = StringUtil.split(verifyCode, "#"); String sessionCode =
             * verifyMobileCode[0]; // long rong =
             * Long.parseLong(verifyMobileCode[1]); if
             * (StringUtil.isBlank(verifyCode)) { errorMsg = "您的短信验证码已经失效！";
             * throw new AppWebException("您的短信验证码已经失效！"); } if
             * (!StringUtil.equalsIgnoreCase(rv.getVerifycode(), sessionCode)) {
             * errorMsg = "您的短信验证码错误！"; throw new AppWebException("您的短信验证码错误！");
             * }
             */
        }
        /*
         * Captcha cap = (Captcha)
         * request.getSession().getAttribute("register_captcha"); if (cap !=
         * null) { if
         * (!StringUtil.equalsIgnoreCase(cap.getAnswer().toLowerCase(),
         * rv.getRegisterVerifyCode().toLowerCase())) { errorMsg = "您的验证码错误！";
         * throw new AppWebException("您的验证码错误！"); } } else { errorMsg =
         * "请输入验证码！"; throw new AppWebException("请输入验证码！"); }
         */

        session.removeAttribute("verifyMobileCode_" + rv.getMobile());

        AdminUser user = adminUserService.registerUser(dto);
//            PatientGroupDto groupDto = new PatientGroupDto();
//            groupDto.setDoctorId(dto.getId());
//            groupDto.setGroupName("默认分组");
//            groupDto.setAskForwardingToCustomer("true");
//            patientGroupService.savePatientGroup(groupDto);
        // 完成注册之后失效改验证码
        return "redirect:/security/user/edit/" + user.getCasUserId();

    }

    /***
     * 注册
     *
     * @author songlin.li
     * @param request
     * @return
     */
    @RequestMapping(value = "register/import", method = {RequestMethod.POST, RequestMethod.GET})
    public String doImport(HttpServletRequest request) {
        if (request instanceof MultipartHttpServletRequest) {
            try {
                MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
                MultipartFile file = multipartRequest.getFile("file");
                adminUserService.importDoctor(file.getInputStream());
            } catch (Exception e) {
                // TODO: handle exception
            }
            return "redirect:/admin/list";
        } else {
            return "admin/import";
        }
    }

    @RequestMapping(value = "/release/{groupname}menu")
    @ResponseBody
    public void releaseMemu(@PathVariable String groupname) {
        try {
            WsApiUtil.createDefault().key(getWxAppid()).post2Gateway(WsApiMethodEnum.releaseMenu);
        } catch (Exception e) {
            throw new AppWebException("", e);
        }
    }
}
