<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>微信支付</title>
</head>
<body>
<%@ include file="progress.jsp" %>
<div class="order-step-area2">
    <div class="order-s-a2-bd clearfix">
        <div class="alert alert-info fade in">
            请用微信扫描下方二维码并完成支付
        </div>
        <div style="text-align: center;">
            <img alt="" src="/payment/qrcode?content=${wxpayResponse }" />
        </div>
    </div>
</div>
</body>
</html>