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

	<form action="/dic/menu/save" class="sky-form" method="post">
		<input type="hidden" name="id" value="${menu.id }">
		<c:choose>
		<c:when test="${not empty menu.parentId}">
			<input type="hidden" name="parentId" value="${menu.parentId }">
			<c:set var="parentId" value="${menu.parentId }" />
		</c:when>
		<c:when test="${not empty param.parentId}">
			<input type="hidden" name="parentId" value="${param.parentId }">
			<c:set var="parentId" value="${param.parentId }" />
		</c:when>

			<c:otherwise></c:otherwise>
		</c:choose>
		<fieldset>
			<section>
				<label class="label">菜单名称</label> <label class="input"> <input type="text" name="name" value="${ menu.name }">
				</label>
			</section>


			<section>
				<label class="label">菜单描述</label> <label class="input"> <input type="text" name="description" value="${ menu.description }">
			</label>
			</section>

			<section>
				<label class="label">菜单Type</label> <label class="input">

				<select  name="type">
					<c:forEach items="${types}" var="type">
						<option value="${type}" <c:if test="${menu.type == type}">selected</c:if>   >${type.displayName}</option>
					</c:forEach>
				</select>
			</label>
			</section>
			<section style="display: none" id="showurl">
				<label class="label">菜单URL</label> <label class="input"> <input type="text" name="url" value="${ menu.url }">
				</label>
			</section>

			<section>
				<label class="label">排序</label> <label class="input"> <input type="text" name="sortOrder" value="${ menu.sortOrder }">
			</label>
			</section>
			<section>
				<label class="label">选择图标</label> <label class="input"> <input type="text" name="icon" value="${ menu.icon }">
			</label>
			</section>
		</fieldset>
		<footer>
			<button type="submit" class="btn-u">提交</button>
			<button type="button" class="btn-u btn-u-default" onclick="window.history.back();">返回</button>
		</footer>
	</form>


	<myjs>
	<script>
		$(function () {
			$("select[name='type']").change(function () {
				if($(this).val() == 'URL'){
				    $("#showurl").show(100);
				}else{
                    $("#showurl").hide(10);
				}
            })
        })
	</script>
	</myjs>
</body>
</html>