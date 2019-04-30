<%--
  Created by IntelliJ IDEA.
  User: songlin
  Date: 2018/2/27
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>微信支付</title>
</head>
<body>

<div class="weui-form-preview">
    <div class="weui-form-preview__hd">
        <div class="weui-form-preview__item">
            <label class="weui-form-preview__label">付款金额</label>
            <em class="weui-form-preview__value">¥${wxpayResponse.amount}</em>
        </div>
    </div>
    <div class="weui-form-preview__bd">
        <div class="weui-form-preview__item">
            <label class="weui-form-preview__label">订单号</label>
            <span class="weui-form-preview__value">${wxpayResponse.orderNo}</span>
        </div>
        <div class="weui-form-preview__item">
            <label class="weui-form-preview__label">商品名称</label>
            <span class="weui-form-preview__value">${wxpayResponse.product}</span>
        </div>
        <div class="weui-form-preview__item">
            <label class="weui-form-preview__label">备注</label>
            <span class="weui-form-preview__value">${wxpayResponse.remark}</span>
        </div>
    </div>
</div>
</body>
<myjs>
    <script>
        $(function () {
            

        var option = {
            "appId":"${wxpayResponse.appId}",
            "timestamp": ${wxpayResponse.timeStamp}, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
            "nonceStr": '${wxpayResponse.nonceStr}', // 支付签名随机串，不长于 32 位
            "package": '${wxpayResponse.package}', // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
            "signType": 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
            "paySign": '${wxpayResponse.paySign}', // 支付签名
        };
        $.wechat.init({
            debug : false,
            jsApiList : [ 'chooseWXPay' ],
            success : function(data) {
                wx.ready(function () {
                    /*
                     wx.invoke('setNavigationBarColor', {
                     color: '#F8F8F8'
                     });
                     */
                    /* wx.invoke('setBounceBackground', {
                         'backgroundColor': '#F8F8F8',
                         'footerBounceColor' : '#F8F8F8'
                     });*/
                    wx.chooseWXPay(option);
                });
            }
        });
        })
        // function onBridgeReady(){
        //     WeixinJSBridge.invoke(
        //         'getBrandWCPayRequest', {
        //             "appId":"wx2421b1c4370ec43b",     //公众号名称，由商户传入
        //             "timeStamp":"1395712654",         //时间戳，自1970年以来的秒数
        //             "nonceStr":"e61463f8efa94090b1f366cccfbbb444", //随机串
        //             "package":"prepay_id=u802345jgfjsdfgsdg888",
        //             "signType":"MD5",         //微信签名方式：
        //             "paySign":"70EA570631E4BB79628FBCA90534C63FF7FADD89" //微信签名
        //         },
        //         function(res){
        //             if(res.err_msg == "get_brand_wcpay_request:ok" ) {}     // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
        //         }
        //     );
        // }
        // if (typeof WeixinJSBridge == "undefined"){
        //     if( document.addEventListener ){
        //         document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
        //     }else if (document.attachEvent){
        //         document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
        //         document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
        //     }
        // }else{
        //     onBridgeReady();
        // }
    </script>
</myjs>
</html>
