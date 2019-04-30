<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>公司列表</title>
    <style type="text/css">
        label {
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="row">
    <div class="col-xs-12">

        <form action="${pathname }" method="get">
            <div class="row">
                <div class="col-md-8" id="condition_area">
                    <div class="row">
                        <div class="col-md-4 pl_50">

                            <label>名称</label>
                            <input name="conditions[0].value" value="" class="form-control">
                            <input name="conditions[0].conditionType" type="hidden" value="FL">
                            <input name="conditions[0].property" value="name" type="hidden">
                        </div>
                        <div class="col-md-4">

                        </div>
                    </div>
                    <c:forEach items="${conditonVo.conditions }" var="condition" varStatus="sta">
                        <div class="row margin-top-20 row_${sta.index }">
                            <div class="col-md-4 pr_50">
                                <select name="conditions[${sta.index }].property" class="form-control">

                                </select>
                            </div>
                            <div class="col-md-4 pr_50">
                                <select name="conditions[${sta.index }].conditionType" class="form-control">
                                    <c:forEach items="${matchTypes }" var="matchType">
                                        <option value="${matchType }"
                                                <c:if test="${matchType.name() eq condition.matchType.name() }">selected="selected"</c:if> >${matchType.displayName }</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-4 pr_50">
                                <input name="conditions[${sta.index }].formId" value="${condition.formId }"
                                       type="hidden">
                                <input name="conditions[${sta.index }].value" value="${condition.value }"
                                       class="form-control">
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </div>
        </form>

        <div class="header smaller lighter blue" id="buttons">
            <button data-type="submit" class="btn-u btn-u-blue">查询</button>
            <button data-href="${pathname }" class="btn-u btn-u-blue">重置条件</button>
            <security:authorize url="/admin/org/create">
                <button data-href="/admin/org/create" class="btn-u btn-u-blue">新建</button>
            </security:authorize>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>公司名称</th>
                    <th>公司简称</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pages.result }" var="org">
                    <tr>
                        <td>${org.name }</td>

                        <td>${org.simpleName}</td>
                        <td>
                            <security:authorize url="/admin/org/edit/">
                                <a href="/admin/org/edit/${org.id }" class="btn btn-success btn-xs">修改</a>
                            </security:authorize>
                            <security:authorize url="/admin/dept/list/">
                                <a href="/admin/dept/list/${org.id}" class="btn btn-info btn-xs">部门管理</a>
                            </security:authorize>

                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <tags:page currUrl="${currentUrl }" pageVo="${pages }"></tags:page>
    </div>
</div>

<div class="hide" id="condition_temp">
    <div class="row margin-top-20">
        <div class="col-md-4 pr_50">
            <select name="property" class="form-control">
                <option value="">--请选择--</option>
            </select>
        </div>
        <div class="col-md-4 pr_50">
            <select name="conditionType" class="form-control">
                <c:forEach items="${matchTypes }" var="matchType">
                    <option value="${matchType }">${matchType.displayName }</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-md-4 pr_50">
            <input name="formId" value="" type="hidden">
            <input name="value" value="" class="form-control">
        </div>
    </div>
</div>
<myjs>
    <script type="text/javascript">
        $(function () {
            <c:forEach items="${conditonVo.conditions }" var="condition" varStatus="sta">
            getCondition('${condition.formId}', '${condition.property}', ${sta.index});
            </c:forEach>
            var i = ${fn:length(pages.conditions) };
            $("#formId").change(function () {
                if ($(this).val() != "") {
                    appCondition($(this).val(), "", i++);
                }
            })


            function appCondition(formId, selectedValue, index) {
                var temp = $("#condition_temp").clone().html();
                $("#condition_area").append(temp);
                var row = $("#condition_area").children(":last");
                row.find("select,input").each(function () {
                    var newName = "conditions[" + index + "]." + $(this).prop("name");
                    $(this).prop("name", newName);
                })
                row.addClass("row_" + index);
                $.getJSON("/follow/query/getFormCondition", {formId: formId}, function (res) {
                    $.each(res, function (a, b) {
                        var opt = $("<option>").prop("value", b.name).text(b.label);
                        if (selectedValue) {
                            if (selectedValue == b.name) {
                                opt.prop("selected", "selected")
                            }
                        }
                        opt.appendTo(row.find("select:first"));
                        row.find("input:first").val(formId);
                    })
                })
            }

            function getCondition(formId, selectedValue, index) {
                var row = $(".row_" + index);
                $.getJSON("/follow/query/getFormCondition", {formId: formId}, function (res) {
                    $.each(res, function (a, b) {
                        var opt = $("<option>").prop("value", b.name).text(b.label);
                        if (selectedValue) {
                            if (selectedValue == b.name) {
                                opt.prop("selected", "selected")
                            }
                        }
                        opt.appendTo(row.find("select:first"));
                    })
                })
            }

            $(".update-comment").click(function () {
                var comment = $(this).prev("input").val();
                var sourceComment = $(this).prev("input").data("value");
                var id = $(this).prev("input").data("id");
                if (isNotBlank(comment) && isNotBlank(id) && comment != sourceComment) {
                    /* $.confirm({
                          body: '确定提交吗'
                          ,width: 'normal'
                          ,okHidden: function(){
                                $.getJSON("/follow/list/updateComment",{id: id, comment: comment},  function(res){
                                    $.alert("备注成功");
                                })
                        }
                    }) */
                    if (confirm("确定提交吗？")) {
                        $.getJSON("/follow/list/updateComment", {id: id, comment: comment}, function (res) {
                            alert("备注成功");
                        })
                    }
                }
            })

            $("button", "#buttons").each(function () {
                $(this).click(function () {
                    var href = $(this).data("href");
                    if (href) {
                        location.href = href;
                    } else {
                        $("form").submit();
                    }
                })
            })

            $(".delete-doctor").click(function () {
                var href = $(this).data("href");
                var name = $(this).parents("tr").children(":first").text();
                var obj = this;
                if (confirm("请谨慎移除" + name + "医生资料，删除后该医生资料将不再公布及不能登录任何系统！是否继续删除？")) {
                    $.ajax({
                        url: href,
                        success: function () {
                            $(obj).parents("tr").remove();
                        }
                    })
                }
            })


        })
    </script>
</myjs>
</body>
</html>