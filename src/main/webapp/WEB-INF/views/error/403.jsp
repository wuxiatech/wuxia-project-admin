<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 	isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="cn.wuxia.common.exception.AppPermissionException,cn.wuxia.common.exception.AppObjectNotFoundException" %>
<%@ page import="java.io.PrintWriter"%>
<%
    Throwable ex = null;
	if (exception != null)
		ex = exception;
	if (request.getAttribute("javax.servlet.error.exception") != null)
		ex = (Throwable) request
				.getAttribute("javax.servlet.error.exception");

	//注意此类处理方式只是对某些js类库有用，比如jquery、extjs等。
	if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
		response.setCharacterEncoding("utf-8");
		if (ex instanceof AppObjectNotFoundException) {
			response.setStatus(999);
		}else
			response.setStatus(403);
		PrintWriter writer = response.getWriter();
		if (ex instanceof AppPermissionException
				|| ex instanceof AppObjectNotFoundException) {
			writer.println(ex.getMessage());
			
		}else{
			writer.println("抱歉，您没有访问该资源的权限！");
		}
		writer.flush();
		writer.close();
	}
%>
<% if (BrowserUtils.isWeiXin(request)) { %>
<%@ include file="mobile/403.jsp" %>
<%} else {%>
<html lang="zh-cn">
<head>
	<title>资源访问受限</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<meta http-equiv="Cache-Control" content="no-store"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<%@ include file="/WEB-INF/layouts_admin/head.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/layouts_admin/messages.jsp" %>
<!-- START Page Container -->
<%@ include file="/WEB-INF/layouts_admin/header.jsp" %>
<%-- <%@ include file="/WEB-INF/layouts_default/mainbar.jsp"%> --%>
<!-- Main Container -->

<div class="error-container">
	<div class="well">
		<h1 class="grey lighter smaller">
											<span class="blue bigger-125">
												<i class="icon-sitemap"></i>
												403
											</span>
			访问受限
		</h1>

		<hr>
		<h3 class="lighter smaller">We looked everywhere but we couldn't find it!</h3>

		<div>
			<form class="form-search">
												<span class="input-icon align-middle">
													<i class="icon-search"></i>

													<input type="text" class="search-query"
														   placeholder="Give it a search...">
												</span>
				<button class="btn btn-sm" onclick="return false;">Go!</button>
			</form>

			<div class="space"></div>
			<h4 class="smaller">Try one of the following:</h4>

			<ul class="list-unstyled spaced inline bigger-110 margin-15">
				<li>
					<i class="icon-hand-right blue"></i>
					Re-check the url for typos
				</li>

				<li>
					<i class="icon-hand-right blue"></i>
					Read the faq
				</li>

				<li>
					<i class="icon-hand-right blue"></i>
					Tell us about it
				</li>
			</ul>
		</div>

		<hr>
		<div class="space"></div>

		<div class="center">
			<a href="#" class="btn btn-grey">
				<i class="icon-arrow-left"></i>
				Go Back
			</a>

			<a href="#" class="btn btn-primary">
				<i class="icon-dashboard"></i>
				Dashboard
			</a>
		</div>
	</div>
</div>
<!-- class="container pb_60" -->
<!-- END Main Container -->
<%@ include file="/WEB-INF/layouts_admin/footer.jsp" %>
<!-- END Page Container -->
<%@ include file="/WEB-INF/layouts_admin/footerjs.jsp" %>
</body>
</html>
<%}%>