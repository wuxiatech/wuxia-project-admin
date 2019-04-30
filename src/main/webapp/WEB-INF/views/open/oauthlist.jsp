<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>授权列表</title>

</head>

<body>
<div class="row">
    <div class="col-xs-12">
        <div class="header smaller lighter blue" id="buttons">
            <a href="/wxopen/oauth/create" class="btn-u btn-u-blue">新增公众号授权</a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <th>授权appid</th>
                <th>公众号</th>
                <th>头像</th>
                <th>公众号类型</th>
                <th>公司名称</th>
                <th>操作</th>
                </thead>
                <tbody>
                <c:forEach items="${pages.result }" var="auth">
                    <tr>
                        <td>${auth.authorizerAppid }</td>
                        <td>${auth.nickName }</td>
                        <td><img src="${auth.headImg }" width="50"/></td>
                        <td><c:choose><c:when
                                test="${auth.serviceTypeInfo == 'service'}">服务号</c:when><c:otherwise>订阅号</c:otherwise></c:choose></td>
                        <td>${auth.principalName}</td>
                        <td><a href="/wxopen/oauth/edit/${auth.id}">编辑</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<myjs>
    <script type="text/javascript">

    </script>
</myjs>
</body>
</html>