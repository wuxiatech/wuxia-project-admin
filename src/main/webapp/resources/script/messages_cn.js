/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: CN
 */
jQuery.extend(jQuery.validator.messages, {
        required: "",
		remote: "",
		email: "",
		url: "",
		date: "",
		dateISO: "",
		number: "",
		digits: "",
		creditcard: "",
		equalTo: "",
		accept: "",
		maxlength: "",
		minlength: "",
		rangelength: "",
		range: "",
		max: "",
		min: ""
});
//昵称    
jQuery.validator.addMethod("isCompanyName", function(value, element) {       
    var name = /^[a-zA-z0-9\u4E00-\u9FA5\.\_\(\)\（\）\-\s]*$/;
    return this.optional(element) || name.test(value);       
}, ""); 
//昵称    
jQuery.validator.addMethod("isUsername", function(value, element) {       
    var name = /^[a-zA-z0-9\u4E00-\u9FA5\.\_\-\s]*$/;
    return this.optional(element) || name.test(value);       
}, "");   
//密码
jQuery.validator.addMethod("isPassword", function(value, element) {       
	var password = /^(([a-zA-z]+[0-9]+[a-zA-z0-9]*)|([0-9]+[a-zA-z]+[a-zA-z0-9]*))*$/;
    return this.optional(element) || password.test(value);       
}, "");   
// 手机号码验证       
jQuery.validator.addMethod("isMobile", function(value, element) {       
    var length = value.length;   
    var mobile = /^1[3584]\d{9}$/i;   
    return this.optional(element) || (length == 11 && mobile.test(value));       
}, "");       
     
// 电话号码验证       
jQuery.validator.addMethod("isTel", function(value, element) {       
	var tel = /^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d+)*$/i;      //电话号码格式010-12345678   
    return this.optional(element) || (tel.test(value));       
}, "");  
//联系电话(手机/电话皆可)验证 
jQuery.validator.addMethod("isPhone", function(value,element) { 
  var mobile = /^1[3584]\d{9}$/i;
  var tel = /^((\d{3,4})|\d{3,4}-)?\d{7,8}(-\d+)*$/i; 
  return this.optional(element) || (tel.test(value) || (length == 11 && mobile.test(value)) ); 
}, ""); 

// Email验证
jQuery.validator.addMethod("isEmail", function(value, element) {
	var reg = /^([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.|-]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	return this.optional(element) || (reg.test(value));
}, "");
//英文和数字的验证
jQuery.validator.addMethod("isEnglishOrShuZi",function(value,element){
	var reg=/^[0-9a-zA-Z\x00-\xff&]+$/g;
	log(value);
	log(element);
	return this.optional(element)|| (reg.test(value));
},"");
// 验证非纯数字
jQuery.validator.addMethod("isNAN", function(value, element) {
	var reg = /^\d+$/;
	return this.optional(element) || (!reg.test(value));
}, "");
// 验证海关编码 十位正整数
jQuery.validator.addMethod("isCustomCode", function(value,element) { 
	  var customCode = /^((\d{10}))*$/i; 
	  return this.optional(element) || (customCode.test(value)); 
	}, ""); 
// 验证数字格式的金额
jQuery.validator.addMethod("isPriceNum", function(value,element) { 
	var priceNum = /^[1-9]{1}\d*(\.\d{1,2})?$/; 
	return this.optional(element) || (priceNum.test(value)); 
}, ""); 
// 验证正整数
jQuery.validator.addMethod("isPositiveInteger", function(value,element) { 
	var positiveInteger = /^[1-9]{1}\d*?$/; 
	return this.optional(element) || (positiveInteger.test(value)); 
}, ""); 

// 验证英文以及空格
jQuery.validator.addMethod("isEngOnly", function(value,element) { 
	var engOnly = /^[a-zA-Z\s]+$/; 
	return this.optional(element) || (engOnly.test(value)); 
}, ""); 
jQuery.validator.addMethod("isEngNameMul", function(value,element) { 
	var engNameMul = /^([a-zA-Z\s]+(;)?)*$/i; 
	return this.optional(element) || (engNameMul.test(value)); 
}, ""); 
//验证商品编码 多组数据用分号隔开形如 productName;商品编码;
jQuery.validator.addMethod("isProductNameMul", function(value,element) { 
	var productNameMul = /^((.+)(;)?)*$/i; 
	return this.optional(element) || ((value!=='多个商品名称请用分号;隔开') && (value!=='多个商品名称请用分号；隔开') && (productNameMul.test(value))); 
}, ""); 
//验证海关编码 十位正整数 多组数据用分号隔开形如 1234567899;1234567899;
jQuery.validator.addMethod("isCustomCodeMul", function(value,element) { 
	  var customCodeMul = /^((\d{10})(;)?)*$/i; 
	  return this.optional(element) || ((value!=='多个海关编码请用分号;隔开') && (value!=='多个海关编码请用分号；隔开') && (customCodeMul.test(value))); 
	}, ""); 
//验证数字格式的重量-正浮点数
jQuery.validator.addMethod("isPositiveFloatNum", function(value,element) { 
	var positiveFloatNum = /^[0-9]{1}\d*(\.\d{1,2})?$/; 
	return this.optional(element) || (positiveFloatNum.test(value));
}, ""); 
//验证QQ的格式
jQuery.validator.addMethod("isQQNum", function(value,element) { 
	var qq = /^\d{5,11}$/; 
	return this.optional(element) || (qq.test(value));
}, "");

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
}, ""); 

function errorTop() {
	$('body,html').animate({
		scrollTop : $(".invalid").first().offset().top
	}, 200);
}