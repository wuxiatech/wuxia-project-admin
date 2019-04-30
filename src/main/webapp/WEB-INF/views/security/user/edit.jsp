<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>角色列表</title>
<style type="text/css">
label {
	font-size: 14px;
}
</style>
</head>
<body>

	<form action="/security/user/save" class="sky-form" method="post">
		<input type="hidden" name="userId" value="${userId }">
		<input type="hidden" name="callback" value="${param.callback }">
		<fieldset>
			<section>
				<label class="label">${userName}</label>
				<div class="row">
					<c:forEach items="${allroles }" var="role" varStatus="s">
						<div class="col col-4">
							<label class="checkbox"><input
								<c:forEach items="${userRole.roles }" var="checkRole"><c:if test="${checkRole.id == role.id }">checked=checked</c:if></c:forEach>
								type="checkbox" name="roles[${s.index }].id" value="${role.id }"><i></i>${role.roleDesc}</label>
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