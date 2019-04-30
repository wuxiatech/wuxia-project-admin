<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/project/functions" prefix="ifn"%>
<%@ taglib uri="/project/storage/functions" prefix="sfn"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ page import="cn.wuxia.project.security.common.SpringSecurityUtils"%>
<%@ page import="org.springframework.security.core.context.SecurityContext"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.wuxia.project.basic.support.Functions" %>
<c:set var="springSecurityContext" value="${SPRING_SECURITY_CONTEXT}" />
<c:set var="pathname" value="${requestScope['javax.servlet.forward.request_uri']}"></c:set>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="local" value="<%=request.getLocale()%>" />
<c:set var="radom" value="<%=System.currentTimeMillis()%>" />

<c:choose>
	<c:when test="${empty pageContext.request.queryString }">
		<c:set var="currentUrl" value="${pathname}"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="currentUrl"
			value="${pathname}?${pageContext.request.queryString }"></c:set>
	</c:otherwise>
</c:choose>
<c:if test="${ springSecurityContext != null}">
	<c:set var="userDetail" value="${ springSecurityContext.authentication.principal}"></c:set>
</c:if>
<c:if test="${ springSecurityContext == null}">
	<c:set var="userDetail" value="<%=SpringSecurityUtils.getCurrentUser()%>"></c:set>
</c:if>
<c:set var="customerName" value="${userDetail.displayName }"></c:set>
<c:set var="isLogon" value="${userDetail!=null }"></c:set>
