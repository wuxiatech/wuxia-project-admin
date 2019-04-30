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
            <button data-href="/dic/config/create" class="btn-u btn-u-blue">新增字典</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>字典名称</th>
                    <th>字典CODE</th>
                    <th>字典类型</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="config">
                    <tr>
                        <td><a href="/dic/config/values/${config.id}">${config.name }</a></td>
                        <td>${config.code}</td>
                        <td>${config.type}</td>

                        <td><a href="/dic/config/edit/${config.id}" class="btn btn-success btn-xs">修改</a>
                            <a href="/dic/config/del/${config.id}" class="btn btn-info btn-xs">删除</a>
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