/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.view.admin.web;


import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.orm.query.Conditions;
import cn.wuxia.common.orm.query.MatchType;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.project.security.core.user.entity.Department;
import cn.wuxia.project.security.core.user.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/admin/dept/**")
public class DeptmentController extends BaseController {


    @Autowired
    private DepartmentService departmentService;


    @RequestMapping(value = "/list/{organizationId}", method = {RequestMethod.GET, RequestMethod.POST})
    public String list(Model model, Pages page, @PathVariable String organizationId) {
        page = page == null ? new Pages(15) : page;
        if (page.getPageSize() < 0) {
            page.setPageSize(15);
        }
        page.addCondition(new Conditions("isObsoleteDate", MatchType.ISN, null));

        page.addCondition(new Conditions("organizationId", organizationId));
        page = departmentService.findAll(page);
        model.addAttribute("pages", page);
        model.addAttribute("organizationId", organizationId);
        return "organization/dept/list";
    }

    @RequestMapping(value = "/create/{organizationId}", method = {RequestMethod.GET})
    public String create(Model model, @PathVariable String organizationId) {
        Department dept = new Department();
        dept.setOrganizationId(organizationId);
        model.addAttribute("dept", dept);
        return "organization/dept/edit";

    }

    @RequestMapping(value = "/edit/{id}", method = {RequestMethod.GET})
    public String edit(Model model, @PathVariable String id) {
        model.addAttribute("dept", departmentService.findById(id));
        return "organization/dept/edit";
    }

    @RequestMapping(value = "/submit", method = {RequestMethod.POST})
    public String submit(Model model, Department dept) {
        departmentService.save(dept);
        return "redirect:list/" + dept.getOrganizationId();
    }
}
