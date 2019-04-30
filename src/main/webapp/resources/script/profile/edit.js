$(function() {
	editForm.initForm();
	// 去掉所有input的autocomplete, 显示指定的除外
	$('input:not([autocomplete]),textarea:not([autocomplete]),select:not([autocomplete])').attr('autocomplete', 'off');
	// 防止浏览器记住密码
	$("#password").focus(function() {
		$(this).attr("type", "password");
	});
	//$("#register_img_verifycode").attr("src", "/auth/genRegisterVerifyCode");
	// 校验手机号码&&发送手机验证码
	$("#mobileVerificationCode").click(function() {
		//获得手机号码文本框
		var temp_mobile = $("#mobile");
		//获得手机验证码文本框
		var temp_code = $("#mobileVerificationCode");
		if (temp_mobile.valid() === 1 && temp_mobile.attr("data-flag") === "true") {
			var t = 60;
			var i = setInterval(function() {
				temp_code.text(t-- + "秒");
			}, 1000);
			temp_mobile.attr("readonly", true);
			temp_code.attr("disabled", true).addClass("btn-u-default");// 发验证码按钮变色
			setTimeout(function() {
				clearTimeout(i);
				temp_code.text("点击发送验证码").removeAttr("disabled").removeClass("btn-u-default");// 发验证码按钮变色
				temp_mobile.removeAttr("readonly").addClass("btn-u-default");
				temp_code.attr("data-clickable", true);
			}, t * 1000 + 1000);
			$.ajax({
				cache : false,
				type : "POST",
				url : "/auth/captcha/send",
				data : {
					mobile : temp_mobile.val()
				},
				success : function(data) {
					var code = data.code;
					if ("00000" == code) {
					}else{
						$("#errorLabel").text(data.msg).show();
					}
				},
				error : function(data){
				}
			});
		} 
	});

	// 检查手机是否已经注册
	/*$("#mobile").on("keyup blur", function() {
		//获得手机号码文本框
		var temp_mobile = $("#mobile");
		//获得手机验证码文本框
		var temp_code = $("#mobileVerificationCode");
		var l = $.trim(temp_mobile.val()).length;
		if (l === 11 && temp_mobile.valid() === 1) {
			$.ajax({
				cache : false,
				type : "POST",
				url : "/auth/mobile/verify",
				data : {
					mobile : temp_mobile.val()
				},
				success : function(data) {
					var code = data.code;
					if("00000" == code){
						temp_mobile.parent().addClass("margin-bottom-20");
						$("#errorLabel").text("").hide();
						temp_mobile.attr("data-flag", true).addClass("valid").removeClass("invalid").parent().addClass("state-success").removeClass("state-error");
						mobileFlag = true;
						if(mobileFlag && registCodeFlag && smsFlag && salesCode){
							$("#registButton").attr("disabled", false).removeClass("btn-u-default");
							temp_code.removeClass("btn-u-default");
						}
					}else{
						$("#errorLabel").text(data.msg).show();
						temp_code.addClass("btn-u-default");
						temp_mobile.attr("data-flag", false).addClass("invalid").removeClass("valid").parent().addClass("state-error").removeClass("state-success");
						mobileFlag = false;
						$("#registButton").attr("disabled", true).addClass("btn-u-default");
					}
				},error: function(data){
					$("#errorLabel").text("手机验证码不正确").show;
					mobileFlag = false;
					$("#registButton").attr("disabled", true).addClass("btn-u-default");
				}
			});
		} else {
			temp_mobile.parent().addClass("margin-bottom-20");
			$("#errorLabel").text("").hide();
			temp_mobile.val($.trim(temp_mobile.val()));
			temp_code.addClass("btn-u-default");
			temp_mobile.attr("data-flag", false).addClass("invalid").removeClass("valid").parent().addClass("state-error").removeClass("state-success");
		}
	});
	
	// 检查验证码是否正确
	$("#verifycode").on("keyup blur", function() {
		var temp_verifycode = $("#verifycode");
		if (temp_verifycode.valid() == 1) {
			$.ajax({
				cache : false,
				type : "POST",
				url : "/auth/captcha/verify",
				data : {
					mobile : $("#mobile").val(),
					verifycode : temp_verifycode.val()
				},
				success : function(data) {
					var code = data.code;
					if ("00000" == code) {
						$("#errorLabel").text("").hide();
						temp_verifycode.attr("data-flag", true).addClass("valid").removeClass("invalid").parent().addClass("state-success").removeClass("state-error");
						smsFlag = true;
						if(mobileFlag && registCodeFlag && smsFlag && salesCode){
							$("#registButton").attr("disabled", false).removeClass("btn-u-default");
						}
					} else {
						$("#errorLabel").text(data.msg).show();
						temp_verifycode.attr("data-flag", false).addClass("invalid").removeClass("valid").parent().addClass("state-error").removeClass("state-success");
						smsFlag = false;
						$("#registButton").attr("disabled", true).addClass("btn-u-default");
					}
				},error : function(data){
					$("#errorLabel").text("验证码无效").show();
					temp_verifycode.attr("data-flag", false).addClass("invalid").removeClass("valid").parent().addClass("state-error").removeClass("state-success");
					smsFlag = false;
					$("#registButton").attr("disabled", true).addClass("btn-u-default");
				}
			});
		} else {
			temp_verifycode.attr("data-flag", false).addClass("invalid").removeClass("valid").parent().addClass("state-error").removeClass("state-success");
			smsFlag = false;
			$("#registButton").attr("disabled", true).addClass("btn-u-default");
		}
	});
	
	*/
	// 点击注册
//	$(".sky-form").submit(function() {
//		if(valid.valid()){
//			return true;
//		}else
//			return false;
////		if (valid.valid() && $("#mobile").attr("data-flag") === "true" && $("#verifycode").attr("data-flag") === "true") {
////			return true;
////		} else {
////			return false;
////		}
//	});
	
	
	$("#registerVerifyCode").blur(function(){ //验证用户名是否存在
		$.post(
        "/auth/checkRegisterVerifyCode",
        {
     	   verifycode:$("#registerVerifyCode").val()
        },
        function(rtx){
        	if(rtx){
        		
        	}else{
        		
        	}
        }
		)
	}) 
});
function changeVerifyCode(){
	var append = '?' + new Date().getTime();
	$("#register_img_verifycode").attr('src', '/auth/genRegisterVerifyCode' + append);
}
