/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.view.admin.web;


import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.orm.query.Conditions;
import cn.wuxia.common.orm.query.MatchType;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.project.security.core.user.entity.Organization;
import cn.wuxia.project.security.core.user.service.OrganizationService;
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
@RequestMapping("/admin/org/**")
public class OrganizationController extends BaseController {

    @Autowired
    private OrganizationService organizationService;


    @RequestMapping(value = "/list", method = {RequestMethod.GET, RequestMethod.POST})
    public String hospitalList(Model model, Pages page) {
        page = page == null ? new Pages(15) : page;
        if (page.getPageSize() < 0) {
            page.setPageSize(15);
        }
        page.addCondition(new Conditions("isObsoleteDate", MatchType.ISN, null));

        page.addCondition(new Conditions("platform", getWxAppid()));
        page = organizationService.findAll(page);
        model.addAttribute("pages", page);
        return "organization/list";

    }

    @RequestMapping(value = "/create", method = {RequestMethod.GET})
    public String hospitalCreate(Model model) {
        return "organization/edit";

    }

    @RequestMapping(value = "/edit/{organizationId}", method = {RequestMethod.GET})
    public String hospitalCreate(Model model, @PathVariable String organizationId) {
        model.addAttribute("organization", organizationService.findById(organizationId));
        return "organization/edit";
    }

    @RequestMapping(value = "/submit", method = {RequestMethod.POST})
    public String hospitalSave(Model model, Organization organization) {
        organization.setPlatform(getWxAppid());
        organizationService.save(organization);
        return "redirect:list";
    }


}
