<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layouts_admin/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
div.form {
	margin: 20px 50px;
	background-color: #ffcc00;
	display: -moz-inline-box;
	display: block;
}

p {
	line-height: 25px;
}

label {
	width: 150px;
	padding: 0 20px;
}

input {
	width: 50%;
	left: 200px;
}
</style>
</head>
<body>
	<div class="form">
		<form id="buildForm" action="/system/generate" method="post">
			<p>
				<label style="color: red;">uri:</label><input name="sourceUrl"
					value="${ sourceUrl}">eg. /services/serviceCategory
			</p>
			<p>
				<label style="color: red;">target:</label><input
					name="toDistLocation" value="${ toDistLocation}">eg.
				/common
			</p>
			<p>
				<label style="color: red;">static page name:</label><input
					name="fileName" value="${fileName }">eg.
				serviceCategory.jsp
			</p>
			<p>
				<label>charset/encoding:</label><input name="charset"
					value="${charset }">eg. UTF-8
			</p>
			<p>
				<label>parameter:</label>
				<textarea name="parameter">${ parameter}</textarea>
				eg. a=b&b=c&c=d
			</p>
			<p>
				<button id="buildOne" type="submit">Generate Static Page</button>
				<button id="buildAll" type="button">Generate All Static
					Page</button>
			</p>
		</form>
	</div>
	<div class="form">
		<form action="/system/cleanEhCached" method="post">
			<p>
				<label>key:</label><input name="ehkey">eg. key
			</p>
			<p>
				<button type="submit">Clean Ehcache</button>
			</p>
		</form>
	</div>
	<div class="form">
		<form action="/system/cleanMemcached" method="post">
			<p>
				<label>key:</label><input name="memkey">eg.0
			</p>
			<p>
				<button type="submit">Clean Memcached</button>
			</p>
		</form>
	</div>
	<myjs>
	<script type="text/javascript">
		$(function() {
			$("#buildAll").click(function() {
				$("#buildForm").attr("action", "/system/generateAll").submit();
			})
		})
	</script>
	</myjs>
</body>
</html>