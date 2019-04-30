<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>顺序no列表</title>
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
            <button data-href="/dic/orderno/create" class="btn-u btn-u-blue">新增orderno</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>CODE</th>
                    <th>开始</th>
                    <th>步长</th>
                    <th>当前</th>
                    <th>备注</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="orderno">
                    <tr>
                        <td>${orderno.code}</td>
                        <td>${orderno.startno }</td>
                        <td>${orderno.stepleng}</td>
                        <td>${orderno.nextno - 1 }</td>
                        <td>${orderno.remark }</td>
                        <td><a href="/dic/orderno/edit/${orderno.id}" class="btn btn-success btn-xs">修改</a>
                            <a href="/dic/orderno/del/${orderno.id}" class="btn btn-info btn-xs">删除</a>
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