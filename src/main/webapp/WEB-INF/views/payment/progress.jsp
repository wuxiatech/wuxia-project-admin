<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div class="order-step-area1" style="padding: 0;margin: 0;">
	<div id="fuelux-wizard" class="row-fluid" data-target="#step-container">
		<ul class="wizard-steps">
			<li data-target="#step1"
				<c:if test="${fn:contains(pathname, 'recharge')
				||fn:contains(pathname, '/payment/pay')
				||fn:contains(pathname, '/payment/submit')
				||fn:contains(pathname, 'finish')}">class="active"</c:if>>
				<span class="step">1</span> <span class="title">输入充值金额</span>
			</li>
			<li data-target="#step2"
				<c:if test="${fn:contains(pathname,'/payment/pay')
				||fn:contains(pathname, '/payment/submit')
				||fn:contains(pathname, 'finish')}">class="active"</c:if>><span
				class="step">2</span> <span class="title">支付宝或微信支付</span></li>
			<li data-target="#step3"
				<c:if test="${fn:contains(pathname, 'finish')}">class="active"</c:if>><span
				class="step">3</span> <span class="title">完成充值</span></li>
		</ul>
	</div>
</div>

