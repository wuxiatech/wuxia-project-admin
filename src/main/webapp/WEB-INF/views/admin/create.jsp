<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en"> <!--<![endif]-->
<head>
    <title>新建账户</title>

    <style>
        .sky-form .state-error input, .sky-form .state-error select, .sky-form .state-error select + i,
        .sky-form .state-error textarea, .sky-form .radio.state-error i,
        .sky-form .checkbox.state-error i, .sky-form .toggle.state-error i,
        .sky-form .toggle.state-error input:checked + i {
            background: #fff0f0 none repeat scroll 0 0;
        }

        .sky-form .state-success input, .sky-form .state-success select, .sky-form .state-success select + i, .sky-form .state-success textarea, .sky-form .radio.state-success i, .sky-form .checkbox.state-success i, .sky-form .toggle.state-success i, .sky-form .toggle.state-success input:checked + i {
            background: #f0fff0 none repeat scroll 0 0;
        }

        .verifycode input.form-control {
            width: 50%;
        }

        .checkbox lable {
            font-size: 14px;
        }
    </style>

</head>

<body>
<div class="page-header">
    <h1>
        账号新建
        <small><i class="icon-double-angle-right"></i>

        </small>
    </h1>
</div>

<div class="row">
    <div class="col-xs-12">
        <!--Reg Block-->
        <form class="form-horizontal" action="/admin/user/register/submit" method="post" id="sky-form">
                <input class="ace" type="radio" checked="" name="type" value="NORMAL">
            <div class="form-group">


                <label for="mobile" class="col-sm-3 control-label no-padding-right">账号：</label>
                <div class="col-sm-6">
                    <input id="mobile" name="mobile" type="text" class="form-control" placeholder="请输入手机号码作为登录账号"
                           autocomplete="off">
                </div>
            </div>
            <div class="form-group">


                <label for="realName" class="col-sm-3 control-label no-padding-right">名字：</label>
                <div class="col-sm-6">
                    <input name="realName" type="text" class="form-control" placeholder="请输入名字" autocomplete="off">
                </div>
            </div>
            <div class="form-group">


                <label for="password" class="col-sm-3 control-label no-padding-right">密码：</label>
                <div class="col-sm-6">
                    <input id="password" name="password" type="password" class="form-control" placeholder="请输入密码"
                           autocomplete="off">
                </div>
            </div>
            <div class="form-group">


                <label for="repassword" class="col-sm-3 control-label no-padding-right">重复密码：</label>
                <div class="col-sm-6">
                    <input name="repassword" type="password" class="form-control" placeholder="请再次输入密码"
                           autocomplete="off">
                </div>
            </div>
            <div class="form-group">
                <label for="mobile" class="col-sm-3 control-label no-padding-right">部门：</label>
                <div class="col-sm-6">
                    <select id="departmentId" name="departmentId" class="form-control" >
                        <option value="">--请选择部门--</option>
                        <c:forEach items="${depts}" var="dept">
                            <option value="${dept.id}">${dept.departmentName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="form-group">


                <label for="registerVerifyCode" class="col-sm-3 control-label no-padding-right">验证码：</label>
                <div class="col-sm-6" id="verifycode">
                    <input type="text" value="" class="form-control" placeholder="验证码" id="registerVerifyCode"
                           name="registerVerifyCode"
                           maxlength="5" autocomplete="off" data-flag="false">
                    <img onclick="javascript:changeVerifyCode();" title="验证码图片" alt="验证码图片"
                         id="register_img_verifycode"
                         name="register_img_verifycode" src="/auth/genRegisterVerifyCode?${radom }"
                         style="height: 34px">
                    <i style="display: none;color: #69aa46 !important; font-size:18px" class="fa fa-check"
                       id="okSign"></i>
                    <i style="display: none;color: red !important; font-size:18px" class="fa fa-times"
                       id="unokSign"></i>
                </div>
            </div>

            <hr>
            <div class="row">
                <div class="col-md-10 col-md-offset-1">
                    <button type="submit" class="btn btn-info" id="registButton">提交注册</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!--End Reg Block-->
<myjs>
    <script type="text/javascript" src="/resources/script/auth/registerForm.js"></script>
    <script type="text/javascript" src="/resources/script/auth/register.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            registerForm.initForm();
        });
    </script>
</myjs>
</body>
</html> 