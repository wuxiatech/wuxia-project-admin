<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.PrintWriter"%>
<%
	//注意此类处理方式只是对某些js类库有用，比如jquery、extjs等。
	if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
		response.setCharacterEncoding("utf-8");
		response.setStatus(404);
		PrintWriter writer = response.getWriter();
		writer.println("抱歉，您的请求非法！");
		writer.flush();
		writer.close();
	}
%>
<!DOCTYPE html>
<html >
<head>
<title>400 - 请求非法</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
</head>
<body>
	<div class="container">
	    <div class="error_nav">
	   	  	<div class="error_cont"> 
		      	<div class="img"><img width="160" height="160" src="<c:url value="/resources/images/400.png"/>"></div>
				<div class="title">
					<h3 class="f_16 bold mt_10 ml_10">对不起，您的请求有误，以下信息有没有您需要的？</h3>			
				</div>
				<div class="oper f_14">
					<ul>
						<li>去其他地方逛逛：<br><a href="javascript:history.go(-1);">返回上一页</a><ins>|</ins><a href="/home">控制台</a></li>
					</ul>
				</div>
			</div>
	    </div>
	</div>
</body>
</html>