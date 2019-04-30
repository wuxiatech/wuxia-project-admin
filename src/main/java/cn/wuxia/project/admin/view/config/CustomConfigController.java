/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.view.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.wuxia.project.basic.core.conf.entity.SystemDictionary;
import cn.wuxia.project.basic.core.conf.service.SystemDictionaryService;
import cn.wuxia.project.basic.core.conf.support.DicBean;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.exception.AppWebException;
import cn.wuxia.common.util.StringUtil;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/dic/config/*")
public class CustomConfigController extends BaseController {

	@Autowired
	private SystemDictionaryService dictionaryConfigService;

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String configList(Model model) {
		model.addAttribute("list", dictionaryConfigService.findByParentId(null));
		return "config/list";
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String configCreate(Model model) {
		return configEdit(model, null);
	}

	@RequestMapping(value = "/edit/{dicId}", method = RequestMethod.GET)
	public String configEdit(Model model, @PathVariable String dicId) {
		if (StringUtil.isNotBlank(dicId)) {
			model.addAttribute("dicConfig", dictionaryConfigService.findById(dicId));
		}

		return "config/edit";
	}

	@RequestMapping(value = "/values/{dicId}", method = RequestMethod.GET)
	public String configValuesEdit(Model model, @PathVariable String dicId) {
		if (StringUtil.isNotBlank(dicId)) {
			model.addAttribute("dicConfig", dictionaryConfigService.findById(dicId));
			model.addAttribute("configValues", dictionaryConfigService.findByParentId(dicId));
			return "config/values";
		}
		return "redirect:../list";
	}

	@RequestMapping(value = "/del/{dicId}", method = RequestMethod.GET)
	public String configDel(Model model, @PathVariable String dicId) {
		if (StringUtil.isNotBlank(dicId)) {
			dictionaryConfigService.delete(dicId);
		}
		return "redirect:../list";
	}

	@RequestMapping(value = "save", method = RequestMethod.POST)
	public String configSave(Model model, SystemDictionary vo) {

		if (StringUtil.isNotBlank(vo.getParentid())) {
			SystemDictionary systemDictionary = dictionaryConfigService.findById(vo.getParentid());
			DicBean dicBean = dictionaryConfigService.findByCodeAndParentCode(vo.getCode(), systemDictionary.getCode());
			if ((dicBean == null) || (dicBean != null && StringUtil.equals(dicBean.getId(), vo.getId()))) {
				dictionaryConfigService.save(vo);
			} else {
				throw new AppWebException("已存在该字典数据！");
			}
			return "redirect:values/" + vo.getParentid();
		} else if (StringUtil.isNotBlank(vo.getId())) {
			/**
			 * 修改字典，判断当前code是否已被使用
			 */
			DicBean dicBean = dictionaryConfigService.findByCode(vo.getCode());
			if ((dicBean != null && StringUtil.equals(vo.getId(), dicBean.getId())) || (dicBean == null)) {
				dictionaryConfigService.save(vo);
			} else {
				throw new AppWebException("已存在该字典数据！");
			}
		} else if (StringUtil.isNotBlank(vo.getCode())) {
			/**
			 * 新增直接判断codee是否已被用
			 */
			DicBean dicBean = dictionaryConfigService.findByCode(vo.getCode());

			if (dicBean == null) {
				dictionaryConfigService.save(vo);
			} else {
				throw new AppWebException("已存在该字典数据！");
			}
		}
		return "redirect:list";
	}

	@RequestMapping(value = "/values/save", method = RequestMethod.POST)
	public String configBatchSave(Model model, List<SystemDictionary> vos) {
		dictionaryConfigService.batchSave(vos);
		return "redirect:../list";
	}
}
