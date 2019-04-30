<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>菜单列表</title>
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
            <button data-href="/dic/menu/create" class="btn-u btn-u-blue">新增菜单</button>
            <button data-href="/dic/menugroup/list" class="btn-u btn-u-green">分组管理</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>菜单名称</th>
                    <th>菜单描述</th>
                    <th>菜单类型</th>
                    <th>菜单url</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="menu">
                    <tr>
                        <td><a href="/dic/menu/submenu/${menu.id}">${menu.name }</a></td>
                        <td>${menu.description}</td>
                        <td><c:if test="${not empty menu.type}">${menu.type.displayName}</c:if></td>
                        <td>${menu.url}</td>
                        <td><a href="/dic/menu/edit/${menu.id}" class="btn btn-success btn-xs">修改</a>
                            <a href="/dic/menu/del/${menu.id}" class="btn btn-info btn-xs">删除</a>
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