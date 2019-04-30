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


<div class="row">
    <div class="col-xs-12">
        <div class="header smaller lighter blue" id="buttons">
            <button data-href="/security/permission/create<c:if test="${not empty param.type}">?type=${param.type}</c:if>" class="btn-u btn-u-blue">新增权限</button>
            <c:forEach var="type" items="${systems }">
                <button data-href="/security/permission/list?type=${type }" class="btn-u btn-u-blue">
                    筛选权限-${type.displayName}</button>
            </c:forEach>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>权限名字</th>
                    <th>权限描述</th>
                    <th>所属</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="prm">
                    <tr>
                        <td>${prm.permissionName }</td>

                        <td>${prm.permissionDesc}</td>
                        <td>${prm.systemType.displayName}</td>

                        <td><a href="/security/permission/edit/${prm.id}" class="btn btn-success btn-xs">分配资源</a>
                            <a href="/security/permission/del/${prm.id}" class="btn btn-info btn-xs">删除权限</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<myjs>
    <script>
        $("button", "#buttons").each(function () {
            $(this).click(function () {
                location.href = $(this).data("href");
            })
        })
    </script>
</myjs>
</body>
</html>