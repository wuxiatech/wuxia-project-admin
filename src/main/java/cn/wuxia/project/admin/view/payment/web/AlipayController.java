/*
 * Created on :29 May, 2014 Author :songlin Change History Version Date Author
 * Reason <Ver.No> <date> <who modify> <reason>
 */
package cn.wuxia.project.admin.view.payment.web;

import cn.wuxia.common.util.*;
import cn.wuxia.component.epay.EpayService;
import cn.wuxia.component.epay.alipay.config.AlipayConfig;
import cn.wuxia.component.epay.alipay.f2fpay.ToAlipayQrTradePay;
import cn.wuxia.component.epay.alipay.factory.AlipayAPIClientFactory;
import cn.wuxia.component.epay.alipay.util.AlipayNotify2;
import cn.wuxia.component.epay.alipay.util.AlipaySubmit2;
import cn.wuxia.component.epay.bean.EpayBean;
import cn.wuxia.component.epay.enums.EpayPlatform;
import cn.wuxia.component.epay.trade.enums.PaymentTradeStatusEnum;
import cn.wuxia.component.epay.trade.enums.PaymentTradeTypeEnum;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.common.support.CacheSupport;
import cn.wuxia.project.security.common.MyUserDetails;
import cn.wuxia.project.security.common.SpringSecurityUtils;
import com.alipay.api.AlipayClient;
import com.alipay.api.domain.AlipayTradePayModel;
import com.alipay.api.request.AlipayTradeWapPayRequest;
import com.alipay.api.response.AlipayTradePrecreateResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * 支付宝支付
 *
 * @author songlin
 * @ Version : V<Ver.No> <2017年5月10日>
 */
@RequestMapping(value = "/alipay/*")
@Controller
public class AlipayController extends BaseController {
    protected final Logger logger = LoggerFactory.getLogger("epay");

    @Autowired
    private EpayService paymentService;

    /**
     * 当面付，生成二维码
     *
     * @param model
     * @param orderNo
     * @param amount
     * @param body
     * @param response
     * @param paymentType
     * @param remark
     * @return
     * @throws Exception
     * @author songlin.li
     */
    public String buildPay(Model model, String type, @RequestParam(required = true) String amount, @RequestParam(required = true) String callbackUrl,
                           @RequestParam(required = true) String paymentType, String remark, String orderNo, Boolean needReceipt) throws Exception { // 第二次签名参数

        logger.info("订单号：" + orderNo);

        String serialNumber = NoGenerateUtil.generateNo(22);
        String notifyUrl = getServerHttpPath() + "/alipay/trade/" + (StringUtil.isBlank(orderNo) ? serialNumber : orderNo);
        //  
        String extra = "{\"paymentType\":\"" + paymentType + "\",\"userId\":\"" + ((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid() + "\"}";
        extra = EncodeUtils.base64UrlSafeEncode(extra.getBytes());
        AlipayTradePrecreateResponse resp = ToAlipayQrTradePay.qrPay(serialNumber, amount, remark, notifyUrl, extra);
        if (null != resp && resp.isSuccess()) {
            /**
             * 支付前保存交易
             */
            EpayBean epayBean = new EpayBean();
            epayBean.setAmount(new BigDecimal(amount));
            epayBean.setSerialNumber(serialNumber);
            epayBean.setUserId(((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid());
            epayBean.setStatus(PaymentTradeStatusEnum.DAIFUKUAN);
            epayBean.setType(PaymentTradeTypeEnum.valueOf(paymentType));
            epayBean.setPaymentPlatform(EpayPlatform.ALIPAY);
            epayBean.setRemark("【" + EpayPlatform.ALIPAY.getPlatformName() + "】" + remark);
            epayBean.setSuccessTrade(true);
            paymentService.beforePayment(epayBean);
            model.addAttribute("alipayResponse", resp);
            return "payment/alipay";
        } else {
            return "";
        }
    }

    /**
     * 支付
     *
     * @param model
     * @param orderNo
     * @param amount
     * @param body
     * @param response
     * @param paymentType
     * @param remark
     * @return
     * @throws Exception
     * @author songlin.li
     */
    public String buildPay2(Model m, String type, @RequestParam(required = true) String amount, @RequestParam(required = true) String callbackUrl,
                            @RequestParam(required = true) String paymentType, String remark, String orderNo, Boolean needReceipt) throws Exception { // 第二次签名参数

        logger.info("订单号：" + orderNo);

        String serialNumber = NoGenerateUtil.generateNo(22);
        String notifyUrl = getServerHttpPath() + "/alipay/trade/" + (StringUtil.isBlank(orderNo) ? serialNumber : orderNo);
        // 商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = serialNumber;
        // 订单名称，必填
        String subject = remark;
        System.out.println(subject);
        // 付款金额，必填
        String total_amount = amount;
        // 商品描述，可空
        String body = "【" + EpayPlatform.ALIPAY.getPlatformName() + "】" + remark;
        // 超时时间 可空
        String timeout_express = "2m";
        // 销售产品码 必填
        String product_code = "QUICK_WAP_PAY";
        /**********************/
        // SDK 公共请求类，包含公共请求参数，以及封装了签名与验签，开发者无需关注签名与验签     
        AlipayClient alipayClient = AlipayAPIClientFactory.getAlipayClient();
        AlipayTradeWapPayRequest alipay_request = new AlipayTradeWapPayRequest();

        // 封装请求支付信息
        AlipayTradePayModel model = new AlipayTradePayModel();
        model.setOutTradeNo(out_trade_no);
        model.setSubject(subject);
        model.setTotalAmount(total_amount);
        model.setBody(body);
        model.setTimeoutExpress(timeout_express);
        model.setProductCode(product_code);
        alipay_request.setBizModel(model);
        // 设置异步通知地址
        alipay_request.setNotifyUrl(notifyUrl);
        // 设置同步地址
        alipay_request.setReturnUrl(callbackUrl);
        // 调用SDK生成表单
        String form = alipayClient.pageExecute(alipay_request).getBody();

        /**
         * 支付前保存交易
         */
        EpayBean epayBean = new EpayBean();
        epayBean.setAmount(new BigDecimal(amount));
        epayBean.setSerialNumber(serialNumber);
        epayBean.setUserId(((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid());
        epayBean.setStatus(PaymentTradeStatusEnum.DAIFUKUAN);
        epayBean.setType(PaymentTradeTypeEnum.valueOf(paymentType));
        epayBean.setPaymentPlatform(EpayPlatform.ALIPAY);
        epayBean.setRemark("【" + EpayPlatform.ALIPAY.getPlatformName() + "】" + remark);
        epayBean.setSuccessTrade(true);
        paymentService.beforePayment(epayBean);
        m.addAttribute("alipayResponse", form);
        return "payment/alipay";

    }

    /**
     * PC收银台支付
     *
     * @param model
     * @param orderNo
     * @param amount
     * @param body
     * @param response
     * @param paymentType
     * @param remark
     * @return
     * @throws Exception
     * @author songlin.li
     */
    public String buildPay3(Model m, String type, @RequestParam(required = true) String amount, @RequestParam(required = true) String callbackUrl,
                            @RequestParam(required = true) String paymentType, @RequestParam(required = true) String orderNo, String remark, Boolean needReceipt)
            throws Exception {

        logger.info("订单号：" + orderNo);

        String serialNumber = NoGenerateUtil.generateNo(22);
        String notifyUrl = getServerHttpPath() + "/alipay/trade/" + serialNumber;
        ////////////////////////////////////请求参数//////////////////////////////////////

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = orderNo;

        //订单名称，必填
        String subject = remark;

        DecimalFormat df = new DecimalFormat("##0.00");
        //付款金额，必填
        String total_fee = df.format(NumberUtil.toDouble(amount));

        //商品描述，可空
        String body = "";

        //////////////////////////////////////////////////////////////////////////////////

        //把请求参数打包成数组
        Map<String, String> sParaTemp = new HashMap<String, String>();
        sParaTemp.put("service", AlipayConfig.service);
        sParaTemp.put("partner", AlipayConfig.partner);
        sParaTemp.put("seller_id", AlipayConfig.seller_id);
        sParaTemp.put("_input_charset", AlipayConfig.CHARSET);
        sParaTemp.put("payment_type", AlipayConfig.payment_type);
        sParaTemp.put("notify_url", notifyUrl);
        sParaTemp.put("return_url", callbackUrl);
        sParaTemp.put("anti_phishing_key", AlipayConfig.anti_phishing_key);
        sParaTemp.put("exter_invoke_ip", AlipayConfig.exter_invoke_ip);
        sParaTemp.put("out_trade_no", out_trade_no);
        sParaTemp.put("subject", subject);
        sParaTemp.put("total_fee", total_fee);
        sParaTemp.put("body", body);
        String extra = "{\"paymentType\":\"" + paymentType + "\",\"userId\":\"" + ((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid() + "\"}";
        extra = EncodeUtils.base64UrlSafeEncode(extra.getBytes());
        if (extra.length() > 100) {
            throw new Exception("长度不能超过100");
        }
        sParaTemp.put("extra_common_param", extra);
        //其他业务参数根据在线开发文档，添加参数.文档地址:https://doc.open.alipay.com/doc2/detail.htm?spm=a219a.7629140.0.0.O9yorI&treeId=62&articleId=103740&docType=1
        //如sParaTemp.put("参数名","参数值");

        //建立请求
        String sHtmlText = AlipaySubmit2.buildRequest(sParaTemp, "get", "确认");

        /**
         * 支付前保存交易
         */
        EpayBean epayBean = new EpayBean();
        epayBean.setAmount(new BigDecimal(amount));
        epayBean.setSerialNumber(serialNumber);
        epayBean.setOrderNo(orderNo);
        epayBean.setUserId(((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid());
        epayBean.setStatus(PaymentTradeStatusEnum.DAIFUKUAN);
        epayBean.setType(PaymentTradeTypeEnum.valueOf(paymentType));
        epayBean.setPaymentPlatform(EpayPlatform.ALIPAY);
        epayBean.setRemark("【" + EpayPlatform.ALIPAY.getPlatformName() + "】" + remark);
        epayBean.setSuccessTrade(true);
        paymentService.beforePayment(epayBean);
        m.addAttribute("alipayResponse", sHtmlText);
        return "payment/alipay";

    }

    /**
     * 支付成功后跳转的页面
     * <pre>
     * {buyer_email=237550195@qq.com, notify_time=2017-04-08 15:47:08,
     * seller_email=pay@ueq.com, exterface=create_direct_pay_by_user, subject=充值支付,
     * sign=AcsjORWnNffaII8i/Oo9DSh4YNUZ1t5hlNfsKZNVjv5cnzQh3nvba8wSGxuPypnxnPJBPTsJAMRHeHtSn7SQ8HJEJOctf58IOWMw0qStQ85LwvzxOj1GmD16RXeRosl2YMtVmIbwFsBpqquCjloQ0RyBgSVYSQWJ6awznoUVKl4=,
     * buyer_id=2088502528532248, is_success=T,
     * notify_id=RqPnCoPT3K9%2Fvwbh3InYyPo8sRIsXxcEXMNEzy7E5XecOC6r%2FVKsWLCL4B8lRaazzmxM,
     * notify_type=trade_status_sync, payment_type=1, out_trade_no=1704081545501029678154, total_fee=0.01,
     * trade_status=TRADE_SUCCESS, trade_no=2017040821001004240262509292, sign_type=RSA, seller_id=2088121768313109}
     * </pre>
     *
     * @param request
     * @return
     * @author wuwenhao
     */
    @RequestMapping(value = "trade/{serialNumber}")
    @ResponseBody
    public String trade(HttpServletRequest request, @PathVariable String serialNumber) {
        Object isExists = CacheSupport.get(this.getClass().getName() + serialNumber);
        if (isExists != null) {
            logger.info("serialNumber:{}已成功接收，忽略！", serialNumber);
            return "fail";
        }
        try {

            Map<String, String> map = ServletUtils.getParametersStartingWith2(request, "");
            logger.info("{}", map);
            if (!StringUtil.equalsIgnoreCase("TRADE_SUCCESS", (String) map.get("trade_status"))) {
                return "fail";
            }
            boolean verfiyresult = AlipayNotify2.verify(map);
            if (!verfiyresult) {
                logger.info("签名不对！");
                return "fail";
            }
            // 更新支付状态
            EpayBean epayBean = new EpayBean();
            epayBean.setAmount(new BigDecimal(map.get("total_fee") + ""));
            epayBean.setSerialNumber(serialNumber);
            epayBean.setPaymentNumber((String) map.get("trade_no"));
            String attach = (String) map.get("extra_common_param");
            attach = new String(EncodeUtils.base64Decode(attach));
            Map<String, Object> att = JsonUtil.fromJson(attach);
            epayBean.setUserId("" + att.get("userId"));
            epayBean.setStatus(PaymentTradeStatusEnum.CHENGGONG);
            epayBean.setType(PaymentTradeTypeEnum.valueOf("" + att.get("paymentType")));
            epayBean.setPaymentPlatform(EpayPlatform.ALIPAY);
            epayBean.setOrderNo((String) map.get("out_trade_no"));
            epayBean.setSuccessTrade(true);
            epayBean.setTransDate(DateUtil.newInstanceDate());
            paymentService.afterPayment(epayBean);
            logger.info("finish.........");

        } catch (Exception e) {
            logger.error("", e);
        }
        return "success";
    }

}
