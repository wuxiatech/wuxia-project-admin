<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>

<c:set var="dataId">${empty adPosition.id?0:adPosition.id}</c:set>
<c:set var="title">
    <c:choose>
        <c:when test="${empty adPosition.id}">新增广告位</c:when>
        <c:otherwise>
            查看广告位-${adPosition.id}
        </c:otherwise>
    </c:choose>
</c:set>
<html>
<head>
    <title>${title}</title>
</head>
<body>
<!-- start content -->
<form action="${ctx}/ad/position/${adPosition.appid}/save" method="post"
      id="adPositionForm" class="sky-form" novalidate="novalidate">
    <input type="hidden" name="id" value="${adPosition.id}"/>
    <header>${title}</header>

    <!-- 根据表字段生成表单内容 -->
    <fieldset>

        <div class="row">
            <section class="col col-6" style="display: none">
                <label >appid</label>
                <label class="input">
                    <input type="text" name="appid" value="${adPosition.appid}" maxlength="32"/>
                    <b class="tooltip tooltip-left">输入appid</b>
                </label>
            </section>

            <section class="col col-6">
                <label >广告位名</label>
                <label class="input">
                    <input type="text" name="name" value="${adPosition.name}" maxlength="100"/>
                    <b class="tooltip tooltip-left">输入广告位名</b>
                </label>
            </section>
            <section class="col col-6">
                <label >广告位描述</label>
                <label class="input">
                    <input type="text" name="description" value="${adPosition.description}" maxlength="255"/>
                    <b class="tooltip tooltip-left">输入广告位描述</b>
                </label>
            </section>
        </div>


    </fieldset>

    <footer>
        <button type="submit" class="btn btn-success">保存</button>
        <a type="button" class="btn btn-default" href="/ad/position/${adPosition.appid}/list">返回</a>
    </footer>
</form>
<!-- myjs 可以将此模板的 JavaScript 到装饰器的 body 之前-->
<myjs>
    <script type="text/javascript" src="//ace.zjcdn.cn/assets/js/spin.min.js"></script>
    <script type="text/javascript" src="/resources/script/plugin/spin.config.js"></script>
    <script type="text/javascript" src="/resources/script/config/adPositionForm.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            adPositionForm.initForm();
        });
    </script>
</myjs>
</body>
</html>