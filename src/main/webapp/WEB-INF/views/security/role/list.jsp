<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>角色列表</title>
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
            <button data-href="/security/role/create" class="btn-u btn-u-blue">新增角色</button>
            <button data-href="/security/cache/clean" data-async="true" class="btn-u btn-u-blue">清缓存</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>角色名字</th>
                    <th>角色描述</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="role">
                    <tr>
                        <td>${role.roleName }</td>

                        <td>${role.roleDesc}</td>


                        <td><a href="/security/role/edit/${role.id}" class="btn btn-success btn-xs">分配权限</a>
                            <a href="/security/role/del/${role.id}" class="btn btn-info btn-xs">删除角色</a>
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