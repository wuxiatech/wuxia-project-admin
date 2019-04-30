<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>新增或修改任务</title>
    <style type="text/css">
        label {
            font-size: 14px;
        }
    </style>
</head>
<body>

<form action="/system/scheduler/save" class="sky-form" method="post">
    <input type="hidden" name="id" value="${job.id }">
    <input type="hidden" name="jobTrigger"
           value="${ job.jobTrigger }">
    <fieldset>
        <section>
            <label class="label">任务名称</label> <label class="input"> <input type="text" name="name"
                                                                           <c:if test="${not empty job.name}">readonly="readonly"</c:if>
                                                                           value="${ job.name }"
        >
        </label>
        </section>
        <section>
            <label class="label">任务别名</label> <label class="input"> <input type="text" name="aliasName"
                                                                           value="${ job.aliasName }">
        </label>
        </section>
        <section>
            <label class="label">任务分组</label> <label class="input"> <input type="text" name="group"
                                                                           <c:if test="${not empty job.group}">readonly="readonly"</c:if>
                                                                           value="${ job.group }">
        </label>
        </section>
        <section>
            <label class="label">运行环境</label>
            <c:if test="${not empty job.runSystem}">
                <label class="radio">
                    <input type="radio" class="ace" value="${job.runSystem}" name="runSystem"
                           checked="checked" readonly="readonly"/>
                    <span class="lbl"> ${job.runSystem}(${job.runSystem})</span>
                </label>
            </c:if>
            <c:if test="${ empty job.runSystem}">
                <c:forEach items="${systems}" var="sys">
                    <label class="radio">
                        <input type="radio" class="ace" value="${sys}" name="runSystem"
                               <c:if test="${job.runSystem eq sys }">checked</c:if> />
                        <span class="lbl"> ${sys.displayName}(${sys.subdomain})</span>
                    </label>
                </c:forEach>
            </c:if>
        </section>
        <section>
            <label class="label">任务运行时间表达式</label> <label class="input"> <input type="text" name="cronExpression"
                                                                                value="${ job.cronExpression }">
        </label>
        </section>

        <section>
            <label class="label">是否异步：</label>
            <label class="radio">
                <input type="radio" class="ace" value="true" name="isSync"
                       <c:if test="${job.isSync }">checked</c:if> />
                <span class="lbl"> 同步</span>
            </label>

            <label class="radio">
                <input type="radio" class="ace" value="false" name="isSync"
                       <c:if test="${!job.isSync}">checked</c:if> />
                <span class="lbl"> 异步</span>
            </label>
        </section>
        <section>
            <label class="label">任务描述</label> <label class="input"> <input type="text" name="description"
                                                                           value="${ job.description }">
        </label>
        </section>
        <section>
            <label class="label">要执行的任务类</label> <label class="input"> <input type="text" name="jobClassName"
                                                                              value="${ job.jobClassName }">
        </label>
        </section>
        <section>
            <label class="label">方法名</label> <label class="input"> <input type="text" name="methodName"
                                                                          value="${ job.methodName }">
        </label>
        </section>
        <section>
            <label class="label">排序</label> <label class="input"> <input type="number" name="order_"
                                                                         value="${ job.order_ }">
        </label>
        </section>
    </fieldset>
    <footer>
        <button type="submit" class="btn-u">提交</button>
        <button type="button" class="btn-u btn-u-default" onclick="window.history.back();">返回</button>
    </footer>
</form>


<myjs></myjs>
</body>
</html>