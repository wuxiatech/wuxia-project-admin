<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>部门资料</title>
</head>
<body>
<div class="page-header">
    <h1>
        部门资料
        <small><i class="icon-double-angle-right"></i>

        </small>
    </h1>
</div>
<!-- /.page-header -->

<div class="row">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <form class="form-horizontal" role="form" action="/admin/dept/submit"
              method="post">
            <input name="id" value="${dept.id }" type="hidden">
            <input name="organizationId" value="${dept.organizationId }" type="hidden">
            <div class="form-group">


                <label for="form-field-8" class="col-sm-3 control-label no-padding-right">名称：</label>
                <div class="col-sm-9">
                    <input
                            class="form-control limited" id="form-field-8" name="departmentName"
                            maxlength="50" value="${dept.departmentName }">
                    </textarea>
                </div>
            </div>
            <div class="clearfix form-actions">
                <div class="col-md-offset-4">
                    &nbsp; &nbsp; &nbsp;
                    <button class="btn btn-info" type="submit">
                        <i class="icon-ok bigger-110"></i> 提交
                    </button>

                    &nbsp; &nbsp; &nbsp;
                    <button class="btn" type="reset">
                        <i class="icon-undo bigger-110"></i> 重置
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<myjs>
    <script>
        $('form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                departmentName: {
                    required: true,
                    minlength: 3
                }
            },

            messages: {
                departmentName: {
                    required: "请填写部门名称",
                    minlength: "至少填入3个字"
                }
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },

            errorPlacement: function (error, element) {
                if (element.is(':checkbox') || element.is(':radio')) {
                    var controls = element.closest('div[class*="col-"]');
                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
                else if (element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                }
                else if (element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
                }
                else error.insertAfter(element);
            },

            submitHandler: function (form) {
                form.submit();
            },
            invalidHandler: function (form) {
            }
        });

    </script>
</myjs>
</body>
</html>