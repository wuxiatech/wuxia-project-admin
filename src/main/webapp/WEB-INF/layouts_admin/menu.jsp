<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>





<!--左边 -->
<div class="sidebar" id="sidebar">
    <ul class="nav nav-list">
        
        <li class="">
            <a  class="dropdown-toggle">
                <i class="icon-desktop"></i>
                <span class="menu-text">
									账号管理
								 </span>
                
                <b class="arrow icon-angle-down"></b>
                
            </a>
            
            <ul class="submenu">
            
                <sec:authorize url="/patient/">
                    <li <c:if test="${ pathname eq '/patient/'}">class="active"</c:if> ><a href="/patient/"><i class="icon-double-angle-right"></i>患者列表</a></li>
                </sec:authorize>
            
                <sec:authorize url="/doctor/">
                    <li <c:if test="${ pathname eq '/doctor/'}">class="active"</c:if> ><a href="/doctor/"><i class="icon-double-angle-right"></i>医生菜单</a></li>
                </sec:authorize>
            
            </ul>
            
        </li>
        
    </ul>
    <!-- 隐藏左边 -->
    <div class="sidebar-collapse" id="sidebar-collapse">
        <i class="icon-double-angle-left" data-icon1="icon-double-angle-left"
           data-icon2="icon-double-angle-right"></i>
    </div>
</div>
