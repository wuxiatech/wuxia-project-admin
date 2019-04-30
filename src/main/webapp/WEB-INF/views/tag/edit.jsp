<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>标签分类资料</title>
</head>
<body>
<div class="page-header">
    <h1>
        标签分类资料
        <small><i class="icon-double-angle-right"></i>

        </small>
    </h1>
</div>
<!-- /.page-header -->

<div class="row">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <form class="form-horizontal" role="form" action="/dic/tag/save"
              method="post">
            <input name="categoryId" value="${vo.categoryId }" type="hidden">
            <div class="form-group">


                <label for="form-field-2" class="col-sm-3 control-label no-padding-right">分类：</label>
                <div class="col-sm-9">
                    <input
                            class="form-control limited" id="form-field-2" name="categoryName"
                            maxlength="50" value="${vo.categoryName }">
                    </textarea>
                </div>
            </div>
            <div class="form-group">


                <label for="form-field-3" class="col-sm-3 control-label no-padding-right">code：</label>
                <div class="col-sm-9">
                    <input
                            class="form-control limited" id="form-field-3" name="categoryCode" placeholder="可不填，自动生成"
                            maxlength="50" value="${vo.categoryCode }">
                    </textarea>
                </div>
            </div>
            <div class="form-group">


                <label for="form-field-4" class="col-sm-3 control-label no-padding-right">选项类型：</label>
                <div class="col-sm-9 radio">
                    <label>
                        <input type="radio" class="ace" value="radio" name="checktype"
                               <c:if test="${vo.checktype eq 'radio'}">checked</c:if> />
                        <span class="lbl"> 单选</span>
                    </label>

                    <label>
                        <input type="radio" class="ace" value="checkbox" name="checktype"
                               <c:if test="${vo.checktype  eq 'checkbox'}">checked</c:if> />
                        <span class="lbl"> 多选</span>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label no-padding-right"
                       for="switch-field-1"> 是否开启可查询 </label>

                <div class="col-sm-2">
                    <input id="switch-field-1" name="openquery" value="true" class="ace ace-switch ace-switch-7"
                           type="checkbox"
                           <c:if test="${'true' eq vo.openquery }">checked=checked</c:if> >
                    <span class="lbl"></span>
                </div>
                <span
                        class="help-inline col-xs-10 col-sm-6 "> <span
                        class="middle">选择后可通过标签刷选</span>
						</span>
            </div>
            <div class="clearfix form-actions">
                <div class="col-md-offset-3">
                    &nbsp; &nbsp; &nbsp;
                    <button class="btn btn-info" type="submit">
                        <i class="icon-ok bigger-110"></i> 提交
                    </button>
                    &nbsp; &nbsp; &nbsp;
                    <button class="btn btn-info" type="button" id="create-answer">
                        <i class="icon-ok bigger-110"></i> 新增标签
                    </button>
                    &nbsp; &nbsp; &nbsp;
                    <button class="btn" type="reset">
                        <i class="icon-undo bigger-110"></i> 重置
                    </button>
                </div>
            </div>
            <hr>
            <div class="row" id="answers-area">
                <c:forEach items="${vo.tags }" var="a" varStatus="sta">
                    <div class="col-xs-12 col-sm-4">
                        <div class="widget-box">
                            <div class="widget-header">
                                <h4>内容 ${sta.index+1 }</h4>
                                <input name="answer" type="hidden" value="${sta.index }">
                                <input name="tags[${sta.index }].id" type="hidden" value="${a.id }">
                                <input name="tags[${sta.index }].categoryId" type="hidden" value="${a.categoryId }">
                                <div class="widget-toolbar">
                                    <a href="#" data-action="collapse"> <i
                                            class="icon-chevron-up"></i>
                                    </a> <a href="#" data-action="close"> <i class="icon-remove"></i>
                                </a>
                                </div>
                            </div>

                            <div class="widget-body">
                                <div class="widget-main">
                                    <div>
                                        <label for="form-field-8"></label>

                                        <input class="form-control limited" id="form-field-8"
                                               name="tags[${sta.index }].tagName"
                                               maxlength="50" value="${a.tagName}">
                                    </div>
                                    <hr>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </form>
    </div>
</div>
<div style="display:none" id="answer-temp">
    <div class="col-xs-12 col-sm-4">
        <div class="widget-box">
            <div class="widget-header">
                <h4>内容</h4>
                <input name="answer" type="hidden">
                <div class="widget-toolbar">
                    <a href="#" data-action="collapse"> <i
                            class="icon-chevron-up"></i>
                    </a> <a href="#" data-action="close"> <i class="icon-remove"></i>
                </a>
                </div>
            </div>

            <div class="widget-body">
                <div class="widget-main">
                    <div>
                        <label for="form-field-8"></label>

                        <input class="form-control limited" id="form-field-8" name="tagName"
                               maxlength="50">
                    </div>
                    <hr>
                </div>
            </div>
        </div>
    </div>
</div>
<myjs>
    <script>
        $('form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                categoryName: {
                    required: true,
                    minlength: 3
                }
            },

            messages: {
                categoryName: {
                    required: "请填写真实姓名",
                    minlength: "至少填入5个字"
                }
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
            },

            highlight: function (e) {
                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
            },

            success: function (e) {
                $(e).closest('.form-group').removeClass('has-error').addClass('has-info');
                $(e).remove();
            },

            errorPlacement: function (error, element) {
                if (element.is(':checkbox') || element.is(':radio')) {
                    var controls = element.closest('div[class*="col-"]');
                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
                }
                else if (element.is('.select2')) {
                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
                }
                else if (element.is('.chosen-select')) {
                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
                }
                else error.insertAfter(element);
            },

            submitHandler: function (form) {
                form.submit();
            },
            invalidHandler: function (form) {
            }
        });


        $("#create-answer").click(function () {
            var answerarea = $("#answers-area");
            var answertemp = $("#answer-temp").children(":first").clone().addClass("answers-div");
            var index = answerarea.children(":last").find("[name='answer']").val();
            index = index == undefined ? 0 : parseInt(index) + 1;
            answertemp.find("h4").text(answertemp.find("h4").text() + (index + 1));
            var answername = "tags[" + index + "].";
            answertemp.find("[name='answer']").val(index);
            /**
             * 添加到页面
             **/
            answerarea.append(answertemp);
            /**
             * 修改所有名字
             */
            answertemp.find("[name]").not(":first").each(function () {
                $(this).prop("name", answername + $(this).prop("name"));
            })
        })
    </script>
</myjs>
</body>
</html>