/*
 * Created on :29 May, 2014 Author :songlin Change History Version Date Author
 * Reason <Ver.No> <date> <who modify> <reason>
 */
package cn.wuxia.project.admin.view.payment.web;

import cn.wuxia.common.util.*;
import cn.wuxia.common.web.httpclient.HttpClientException;
import cn.wuxia.common.web.httpclient.HttpClientUtil;
import cn.wuxia.common.xml.Dom4jXmlUtil;
import cn.wuxia.component.epay.EpayService;
import cn.wuxia.component.epay.bean.EpayBean;
import cn.wuxia.component.epay.enums.EpayPlatform;
import cn.wuxia.component.epay.trade.enums.PaymentTradeStatusEnum;
import cn.wuxia.component.epay.trade.enums.PaymentTradeTypeEnum;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.common.support.CacheConstants;
import cn.wuxia.project.common.support.CacheSupport;
import cn.wuxia.project.security.common.MyUserDetails;
import cn.wuxia.project.security.common.SpringSecurityUtils;
import cn.wuxia.project.weixin.WxUserContext;
import cn.wuxia.project.weixin.WxUserContextUtil;
import cn.wuxia.project.weixin.api.WxAccountUtil;
import cn.wuxia.wechat.pay.util.PaySignUtil;
import cn.wuxia.wechat.pay.util.PayUtil;
import com.google.common.collect.Maps;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

/**
 * 微信支付处理
 *
 * @author songlin
 * @ Version : V<Ver.No> <2017年5月10日>
 */
@RequestMapping(value = "/wxpay/*")
@Controller
public class WxpayController extends BaseController {

    @Autowired
    private EpayService paymentService;

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
     * @author songlin
     */
    public String buildMobilePay(Model model, String type, @RequestParam(required = true) String amount,
                                 @RequestParam(required = true) String callbackUrl, @RequestParam(required = true) String paymentType,
                                 @RequestParam(required = true) String orderNo, String remark, Boolean needReceipt) throws Exception { // 第二次签名参数
        logger.info("订单号：" + orderNo);
        WxUserContext wxUserContext = WxUserContextUtil.getUserContext();
        String seriaNumber = NoGenerateUtil.generateNo(16);
        //金额转化为分为单位
        SortedMap<String, Object> signParams = new TreeMap<String, Object>();
        String notifyUrl = getServerHttpPath() + "/wxpay/trade/" + seriaNumber;
        String extra = "{\"paymentType\":\"" + paymentType + "\",\"userId\":\"" + getCurrentUser().getId() + "\"" + ", \"userName\":\""
                + wxUserContext.getName() + "\",\"callbackUrl\":\"" + callbackUrl + "\"}";
        extra = EncodeUtils.base64UrlSafeEncode(extra.getBytes());
        /**
         * 由于长度限制了127个长度，故考虑使用存放key到缓存，通过key拿到真是数据
         */
        String key = "WXPAYMENTATTA" + orderNo;
        CacheSupport.getCache(CacheConstants.CACHED_VALUE_30_MINUTES).put(key, extra);
        signParams = PayUtil.buildPayment(WxAccountUtil.getPayAccount(getWxAppid()), orderNo, remark, amount, SystemUtil.getOSIpAddr(),
                wxUserContext.getOpenid(), notifyUrl, key);
        if (null != signParams && !signParams.isEmpty()) {
            /**
             * 支付前保存交易
             */
            EpayBean epayBean = new EpayBean();
            epayBean.setAmount(new BigDecimal(amount));
            epayBean.setSerialNumber(seriaNumber);
            epayBean.setOrderNo(orderNo);
            epayBean.setUserId(getCurrentUser().getId());
            epayBean.setStatus(PaymentTradeStatusEnum.DAIFUKUAN);
            epayBean.setType(PaymentTradeTypeEnum.valueOf(paymentType));
            epayBean.setPaymentPlatform(EpayPlatform.WECHATPAY);
            epayBean.setRemark("【" + EpayPlatform.WECHATPAY.getPlatformName() + "】" + remark);
            epayBean.setSuccessTrade(true);
            paymentService.beforePayment(epayBean);
            model.addAttribute("wxpayResponse", signParams);
            return "payment/wxjspay";
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
     * @author songlin
     */
    public String buildPay(Model model, String type, @RequestParam(required = true) String amount, @RequestParam(required = true) String callbackUrl,
                           @RequestParam(required = true) String paymentType, @RequestParam(required = true) String orderNo, String remark, Boolean needReceipt)
            throws Exception { // 第二次签名参数
        logger.info("订单号：" + orderNo);
        String seriaNumber = NoGenerateUtil.generateNo(16);
        //金额转化为分为单位
        String notifyUrl = getServerHttpPath() + "/wxpay/trade/" + seriaNumber;
        String extra = "{\"paymentType\":\"" + paymentType + "\",\"userId\":\"" + ((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid() + "\"" + ", \"userName\":\""
                + ((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getDisplayName() + "\",\"callbackUrl\":\"" + callbackUrl + "\"}";
        extra = EncodeUtils.base64UrlSafeEncode(extra.getBytes());
        /**
         * 由于长度限制了127个长度，故考虑使用存放key到缓存，通过key拿到真是数据
         */
        String key = "WXPAYMENTATTA" + orderNo;
        CacheSupport.getCache(CacheConstants.CACHED_VALUE_30_MINUTES).put(key, extra);
        String codeUrl = PayUtil.buildNativePayment(WxAccountUtil.getPayAccount(getWxAppid()), orderNo, remark, amount, SystemUtil.getOSIpAddr(),
                notifyUrl, key);

        /**
         * 支付前保存交易
         */
        EpayBean epayBean = new EpayBean();
        epayBean.setAmount(new BigDecimal(amount));
        epayBean.setSerialNumber(seriaNumber);
        epayBean.setOrderNo(orderNo);
        epayBean.setUserId(((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid());
        epayBean.setStatus(PaymentTradeStatusEnum.DAIFUKUAN);
        epayBean.setType(PaymentTradeTypeEnum.valueOf(paymentType));
        epayBean.setPaymentPlatform(EpayPlatform.WECHATPAY);
        epayBean.setRemark("【" + EpayPlatform.WECHATPAY.getPlatformName() + "】" + remark);
        epayBean.setSuccessTrade(true);
        paymentService.beforePayment(epayBean);
        model.addAttribute("wxpayResponse", codeUrl);
        return "payment/wxpay";

    }

    /**
     * 支付成功后跳转的页面
     *
     * @param request
     * @return
     * @author wuwenhao
     */
    @RequestMapping(value = "trade/{seriaNumber}")
    @ResponseBody
    public String trade(HttpServletRequest request, @PathVariable String seriaNumber) {
        Object isExists = CacheSupport.get(this.getClass().getName() + seriaNumber);
        if (isExists != null) {
            logger.info("seriaNumber:{}已成功接收，忽略！", seriaNumber);
            return "";
        }
        SortedMap<String, Object> returnMap = Maps.newTreeMap();
        ServletInputStream in;
        try {
            in = request.getInputStream();
            String xml = IOUtils.toString(in);
            logger.debug(xml);
            Map<String, Object> map = Dom4jXmlUtil.xml2map(xml, false);
            if (!StringUtil.equalsIgnoreCase("SUCCESS", MapUtil.getString(map, "return_code"))) {
                throw new Exception(MapUtil.getString(map, "return_msg"));
            }
            SortedMap<String, Object> signParams = new TreeMap<String, Object>(map);
            String mysign = PaySignUtil.createSign(WxAccountUtil.getPayAccount(getWxAppid()), signParams);
            String sign = MapUtil.getString(map, "sign");
            logger.info("mysign:{}, fromsign:{}", mysign, sign);
            if (!StringUtil.equals(mysign, sign)) {
                throw new Exception("签名不一致");
            }

            // 更新支付状态
            EpayBean epayBean = new EpayBean();
            epayBean.setAmount(new BigDecimal(MapUtil.getInteger(map, "total_fee")).divide(new BigDecimal(100)));
            epayBean.setSerialNumber(seriaNumber);
            epayBean.setPaymentNumber(MapUtil.getString(map, "transaction_id"));
            String attach = MapUtil.getString(map, "attach");
            /**
             * 由于长度限制了127个长度，故考虑使用存放key到缓存，通过key拿到真是数据
             */
            Cache.ValueWrapper keyvalue = CacheSupport.getCache(CacheConstants.CACHED_VALUE_30_MINUTES).get(attach);
            attach = new String(EncodeUtils.base64Decode((String) keyvalue.get()));
            logger.info("attach: {}", attach);
            Map<String, Object> att = JsonUtil.fromJson(attach);
            epayBean.setUserId("" + att.get("userId"));
            epayBean.setType(PaymentTradeTypeEnum.valueOf("" + att.get("paymentType")));
            epayBean.setPaymentPlatform(EpayPlatform.WECHATPAY);
            epayBean.setOrderNo(MapUtil.getString(map, "out_trade_no"));
            epayBean.setSuccessTrade(true);
            epayBean.setTransDate(DateUtil.newInstanceDate());
            paymentService.afterPayment(epayBean);
            logger.info("finish.........");
            String callbackUrl = MapUtil.getString(att, "callbackUrl");
            /**
             * TODO
             */
            if (StringUtil.isNotBlank(callbackUrl)) {
                try {
                    HttpClientUtil.postJson(callbackUrl, attach);
                } catch (HttpClientException e) {
                    logger.warn("支付调用{}有误！", callbackUrl);
                }
            }
            returnMap.put("return_code", "SUCCESS");
            returnMap.put("return_msg", "OK");
            CacheSupport.set(this.getClass().getName() + seriaNumber, true);
        } catch (Exception e) {
            logger.error("", e);
            returnMap.put("return_code", "FAIL");
            returnMap.put("return_msg", e.getMessage());
        }
        return PayUtil.parseXML(returnMap);
    }

}
