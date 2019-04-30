package cn.wuxia.project.admin.view;

import cn.wuxia.common.exception.AppWebException;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.util.StringUtil;
import cn.wuxia.project.basic.api.WsApiUtil;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.wechat.WeChatException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/weixin/**")
public class WechatApiController extends BaseController {

    /**
     * 同步图文
     *
     * @return
     */
    @RequestMapping(value = "/syncfromweixin", method = { RequestMethod.GET, RequestMethod.POST })
    @ResponseBody
    public Pages syncFromWeixin(Model model, Pages pages, boolean reconver, String mediaid) throws WeChatException {
//        if (StringUtil.isNotBlank(mediaid)) {
//            List<Article> articles = MaterialMediaUtil.getNews(WxAccountUtil.getByAppid(getWxAppid()), mediaid);
//            wxNewsService.saveByMaterial(getWxAppid(), getCurrentUserDetail().getUid(), mediaid, articles);
//
//            Map param = Maps.newHashMap();
//            param.put("mediaid", mediaid);
//            try {
//                /**
//                 * FIXME 参数hardcode
//                 */
//                WsApiUtil.createDefault().key(getWxAppid())
//                        .gateway(StringUtil.replace(WsApiUtil.createDefault().apiGateway, "handler", "wechat/article"))
//                        .post2Gateway(param, "synconefromweixin");
//            } catch (Exception e) {
//                throw new AppWebException(e.getMessage());
//            }
//        } else {
//            if (pages.getPageSize() < 0) {
//                pages.setPageSize(1);
//                pages.setTotalCount(2);
//
//                while (pages.isHasNext()) {
//
//                    try {
//                        List<MediaContent> mediaContents = MaterialMediaUtil.batchget(WxAccountUtil.getByAppid(getWxAppid()),
//                                MaterialMediaTypeEnum.news, pages);
//
//                        if (ListUtil.isNotEmpty(mediaContents)) {
//                            for (MediaContent mediaContent : mediaContents) {
//                                wxNewsService.saveByMaterial(getWxAppid(), getCurrentUserDetail().getUid(), mediaContent.getMedia_id(),
//                                        mediaContent.getContent());
//                            }
//                        }
//                        pages.setPageNo(pages.getNextPage());
//
//                    } catch (WeChatException e) {
//                        continue;
//                        //                throw new AppWebException("同步图文出错", e);
//                    }
//                }
//                try {
//                    Thread.sleep(1000);
//                } catch (InterruptedException e) {
//                    e.printStackTrace();
//                }
//
//            } else {
//                try {
//                    List<MediaContent> mediaContents = MaterialMediaUtil.batchget(WxAccountUtil.getByAppid(getWxAppid()), MaterialMediaTypeEnum.news,
//                            pages);
//
//                    if (ListUtil.isNotEmpty(mediaContents)) {
//                        for (MediaContent mediaContent : mediaContents) {
//                            wxNewsService.saveByMaterial(getWxAppid(), getCurrentUserDetail().getUid(), mediaContent.getMedia_id(),
//                                    mediaContent.getContent());
//                        }
//                    }
//                    pages.setPageNo(pages.getNextPage());
//
//                } catch (WeChatException e) {
//                    throw new AppWebException("同步图文出错", e);
//                }
//            }
            try {
                /**
                 * FIXME 参数hardcode
                 */
                WsApiUtil.createDefault().key(getWxAppid())
                        .gateway(StringUtil.replace(WsApiUtil.createDefault().apiGateway, "handler", "wechat/article"))
                        .post2Gateway(pages, "syncfromweixin");
            } catch (Exception e) {
                throw new AppWebException(e.getMessage());
            }

//        }
        return pages;
    }
}
