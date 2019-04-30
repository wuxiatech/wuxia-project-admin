<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="/resources/script/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
<script src="/resources/script/uploadify/jquery.uploadify.min.js" type="text/javascript"></script>
<%--	实例
<%@ include file="/WEB-INF/views/common/uploadify.jsp"%>
<script type="text/javascript">
$(function() {
	$('#file_uploadFileSetId').uploadFile();
});
</script>
<input type="hidden" name="fileset.uploadFileSetId" id="fileset_uploadFileSetId" value="200" />
<input name="uploadFileSetId" id="file_uploadFileSetId" type="file" value="Upload Doc" style="width: 160px">
--%>
<script type="text/javascript">
(function($) {
	jQuery.fn.uploadFile = function(options) {
		options = jQuery.extend({
			uploadFileSet: null,
			data:{uploadCategory: 'def'},
			auto: true,
			text:'上传',
			fileType: "*.doc;*.docx;*.xls;*.xlsx;*.ppt;*.pptx;*.txt;*.rtf;*.jpg;*.jpeg;*.png;*.gif",
			url: "/upload/uploadFile",
			width: 120,
			height: 30,
			buttonClass:'',
			callback: function() {
				return false;
			}
		}, options || {});

		var uploadFileSet = options.uploadFileSet;
		if (uploadFileSet == null) {
			var name = "fileset." + $(this).attr("name");
			uploadFileSet = $("input[name='" + name + "']:hidden");
		}
		var obj = this;
		$(this).uploadify({
			swf: '/resources/script/uploadify/uploadify.swf',
			uploader: options.url,
			formData: options.data,
			buttonText: options.text,
			removeCompleted: false,
			checkExisting: "/upload/checkExistingUploadFile",
			auto: options.auto,
			multi: false,
			uploadLimit: 0,
			fileSizeLimit: '10MB',
			height: options.height,
			width: options.width,
			buttonClass:options.buttonClass,
			fileTypeExts: options.fileType,
			onUploadComplete: function() {
			},
			onSelect: function() {
				$(obj).uploadify('settings', 'formData', {
					'uploadFileSetId' : $(uploadFileSet).val()
				});
			},
			onUploadSuccess: function(file, data, response) {
				var entity = jQuery.parseJSON(data);
				if (entity && entity.uploadFileSetInfoId != '') {
					$(uploadFileSet).val(entity.uploadFileSetInfoId);
				}
				if (options.callback) {
					options.callback(obj, entity);
				}
			},
			onUploadProgress: function() {
			},
			onCancel: function(file) {
			},
			onDisable: function(file) {
			}
		});
	}
})(jQuery);
</script>