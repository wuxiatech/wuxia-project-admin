<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>${remark }</title>
</head>
<body>
<%@ include file="progress.jsp" %>
<div class="order-step-area2">
    <div class="order-s-a2-bd clearfix">
        <form action="/payment/submit" target="_blank" id="finishForm" method="post" class="form-horizontal">
            <div class="form-group">
                <label class="col-lg-2 control-label">交易订单号：</label>
                <div class="col-lg-10 control-label" style="text-align: left;">
                    ${orderNo}
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-2 control-label">应付金额：</label>
                <div class="col-lg-10 control-label" style="text-align: left;">
                    <span class="bold" style="font-size:14px; color: orange; "><fmt:formatNumber value="${truecharge }" pattern="#,##0.00"/> </span>人民币
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-2 control-label">实际到账：</label>
                <div class="col-lg-10 control-label" style="text-align: left;">
                    <span class="bold" style="font-size:14px; color: orange; "><fmt:formatNumber value="${orderCharge }" pattern="#,##0.00"/> </span>${currencydto.currencyName }
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-2 control-label">
                </label>
                    <div class="col-lg-10 control-label" style="text-align: left;">
                    请您在提交支付订单后<span class="font_color01">2小时</span>内完成支付，否则订单会自动取消。
                    </div>
            </div>
            <div class="form-group">
                <label class="col-lg-2 control-label">选择支付方式：</label>
                <div class="col-lg-10 control-label sky-form" style="text-align: left;">
                    <section>
                        <div class="inline-group">
                            <label class="radio">
                                <input type="radio" type="radio" value="WECHATPAY" autocomplete="off" name="platform" checked="checked">
                                <i class="rounded-x"></i>
                                <img alt="微信支付" src="/resources/pictures/WePayLogo.png" width="80">
                            </label>
                            <label class="radio">
                                <input type="radio" value="ALIPAY" autocomplete="off" name="platform">
                                <i class="rounded-x"></i>
                                <img alt="支付宝支付" src="/resources/pictures/alipay.gif" width="80">
                            </label>
                        </div>

                    </section>
                </div>
            </div>
            <div class="form-group">
                <label class="col-lg-2 control-label"></label>
                <div class="col-lg-10 control-label" style="text-align: left;">
                    <input type="hidden" name="amount" id="amount" value="${truecharge }">
                    <input type="hidden" name="paymentType" id="paymentType" value="${paymentType }">
                    <input type="hidden" name="callbackUrl" id="callbackUrl" value="${returnUrl }">
                    <input type="hidden" name="remark" value="${remark }">
                    <input type="hidden" name="orderNo" value="${orderNo }">
                    <button class="btn-u btn-u-blue" type="button" id="submitButton">付款</button>
                    <a href="/payment/recharge" class="btn-u btn-u-default">取消</a>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- End -->
<myjs>
	<script type="text/javascript">
		$(function(){
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
		})

		//弹出付款提示框
		var dialogWindow;
		function showDialongMessage() {

			$.alert({title:"提示", content:"您的订单是否支付成功？", buttons:{
				"支付成功":function(){paySuccess();this.close()},
        		"关闭":function(){this.close()}
        	}});

		}
		function paySuccess(){
			window.location.href = "${returnUrl}";
		}

		</script>
		</myjs>
</body>
</html>




