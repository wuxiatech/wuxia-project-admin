<%@ page import="cn.wuxia.project.common.security.UserContextUtil" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="ifn" uri="/project/functions"%>
<c:set var="pathname" value="${requestScope['javax.servlet.forward.request_uri']}"></c:set>
<c:set var="ctx" value="${pageContext.request.serverName}${pageContext.request.contextPath}" />
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
<c:set var="userContext" value="<%=UserContextUtil.getUserContext() %>"/>
<c:set var="isLogon" value="${userContext!=null }"></c:set>
