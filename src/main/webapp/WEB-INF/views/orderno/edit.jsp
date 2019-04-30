<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>新增orderno</title>
<style type="text/css">
label {
	font-size: 14px;
}
</style>
</head>
<body>

	<form action="/dic/orderno/save" class="sky-form" method="post">
		<input type="hidden" name="id" value="${noGenerate.id }">
		<fieldset>
			<section>
				<label class="label">no code</label> <label class="input"> <input type="text" name="code" value="${ noGenerate.code }">
				</label>
			</section>
			<section>
				<label class="label">开始</label> <label class="input"> <input type="text" name="startno" value="${ noGenerate.startno }">
				</label>
			</section>
			<section>
				<label class="label">步长</label> <label class="input"> <input type="text" name="stepleng" value="${ noGenerate.stepleng }">
			</label>
			</section>
			<c:if test="${not empty noGenerate.id}">
			<section>
				<label class="label">下一个no</label> <label class="input"> <input type="text" name="nextno" value="${ noGenerate.nextno }">
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