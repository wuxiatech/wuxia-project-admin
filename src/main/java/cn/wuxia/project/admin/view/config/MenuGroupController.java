/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.view.config;

import java.util.List;

import cn.wuxia.project.admin.view.config.bean.MenuGroupVo;
import cn.wuxia.project.security.core.enums.SystemType;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Lists;

import cn.wuxia.project.basic.core.conf.bean.MenuBean;
import cn.wuxia.project.basic.core.conf.entity.CustomMenu;
import cn.wuxia.project.basic.core.conf.entity.CustomMenuGroup;
import cn.wuxia.project.basic.core.conf.service.CustomMenuGroupService;
import cn.wuxia.project.basic.core.conf.service.CustomMenuService;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.util.ListUtil;
import cn.wuxia.common.util.StringUtil;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/dic/menugroup/*")
public class MenuGroupController extends BaseController {

    @Autowired
    private CustomMenuGroupService menuGroupService;

    @Autowired
    private CustomMenuService menuService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String configList(Model model, Pages pages) {
        pages = menuGroupService.findAll(pages);
        List<CustomMenuGroup> list = pages.getResult();
        List<MenuGroupVo> returnList = Lists.newArrayList();
        for (CustomMenuGroup menuGroup : list) {
            returnList.add(new MenuGroupVo(menuGroup));
        }
        pages.setResult(returnList);
        model.addAttribute("pages", pages);
        return "menu/grouplist";
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String configCreate(Model model) {
        return configEdit(model, null);
    }

    @RequestMapping(value = "/edit/{groupid}", method = RequestMethod.GET)
    public String configEdit(Model model, @PathVariable String groupid) {
        if (StringUtil.isNotBlank(groupid)) {
            model.addAttribute("vo", new MenuGroupVo(menuGroupService.findById(groupid)));
        }
        List<CustomMenu> menus = menuService.findAll();
        List<MenuBean> menuBeans = Lists.newArrayList();
        for (CustomMenu menu : menus) {
            menuBeans.add(new MenuBean(menu));
        }
        model.addAttribute("menus", menuBeans);
        model.addAttribute("filters", SystemType.values());
        return "menu/groupedit";
    }

    @RequestMapping(value = "/del/{groupid}", method = RequestMethod.GET)
    public String configDel(Model model, @PathVariable String groupid) {
        if (StringUtil.isNotBlank(groupid)) {
            menuGroupService.delete(groupid);
        }
        return "redirect:../list";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String configSave(Model model, MenuGroupVo vo) {

        CustomMenuGroup customMenuGroup = vo.getMenuGroup();

        if (StringUtil.isBlank(customMenuGroup.getGroupCode())) {
            RandomStringGenerator generator = new RandomStringGenerator.Builder().withinRange('a', 'z').build();
            String code = generator.generate(6);
            customMenuGroup.setGroupCode(code);
        }
        if (ListUtil.isNotEmpty(customMenuGroup.getMenus())) {
        } else if (StringUtil.isNotBlank(vo.getMenuNames())) {
            List<CustomMenu> menus = Lists.newArrayList();
            for (String menuId : StringUtil.split(vo.getMenuNames(), ",")) {
                menus.add(menuService.findById(menuId));
            }
            customMenuGroup.setMenus(menus);
        }
        menuGroupService.save(customMenuGroup);
        return "redirect:list";
    }

}
