<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>任务列表</title>
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
            <button data-href="/system/scheduler/create" class="btn-u btn-u-blue">新增定时任务</button>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered table-striped">
                <thead>
                <tr>
                    <th>任务名称</th>
                    <th>任务别名</th>
                    <th>任务分组</th>
                    <th>触发器</th>
                    <th>任务状态</th>
                    <th>是否异步</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${list }" var="job">
                    <td>${job.name}</td>
                    <td>${job.aliasName }</td>
                    <td>${job.group}</td>
                    <td>${job.jobTrigger }</td>
                    <td>${job.status.displayName }</td>
                    <td>${job.isSync}</td>
                    <td>
                        <a href="/system/scheduler/edit/${job.id}" class="btn btn-success btn-xs">修改</a>
                        <a id="deleteJob" data-href="/system/scheduler/del/${job.id}" data-async="false"
                           data-alert="确定删除任务吗？" class="btn btn-info btn-xs">删除</a>
                        <a id="startJob" data-alert="确定启动任务吗？可能会有1分钟的延迟。"
                           <c:if test="${job.status ne 'PAUSED'}">style="display: none" </c:if>
                           data-href="/system/scheduler/startup/${job.id}" data-async="FALSE"
                           class="btn btn-success btn-xs">启动</a>
                        <a id="paulJob" data-alert="确定暂停任务吗？可能会有1分钟的延迟。"
                           <c:if test="${job.status ne 'NORMAL'}">style="display: none" </c:if>
                           data-href="/system/scheduler/paul/${job.id}" data-async="FALSE" class="btn btn-info btn-xs">暂停</a>
                        <a data-href="/system/scheduler/runonce/${job.id}" data-async="true"
                           data-alert="确定运行${job.aliasName}任务吗？" class="btn btn-info btn-xs">立刻运行一次</a>
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
        $("#deleteJob").click(function () {
            $(this).parent("tr").hide();
        })
        $("#deleteJob").click(function () {
            $(this).parent("tr").hide();
        })
        $("#deleteJob").click(function () {
            $(this).parent("tr").hide();
        })
    </script>
</myjs>
</body>
</html>