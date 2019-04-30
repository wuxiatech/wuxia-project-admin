<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>导入用户</title>
    <mycss>
        <link rel="stylesheet" href="//ace.zjcdn.cn/assets/css/dropzone.css"/>
    </mycss>
</head>
<body id="question_body">
<div class="page-header">
    <h1>
        导入
        <small><i class="icon-double-angle-right"></i>

        </small>
    </h1>
</div>
<!-- /.page-header -->


<div class="row">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <div id="dropzone">
            <form action="/admin/register/import" class="dropzone" method="post" enctype="multipart/form-data">
                <div class="fallback">
                    <input name="file" type="file" multiple=""/>
                </div>
            </form>

        </div>
        <button class="btn btn-primary" id="submitButton">提交文件</button>
        <!-- PAGE CONTENT ENDS -->
    </div>
    <!-- /.col -->
</div>


<myjs>
    <script src="//ace.zjcdn.cn/assets/js/dropzone.min.js"></script>
    <script type="text/javascript">
        jQuery(function ($) {

            try {
                $(".dropzone").dropzone({
                    paramName: "file", // The name that will be used to transfer the file
                    maxFilesize: 1, // MB
                    acceptedFiles: ".xls,.xlsx",
                    addRemoveLinks: true,
                    dictDefaultMessage:
                        '<span class="bigger-150 bolder"><i class="icon-caret-right red"></i> 拖拉</span> 到本区域上传 \
                        <span class="smaller-80 grey">(或点击)</span> <br /> \
                        <i class="upload-icon icon-cloud-upload blue icon-3x"></i>'
                    ,
                    dictResponseError: '上传文件出错!',
                    autoProcessQueue: false,
                    //change the previewTemplate to use Bootstrap progress bars
                    previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>",
                    init: function () {
                        var myDropzone = this;
                        $("#submitButton").click(function () {
                            myDropzone.processQueue(); // Tell Dropzone to process all queued files.
                        });
                        this.on("success", function (file) {
                            alert(file.name + "上传成功");
                        })
                        this.on("addedfile", function () {
                            // Show submit button here and/or inform user to click it.
                            $("#submitButton").show();
                        });
                    }
                });
            } catch (e) {
                alert('Dropzone.js does not support older browsers!');
            }

        });
    </script>
</myjs>


</body>
</html>