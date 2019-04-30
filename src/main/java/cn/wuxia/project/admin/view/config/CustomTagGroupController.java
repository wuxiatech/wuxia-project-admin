/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.view.config;

import java.util.List;

import cn.wuxia.project.admin.view.config.bean.TagCategoryVo;
import cn.wuxia.project.admin.view.config.bean.TagGroupVo;
import cn.wuxia.project.security.core.user.entity.Organization;
import cn.wuxia.project.security.core.user.service.DepartmentService;
import cn.wuxia.project.security.core.user.service.OrganizationService;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.collect.Lists;

import cn.wuxia.project.basic.core.conf.bean.TagGroupCategory;
import cn.wuxia.project.basic.core.conf.entity.CustomTagCategory;
import cn.wuxia.project.basic.core.conf.entity.CustomTagGroup;
import cn.wuxia.project.basic.core.conf.service.CustomTagCategoryService;
import cn.wuxia.project.basic.core.conf.service.CustomTagGroupService;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.util.ListUtil;
import cn.wuxia.common.util.StringUtil;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/dic/taggroup/*")
public class CustomTagGroupController extends BaseController {

    @Autowired
    private CustomTagGroupService tagGroupService;

    @Autowired
    private CustomTagCategoryService tagCategoryService;

    @Autowired
    private OrganizationService hospitalService;

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String configList(Model model, Pages pages) {
        pages = tagGroupService.findAll(pages);
        List<CustomTagGroup> list = pages.getResult();
        List<TagGroupVo> returnList = Lists.newArrayList();
        for (CustomTagGroup tagGroup : list) {
            returnList.add(new TagGroupVo(tagGroup));
        }
        pages.setResult(returnList);
        model.addAttribute("pages", pages);
        return "tag/grouplist";
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String configCreate(Model model) {
        return configEdit(model, null);
    }

    @RequestMapping(value = "/edit/{groupid}", method = RequestMethod.GET)
    public String configEdit(Model model, @PathVariable String groupid) {
        if (StringUtil.isNotBlank(groupid)) {
            model.addAttribute("vo", new TagGroupVo(tagGroupService.findById(groupid)));
        }
        List<CustomTagCategory> tagCategories = tagCategoryService.findAll();
        List<TagCategoryVo> tagCategoryVos = Lists.newArrayList();
        for (CustomTagCategory tagCategory : tagCategories) {
            tagCategoryVos.add(new TagCategoryVo(tagCategory, null));
        }
        model.addAttribute("categorys", tagCategoryVos);

        List<Organization> hospitals = hospitalService.findAll();
        if (ListUtil.isNotEmpty(hospitals)) {
            if (hospitals.size() == 1) {
                model.addAttribute("departments", hospitals.get(0).getDepartments());
            }
        }
        return "tag/groupedit";
    }

    @RequestMapping(value = "/del/{groupid}", method = RequestMethod.GET)
    public String configDel(Model model, @PathVariable String groupid) {
        if (StringUtil.isNotBlank(groupid)) {
            tagGroupService.delete(groupid);
        }
        return "redirect:../list";
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String configSave(Model model, TagGroupVo vo) {

        CustomTagGroup customTagGroup = vo.getTagGroup();

        if (StringUtil.isBlank(customTagGroup.getCode())) {
            RandomStringGenerator generator = new RandomStringGenerator.Builder().withinRange('a', 'z').build();
            String code = generator.generate(6);
            customTagGroup.setCode(code);
        }
        if(ListUtil.isNotEmpty(customTagGroup.getChildren())){
            for(TagGroupCategory groupCategory : customTagGroup.getChildren()){
               CustomTagCategory category = tagCategoryService.findById(groupCategory.getCategoryId());
                groupCategory.setCategoryCode(category.getCode());
                groupCategory.setCategoryName(category.getName());
            }
        }
        tagGroupService.save(customTagGroup);
        return "redirect:list";
    }

}
