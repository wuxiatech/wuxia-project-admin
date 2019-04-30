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

	<form action="/security/role/save" class="sky-form" method="post">
		<input type="hidden" name="roleId" value="${rolePermissions.roleId }">

		<fieldset>
			<section>
				<label class="label">角色名</label> <label class="input"> <input type="text" name="roleName" value="${ rolePermissions.roleName }">
				</label>
			</section>
			<section>
				<label class="label">角色描述</label> <label class="input"> <input type="text" name="roleDesc" value="${ rolePermissions.roleDesc }">
				</label>
			</section>


			<c:forEach items="${systems }" var="sys">
				<section>
					<label class="label">${sys.displayName }</label>
					<div class="row" id="${sys}-div">
						<c:forEach items="${allpermissions }" var="res" varStatus="sta">
							<c:if test="${res.systemType eq sys}">
								<div class="col col-4">
									<label class="checkbox"><input
											<c:forEach items="${rolePermissions.permissions }" var="checkReso"><c:if test="${checkReso.id == res.id }">checked=checked</c:if></c:forEach>
											type="checkbox" name="permissions[${sta.index }].id" value="${res.id }"><i></i>${res.permissionDesc }（${res.permissionName }）</label>
								</div>
							</c:if>
						</c:forEach>
					</div>
				</section>
			</c:forEach>

		</fieldset>
		<footer>
			<button type="submit" class="btn-u">提交</button>
			<button type="button" class="btn-u btn-u-default" onclick="window.history.back();">返回</button>
		</footer>
	</form>


	<myjs> </myjs>
</body>
</html>