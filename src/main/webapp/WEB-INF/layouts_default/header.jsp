<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="header hidden-sm hidden-xs">
	<div class="container">
		<!-- Logo -->
		<a href="/" class="logo"> <img alt="Logo" src="/resources/images/${englishname_ctx }.gif" style="width: 100%;margin-bottom:35px;">
		</a>
		<!-- End Logo -->

		<!-- Topbar -->
		<div class="topbar">
			<ul class="loginbar pull-right">
				<li><c:choose>
						<c:when test="${not empty userDetail.displayName }"><a href="/doctor/profile">${userDetail.displayName }</a></c:when>
						<c:otherwise>
							<a href="/auth/login">登录</a>
						</c:otherwise>
					</c:choose></li>
				<li class="topbar-devider"></li>
				<li><a href="/auth/logout">退出</a></li>
			</ul>
		</div>
		<!-- End Topbar -->
	</div>
	<div class="collapse navbar-collapse mega-menu navbar-responsive-collapse" role="navigation">
		<div class="container">
			<ul class="nav navbar-nav">
				<li class="dropdown">
				<a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
                                    账号管理
                                </a>
                                <ul class="dropdown-menu">
				<sec:authorize url="/doctor/qrlist">
					<li <c:if test="${ pathname eq '/doctor/qrlist'}">class="active"</c:if>><a href="/doctor/qrlist">医生二维码</a></li>
				</sec:authorize>
				<sec:authorize url="/admin/doctor/list">
					<li <c:if test="${ pathname eq '/admin/doctor/list'}">class="active"</c:if>><a href="/admin/doctor/list">医生列表</a></li>
				</sec:authorize>
				<sec:authorize url="/admin/nurse/list">
					<li <c:if test="${ pathname eq '/admin/nurse/list'}">class="active"</c:if>><a href="/admin/nurse/list">护士列表</a></li>
				</sec:authorize>
				<sec:authorize url="/admin/medicalstaff/list">
					<li <c:if test="${ pathname eq '/admin/medicalstaff/list'}">class="active"</c:if>><a href="/admin/medicalstaff/list">医技列表</a></li>
				</sec:authorize>
				<sec:authorize url="/admin/customer/list">
					<li <c:if test="${ pathname eq '/admin/customer/list'}">class="active"</c:if>><a href="/admin/customer/list">客服列表</a></li>
				</sec:authorize>
				<sec:authorize url="/admin/doctor/statistics">
					<li <c:if test="${ pathname eq '/admin/doctor/statistics'}">class="active"</c:if>><a href="/admin/doctor/statistics">医生数据统计</a></li>
				</sec:authorize>
				</ul>
				</li>
				
				<li class="dropdown">
				<a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
                                    权限管理
                                </a>
                                <ul class="dropdown-menu">
		 		<sec:authorize url="/security/resources/list"> 
				<li <c:if test="${ pathname eq '/security/resources/list'}">class="active"</c:if>><a href="/security/resources/list">资源管理</a></li>
			 	</sec:authorize> 
				<sec:authorize url="/security/permission/list">
				<li <c:if test="${ pathname eq '/security/permission/list'}">class="active"</c:if>><a href="/security/permission/list">权限管理</a></li>
				</sec:authorize>
				<sec:authorize url="/security/role/list">
					<li <c:if test="${ pathname eq '/security/role/list'}">class="active"</c:if>><a href="/security/role/list">角色管理</a></li>
				</sec:authorize>
				</ul>
				</li>
				
				<sec:authorize url="/wxopen/oauth">
					<li <c:if test="${ pathname eq '/wxopen/oauth/jumpoauth'}">class="active"</c:if>><a href="/wxopen/oauth/jumpoauth">公众号管理</a></li>
				</sec:authorize>
				<li class="dropdown">
					<a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
						系统设置
					</a>
					<ul class="dropdown-menu">
						<sec:authorize url="/dic/config/list">
							<li <c:if test="${ pathname eq '/dic/config/list'}">class="active"</c:if>><a href="/dic/config/list">字典管理</a></li>
						</sec:authorize>

					</ul>
				</li>
				<li class="dropdown">
				<a href="javascript:void(0);" class="dropdown-toggle" data-toggle="dropdown">
                                    快捷方式
                                </a>
                                <ul class="dropdown-menu">
			<li class=""><a href="http://${fn:replace(domain, 'admin', 'www') }/wechat/article/management">返回微官网</a></li>
					<li><a href="http://${fn:replace(domain, 'admin', 'followup') }/follow/list">返回随访系统</a></li>
				
					<li class=""><a href="http://${fn:replace(domain, 'admin', 'remind') }/doctor/myQRcode">返回提醒系统</a></li>
			</ul></li>
			</ul>
		</div>
	</div>
</div>