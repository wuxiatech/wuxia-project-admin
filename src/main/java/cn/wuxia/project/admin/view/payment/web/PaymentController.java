/*
 * Created on :29 May, 2014 Author :songlin Change History Version Date Author
 * Reason <Ver.No> <date> <who modify> <reason>
 */
package cn.wuxia.project.admin.view.payment.web;

import cn.wuxia.common.exception.AppWebException;
import cn.wuxia.common.util.NoGenerateUtil;
import cn.wuxia.common.util.NumberUtil;
import cn.wuxia.common.util.QRCodeUtil;
import cn.wuxia.common.util.StringUtil;
import cn.wuxia.component.epay.EpayException;
import cn.wuxia.component.epay.EpayService;
import cn.wuxia.component.epay.bean.EpayRefundBean;
import cn.wuxia.component.epay.enums.EpayPlatform;
import cn.wuxia.component.epay.trade.enums.PaymentTradeTypeEnum;
import cn.wuxia.project.basic.core.conf.entity.Currency;
import cn.wuxia.project.basic.core.conf.service.CurrencyService;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.payment.core.service.FundsDetailService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;


/**
 * 支付中心集中处理
 * @author songlin
 * @ Version : V<Ver.No> <2017年5月10日>
 */
@RequestMapping(value = "/payment/*")
@Controller
public class PaymentController extends BaseController {

    @Autowired
    private EpayService paymentService;

    @Autowired
    private WxpayController wxpay;

    @Autowired
    private AlipayController alipay;

    @Autowired
    private FundsDetailService fundsDetailService;

    @Autowired
    private CurrencyService currencyService;

    /**
     * 支付前生成支付平台相应的请求
     * @author songlin
     * @param model
     * @param platform
     * @param amount
     * @param callbackUrl
     * @param paymentType
     * @param orderNo
     * @param remark
     * @param needReceipt
     * @return
     * @throws Exception
     */
    @RequestMapping("/submit")
    public String buildPay(Model model, EpayPlatform platform, @RequestParam(required = true) String amount,
                           @RequestParam(required = true) String callbackUrl, @RequestParam(required = true) String paymentType, String orderNo, String remark,
                           Boolean needReceipt) throws Exception {
        if (platform == null)
            throw new AppWebException("支付类型为空");

        orderNo = StringUtil.isBlank(orderNo) ? NoGenerateUtil.generateNo(22) : orderNo;
        String jsp = "";
        switch (platform) {
            case WECHATPAY:
                jsp = wxpay.buildPay(model, "", amount, callbackUrl, paymentType, orderNo, remark, needReceipt);
                break;
            case ALIPAY:
                jsp = alipay.buildPay3(model, "", amount, callbackUrl, paymentType, orderNo, remark, needReceipt);
                break;
            default:
                break;
        }
        return jsp;
    }

    /**
     * 公共跳转支付平台
     * @author wuwenhao songlin
     * @param model
     * @param paymentType
     * @param amount
     * @param orderNo
     * @param returnurl
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "pay")
    public String buildRequest(Model model, String paymentType, String amount, String orderNo, String returnurl) throws Exception {
        if (StringUtil.equalsIgnoreCase(PaymentTradeTypeEnum.CHONGZHI.name(), paymentType)) {
            Currency currencydto = currencyService.getByCurrencyCode("RMB");
            model.addAttribute("currencydto", currencydto);
            model.addAttribute("truecharge", (currencydto.getExchangeRateToRmb() * NumberUtil.toDouble(amount)));
            model.addAttribute("orderCharge", amount);
            model.addAttribute("paymentType", paymentType);
            if (!StringUtil.startsWith(returnurl, "http") && StringUtil.startsWith(returnurl, "/")) {
                returnurl = getServerHttpPath() + returnurl;
            }

            model.addAttribute("orderNo", NoGenerateUtil.generateNo("PAYMENT", 22));
            model.addAttribute("returnUrl", returnurl);
            model.addAttribute("remark", "快递费");
            //            }
            return "/payment/otherFinish";
        } else if (StringUtil.isNotBlank(orderNo)) {

            //            model.addAttribute("orderId", salesOrder.getId());
            //            //将培训页面跳转至默认订单详情页面
            //            if (StringUtil.indexOf(getRequestServerName(), "/px") != -1) {
            //                model.addAttribute("detailUrl", getRequestServerName() + "/sales/" + salesOrder.getOrderNo() + ".html");
            //            } else {
            //                model.addAttribute("detailUrl", "/sales/" + salesOrder.getOrderNo() + ".html");
            //            }
            //            model.addAttribute("orderNo", salesOrder.getOrderNo());
            //            model.addAttribute("orderCharge", salesOrder.getAllCharge());
            return "/payment/finish";
        } else {
            throw new Exception("参数格式不对");
        }

    }

    @RequestMapping(value = "qrcode")
    public @ResponseBody void payqrcode(String content, HttpServletResponse response) throws Exception {
        OutputStream output = response.getOutputStream();
        QRCodeUtil.encode(content, output);
        IOUtils.closeQuietly(output);
    }

    @ResponseBody
    public boolean refund(String paymentTradeNo, String amount, String remark) {
        EpayRefundBean refundBean = new EpayRefundBean();
        refundBean.setClientIp(getVisitorIp());
        refundBean.setSerialNumber(paymentTradeNo);
        refundBean.setRefundAmount(amount);
        refundBean.setUserId("");
        refundBean.setRemark(remark);
        try {
            return paymentService.refund(refundBean);
        } catch (EpayException e) {
            throw new AppWebException("退款有误！", e);
        }
    }

}
