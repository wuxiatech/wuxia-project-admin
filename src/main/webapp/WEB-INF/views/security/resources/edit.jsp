<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>编辑资源</title>
<style type="text/css">
label {
	font-size: 14px;
}
</style>
</head>
<body>

	<form action="/security/resources/save" class="sky-form" method="post">
		<input type="hidden" name="id" value="${securityResources.id }">

		<fieldset>
			<section>
				<label class="label">URI</label> <label class="input"> <input type="text" name="uri" value="${ securityResources.uri }">
				</label>
			</section>
			<section>
				<label class="label">描述</label> <label class="input"> <input type="text" name="description" value="${ securityResources.description }">
				</label>
			</section>
				<section>
					<label class="label">所属</label>
					<div class="row">
						<c:forEach items="${systems }" var="sys" varStatus="sta">
								<div class="col col-4">
									<label class="checkbox"><input
										<c:if test="${sys == securityResources.type || sys == param.type}">checked=checked</c:if>
										<c:if test="${not empty securityResources.id}">readonly</c:if>
										type="radio" name="type" value="${sys }"><i></i>${sys.displayName }</label>
								</div>
						</c:forEach>
					</div>
				</section>
		</fieldset>
		<footer>
			<button type="submit" class="btn-u">提交</button>
			<button type="button" class="btn-u btn-u-default" onclick="window.history.back();">返回</button>
		</footer>
	</form>


	<myjs> </myjs>
</body>
</html>