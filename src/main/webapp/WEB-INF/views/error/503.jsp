<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory"%>
<%@ page import="java.io.PrintWriter"%>

<%
	//注意此类处理方式只是对某些js类库有用，比如jquery、extjs等。
	if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
		response.setCharacterEncoding("utf-8");
		response.setStatus(404);
		PrintWriter writer = response.getWriter();
		writer.println("抱歉，发生系统错误，请稍后再试！");
		writer.flush();
		writer.close();
	}
%>

<!DOCTYPE html>
<html >
<head>
<title>503 - 系统内部错误</title>
<%@ include file="/WEB-INF/views/common/header.jsp"%>

</head>

<body>
	<div class="container">
	    <div class="error_nav">
	   	  	<div class="error_cont">
		      	<div class="img"><img width="160" height="160" src="<c:url value="/resources/images/500.png"/>"></div>
				<div class="title">
					<h3 class="f_16 bold mt_10 ml_10">对不起，很遗憾系统出错了，以下信息有没有您需要的？</h3>			
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
