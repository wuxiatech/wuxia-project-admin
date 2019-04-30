<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh-cn" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="zh-cn" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh-cn">
<!--<![endif]-->
<head>
<title><sitemesh:write property='title' />-管理系统</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<%@ include file="head.jsp"%>
<sitemesh:write property='head' />
</head>
<body id="<sitemesh:write property='body.id' />">
	<%@ include file="messages.jsp"%>
	<!-- START Page Container -->
	<%@ include file="header.jsp"%>
	<%-- <%@ include file="/WEB-INF/layouts_default/mainbar.jsp"%> --%>
	<!-- Main Container -->
	<!-- class="container pb_60" -->
	<sitemesh:write property='body' />
	<!-- END Main Container -->
	<%@ include file="footer.jsp"%>
	<!-- END Page Container -->
	<%@ include file="footerjs.jsp"%>
	<sitemesh:write property='myjs' />
	<sitemesh:write property='myfooter' />
</body>
</html>