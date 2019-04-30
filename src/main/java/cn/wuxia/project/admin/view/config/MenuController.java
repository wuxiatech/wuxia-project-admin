/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.view.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.wuxia.project.basic.core.conf.entity.CustomMenu;
import cn.wuxia.project.basic.core.conf.enums.MenuTypeEnum;
import cn.wuxia.project.basic.core.conf.service.CustomMenuService;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.orm.query.Conditions;
import cn.wuxia.common.orm.query.MatchType;
import cn.wuxia.common.orm.query.Sort;
import cn.wuxia.common.util.StringUtil;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/dic/menu/")
public class MenuController extends BaseController {

    @Autowired
    private CustomMenuService menuService;

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("list", menuService.find(new Sort("sortOrder"), new Conditions("parentId", MatchType.ISN, null)));
        return "menu/list";
    }

    @RequestMapping(value = "create", method = RequestMethod.GET)
    public String create(Model model, String parentId) {
        model.addAttribute("parentId", parentId);
        return edit(model, null);
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            CustomMenu menu = menuService.findById(id);
            model.addAttribute("menu", menu);
        }
        model.addAttribute("types", MenuTypeEnum.values());
        return "menu/edit";
    }

    @RequestMapping(value = "/submenu/{menuId}", method = RequestMethod.GET)
    public String submenu(Model model, @PathVariable String menuId) {
        if (StringUtil.isNotBlank(menuId)) {
            model.addAttribute("menu", menuService.findById(menuId));

            model.addAttribute("submenus", menuService.findByParentId(menuId));
            return "menu/submenulist";
        }
        return "redirect:/dic/menu/list";
    }

    @RequestMapping(value = "/del/{menuId}", method = RequestMethod.GET)
    public String del(Model model, @PathVariable String menuId, String parentId) {
        if (StringUtil.isNotBlank(menuId)) {
            menuService.delete(menuId);
        }
        if (StringUtil.isBlank(parentId)) {

            return "redirect:../list";
        } else {
            return "redirect:../submenu/" + parentId;
        }
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Model model, CustomMenu menu) {
        menuService.save(menu);
        if (StringUtil.isNotBlank(menu.getParentId())) {
            return "redirect:submenu/" + menu.getParentId();
        } else {
            return "redirect:list";
        }
    }

}
