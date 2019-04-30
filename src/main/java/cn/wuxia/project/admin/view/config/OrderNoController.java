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

import cn.wuxia.project.basic.core.conf.entity.OrderNoGenerate;
import cn.wuxia.project.basic.core.conf.service.OrderNoGenerateService;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.util.StringUtil;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/dic/orderno/**")
public class OrderNoController extends BaseController {

    @Autowired
    private OrderNoGenerateService orderNoGenerateService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model) {
        model.addAttribute("list", orderNoGenerateService.findAll());
        return "orderno/list";
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(Model model) {
        return edit(model, null);
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            model.addAttribute("noGenerate", orderNoGenerateService.findById(id));
        }
        return "orderno/edit";
    }

    @RequestMapping(value = "/del/{id}", method = RequestMethod.GET)
    public String configDel(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            orderNoGenerateService.delete(id);
        }
        return "redirect:../list";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String configSave(Model model, OrderNoGenerate orderNoGenerate) {
        if (orderNoGenerate.getNextno() == null) {
            orderNoGenerate.setNextno(orderNoGenerate.getStartno() + orderNoGenerate.getStepleng());
        }
        orderNoGenerateService.save(orderNoGenerate);
        return "redirect:list";
    }

}
