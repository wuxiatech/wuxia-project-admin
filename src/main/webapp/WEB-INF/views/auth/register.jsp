<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->  
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->  
<!--[if !IE]><!--> <html lang="en"> <!--<![endif]-->  
<head>
   <title>注册</title>
	<c:set var="cdn_resources" value="//17.zjcdn.cn" />
    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Favicon -->
   <!--  <link rel="shortcut icon" href="favicon.ico"> -->

    <!-- Web Fonts -->
    <link rel='stylesheet' type='text/css' href='//fonts.useso.com/css?family=Open+Sans:400,300,600&amp;subset=cyrillic,latin'>

    <!-- CSS Global Compulsory -->
    <link rel="stylesheet" href="${cdn_resources}/assets/plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${cdn_resources}/assets/css/style.css">

    <!-- CSS Implementing Plugins -->
    <link rel="stylesheet" href="${cdn_resources}/assets/plugins/animate.css">
    <link rel="stylesheet" href="${cdn_resources}/assets/plugins/line-icons/line-icons.css">
    <link rel="stylesheet" href="${cdn_resources}/assets/plugins/font-awesome/css/font-awesome.min.css">

    <!-- CSS Page Style -->    
    <link rel="stylesheet" href="${cdn_resources}/assets/css/pages/page_log_reg_v2.css">    
	<link rel="stylesheet" href="${cdn_resources}/assets/plugins/sky-forms-pro/skyforms/css/sky-forms.css">
    <link rel="stylesheet" href="${cdn_resources}/assets/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css">
	<style>
#sky-form .state-error input, #sky-form .state-error select, #sky-form .state-error select+i,
	#sky-form .state-error textarea, #sky-form .radio.state-error i,
	#sky-form .checkbox.state-error i, #sky-form .toggle.state-error i,
	#sky-form .toggle.state-error input:checked+i {
	background: #fff0f0 none repeat scroll 0 0;
}

#sky-form .state-success input, #sky-form .state-success select, #sky-form .state-success select + i, #sky-form .state-success textarea, #sky-form .radio.state-success i, #sky-form .checkbox.state-success i, #sky-form .toggle.state-success i, #sky-form .toggle.state-success input:checked + i {
    background: #f0fff0 none repeat scroll 0 0;
}

.verifycode input.form-control{
width: 50%;
}
</style>
    
</head> 

<body>

<!--=== Content Part ===-->    
<div class="container">
    <!--Reg Block-->
    <form id="sky-form" action="/auth/register/submit" method="post">
    <div class="reg-block">
        <div class="reg-block-header">
            <h2>医生注册</h2>
            <!-- <ul class="social-icons text-center">
                <li><a class="rounded-x social_facebook" data-original-title="Facebook" href="#"></a></li>
                <li><a class="rounded-x social_twitter" data-original-title="Twitter" href="#"></a></li>
                <li><a class="rounded-x social_googleplus" data-original-title="Google Plus" href="#"></a></li>
                <li><a class="rounded-x social_linkedin" data-original-title="Linkedin" href="#"></a></li>
            </ul>-->
            <p>已是注册用户？ 点击<a class="color-green" href="/auth/login">登录</a> 进入您的账户。</p>
        </div>

        <div class="note"></div>
        <div class="input-group margin-bottom-20">
            <span class="input-group-addon"><i class="fa fa-tablet"></i></span>
            <input id="mobile" name="mobile" type="text" class="form-control" placeholder="请输入您的手机号码作为登录账号" autocomplete="off">
        </div>
        <div class="note"></div>
        <div class="input-group margin-bottom-20">
            <span class="input-group-addon"><i class="fa fa-user"></i></span>
            <input name="name" type="text" class="form-control" placeholder="请输入您的名字" autocomplete="off">
        </div>
        <div class="note"></div>
        <div class="input-group margin-bottom-20">
            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
            <input id="password" name="password" type="password" class="form-control" placeholder="请输入密码" autocomplete="off">
        </div>
        <div class="note"></div>
        <div class="input-group margin-bottom-20">
            <span class="input-group-addon"><i class="fa fa-key"></i></span>
            <input name="repassword" type="password" class="form-control" placeholder="请再次输入密码" autocomplete="off">
        </div>
        <div class="input-group margin-bottom-30 verifycode">
       		<span class="input-group-addon"><i class="fa fa-eye"></i></span>
        	<input type="text" value="" class="form-control" placeholder="验证码" id="registerVerifyCode" name="registerVerifyCode"
										maxlength="5" autocomplete="off" type="text" data-flag="false">
			<img onclick="javascript:changeVerifyCode();" title="验证码图片" alt="验证码图片" id="register_img_verifycode" name="register_img_verifycode" src="/auth/genRegisterVerifyCode?${radom }" style="height: 34px">
			<i style="display: none;color: #69aa46 !important; font-size:18px" class="fa fa-check" id="okSign"></i>
			<i style="display: none;color: red !important; font-size:18px" class="fa fa-times" id="unokSign"></i>
			</div>
        <hr>
		<!-- 
        <div class="checkbox">            
            <label>
                <input type="checkbox"> 
                I read <a target="_blank" href="page_terms.html">Terms and Conditions</a>
            </label>
        </div> -->
                                
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <button type="submit" class="btn-u btn-block" id="registButton">提交注册</button>                
            </div>
        </div>
    </div>
    </form>
    <!--End Reg Block-->
</div><!--/container-->
<!--=== End Content Part ===-->

<!-- JS Global Compulsory -->           
<script type="text/javascript" src="${cdn_resources}/assets/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="${cdn_resources}/assets/plugins/jquery/jquery-migrate.min.js"></script>
<script type="text/javascript" src="${cdn_resources}/assets/plugins/bootstrap/js/bootstrap.min.js"></script> 
<!-- JS Implementing Plugins -->           
<script type="text/javascript" src="${cdn_resources}/assets/plugins/back-to-top.js"></script>
<script type="text/javascript" src="${cdn_resources}/assets/plugins/backstretch/jquery.backstretch.min.js"></script>
<script type="text/javascript" src="${cdn_resources}/assets/plugins/sky-forms-pro/skyforms/js/jquery.form.min.js"></script>
<script type="text/javascript" src="${cdn_resources}/assets/plugins/sky-forms-pro/skyforms/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${cdn_resources}/assets/plugins/sky-forms-pro/skyforms/js/jquery-ui.min.js"></script>
<!-- JS Page Level -->           
<script type="text/javascript" src="${cdn_resources}/assets/js/app.js"></script>
<script type="text/javascript" src="/resources/script/common.js"></script>
<script type="text/javascript" src="/resources/script/base.js"></script>
<script type="text/javascript" src="/resources/script/auth/registerForm.js"></script>
<script type="text/javascript" src="/resources/script/auth/register.js"></script>
<script type="text/javascript" src="/resources/script/messages_cn.js"></script>
<script type="text/javascript">
    jQuery(document).ready(function() {
        App.init();
        registerForm.initForm();
        });
</script>
<script type="text/javascript">
    $.backstretch([
      "${cdn_resources}/assets/img/bg/19.jpg",
      "${cdn_resources}/assets/img/bg/11.jpg",
      ], {
        fade: 1000,
        duration: 7000
    });
</script>
<!--[if lt IE 9]>
    <script src="${cdn_resources}/assets/plugins/respond.js"></script>
    <script src="${cdn_resources}/assets/plugins/html5shiv.js"></script>
    <script src="${cdn_resources}/assets/plugins/placeholder-IE-fixes.js"></script>
<![endif]-->

</body>
</html> 