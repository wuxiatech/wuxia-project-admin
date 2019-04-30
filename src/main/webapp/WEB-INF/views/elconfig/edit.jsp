<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>新增字典</title>
    <style type="text/css">
        label {
            font-size: 14px;
        }
    </style>
</head>
<body>

<form action="/dynamic-config/save" class="sky-form" method="post">
    <input type="hidden" name="id" value="${dicConfig.id }">
    <fieldset>
        <section>
            <label class="label">规则名称</label> <label class="input"> <input type="text" name="name"
                                                                           value="${ dicConfig.name }">
        </label>
        </section>
        <section>
            <label class="label">appid</label> <label class="input"> <select name="appid" maxlength="32">
            <c:forEach items="${appids}" var="appid">
                <option value="${appid.id}"
                        <c:if test="${appid.id == dicConfig.appid}">selected</c:if> >${appid.displayName}</option>
            </c:forEach>
        </select>
        </label>
        </section>
        <section>
            <label class="label">Key</label> <label class="input"> <input type="text" name="code"
                                                                             value="${ dicConfig.code }">
        </label>
        </section>
        <section>
            <label class="label">规则（因为版本表达式的特殊性，如需比较版本请使用eq,ne,gt,lt,gte,lte, 例如：os=='ios' && lte(version,"1.4.1") ）</label> <label class="input">
            <textarea name="express" style="width: 100%" rows="3"><c:out value="${dicConfig.express }"></c:out></textarea>
        </label>
        </section>
        <section>
            <label class="label">Value</label> <label class="input">
            <textarea style="width: 100%" name="value" rows="3">${ dicConfig.value }</textarea>
        </label>
        </section>

        <section>
            <label class="label">字典Type</label> <label class="input"> <input type="text" name="type"
                                                                             value="${ dicConfig.type }">
        </label>
        </section>
        <section>
            <label class="label">开始时间</label> <label class="input"> <input type="text" name="starttime" id="starttime" data-date-format="yyyy-mm-dd hh:ii" class="date-picker" autocomplete="false"
                                                                             value="<fmt:formatDate value="${dicConfig.starttime}" pattern="yyyy-MM-dd HH:mm"/>">
        </label>
        </section>
        <section>
            <label class="label">有效期</label> <label class="input"> <input type="text" name="expirytime" id="expirytime"  data-date-format="yyyy-mm-dd hh:ii" class="date-picker" autocomplete="false"
                                                                             value="<fmt:formatDate value="${dicConfig.expirytime}" pattern="yyyy-MM-dd HH:mm"/>">
        </label>
        </section>
        <section>
            <label class="label">状态</label> <label class="input"> <select name="status" maxlength="32">
             <c:choose>
                 <c:when test="${not empty dicConfig.status && dicConfig.status}">
                     <option value="true" selected >正常</option>
                     <option value="false"  >禁用</option>
                 </c:when>
                 <c:otherwise>
                     <option value="true"  >正常</option>
                     <option value="false" selected >禁用</option>
                 </c:otherwise>
             </c:choose>

        </select>
    </fieldset>
    <footer>
        <button type="submit" class="btn-u">提交</button>
        <button type="button" class="btn-u btn-u-default" onclick="window.history.back();">返回</button>
    </footer>
</form>


<myjs>
    <script>
        $(function () {
            $("[name='starttime']").datetimepicker({
                timepicker:true,
                autoclose: true, //这里最好设置为false
                todayHighlight : true,
                language : 'zh-CN',
                startDate : new Date(),
            });
            $("[name='expirytime']").datetimepicker({
                timepicker:true,
                startDate:$("[name='starttime']", $(this).parents("form")).val(),
                autoclose: true, //这里最好设置为false
            });
        })
    </script>

</myjs>
</body>
</html>