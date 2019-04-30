<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="taglibs.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 头部开始 -->
<!--最顶 -->
<!--原header.jsp的登录部分 -->
<div class="navbar navbar-default" id="navbar">
    <div class="navbar-inner">
        <div class="navbar-inner">
            <div class="container-fluid" id="">
                <div class="btn-group pull-right">
                    <a class="btn dropdown-toggle" data-toggle="dropdown" href="#"> <i
                            class="icon-user"></i>${customerName }<span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="/admin/user/profile" name="disabledHref">个人资料</a></li>
                        <li class="divider"></li>
                        <li><a href="/auth/logout">退出</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 框架的顶部 -->
<!-- <div class="navbar navbar-default" id="navbar"> -->
<!-- </div> -->
<!--顶部的下面的 -->
<div class="main-container" id="main-container">
    <div class="main-container-inner">
        <!--左边 -->
        <%--<%@include file="menu.jsp"%>--%>
        <div class="sidebar" id="sidebar">
            <ul class="nav nav-list">
                <c:if test="${userDetail.type == 'ADMIN'}">
                <li class="">
                    <a href="#" class="dropdown-toggle">
                        <i class="icon-desktop"></i>
                        <span class="menu-text">
									账号管理
								 </span>
                        <b class="arrow icon-angle-down"></b>
                    </a>
                    <ul class="submenu">
                        <sec:authorize url="/admin/org/list">
                            <li <c:if test="${ pathname eq '/admin/org/list'}">class="active"</c:if>><a
                                    href="/admin/org/list"><i class="icon-double-angle-right"></i>企业机构列表</a></li>
                        </sec:authorize>
                        <sec:authorize url="/admin/user/list">
                            <li <c:if test="${ pathname eq '/admin/user/list'}">class="active"</c:if>><a
                                    href="/admin/user/list"><i class="icon-double-angle-right"></i>管理员列表</a></li>
                        </sec:authorize>
                    </ul>
                </li>
                <li class="">
                    <a href="#" class="dropdown-toggle">
                        <i class="icon-desktop"></i>
                        <span class="menu-text"> 权限管理
								 </span>
                        <b class="arrow icon-angle-down"></b>
                    </a>
                    <ul class="submenu">
                        <sec:authorize url="/security/resources/list">
                            <li <c:if test="${ pathname eq '/security/resources/list'}">class="active"</c:if>><a
                                    href="/security/resources/list"><i class="icon-double-angle-right"></i>资源管理</a></li>
                        </sec:authorize>
                        <sec:authorize url="/security/permission/list">
                            <li <c:if test="${ pathname eq '/security/permission/list'}">class="active"</c:if>><a
                                    href="/security/permission/list"><i class="icon-double-angle-right"></i>权限管理</a>
                            </li>
                        </sec:authorize>
                        <sec:authorize url="/security/role/list">
                            <li <c:if test="${ pathname eq '/security/role/list'}">class="active"</c:if>><a
                                    href="/security/role/list"><i class="icon-double-angle-right"></i>角色管理</a></li>
                        </sec:authorize>
                    </ul>
                </li>
                <li class="">
                    <a href="#" class="dropdown-toggle">
                        <i class="icon-desktop"></i>
                        <span class="menu-text"> 公众号管理
								 </span>
                        <b class="arrow icon-angle-down"></b>
                    </a>
                    <ul class="submenu">
                        <sec:authorize url="/wxopen/oauth/">
                            <li <c:if test="${ pathname eq '/wxopen/oauth/list'}">class="active"</c:if>><a
                                    href="/wxopen/oauth/list"><i class="icon-double-angle-right"></i>公众号管理</a></li>
                        </sec:authorize>
                    </ul>
                </li>

                <li class="">
                    <a href="#" class="dropdown-toggle">
                        <i class="icon-desktop"></i>
                        <span class="menu-text"> 系统设置
								 </span>
                        <b class="arrow icon-angle-down"></b>
                    </a>
                    <ul class="submenu">
                        <sec:authorize url="/dic/config/">
                            <li <c:if test="${ pathname eq '/dic/config/list'}">class="active"</c:if>><a
                                    href="/dic/config/list"><i class="icon-double-angle-right"></i>字典管理</a></li>
                        </sec:authorize>
                        <sec:authorize url="/dic/tag/">
                            <li <c:if test="${ pathname eq '/dic/tag/list'}">class="active"</c:if>><a
                                    href="/dic/tag/list"><i class="icon-double-angle-right"></i>标签管理</a></li>
                        </sec:authorize>
                        <sec:authorize url="/dic/orderno/list">
                            <li <c:if test="${ pathname eq '/dic/orderno/list'}">class="active"</c:if>><a
                                    href="/dic/orderno/list"><i class="icon-double-angle-right"></i>有序号码管理</a></li>
                        </sec:authorize>
                        <sec:authorize url="/advert/location/list">
                            <li <c:if test="${ pathname eq '/advert/location/list'}">class="active"</c:if>><a
                                    href="/advert/location/list"><i class="icon-double-angle-right"></i>广告位管理</a></li>
                        </sec:authorize>
                        <sec:authorize url="/dic/menu/">
                            <li <c:if test="${fn:indexOf(pathname, '/menu/') > 0}">class="active"</c:if>><a
                                    href="/dic/menu/list"><i class="icon-double-angle-right"></i>管理菜单</a></li>
                        </sec:authorize>
                        <sec:authorize url="/system/scheduler/">
                            <li <c:if test="${fn:indexOf(pathname, '/scheduler/') > 0}">class="active"</c:if>><a
                                    href="/system/scheduler/list"><i class="icon-double-angle-right"></i>管理定时任务</a></li>
                        </sec:authorize>
                        <sec:authorize url="/system/build">
                            <li <c:if test="${ pathname eq '/system/build'}">class="active"</c:if>><a
                                    href="/system/build"><i class="icon-double-angle-right"></i>系统工具</a></li>
                        </sec:authorize>

                    </ul>
                </li>
                </c:if>
                <c:forEach items="${ifn:menus('admin_system_menu')}" var="menu">
                    <li class="">
                        <c:if test="${fn:length(menu.subMenu) == 0}">
                            <a href="${menu.url}">
                                <i class="icon-desktop"></i>
                                <span class="menu-text"> ${menu.name}
                                </span>
                            </a>
                        </c:if>
                        <c:if test="${fn:length(menu.subMenu) > 0}">
                            <a href="#" class="dropdown-toggle">
                                <i class="icon-desktop"></i>
                                <span class="menu-text"> ${menu.name}
                                </span>
                                <b class="arrow icon-angle-down"></b>
                            </a>
                            <ul class="submenu">
                                <c:forEach items="${menu.subMenu}" var="submenu">
                                    <sec:authorize url="${submenu.url}">
                                        <li class=""><a href="${submenu.url}"><i
                                                class="icon-double-angle-right"></i>${submenu.name}</a></li>
                                    </sec:authorize>
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

        <!-- 里面的 -->
        <div class="main-content">
            <!-- 里面的标题 -->
            <div class="breadcrumbs" id="breadcrumbs">

            </div>
            <!-- 里面的 -->
            <div class="page-content">
                <!-- PAGE CONTENT BEGINS -->
                <!--头部结束-->