var adPositionForm = function () {

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
            var _form=$("#adPositionForm");
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
                    				'adPositionId':{
					required:true,
					maxlength : 20
				},
				'appid':{
					maxlength : 32
				},
				'name':{
					maxlength : 100
				},
				'description':{
					maxlength : 255
				},
				'creator':{
					maxlength : 45
				},
				'updater':{
					maxlength : 45
				},

                },

                // Messages for form validation
                messages:
                {
                    				'adPositionId':{
					required : '广告位编码为必填',
					maxlength : '广告位编码不能输入超过20个字符'
				},
				'appid':{
					maxlength : 'appid不能输入超过32个字符'
				},
				'name':{
					maxlength : '广告位名不能输入超过100个字符'
				},
				'description':{
					maxlength : '广告位描述不能输入超过255个字符'
				},
				'creator':{
					maxlength : '创建人不能输入超过45个字符'
				},
				'updater':{
					maxlength : '修改人不能输入超过45个字符'
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

