(function($) {
	jQuery.fn.uploadFile = function(options) {
		options = jQuery.extend({
			uploadFileSet : null,
			data : {
				uploadCategory : 'def'
			},
			auto : false,
			fileType : ".jpg,.jpeg,.png,.gif",
			url : "/plugin/pic/localUpload",
			parallelUploads : 1, // 并行上传
			maxFiles : 1,
			maxFilesize : 1, // MB
			uploadButton : "#uploadButton",
			callback : function(data) {
				return false;
			}
		}, options || {});
		var picdata = [];
		var obj = this;
		var myDropzone;
		$(this)
				.dropzone(
						{
							url : options.url,
							parallelUploads : options.parallelUploads,
							maxFiles : options.maxFiles,
							maxFilesize : options.maxFilesize, // MB
							addRemoveLinks : true,
							uploadMultiple : true,
							autoProcessQueue : options.auto, // 是否为自动上传
							acceptedFiles : options.fileType,
							dictDefaultMessage : "<button class=\"btn btn-danger\" type=\"button\">点击上传图片</button>",
							dictRemoveFile : "移除图片",
							dictResponseError : "上传图片有误!",
							dictMaxFilesExceeded : "只能上传" + options.maxFiles + "张图片",
							dictInvalidFileType : "您上传类型有误！上传类型只能为:" + options.fileType,
							dictFileTooBig : "对不起,请上传" + options.maxFilesize + "M以内的图片！",
							dictFallbackMessage : '对不起!您的浏览器不支持拖放文件上传。请换别的浏览器试试',
							previewTemplate : "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>",
							init : function() {
								var btUploadAll = $(options.uploadButton);
								var submitButton = document.querySelector(options.uploadButton);
								myDropzone = this;
								// 为上传按钮添加点击事件
								submitButton.addEventListener("click", function() {
									// 清空数据
									picdata = [];
									// 手动上传所有图片
									myDropzone.processQueue();
								});
							},
							success : function(file, data) {
								picdata.push(data);
								if (myDropzone.getQueuedFiles().length == 0) {
									options.callback(picdata);
									// 上传后移除图片
									this.removeAllFiles();
								} else {
									myDropzone.processQueue();
								}
							}
						});
	}

})(jQuery);
