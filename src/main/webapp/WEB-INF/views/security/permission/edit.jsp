<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>权限列表</title>
    <style type="text/css">
        label {
            font-size: 14px;
        }
    </style>
</head>
<body>

<form action="/security/permission/save" class="sky-form" method="post">
    <input type="hidden" name="permissionId" value="${permissionResources.permissionId }">

    <fieldset>
        <section>
            <label class="label">权限名</label> <label class="input"> <input type="text" name="permissionName"
                                                                          placeholder="请输入英文或数字"
                                                                          value="${ permissionResources.permissionName }">
        </label>
        </section>
        <section>
            <label class="label">权限描述</label> <label class="input"> <input type="text" name="permissionDesc"
                                                                           placeholder="对权限的中文描述"
                                                                           value="${ permissionResources.permissionDesc }">
        </label>
        </section>
        <section>
            <label class="label">所属</label>
            <div class="row">
                <c:forEach items="${systems }" var="sys" varStatus="sta">
                    <div class="col col-4">
                        <label class="checkbox"><input
                                <c:if test="${sys == permissionResources.systemType || sys == param.type}">checked=checked</c:if>
                                <c:if test="${not empty permissionResources.systemType}">readonly</c:if>
                                type="radio" name="systemType" value="${sys }"><i></i>${sys.displayName }</label>
                    </div>
                </c:forEach>
            </div>
        </section>
        <c:if test="${empty permissionResources.systemType}">
            <c:forEach items="${systems }" var="sys">
                <section>
                    <label class="label">${sys.displayName }</label>
                    <div class="row" id="${sys}-div">
                        <c:forEach items="${allresources }" var="res" varStatus="sta">
                            <c:if test="${res.type eq sys}">
                                <div class="col col-4">
                                    <label class="checkbox"><input
                                    <c:forEach items="${permissionResources.resources }" var="checkReso">
                                            <c:if test="${checkReso.id == res.id }">checked=checked</c:if>
                                    </c:forEach>
                                            <c:if test="${not empty param.type && param.type != res.type}">disabled</c:if>
                                            type="checkbox" name="resources[${sta.index }].id"
                                            value="${res.id }"><i></i>${res.description }（${res.uri }）</label>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </section>
            </c:forEach>
        </c:if>
        <c:if test="${not empty permissionResources.systemType}">
            <section>
                <label class="label">${permissionResources.systemType.displayName }</label>
                <div class="row" id="${permissionResources.systemType}-div">
                    <c:forEach items="${allresources }" var="res" varStatus="sta">
                        <div class="col col-4">
                            <label class="checkbox"><input
                            <c:forEach items="${permissionResources.resources }" var="checkReso">
                                    <c:if test="${checkReso.id == res.id }">checked=checked</c:if>
                            </c:forEach>
                                    type="checkbox" name="resources[${sta.index }].id"
                                    value="${res.id }"><i></i>${res.description }（${res.uri }）</label>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </c:if>
    </fieldset>
    <footer>
        <button type="submit" class="btn-u">提交</button>
        <button type="button" class="btn-u btn-u-default" onclick="window.history.back();">返回</button>
    </footer>
</form>


<myjs>


    <script !src="">

        $(function () {
            $("[name='systemType']").click(function () {
                var systemType = $(this).val();
                if ($(this).prop("readonly")) {
                    //this.checked = !this.checked;
                    return false;
                }
                $("#" + systemType + "-div").fadeIn(200).find(":checkbox").prop("disabled", false);
                $(":checkbox").parents("div.row").not("#" + systemType + "-div").hide(50).find(":checkbox").prop("disabled", true);
            })
        })
    </script>
</myjs>
</body>
</html>