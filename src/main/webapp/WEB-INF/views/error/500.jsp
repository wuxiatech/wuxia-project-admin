<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="cn.wuxia.common.exception.ServiceException" %>
<%@ page import="cn.wuxia.common.exception.AppPermissionException" %>
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
        response.setStatus(500);
        PrintWriter writer = response.getWriter();
        if (ex instanceof ServiceException || ex instanceof AppPermissionException) {
            writer.println(request.getAttribute("message"));
        } else {
            writer.println("抱歉，发生系统错误，请稍后再试！");
        }
        writer.flush();
        writer.close();
    }

%>

<% if (BrowserUtils.isWeiXin(request)) {
%>
<%@ include file="mobile/500.jsp" %>
<%} else {%>
<html lang="zh-cn">
<head>
    <title>出错啦</title>

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
												<i class="icon-random"></i>
												500
											</span>
            <%if (null != request.getAttribute("message") && "" != request.getAttribute("message")) {%>
            <%=request.getAttribute("message")%>
            <%} else { %>
            对不起，很遗憾系统出错了，以下信息有没有您需要的？
            <%} %>
        </h1>

        <hr>
        <h3 class="lighter smaller">
            But we are working
            <i class="icon-wrench icon-animated-wrench bigger-125"></i>
            on it!
        </h3>

        <div class="space"></div>

        <div>
            <h4 class="lighter smaller">Meanwhile, try one of the following:</h4>

            <ul class="list-unstyled spaced inline bigger-110 margin-15">
                <li>
                    <i class="icon-hand-right blue"></i>
                    Read the faq
                </li>

                <li>
                    <i class="icon-hand-right blue"></i>
                    Give us more info on how this specific error occurred!
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
