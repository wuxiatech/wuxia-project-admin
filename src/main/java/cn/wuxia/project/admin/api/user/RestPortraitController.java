/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.api.user;

import java.util.List;

import cn.wuxia.project.security.core.user.bean.PortraitTagDto;
import cn.wuxia.project.security.core.user.entity.UserPortrait;
import cn.wuxia.project.security.core.user.entity.UserPortraitTag;
import cn.wuxia.project.security.core.user.service.UserPortraitService;
import cn.wuxia.project.security.core.user.service.UserPortraitTagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.collect.Lists;

import cn.wuxia.project.basic.mvc.controller.RestBaseController;
import cn.wuxia.project.common.bean.CallbackBean;
import cn.wuxia.common.util.BytesUtil;
import cn.wuxia.common.util.StringUtil;

/**
 * songlin.li
 */
@RestController
@RequestMapping("/api/portrait")
public class RestPortraitController extends RestBaseController {

    @Autowired
    private UserPortraitTagService portraitTagService;

    @Autowired
    private UserPortraitService portraitService;

    @Deprecated
    @RequestMapping(value = "/get/{userid}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> get(@PathVariable String userid, String groupcode) {
        if (StringUtil.isNotBlank(groupcode)) {
            return ok(portraitTagService.findByUserAndGroup(userid, groupcode));
        }
        return ok(portraitTagService.findBy("userId", userid));
    }

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> get(String userid) {
        if (StringUtil.isNotBlank(userid))
            return ok(portraitService.findByUserId(userid));
        else
            return notok("参数userid为空");
    }

    @RequestMapping(value = "/save", method = { RequestMethod.POST })
    public ResponseEntity<CallbackBean> save() throws Exception {
        byte[] bytes = getRequestBytes();
        if (bytes != null) {
            UserPortraitTag userPortraits = (UserPortraitTag) BytesUtil.bytesToObject(bytes);
            /**
             * 先删除再保存
             */
            portraitTagService.findByUserAndGroup(userPortraits.getUserId(), userPortraits.getGroup());
            portraitTagService.save(userPortraits);

            /**
             * FIXME 标签保存两份？？？？？
             */

            List<UserPortrait> list = Lists.newArrayList();
            for (PortraitTagDto dto : userPortraits.getTags()) {
                UserPortrait userPortrait = new UserPortrait();
                userPortrait.setCategoryId(dto.getCategoryId());
                userPortrait.setCategoryName(dto.getCategoryName());
                userPortrait.setTagId(dto.getTagId());
                userPortrait.setTagName(dto.getTagName());
                userPortrait.setUserId(userPortraits.getUserId());
                userPortrait.setTagType(UserPortrait.TagType.dic);
                list.add(userPortrait);
                portraitService.deleteByPatientIdAndCategoryId(userPortraits.getUserId(), dto.getCategoryId());
            }

            portraitService.batchSave(list);

            return ok(userPortraits);
        } else {
            return new ResponseEntity(new CallbackBean(), HttpStatus.BAD_REQUEST);
        }
    }

}
