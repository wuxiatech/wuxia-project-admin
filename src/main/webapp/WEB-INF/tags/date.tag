<%@ tag pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/project/functions" prefix="ifn"%>
<%@ attribute name="timestamp" type="java.lang.Long" rtexprvalue="true" required="true" description="long格式的时间" %>
<%@ attribute name="formatter" type="java.lang.String"  required="false" description="格式化如yyyy-MM-dd HH:mm:ss" %>
<c:if test="${empty formatter}" >
    <c:set var="formatter" value="yyyy-MM-dd HH:mm:ss" />
</c:if>
<jsp:useBean id="dateValue" class="java.util.Date"/>
<c:if test="${not empty timestamp}">
<jsp:setProperty name="dateValue" property="time" value="${timestamp*1000}"/>
    <fmt:formatDate value="${dateValue}" pattern="${formatter}"/>
</c:if>