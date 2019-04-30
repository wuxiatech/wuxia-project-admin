<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%@ page import="cn.wuxia.common.util.BrowserUtils" %>
<%

    //记录日志
    Logger logger = LoggerFactory.getLogger("404.jsp");
    //需要结合tomcat等web服务器的access日志来进一步查看详细异常信息
    logger.info("404 Request,Page Not Found!");
    //注意此类处理方式只是对某些js类库有用，比如jquery、extjs等。
    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
        response.setCharacterEncoding("utf-8");
        response.setStatus(404);
        PrintWriter writer = response.getWriter();
        writer.println("抱歉，您请求的资源不存在，请检查请求的链接是否正确！");
        writer.flush();
        writer.close();
    }
%>
<% if (BrowserUtils.isWeiXin(request)) { %>
<%@ include file="mobile/404.jsp" %>
<%} else {%>
<html lang="zh-cn">
<head>
    <title>资源不存在</title>
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
												404
											</span>
            Page Not Found
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
