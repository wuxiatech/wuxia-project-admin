/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.api.user;

import cn.wuxia.project.basic.mvc.controller.RestBaseController;
import cn.wuxia.project.common.bean.CallbackBean;
import cn.wuxia.common.orm.query.Conditions;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.orm.query.Sort;
import cn.wuxia.common.util.SerializeUtils;
import cn.wuxia.project.security.core.user.enums.UserTypeEnum;
import cn.wuxia.project.security.core.user.service.AdminUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * songlin.li
 */
@RestController
@RequestMapping("/api/doctor")
@Api(value = "用户信息", description = "用户信息")
public class RestAdminUserController extends RestBaseController {

    @Autowired
    private AdminUserService adminUserService;

    @ApiOperation(value = "查询管理员信息", notes = "根据id查询信息", httpMethod = "GET")
    @RequestMapping(value = "/get/{userid}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> get(@ApiParam(name = "userid") @PathVariable String userid) {
        return ok(adminUserService.findById(userid));
    }


    @RequestMapping(value = "/mobile/{mobile}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> mobile(@PathVariable String mobile) {
        return ok(adminUserService.findByMobile(getWxAppid(), mobile));
    }

    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    public ResponseEntity<CallbackBean> list() {
        byte[] bytes = getRequestBytes();
        Pages page = SerializeUtils.deSerialize(bytes, Pages.class);
        if (page == null) {
            page = new Pages(1, 15);
        }
        page.addCondition(new Conditions("appid", getWxAppid()));
        page.addCondition(new Conditions("type", UserTypeEnum.NORMAL));
        page = adminUserService.findForUserList(page);
        /**
         * 由于传输数据较大，故需要做特殊处理
         */
        return ok(page);
    }

    @RequestMapping(value = "/locklist", method = {RequestMethod.GET, RequestMethod.POST})
    public ResponseEntity<CallbackBean> lockuserList() {
        byte[] bytes = getRequestBytes();
        Pages page = SerializeUtils.deSerialize(bytes, Pages.class);
        if (page == null) {
            page = new Pages(1, 15);
        }
        page.addCondition(new Conditions("appid", getWxAppid()));
        page.setSort(new Sort(Sort.Direction.DESC, "is_obsolete_date"));
        page = adminUserService.findLockUser(page);
        /**
         * 由于传输数据较大，故需要做特殊处理
         */
        return ok(page);
    }

}
