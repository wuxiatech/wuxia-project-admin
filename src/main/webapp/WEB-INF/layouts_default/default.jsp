<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh-cn" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="zh-cn" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh-cn">
<!--<![endif]-->
<head>
<title><sitemesh:write property='title' /></title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<%@ include file="head.jsp"%>
<sitemesh:write property='head' />
</head>
<body>
	<%@ include file="messages.jsp"%>
	<div class="wrapper">
		<%@ include file="header.jsp"%>
		<div class="container content profile ">
			<%--<div class="row">
				<div class="col-md-3">
					<%@ include file="leftnav.jsp"%>
				</div>
				<div class="col-md-9"> --%>
					<div class="profile-body">
						<sitemesh:write property='body' />
					</div>
				<!--</div>
			 </div>-->
		</div> 
	</div>
	<%@ include file="footer.jsp"%>
	<%@ include file="footerjs.jsp"%>
	<sitemesh:write property='myjs' />
</body>
</html>