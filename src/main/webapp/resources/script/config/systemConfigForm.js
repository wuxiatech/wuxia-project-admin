var systemConfigForm = function () {

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
            var _form=$("#systemConfigForm");
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
                    				'configId':{
					required:true,
					maxlength : 10
				},
				'configValue':{
					required:true,
					maxlength : 200
				},
				'configType':{
					required:true,
					maxlength : 200
				},
				'describe':{
					maxlength : 255
				},
				'ordinalNum':{
					maxlength : 7
				},
				'status':{
					required:true,
					maxlength : 1
				}

                },

                // Messages for form validation
                messages:
                {
                    				'configId':{
					required : '主键为必填',
					maxlength : '主键不能输入超过10个字符'
				},
				'configValue':{
					required : '值内容为必填',
					maxlength : '值内容不能输入超过200个字符'
				},
				'configType':{
					required : '配置类型名为必填',
					maxlength : '配置类型名不能输入超过200个字符'
				},
				'describe':{
					maxlength : '描述不能输入超过255个字符'
				},
				'ordinalNum':{
					maxlength : '排序不能输入超过7个字符'
				},
				'status':{
					required : '状态为必填',
					maxlength : '状态不能输入超过1个字符'
				}

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

