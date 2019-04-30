/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.view.config;

import java.util.List;

import javax.validation.Valid;

import cn.wuxia.project.admin.view.config.bean.TagCategoryVo;
import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.text.RandomStringGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;

import cn.wuxia.project.basic.core.conf.entity.CustomTag;
import cn.wuxia.project.basic.core.conf.entity.CustomTagCategory;
import cn.wuxia.project.basic.core.conf.service.CustomTagCategoryService;
import cn.wuxia.project.basic.core.conf.service.CustomTagService;
import cn.wuxia.project.basic.core.conf.support.DTools;
import cn.wuxia.project.basic.core.conf.support.TagBean;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.util.ListUtil;
import cn.wuxia.common.util.StringUtil;
import cn.wuxia.common.util.reflection.BeanUtil;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/dic/tag/*")
public class CustomTagController extends BaseController {

    @Autowired
    private CustomTagService tagService;

    @Autowired
    private CustomTagCategoryService tagCategoryService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String configList(Model model, Pages pages) {
        /**
         * 暂时不过滤
         */
        //pages.addCondition(Conditions.where("type", CustomTagCategory.TagCategoryType.dic));
        pages = tagCategoryService.findAll(pages);
        List<CustomTagCategory> list = pages.getResult();
        List<TagCategoryVo> returnList = Lists.newArrayList();
        for (CustomTagCategory tagCategory : list) {
            returnList.add(new TagCategoryVo(tagCategory, tagService.findByCategory(tagCategory.getId())));
        }
        pages.setResult(returnList);
        model.addAttribute("pages", pages);
        return "tag/list";
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String configCreate(Model model) {
        return configEdit(model, null);
    }

    @RequestMapping(value = "/edit/{categoryid}", method = RequestMethod.GET)
    public String configEdit(Model model, @PathVariable String categoryid) {
        if (StringUtil.isNotBlank(categoryid)) {
            model.addAttribute("vo", new TagCategoryVo(tagCategoryService.findById(categoryid), tagService.findByCategory(categoryid)));
        }
        return "tag/edit";
    }

    @RequestMapping(value = "/del/{categoryid}", method = RequestMethod.GET)
    public String configDel(Model model, @PathVariable String categoryid, Boolean includetag) {
        if (StringUtil.isNotBlank(categoryid)) {
            tagCategoryService.delete(categoryid);
            if (BooleanUtils.toBoolean(includetag)) {
                tagService.deleteByCategory(categoryid);
            }
        }
        return "redirect:../list";
    }

    @RequestMapping(value = "tags/{categorycode}", method = RequestMethod.GET)
    @ResponseBody
    public List<TagBean> tags(@Valid @PathVariable String categorycode) {
        if (StringUtil.isNotBlank(categorycode)) {
            List<TagBean> tagBeans = DTools.tagsByCcode(categorycode);
            return tagBeans;
        }
        return null;
    }

    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String configSave(Model model, TagCategoryVo vo) {
        CustomTagCategory tagCategory = new CustomTagCategory();
        tagCategory.setName(vo.getCategoryName());
        tagCategory.setId(vo.getCategoryId());
        tagCategory.setType(CustomTagCategory.TagCategoryType.dic);
        if (StringUtil.isNotBlank(vo.getCategoryCode())) {
            tagCategory.setCode(vo.getCategoryCode());
        } else {
            RandomStringGenerator generator = new RandomStringGenerator.Builder().withinRange('a', 'z').build();
            String code = generator.generate(6);
            tagCategory.setCode(code);
        }
        BeanUtil.copyProperties(tagCategory, vo);
        tagCategoryService.save(tagCategory);

        vo.setCategoryId(tagCategory.getId());
        if (ListUtil.isNotEmpty(vo.getTags())) {
            List<CustomTag> tags = Lists.newArrayList();
            for (CustomTag tag : vo.getTags()) {
                if (StringUtil.isNotBlank(tag.getTagName())) {
                    tag.setCategoryId(vo.getCategoryId());
                    tag.setCategoryName(vo.getCategoryName());
                    tags.add(tag);
                }
            }
            tagService.batchSave(tags);
        }
        return "redirect:list";
    }

}
