var userCheckinForm = function () {

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
            var _form=$("#userCheckinForm");
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
                    				'userId':{
					required:true,
					maxlength : 10
				},
				'ip':{
					maxlength : 64
				}

                },

                // Messages for form validation
                messages:
                {
                    				'userId':{
					required : '会员编码为必填',
					maxlength : '会员编码不能输入超过10个字符'
				},
				'ip':{
					maxlength : 'IP地址不能输入超过64个字符'
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

