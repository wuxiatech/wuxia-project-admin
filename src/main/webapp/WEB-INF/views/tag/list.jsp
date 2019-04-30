<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>标签定义列表</title>
    <style type="text/css">
        label {
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="row">
    <div class="col-xs-12">

        <form action="/dic/tag/list">
            <div class="row">
                <div class="col-md-8" id="condition_area">
                    <div class="row">
                        <div class="col-md-4">
                            <label>名称</label>
                        </div>
                        <div class="col-md-4 pr_50">
                            <input name="conditions[0].value" value="" class="form-control">
                            <input name="conditions[0].conditionType" type="hidden" value="FL">
                            <input name="conditions[0].property" value="name" type="hidden">
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
            <button data-href="/dic/tag/list" class="btn-u btn-u-blue">重置条件</button>
            <button data-href="/dic/tag/create" class="btn-u btn-u-blue">新增分类</button>
            <button data-href="/dic/taggroup/list" class="btn-u btn-u-blue">分组管理</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>标签分类名称</th>
                    <th>开发使用code</th>
                    <th>标签</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pages.result }" var="tag">
                    <tr>
                        <td>${tag.categoryName }</td>
                        <td>${tag.categoryCode}</td>
                        <td>${tag.tagsToString()}</td>
                        <td><a href="/dic/tag/edit/${tag.categoryId}" class="btn btn-success btn-xs">定义标签</a>
                            <a href="/dic/tag/del/${tag.categoryId}" class="btn btn-error btn-xs">删除分类</a>
                            <a href="/dic/tag/del/${tag.categoryId}?includetag=true" class="btn btn-error btn-xs">删除分类并删除标签</a>
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