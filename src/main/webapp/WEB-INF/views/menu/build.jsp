<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: songlin
  Date: 2017/11/29
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!--左边 -->
<div class="sidebar" id="sidebar">
    <ul class="nav nav-list">
        <c:forEach items="${menus}" var="menu" >
        <li class="">
            <a <c:if test="${not empty menu.url}"> href="${menu.url}"</c:if> class="dropdown-toggle">
                <i class="icon-desktop"></i>
                <span class="menu-text">
									${menu.name}
								 </span>
                <c:if test="${not empty menu.subMenu}">
                <b class="arrow icon-angle-down"></b>
                </c:if>
            </a>
            <c:if test="${not empty menu.subMenu}">
            <ul class="submenu">
            <c:forEach items="${menu.subMenu}" var="submenu">
                <c:out escapeXml="false" value="<sec:authorize url=\"${submenu.url}\">"></c:out>
                    <li <c:out escapeXml="false" value="<c:if test=\"\${ pathname eq '${submenu.url}'}\">class=\"active\"</c:if>" /> ><a href="${submenu.url}"><i class="icon-double-angle-right"></i>${submenu.name}</a></li>
                <c:out escapeXml="false" value="</sec:authorize>"></c:out>
            </c:forEach>
            </ul>
            </c:if>
        </li>
        </c:forEach>
    </ul>
    <!-- 隐藏左边 -->
    <div class="sidebar-collapse" id="sidebar-collapse">
        <i class="icon-double-angle-left" data-icon1="icon-double-angle-left"
           data-icon2="icon-double-angle-right"></i>
    </div>
</div>