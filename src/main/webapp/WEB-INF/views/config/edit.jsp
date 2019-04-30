<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp"%>
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

	<form action="/dic/config/save" class="sky-form" method="post">
		<input type="hidden" name="id" value="${dicConfig.id }">
		<c:if test="${not empty param.parentid}">
			<input type="hidden" name="parentid" value="${param.parentid }">
			<c:set var="parentid" value="${param.parentid }" />
		</c:if>
		<c:if test="${not empty dicConfig.parentid}">
			<input type="hidden" name="parentid" value="${dicConfig.parentid }">
			<c:set var="parentid" value="${dicConfig.parentid }" />
		</c:if>
		<fieldset>
			<section>
				<label class="label">字典名称</label> <label class="input"> <input type="text" name="name" value="${ dicConfig.name }">
				</label>
			</section>
			<%--<c:if test="${not empty parentid}">--%>
			<section>
				<label class="label">字典Value</label> <label class="input"> <input type="text" name="value" value="${ dicConfig.value }">
				</label>
			</section>
			<%--</c:if>--%>
			<section>
				<label class="label">字典Code</label> <label class="input"> <input type="text" name="code" value="${ dicConfig.code }">
			</label>
			</section>
			<c:if test="${ empty parentid}">
			<section>
				<label class="label">字典Type</label> <label class="input"> <input type="text" name="type" value="${ dicConfig.type }">
			</label>
			</section>
			</c:if>
		</fieldset>
		<footer>
			<button type="submit" class="btn-u">提交</button>
			<button type="button" class="btn-u btn-u-default" onclick="window.history.back();">返回</button>
		</footer>
	</form>


	<myjs> </myjs>
</body>
</html>