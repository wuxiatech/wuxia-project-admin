<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.ibmall.cn/web/functions" prefix="ifn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>艾比网ibmall.cn—您身边的外贸服务超市</title>
<meta name="keywords" content="艾比网 ibmall 外贸 进出口 海运订舱 物流拖车 报关 融资 平台 跨境">
<meta name="description" content="艾比网（www.ibmall.cn）是一家专注于外贸综合服务的平台型网站。艾比网集成提供安全、便捷、优质、高效的外贸综合服务，是您身边的外贸服务超市！">
<!-- start meta -->
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-store" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta property="wb:webmaster" content="f8b0bf530545d9f6" />
<!-- /start meta -->
<link href="/resources/images/wmg/favicon.ico" type="image/x-icon" rel="shortcut icon">
<link rel="stylesheet" type="text/css" href="/resources/styles/css/bootstrap.ibmall.css" />
<link rel="stylesheet" type="text/css" href="/resources/styles/css/ace.min.css">
<link rel="stylesheet" type="text/css" href="/resources/styles/css/font-awesome.min.css" />
<link href="/resources/styles/wmg/ibmall_style.css" rel="stylesheet" type="text/css" />
<link href="/resources/styles/wmg/ibmall_headfoot.css" rel="stylesheet" type="text/css" />
<link href="/resources/styles/wmg/ibmall_user.css" rel="stylesheet" type="text/css" />
<link href="/resources/styles/base1.css" rel="stylesheet" type="text/css" />
<%@ include file="/WEB-INF/views/common/artDialog-css.jsp"%>
<link rel="stylesheet" href="/resources/styles/css/jquery-ui-1.10.3.full.min.css" />
<style>
.ui-dialog-titlebar-close {
	display: none;
}
</style>
</head>
<body>
	<!-- head-->
	<!--/head-->
	<!-- Go-->
	<div class="ibm_middle">
		<div class="ibm_middle_inner">
			<div class="col-xs-12 pl_0 pr_0 bors_bce0a8 bg_f3fded pt_40 pb_40 mb_20">
				<div class="col-xs-12 pl_0 pr_0 tex_c f_16 b37link mt_20">
					<div class="inline ml_20 mr_20">订单号：${orderNo }</div>
					<div class="inline ml_20 mr_20">
						应付金额：
						<span class="bold font_color01">
							￥
							<fmt:formatNumber value="${orderCharge }" pattern="#,##0.00" />
						</span>
					</div>
				</div>
				<div class="col-xs-12 pl_0 pr_0 tex_c mt_20">
					请您在提交订单后
					<span class="font_color01">24小时</span>
					内完成支付，否则订单会自动取消。
				</div>
			</div>
			<div class="col-xs-12 pl_0 pr_0">
				<div id="tabs" class="mb_15 tab_header">
					<ul class="" role="">
						<li class="hover"><a href="#tabs-1">支付方式</a></li>
					</ul>
				</div>
				<div class="bors_all pl_30 pr_30 pt_30 pb_30 f_12 l_h_26 fn-clear pot_r">
					<div class="col-xs-12 pt_50 pb_50 ">
						<ul>
							<li class="col-xs-3  h_60 mb_20"><a class="bank">
									<div style="border:2px solid #fb5b03" class="bors_all">
										<div class="tex_c pt_10 pb_10">
											<img width="140" height="46" alt="银联支付" src="/resources/images/wmg/logo/bank_0.png">
										</div>
									</div>
								</a>
							</li>
							<c:forEach begin="1" end="11" var="i">
								<li class="col-xs-3  h_60 mb_20"><a class="bank">
										<div class="bors_all">
											<div class="tex_c pt_10 pb_10">
												<img width="140" height="46" alt="银联支付" src="/resources/images/wmg/logo/bank_${i }.png">
											</div>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="tex_c pt_30 mt_30 col-xs-12 pb_40 bors_t">
						<form action="/px/checkOrderCharge" target="_blank" id="finishForm" method="post">
							<%--<input type="hidden" name="amount" id="amount" value="${orderCharge }">
											<input type="hidden" name="paymentType" id="paymentType" value="${paymentType }">
											<input type="hidden" name="orderNo" id="orderNo" value="${orderNo }">
											<input type="hidden" name="callbackUrl" id="callbackUrl" value="${detailUrl }">
											<input type="hidden" name="remark" value="艾比网检测检验交易支付"> --%>
							<input type="hidden" name="oid" id="orderId" value="${ifn:encodeId(orderId) }">
							<input type="hidden" id="detailUrl" value="${detailUrl }">
						</form>
						<button class="btn btn-sm btn-primary no-radius btn_log mr_20" type="button" id="submitButton">付款</button>
						<div class="clearfix"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End -->
	<%@ include file="/common/footer.jsp"%>
	<%@ include file="/WEB-INF/views/common/artDialog-js.jsp"%>
	<script type="text/javascript" src="/resources/scripts/ace/jquery-ui-1.10.3.full.min.js"></script>
	<script type="text/javascript">
		$(function() {
			if ("${orderId}".length <= 0) {
				if ("${detailUrl }".length > 0) {
					window.location.href = "${detailUrl }";
				} else {
					window.location.href = "/";
				}
			}
			$("#submitButton").click(function() {
				$("#finishForm").submit();
				showDialongMessage();
				/*$.ajax({
					cache : false,
					type : "POST",
					url : "/user/checkVerifycode",
					data : {
						charge : $("#amount").val(),
						orderId : "${orderId}"
					},
					success : function(data) {
						if (data == true) {
						}else {
							
						}
					},
					error : function(data) {
						
					}
				});	*/
			});
			
			$(".bank").click(function() {
				$(".bors_all").removeAttr("style");
				$(this).find(".bors_all").attr("style","border:2px solid #fb5b03");
			});
		})

		//弹出付款提示框
		var dialogWindow;
		function showDialongMessage() {
			showMessage({
				title : "<div class='widget-header widget-header-small'><h5 class='smaller'><i class='icon-ok'></i>提示</h5></div>",
				message : '您的订单是否支付成功？'
			}, [{
				text : "支付成功",
				'class' : 'successPay btn btn-primary btn-minier ui-button-text f_12 ',
				click : function() {
					paySuccess();
				}
			}, {
				text : "关闭",
				'class' : 'closePay btn btn-minier ui-button-text f_12 ',
				click : function() {
					paySuccess();
				}
			}])
		}
		function paySuccess() {
			window.location.href = "/sales/${orderNo}.html";
		}
	</script>
</body>
</html>
