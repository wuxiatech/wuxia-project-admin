var valid1;
var editForm = function() {
	return {
		// Checkout Form
		initForm : function() {
			// Validation
			valid1 = $('form', "#profile-1").validate(
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
						            	   mobile:function(){return $("#mobile").val();},
										   oldmobile:function(){return $("#oldmobile").val()}
						               } 
						        } 
							},
							"realName" : {
								required : true
							},
							"title" : {
								required : true
							}
							/*,
							"registerVerifyCode":{
								required : true,
								remote:{ //验证用户名是否存在
						               type:"POST",
						               url:"/auth/checkRegisterVerifyCode",
						               data:{
						            	   verifycode:function(){return $("#registerVerifyCode").val();}
						               } 
						        } 
							}*/
						},
						// Messages for form validation
						messages : {
							"mobile" : {
								isMobile : "请输入正确的手机号码",
								required : "请输入手机号码",
								remote:"手机格式不正确或已注册"
							},
							"realName" : {
								required : "请输入您的名字"
							},
							"title" : {
								required : "请输入您的职称"
							}
							/*,
							"registerVerifyCode":{
								required: "请输入图中的数字"
							}*/
						},
						// Do not change code below
						errorPlacement : function(error, element) {
							if($(element).next("b").lenth > 0){
								$(element).next("b").html(error);
							}else{
								$("<b class=\"tooltip tooltip-top-right\"></b>").html(error).insertAfter(element);
							}
						},
						 // Ajax form submition                  
			            submitHandler: function(form){
			                $(form).ajaxSubmit({
			                	success: function(d){
			                    	alert("修改成功");
			                    },error(t){
			                    	alert(t);
			                    }
			                });
			            }

					});
			
			
			valid2 = $('form', "#password-1").validate(
					{
						// Rules for form validation
						rules : {
							"oldpassword" : {
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
							}
						},
						// Messages for form validation
						messages : {
							"oldpassword" : {
								required : "请输入您的原密码"
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
							}
						},
						// Do not change code below
						errorPlacement : function(error, element) {
							if($(element).next("b").lenth > 0){
								$(element).next("b").html(error);
							}else{
								$("<b class=\"tooltip tooltip-top-right\"></b>").html(error).insertAfter(element);
							}
						},
						 // Ajax form submition                  
			            submitHandler: function(form){
			                $(form).ajaxSubmit({
			                    success: function(d){
			                    	alert("修改成功");
			                    },error(t){
			                    	alert(t);
			                    }
			                });
			            }

					});
		}

	};

}();