<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <title>充值</title>
    </head>
    <body>
    <%@ include file="progress.jsp" %>
    <div class="order-step-area2">
        <div class="order-s-a2-bd clearfix">
            <form action="/payment/pay" id="chargeform" method="post" class="form-horizontal">
                <input type="hidden" name="paymentType" value="CHONGZHI">
                <input type="hidden" name="returnurl" value="${currentUrl }">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-lg-2 control-label">可用余额</label>
                        <div class="col-lg-10">
                            <input class="form-control" style="height:40px;width: 260px; display: inline;border: none;text-align: right;" type="text" value="<fmt:formatNumber value="${map.availableAmount }" pattern="#,##0.00#"/>"
                                   autocomplete="off" readonly/>
                            <span>${map.currencyName }</span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="amount" class="col-lg-2 control-label">充值金额</label>
                        <div class="col-lg-10">
                            <input class="form-control" style="height:40px;width: 260px; display: inline;text-align: right;" type="text" name="amount" id="amount"
                                   autocomplete="off" data-exchangeratetormb="${currency.exchangeRateToRmb}"/>
                            <span>${map.currencyName }</span>
                            <p style="margin: 5px 0 0 0">按照当前系统约定汇率1欧元=${currency.exchangeRateToRmb}人民币，该充值金额相当于 <span id="rmbShow">0</span> 人民币。</p>
                        </div>
                    </div>
                    <div class="form-group verifycode">
                        <label class="col-lg-2 control-label">验证</label>
                        <div class="col-lg-10">
                            <div id="slider" style="width:260px;height:40px;">

                            </div>
                            <p id="unlockmsg" style="display: none;">请完成验证</p>
                        </div>
                    </div>
                    <div class="form-group verifycode">
                        <label class="col-lg-2 control-label"></label>
                        <div class="col-lg-10">
                            <button type="submit" class="btn-u btn-u-blue">下一步</button>
                            <a href="/user/center" class="btn-u btn-u-default">取消</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <myjs>
    <script type="text/javascript">
        <!--
        $("head").append('<link href="${resources_ctx}/resources/script/slidetounlock/less/unlock.css" rel="stylesheet">');
        //-->
    </script>
    <script src="${resources_ctx}/resources/script/slidetounlock/js/unlock.js"></script>
    <script type="text/javascript" src="${resources_ctx}/resources/script/payment/recharge.js?v=1.434"></script>
    </myjs>
    </body>

</html>
