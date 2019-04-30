<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="taglibs.jsp" %>

<header data-am-widget="header"
        class="am-header am-header-default">
    <div class="am-header-left am-header-nav">
        <a href="/mobile/${userContext.userType}/center<c:if test="${not empty patientid}">/${patientid}</c:if>" class="">

            <i class="am-header-icon am-icon-home"></i>
        </a>
    </div>

    <h1 class="am-header-title">
        <a href="javascript:;" class="">
            <sitemesh:write property='title'/>
        </a>
    </h1>

    <div class="am-header-right am-header-nav">
        <a href="#right-link" class="">

            <i class="am-header-icon"></i>
        </a>
    </div>
</header>