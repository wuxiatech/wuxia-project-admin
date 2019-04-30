package cn.wuxia.project.admin.view.payment.web;

import cn.wuxia.common.orm.query.Conditions;
import cn.wuxia.common.orm.query.MatchType;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.orm.query.Sort;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.payment.core.service.FundsTradeDetailService;
import cn.wuxia.project.security.common.MyUserDetails;
import cn.wuxia.project.security.common.SpringSecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 订单交易明细表 Service Controller class.
 *
 * @author songlin.li
 * @since 2017-02-16
 */
@Controller
@RequestMapping("/funds/trade/**")
public class FundsTradeDetailController extends BaseController {

    @Autowired
    private FundsTradeDetailService fundsTradeDetailService;

    @RequestMapping("/list")
    public String tradeDetail(Model model, Pages page) {

        if (page.getPageSize() < 0) {
            page.setPageSize(20);
        }

        page.addCondition(new Conditions("userId", ((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid()));//依据具体情况修改
        page.addCondition(new Conditions("isObsoleteDate", MatchType.ISN));
        page.setSort(new Sort(new Sort.Order(Sort.Direction.DESC, "tradeTime"), new Sort.Order(Sort.Direction.DESC, "orderNo")));
        page = fundsTradeDetailService.findPages(page);
        model.addAttribute("pages", page);
        return "/funds/trade/tradeDetailList";
    }
}
