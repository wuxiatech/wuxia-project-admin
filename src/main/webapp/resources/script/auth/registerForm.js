var valid;
var registerForm = function() {
	return {
		// Checkout Form
		initForm : function() {
			// Validation
			valid = $('#sky-form').validate(
					{
						// Rules for form validation
						rules : {
							"mobile" : {
								isMobile : true,
								required : true,
								remote:{ //验证用户名是否存在
						               type:"POST",
						               url:"/auth/mobile/uniqe",
						               data:{
						            	   mobile:function(){return $("#mobile").val();}
						               } 
						        } 
							},
							"realName" : {
								maxlength: 32,
								required : true
							},
							"password" : {
								required : true,
								minlength : 6,
								maxlength : 16
							},
							"repassword" : {
								equalTo:'#password',
								required : true,
								minlength : 6,
								maxlength : 16
							},
							"registerVerifyCode":{
								required : true,
								remote:{ //验证用户名是否存在
						               type:"POST",
						               url:"/auth/checkRegisterVerifyCode",
						               data:{
						            	   verifycode:function(){return $("#registerVerifyCode").val();}
						               } 
						        } 
							}
						},
						// Messages for form validation
						messages : {
							"mobile" : {
								isMobile : "请输入正确的手机号码",
								required : "请输入手机号码",
								remote:"手机已注册，如忘记密码请找回密码"
							},
							"realName" : {
								required : "请输入您的名字"
							},
							"password" : {
								required : "请输入您的密码",
								minlength : "密码长度不能少于6位",
								maxlength : "密码长度不能大于16位"
							},
							"repassword" : {
								required : "请再次输入您的密码",
								equalTo:"两次输入的密码不一致",
								minlength : "长度不能少于6位",
								maxlength : "长度不能大于6位"
							},
							"registerVerifyCode":{
								required: "请输入图中的数字",
								remote: "验证码匹配有误，请尝试点击二维码后重新输入"
							}
						},
						// Do not change code below
						errorPlacement : function(error, element) {
								if(isNotBlank($(error).text())){
								$(element).parent().prev(".note").addClass("note-error").html(error);
								}
						},
						success : function(label) {
							//log(label);
						}

					});
		}

	};

}();