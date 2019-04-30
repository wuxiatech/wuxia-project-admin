var ad1Form = function () {

    return {
        //Form
        initForm: function () {
            /*Tooltips*/
            jQuery('.tooltips').tooltip();
            jQuery('.tooltips-show').tooltip('show');
            jQuery('.tooltips-hide').tooltip('hide');
            jQuery('.tooltips-toggle').tooltip('toggle');
            jQuery('.tooltips-destroy').tooltip('destroy');
            // Validation
            var _form=$("#ad1Form");
            var spinner = new Spinner(opts_spinner);
            var target = $("body");
            _form.validate({
                //失去焦点时验证
                onfocusout : function(element) {
                $(element).valid();
                },
                onclick:false,
                onkeyup : false,
                focusInvalid : true,
                // Rules for form validation
                rules:
                {
                    				'adId':{
					required:true,
					maxlength : 20
				},
				'adPositionId':{
					required:true,
					maxlength : 10
				},
				'adName':{
					maxlength : 100
				},
				'title':{
					required:true,
					maxlength : 150
				},
				'pic1':{
					required:true,
					maxlength : 300
				},
				'pic2':{
					maxlength : 300
				},
				'pic3':{
					maxlength : 300
				},
				'regions':{
					maxlength : 1000
				},
				'creator':{
					maxlength : 45
				},
				'updater':{
					maxlength : 45
				},
				'url':{
					maxlength : 255
				},
				'tagDes':{
					maxlength : 10
				},

                },

                // Messages for form validation
                messages:
                {
                    				'adId':{
					required : '广告ID为必填',
					maxlength : '广告ID不能输入超过20个字符'
				},
				'adPositionId':{
					required : '广告位置为必填',
					maxlength : '广告位置不能输入超过10个字符'
				},
				'adName':{
					maxlength : '名称不能输入超过100个字符'
				},
				'title':{
					required : '广告标题为必填',
					maxlength : '广告标题不能输入超过150个字符'
				},
				'pic1':{
					required : '主图为必填',
					maxlength : '主图不能输入超过300个字符'
				},
				'pic2':{
					maxlength : '图2不能输入超过300个字符'
				},
				'pic3':{
					maxlength : '图3不能输入超过300个字符'
				},
				'regions':{
					maxlength : '投放地域不能输入超过1000个字符'
				},
				'creator':{
					maxlength : '创建人不能输入超过45个字符'
				},
				'updater':{
					maxlength : '修改人不能输入超过45个字符'
				},
				'url':{
					maxlength : '广告跳转地址不能输入超过255个字符'
				},
				'tagDes':{
					maxlength : '标签文案不能输入超过10个字符'
				},

                },
                                    
                // Ajax form submition                  
                submitHandler: function(form)
                {
                    $(form).ajaxSubmit(
                        {
                            //dataType: "json",
                            beforeSend: function () {
                                _form.find('button[type="submit"]').button('loading');
                                spinner.spin(target.get(0));
                            },
                            success: function () {
                                // _form.addClass('submited');
                                spinner.spin();
                                _form.find('button[type="submit"]').button('reset');
                                bootbox.alert("保存成功");
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                spinner.spin();
                                if (XMLHttpRequest.status != 200) {
                                    _form.find('button[type="submit"]').button('reset');
                                    console.log(XMLHttpRequest);
                                    bootbox.alert('<p>很抱歉，保存时系统返回如下信息：</p><p>' + XMLHttpRequest.responseText + '</p>'
                                    );
                                }
                            }
                        });
                },
                
                // Do not change code below
                errorPlacement: function(error, element)
                {
                    error.insertAfter(element.parent());
                }
            });

        }

    };
    
}();

