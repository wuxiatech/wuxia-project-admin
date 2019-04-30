<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>菜单分组列表</title>
    <style type="text/css">
        label {
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="row">
    <div class="col-xs-12">

        <form action="/dic/menugroup/list">
            <div class="row">
                <div class="col-md-8" id="condition_area">
                    <div class="row">
                        <div class="col-md-4">
                            <label>名称</label>
                        </div>
                        <div class="col-md-4 pr_50">
                            <input name="conditions[0].value" value="" class="form-control">
                            <input name="conditions[0].conditionType" type="hidden" value="FL">
                            <input name="conditions[0].property" value="groupName" type="hidden">
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                </div>
                <div class="col-md-4">

                </div>
            </div>
        </form>
        <div class="header smaller lighter blue" id="buttons">
            <button data-type="submit" class="btn-u btn-u-blue">应用</button>
            <button data-href="/dic/menugroup/list" class="btn-u btn-u-blue">重置条件</button>
            <button data-href="/dic/menugroup/create" class="btn-u btn-u-blue">新增分组</button>
            <button data-href="/dic/menu/create" class="btn-u btn-u-blue">新增菜单</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>分组名称</th>
                    <th>开发使用code</th>
                    <th>包含菜单</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pages.result }" var="group">
                    <tr>
                        <td>${group.groupName }</td>
                        <td>${group.groupCode}</td>
                        <td>${group.menuNames}</td>
                        <td><a href="/dic/menugroup/edit/${group.groupId}" class="btn btn-success btn-xs">分配菜单</a>
                            <a href="/dic/menugroup/del/${group.groupId}" class="btn btn-error btn-xs">删除分组</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <tags:page currUrl="${pathname }" pageVo="${pages }"></tags:page>
    </div>
</div>

<myjs>
    <script type="text/javascript">
        $(function () {





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
        })
    </script>
</myjs>
</body>
</html>