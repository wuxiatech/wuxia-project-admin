<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>字典列表</title>
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
            <button data-href="/dic/menu/create?parentId=${menu.id}" class="btn-u btn-u-blue">
                新增子菜单（${menu.name}）
            </button>
            <c:choose>
            <c:when test="${not empty menu.parentId}">
            <button data-href="/dic/menu/submenu/${menu.parentId}" class="btn-u btn-u-green">
                返回父菜单
            </button>
            </c:when>
                <c:otherwise>
                    <button data-href="/dic/menu/list" class="btn-u btn-u-green">
                        返回父菜单
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>菜单名称</th>
                    <th>菜单描述</th>
                    <th>菜单url</th>
                    <th>排序</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${submenus }" var="submenu">
                    <tr>
                        <td><a href="/dic/menu/submenu/${submenu.id}">${submenu.name }</a></td>
                        <td>${submenu.description}</td>
                        <td>${submenu.url}</td>
                        <td>${submenu.sortOrder}</td>
                        <td><a href="/dic/menu/edit/${submenu.id}?parentId=${menu.id}" class="btn btn-success btn-xs">修改</a>
                            <a href="/dic/menu/del/${submenu.id}?parentId=${menu.id}" class="btn btn-info btn-xs">删除</a>
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