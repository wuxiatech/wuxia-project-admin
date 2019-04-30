<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%@ page import="cn.wuxia.common.util.BrowserUtils" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="zh-cn" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="zh-cn" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="zh-cn">
<!--<![endif]-->
<head>
    <title>请求资源不存在</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta http-equiv="Cache-Control" content="no-store"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <meta http-equiv="Expires" content="0"/>
    <%@ include file="/WEB-INF/layouts_mobile/head.jsp" %>
    <link rel="stylesheet" href="//17.zjcdn.cn/assets/plugins/line-icons/line-icons.css">
    <link rel="stylesheet" href="//17.zjcdn.cn/assets/plugins/font-awesome/css/font-awesome.min.css">
    <style type="text/css">

    </style>
</head>
<body ontouchstart>
<div class="weui-toptips weui-toptips_warn js_tooltips"></div>
<div class="container" id="container">
    <div class="page js_show msg_warn">
        <%@ include file="/WEB-INF/layouts_mobile/header.jsp" %>
        <div class="page__bd" style="min-height:460px;height:100%;">
            <div class="weui-msg">
                <div class="weui-msg__icon-area"><i class="weui-icon-warn weui-icon_msg"></i></div>
                <div class="weui-msg__text-area">
                    <h2 class="weui-msg__title">404</h2>
                    <p class="weui-msg__desc">抱歉，您请求的资源不存在</p>
                </div>
                <div class="weui-msg__opr-area">
                    <p class="weui-btn-area">
                        <a href="/mobile/patient/center" class="weui-btn weui-btn_primary">返回个人中心</a>
                        <a href="javascript:history.back();" class="weui-btn weui-btn_default">返回上一步</a>
                    </p>
                </div>
                <div class="weui-msg__extra-area">
                    <div class="weui-footer">
                        <p class="weui-footer__links">
                            <a href="javascript:void(0);" class="weui-footer__link">稻铭健康提供技术支持</a>
                        </p>
                    </div>
                </div>
            </div>


        </div>
        <c:if test="${pathname != '/mobile/center/index' }">
        </c:if>
    </div>
</div>
<%@ include file="/WEB-INF/layouts_mobile/footerjs.jsp" %>
</body>
</html>

