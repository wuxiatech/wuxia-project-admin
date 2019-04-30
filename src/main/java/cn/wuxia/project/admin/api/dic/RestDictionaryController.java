/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.api.dic;

import java.util.List;

import javax.validation.Valid;

import io.swagger.annotations.Api;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import cn.wuxia.project.basic.core.conf.support.DTools;
import cn.wuxia.project.basic.core.conf.support.DicBean;
import cn.wuxia.project.basic.mvc.controller.RestBaseController;
import cn.wuxia.project.common.bean.CallbackBean;
import cn.wuxia.common.util.StringUtil;

/**
 * songlin.li
 */
@RestController
@RequestMapping("/api/dic/*")
@Api
public class RestDictionaryController extends RestBaseController {

    @RequestMapping(value = "value/{code}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> getValue(Model model, @Valid @PathVariable String code, String parentcode) {
        String value = "";
        if (StringUtil.isNotBlank(code) && StringUtil.isNotBlank(parentcode)) {
            value = DTools.dic(code, parentcode);
        } else if (StringUtil.isNotBlank(code)) {
            value = DTools.dic(code);
        }
        return ok(value);
    }

    @RequestMapping(value = "get/{dicId}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> get(Model model, @Valid @PathVariable String dicId) {
        if (StringUtil.isNotBlank(dicId)) {
            DicBean dicBean = DTools.dicById(dicId);
            if (dicBean == null) {
                return notok("无效id");
            }
            return ok(dicBean);
        }
        return ResponseEntity.badRequest().build();
    }

    @RequestMapping(value = "values/{parentcode}", method = RequestMethod.GET)
    public ResponseEntity<CallbackBean> values(Model model, @Valid @PathVariable String parentcode) {
        if (StringUtil.isNotBlank(parentcode)) {
            List<DicBean> dicBeans = DTools.dicByParentCode(parentcode);
            return ok(dicBeans);
        }
        return new ResponseEntity(new CallbackBean(), HttpStatus.OK);
    }

}
