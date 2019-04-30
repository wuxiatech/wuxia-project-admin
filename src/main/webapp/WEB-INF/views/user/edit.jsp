<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户资料</title>
</head>
<body>
<div class="page-header">
    <h1>
        用户资料
        <small><i class="icon-double-angle-right"></i>

        </small>
    </h1>
</div>
<!-- /.page-header -->

<div class="row">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <form class="form-horizontal" role="form" action="/patient/save"
              method="post">
            <input name="id" value="${patient.id }" type="hidden">
            <div class="form-group">


                <label for="form-field-8" class="col-sm-3 control-label no-padding-right">姓名：</label>
                <div class="col-sm-9">
                    <input
                            class="form-control limited" id="form-field-8" name="realName"
                            maxlength="50" value="${patient.nickName }">
                    </textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="form-field-8" class="col-sm-3 control-label no-padding-right">手机：</label>
                <div class="col-sm-9">
                    <input
                            class="form-control limited" id="form-field-9" name="mobile"
                            maxlength="50" value="${patient.mobile }">
                    </textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right">性别：</label>
                <div class="radio col-sm-9">
                    <label>
                        <input type="radio" class="ace" value="MEN" name="gender"
                               <c:if test="${patient.gender eq 'MAN'}">checked</c:if> />
                        <span class="lbl"> 男士</span>
                    </label>

                    <label>
                        <input type="radio" class="ace" value="WOMEN" name="gender"
                               <c:if test="${patient.gender eq 'WOMEN'}">checked</c:if> />
                        <span class="lbl"> 女士</span>
                    </label>
                    <label>
                        <input type="radio" class="ace" value="UNKNOW" name="gender"
                               <c:if test="${patient.gender eq 'UNKNOW'}">checked</c:if> />
                        <span class="lbl"> 未知</span>
                    </label>
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
                realName: {
                    required: true,
                    minlength: 3
                },
                mobile: {
                    required: true
                }
            },

            messages: {
                realName: {
                    required: "请填写真实姓名",
                    minlength: "至少填入5个字"
                },
                mobile:{
                    required:"请填写手机号码"
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