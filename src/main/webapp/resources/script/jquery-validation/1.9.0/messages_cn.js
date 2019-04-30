/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: CN
 */
jQuery.extend(jQuery.validator.messages, {
        required: "请填写信息",
		remote: "请修正该字段",
		email: "请输入正确格式的电子邮件",
		url: "请输入合法的网址",
		date: "请输入合法的日期",
		dateISO: "请输入合法的日期 (ISO).",
		number: "请输入合法的数字",
		digits: "只能输入整数",
		creditcard: "请输入合法的信用卡号",
		equalTo: "请再次输入相同的值",
		accept: "请输入拥有合法后缀名的字符串",
		maxlength: jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"),
		minlength: jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"),
		rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
		range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
		max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
		min: jQuery.validator.format("请输入一个最小为 {0} 的值")
});
//昵称    
jQuery.validator.addMethod("isCompanyName", function(value, element) {       
    var name = /^[a-zA-z0-9\u4E00-\u9FA5\.\_\-\s]*$/;
    return this.optional(element) || name.test(value);       
}, "仅允许输入（字母，数字，中文，空格，英文.，下划线）"); 
//昵称    
jQuery.validator.addMethod("isUsername", function(value, element) {       
    var name = /^[a-zA-z0-9\u4E00-\u9FA5\.\_\-\s]*$/;
    return this.optional(element) || name.test(value);       
}, "请输入字母，数字或中文");   
//密码
jQuery.validator.addMethod("isPassword", function(value, element) {       
	var password = /^(([a-zA-z]+[0-9]+[a-zA-z0-9]*)|([0-9]+[a-zA-z]+[a-zA-z0-9]*))*$/;
    return this.optional(element) || password.test(value);       
}, "请输入字母，数字的组合");   
// 手机号码验证       
jQuery.validator.addMethod("isMobile", function(value, element) {       
    var length = value.length;   
    var mobile = /^1[3584]\d{9}$/i;   
    return this.optional(element) || (length == 11 && mobile.test(value));       
}, "请正确填写您的手机号码");       
     
// 电话号码验证       
jQuery.validator.addMethod("isTel", function(value, element) {       
	var tel = /^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d+)*$/i;      //电话号码格式010-12345678   
    return this.optional(element) || (tel.test(value));       
}, "请正确填写您的电话号码");  
//联系电话(手机/电话皆可)验证 
jQuery.validator.addMethod("isPhone", function(value,element) { 
  var mobile = /^1[3584]\d{9}$/i;
  var tel = /^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d+)*$/i; 
  return this.optional(element) || (tel.test(value) || (length == 11 && mobile.test(value)) ); 
}, "请正确填写您的号码"); 

// Email验证
jQuery.validator.addMethod("isEmail", function(value, element) {
	var reg = /^([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	return this.optional(element) || (reg.test(value));
}, "请正确填写您的电子邮箱");
//英文和数字的验证
jQuery.validator.addMethod("isEnglishOrShuZi",function(value,element){
	var reg=/^[0-9a-zA-Z\x00-\xff&]+$/g;
	return this.optional(element)|| (reg.test(value));
},"请输入数字或者英文");
// 验证非纯数字
jQuery.validator.addMethod("isNAN", function(value, element) {
	var reg = /^\d+$/;
	return this.optional(element) || (!reg.test(value));
}, "用户名不能为纯数字组合");
// 验证海关编码 十位正整数
jQuery.validator.addMethod("isCustomCode", function(value,element) { 
	  var mobile = /^((\d{10}))*$/i; 
	  return this.optional(element) || (mobile.test(value)); 
	}, "请正确填写海关编码"); 
// 验证数字格式的金额
jQuery.validator.addMethod("isPriceNum", function(value,element) { 
	var mobile = /^[1-9]{1}\d*(\.\d{1,2})?$/; 
	return this.optional(element) || (mobile.test(value)); 
}, "请正确填写数字格式的金额"); 
// 验证正整数
jQuery.validator.addMethod("isPositiveInteger", function(value,element) { 
	var mobile = /^[1-9]{1}\d*?$/; 
	return this.optional(element) || (mobile.test(value)); 
}, "请正确填写正整数"); 

// 验证英文以及空格
jQuery.validator.addMethod("isEngOnly", function(value,element) { 
	var mobile = /^[a-zA-Z\s]+$/; 
	return this.optional(element) || (mobile.test(value)); 
}, "请填写英文"); 
jQuery.validator.addMethod("isEngNameMul", function(value,element) { 
	var mobile = /^([a-zA-Z\s]+(;)?)*$/i; 
	return this.optional(element) || (mobile.test(value)); 
}, "请按格式填写"); 
//验证海关编码 十位正整数 多组数据用分号隔开形如 1234567899;1234567899;
jQuery.validator.addMethod("isCustomCodeMul", function(value,element) { 
	  var mobile = /^((\d{10})(;)?)*$/i; 
	  return this.optional(element) || (mobile.test(value))||value=='多个海关编码,请用分号;隔开'; 
	}, "请正确填写海关编码"); 
//验证数字格式的重量-正浮点数
jQuery.validator.addMethod("isPositiveFloatNum", function(value,element) { 
	var mobile = /^[0-9]{1}\d*(\.\d{1,2})?$/; 
	return this.optional(element) || (mobile.test(value));
}, "请填数字(或带两位小数)"); 
//验证QQ的格式
jQuery.validator.addMethod("isQQNum", function(value,element) { 
	var mobile = /^\d{5,11}$/; 
	return this.optional(element) || (mobile.test(value));
}, "请填QQ号");

//验证表达式
jQuery.validator.addMethod("pattern", function(value,element,param) { 
	var pattern = param; 
	var flag = false;
	try{
		flag = pattern.test(value);
	}catch(err){
		flag=false;
	}
	return this.optional(element) || flag;
}, "请填符合正则表达式的内容"); 