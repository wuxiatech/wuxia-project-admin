<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>代制券DEMO</title>

</head>

<body>
	<table>
		<c:forEach items="${list }" var="card">
			<tr>
				<td>${card.brandName }</td>
				<td>${card.title }</td>
				<td>${card.cardId }</td>
				<td><a href="/cardDemo/qrcode?id=${card.id }">二维码</a></td>
			</tr>
		</c:forEach>
	</table>

<myjs>
<script type="text/javascript">
	
</script>
</myjs>
</body>
</html>