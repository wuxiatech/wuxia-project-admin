/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.api.dic;

import javax.validation.Valid;

import cn.wuxia.project.storage.core.model.UploadFileInfo;
import cn.wuxia.project.storage.core.service.UploadFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import cn.wuxia.project.basic.mvc.controller.RestBaseController;
import cn.wuxia.project.common.bean.CallbackBean;

/**
 * Upload File Controller.
 *
 * @author songlin.li
 * @since 2013-06-25
 */
@RestController
@RequestMapping("/api/file/*")
public class RestUploadFileController extends RestBaseController {
	@Autowired
	private UploadFileService uploadFileService;

	@RequestMapping(value = "get/{uploadFileId}", method = RequestMethod.GET)
	public ResponseEntity<CallbackBean> getFile(@Valid @PathVariable String uploadFileId) {
		UploadFileInfo uploadFileInfo = uploadFileService.getUploadFileInfoById(uploadFileId);
		return ok(uploadFileInfo);
	}

}
