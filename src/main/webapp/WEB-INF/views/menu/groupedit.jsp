<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/layouts_admin/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>菜单分组资料</title>
</head>
<body>
<div class="page-header">
    <h1>
        菜单分组资料
        <small><i class="icon-double-angle-right"></i>

        </small>
    </h1>
</div>
<!-- /.page-header -->

<div class="row">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->

        <form class="form-horizontal" role="form" action="/dic/menugroup/save"
              method="post">
            <input name="groupId" value="${vo.groupId }" type="hidden">
            <div class="form-group">


                <label for="groupname" class="col-sm-2 control-label no-padding-right">分组名：</label>
                <div class="col-sm-9">
                    <input
                            class="form-control limited" id="groupname" name="groupName"
                            maxlength="50" value="${vo.groupName }">
                    </textarea>
                </div>
            </div>

            <div class="form-group">


                <label for="groupcode" class="col-sm-2 control-label no-padding-right">code：</label>
                <div class="col-sm-9">
                    <input
                            class="form-control limited" id="groupcode" name="groupCode" placeholder="可不填，自动生成"
                            maxlength="50" value="${vo.groupCode }">
                    </textarea>
                </div>
            </div>
            <%--<div class="form-group">--%>

                <%--<label for="groupdept" class="col-sm-2 control-label no-padding-right">附加条件：</label>--%>
                <%--<div class="col-sm-4">--%>
                    <%--<select class="form-control" id="groupdept" name="systemType" multiple="multiple" size="5">--%>
                        <%--<c:forEach items="${filters}" var="dept">--%>
                            <%--<c:set var="choosedDept">${ifn:contants(vo.departmentIds, dept.id)}</c:set>--%>
                            <%--<option value="${dept.id}"--%>
                                    <%--<c:if test="${choosedDept}">selected</c:if> >${dept.departmentName}</option>--%>
                        <%--</c:forEach>--%>
                    <%--</select>--%>
                <%--</div>--%>
            <%--</div>--%>
            <div class="form-group">

                <label for="grouptags" class="col-sm-2 control-label no-padding-right">选择菜单：</label>
                <div class="col-sm-4">
                    <select class="form-control" id="grouptags" multiple="multiple" size="10">
                        <c:forEach items="${menus}" var="cat">
                            <c:set var="addCat">true</c:set>
                            <c:forEach items="${vo.groupMenus}" var="child">

                                <c:if test="${cat.menuId eq child.menuId}">
                                    <c:set var="addCat">false</c:set>
                                </c:if>
                            </c:forEach>
                            <c:if test="${addCat}">
                                <option value="${cat.menuId}">${cat.name}（${cat.description}）</option>
                            </c:if>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-sm-1">
                    <button class="btn btn-info btn-sm" id="left_choose" type="button">
                        选择
                        <i class="icon-arrow-right icon-on-right"></i>
                    </button>
                    <p></p>
                    <button class="btn btn-default btn-sm" id="right_choose" type="button">
                        放弃
                        <i class="icon-arrow-left icon-on-left"></i>
                    </button>
                </div>
                <div class="col-sm-4">
                    <select class="form-control" id="choosedTags" multiple="multiple" size="10" name="menuNames">

                        <c:forEach items="${vo.groupMenus}" var="child">

                            <option value="${child.menuId}">${child.name}（${child.description}）</option>

                        </c:forEach>

                    </select>
                </div>
            </div>
            <div class="clearfix form-actions">
                <div class="col-md-offset-4">
                    &nbsp; &nbsp; &nbsp;
                    <button class="btn btn-info" type="submit">
                        <i class="icon-ok bigger-110"></i> 提交
                    </button>

                    &nbsp; &nbsp; &nbsp;
                    <button class="btn" type="reset">
                        <i class="icon-undo bigger-110"></i> 重置
                    </button>
                </div>
            </div>
            <hr>

        </form>
    </div>
</div>

<myjs>
    <script>
        $('form').validate({
            errorElement: 'div',
            errorClass: 'help-block',
            focusInvalid: false,
            rules: {
                groupName: {
                    required: true,
                    minlength: 2
                }
            },

            messages: {
                groupName: {
                    required: "请填写分组名称",
                    minlength: "至少填入2个字"
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
                if($("#choosedTags").children().length == 0){
                    alert("请选择菜单");
                    return false;
                }
                $("#choosedTags").children().prop("selected", true);
                form.submit();
            },
            invalidHandler: function (form) {
            }
        });

        $("#left_choose").click(function () {
            var grouptags = $("#grouptags").find(":selected");
            if (grouptags.length > 0) {
                $("#choosedTags").append(grouptags.clone());
                grouptags.remove();
            }
        })
        $("#grouptags").on("dblclick", function () {
            var grouptags = $("#grouptags").find(":selected");
            if (grouptags.length > 0) {
                $("#choosedTags").append(grouptags.clone());
                grouptags.remove();
            }
        })

        $("#right_choose").click(function () {
            var grouptags = $("#choosedTags").find(":selected");
            if (grouptags.length > 0) {
                $("#grouptags").append(grouptags.clone());
                grouptags.remove();
            }
        })

        $("#choosedTags").on("dblclick", function () {
            var grouptags = $("#choosedTags").find(":selected");
            if (grouptags.length > 0) {
                $("#grouptags").append(grouptags.clone());
                grouptags.remove();
            }
        })
    </script>
</myjs>
</body>
</html>