/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.api.dic;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import cn.wuxia.common.util.*;
import org.apache.commons.lang3.BooleanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Lists;

import cn.wuxia.project.basic.core.conf.bean.TagGroupCategory;
import cn.wuxia.project.basic.core.conf.entity.CustomTagCategory;
import cn.wuxia.project.basic.core.conf.service.CustomTagCategoryService;
import cn.wuxia.project.basic.core.conf.service.CustomTagGroupService;
import cn.wuxia.project.basic.core.conf.service.CustomTagService;
import cn.wuxia.project.basic.core.conf.support.DTools;
import cn.wuxia.project.basic.core.conf.support.TagBean;
import cn.wuxia.project.basic.core.conf.support.TagCategoryBean;
import cn.wuxia.project.basic.mvc.controller.RestBaseController;
import cn.wuxia.project.common.bean.CallbackBean;

/**
 * songlin.li
 */
@RestController
@RequestMapping("/api/tag/*")
public class RestTagController extends RestBaseController {
    @Autowired
    private CustomTagCategoryService tagCategoryService;

    @Autowired
    private CustomTagService tagService;

    @Autowired
    private CustomTagGroupService tagGroupService;

    @RequestMapping(value = "get/{tagId}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> get(Model model, @Valid @PathVariable String tagId) {
        if (StringUtil.isNotBlank(tagId)) {
            TagBean tagBean = null;
            tagBean = DTools.tagById(tagId);
            if (tagBean == null) {
                return new ResponseEntity(new CallbackBean("无效id", CallbackBean.MsgStatus.CLIENT_ERROR), HttpStatus.BAD_REQUEST);
            }
            return ok(tagBean);
        }
        return ResponseEntity.badRequest().build();
    }

    @RequestMapping(value = "values/{categorycode}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> values(Model model, @Valid @PathVariable String categorycode) {
        if (StringUtil.isNotBlank(categorycode)) {
            List<TagCategoryBean> list = Lists.newArrayList();
            CustomTagCategory tagCategory = tagCategoryService.findByCode(categorycode);
            if (tagCategory != null) {
                List<TagBean> tagBeans = DTools.tagsByCid(tagCategory.getId());
                return ok(new TagCategoryBean(tagCategory, tagBeans));
            } else {
                return notok("categorycode[" + categorycode + "]无效参数！");
            }
        }
        return ok();

    }

    /**
     * @param model
     * @param groupcode
     * @param filter
     * @param isquery
     * @return
     */
    @RequestMapping(value = "group/{groupcode}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> groupByCode(Model model, @Valid @PathVariable String groupcode, Boolean isquery) {
        if (StringUtil.isNotBlank(groupcode)) {
            List<TagCategoryBean> list = Lists.newArrayList();

            List<TagGroupCategory> tagGroupCategories = tagGroupService.findByCode(groupcode);
            if (ListUtil.isEmpty(tagGroupCategories)) {
                return notok("groupcode[" + groupcode + "]不存在");
            }
            for (TagGroupCategory tagGroupCategory : tagGroupCategories) {

                CustomTagCategory tagCategory = tagCategoryService.findById(tagGroupCategory.getCategoryId());
                if (BooleanUtils.toBoolean(isquery)) {
                    if (BooleanUtils.toBoolean(tagCategory.getOpenquery())) {
                        List<TagBean> tagBeans = DTools.tagsByCid(tagCategory.getId());
                        list.add(new TagCategoryBean(tagCategory, tagBeans));
                    }
                } else {
                    List<TagBean> tagBeans = DTools.tagsByCid(tagGroupCategory.getCategoryId());
                    list.add(new TagCategoryBean(tagCategory, tagBeans));
                }
            }
            return ok(list);

        }
        return new ResponseEntity(new CallbackBean(), HttpStatus.OK);
    }

    /**
     * filter 格式为json
     * @param model
     * @param groupcode
     * @param filter
     * @param isquery
     * @return
     */
    @RequestMapping(value = "group/filter", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> groupByFilter(Model model) {

        List<TagCategoryBean> list = Lists.newArrayList();
        Map<String, Object> filter = ServletUtils.getParametersMap(request);
        List<TagGroupCategory> tagGroupCategories = tagGroupService.findByFilter(MapUtil.convert2string(filter));

        for (TagGroupCategory tagGroupCategory : tagGroupCategories) {

            CustomTagCategory tagCategory = tagCategoryService.findById(tagGroupCategory.getCategoryId());

            List<TagBean> tagBeans = DTools.tagsByCid(tagGroupCategory.getCategoryId());
            list.add(new TagCategoryBean(tagCategory, tagBeans));

        }
        return ok(list);

    }

}
