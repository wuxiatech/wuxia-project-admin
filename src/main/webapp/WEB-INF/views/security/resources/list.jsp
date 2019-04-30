<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>资源列表</title>
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
            <button data-href="/security/resources/create<c:if test="${not empty param.type}">?type=${param.type}</c:if>" class="btn-u btn-u-blue">新增资源</button>
            <c:forEach var="type" items="${systems }">
                <button data-href="/security/resources/list?type=${type }" class="btn-u btn-u-blue">
                    筛选资源-${type.displayName}</button>
            </c:forEach>
        </div>
        <div class="table-header">
            资源列表
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>资源uri</th>
                    <th>资源描述</th>
                    <th>所属</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="res">
                    <tr>
                        <td>${res.uri }</td>

                        <td>${res.description}</td>
                        <td>${res.type.displayName}</td>

                        <td><a href="/security/resources/edit/${res.id}" class="btn btn-success btn-xs">修改资源</a> <a
                                href="/security/resources/del/${res.id}?type=${res.type}"
                                class="btn btn-info btn-xs">删除资源</a></td>
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