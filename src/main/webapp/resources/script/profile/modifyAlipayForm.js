var modifyalipayform = function () {

    return {
        //Form
        initForm: function () {
            $('#modify-alipay-form').validate(
                {
                    // Rules for form validation
                    rules: {
                        "externAccount": {
                            required: true
                            /*remote: { //验证用户名是否存在
                                type: "POST",
                                url: "/news/user/alipayuniqe",
                                data: {
                                    externAccount: function () {
                                        return $("#form-field-externAccount").val();
                                    }
                                }
                            }*/
                        },
                        "externName": {
                            maxlength: 32,
                            required: true
                        }
                    },
                    // Messages for form validation
                    messages: {
                        "externAccount": {
                            required: "请输入支付宝账号"
                            //remote: "已被多个账号绑定"
                        },
                        "externName": {
                            required: "请输入支付宝名字"
                        }
                    },
                    // Do not change code below
                    errorPlacement: function (error, element) {
                        if (isNotBlank($(error).text())) {
                            $(element).parent().prev(".note").addClass("note-error").html(error);
                        }
                    },
                    submitHandler: function (form) {
                        console.log($(form).serialize());
                        $.ajax(
                            {
                                url: "/news/user/modifyalipay?" + $(form).serialize(),
                                success: function () {
                                    $("#alipay-modal-form").modal('hide');
                                    bootbox.alert("修改成功");
                                }, error: function (d) {
                                    bootbox.alert(d.responseText);
                                }
                            }
                        )
                    }

                });

        }

    };

}();
