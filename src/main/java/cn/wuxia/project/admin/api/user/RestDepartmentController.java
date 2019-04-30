/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.api.user;

import cn.wuxia.project.security.core.user.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import cn.wuxia.project.basic.mvc.controller.RestBaseController;
import cn.wuxia.project.common.bean.CallbackBean;

/**
 * songlin.li
 */
@RestController
@RequestMapping("/api/dept")
public class RestDepartmentController extends RestBaseController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "/get/{deptid}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> get(@PathVariable String deptid) {
        return ok(departmentService.findByDeptId(deptid));
    }

    @RequestMapping(value = "/list/{organizationId}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> list(@PathVariable String organizationId) {
        return ok(departmentService.findByOrganizationId(organizationId));
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> all() {
        return ok(departmentService.findAll(getWxAppid()));
    }
}
