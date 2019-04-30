/**
 *
 */
package cn.wuxia.project.admin.view.config;

import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import cn.wuxia.common.util.ClassLoaderUtil;
import cn.wuxia.common.util.PropertiesUtils;
import cn.wuxia.project.ad.core.service.AddressBase2015Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.common.collect.Lists;

import cn.wuxia.project.basic.core.conf.bean.MenuBean;
import cn.wuxia.project.basic.core.conf.bean.SitemapHTMLBean;
import cn.wuxia.project.basic.core.conf.entity.GenerateStaticPage;
import cn.wuxia.project.basic.core.conf.service.CustomMenuGroupService;
import cn.wuxia.project.basic.core.conf.service.GenerateStaticPageService;
import cn.wuxia.project.basic.core.conf.service.impl.SitemapServiceImpl;
import cn.wuxia.common.cached.memcached.MemcachedUtils;
import cn.wuxia.common.cached.memcached.XMemcachedClient;
import cn.wuxia.common.spring.SpringContextHolder;
import cn.wuxia.common.spring.support.Msg;
import cn.wuxia.common.util.ServletUtils;
import cn.wuxia.common.util.StringUtil;

/**
 * [ticket id] 内部使用
 *
 * @author songlin.li @ Version : V<Ver.No> <2013年8月28日>
 */
@Controller
@RequestMapping("system")
public class InternalSystemController {
    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private GenerateStaticPageService generateStaticPageService;

    @Autowired
    private AddressBase2015Service addressBaseService;

    @Autowired
    private CustomMenuGroupService menuGroupService;

    /**
     * dync to static
     *
     * @param sourceUrl
     * @param toDistLocation
     * @author songlin.li
     */
    @RequestMapping(value = "/build")
    public String buildStaticPage(HttpServletRequest request) throws Exception {
        Map<String, Object> m = ServletUtils.getParametersMap(request);
        for (Map.Entry<String, Object> s : m.entrySet()) {
            request.setAttribute(s.getKey(), s.getValue());
        }
        return "/system/build";
    }

    @RequestMapping(value = "/generate")
    public String generateStaticPage(HttpServletRequest request) throws Exception {
        Map<String, Object> sPara = ServletUtils.getParametersMap(request);
        String sourceUrl = (String) sPara.get("sourceUrl");
        request.setAttribute("sourceUrl", sourceUrl);
        String toDistLocation = (String) sPara.get("toDistLocation");
        request.setAttribute("toDistLocation", toDistLocation);
        String fileName = (String) sPara.get("fileName");
        request.setAttribute("fileName", fileName);
        String charset = (String) sPara.get("charset");
        request.setAttribute("charset", charset);
        if (StringUtil.isBlank(sourceUrl)) {
            Msg.error("sourceUrl不能为空");
            return "forward:build";
        }

        if (StringUtil.isBlank(toDistLocation)) {
            Msg.error("toDistLocation不能为空");
            return "forward:build";
        }
        //        sPara.remove("sourceUrl");
        //        sPara.remove("toDistLocation");
        //        sPara.remove("fileName");
        String path = "";
        ServletContext sc = request.getServletContext();
        if (sc != null) {
            path = sc.getRealPath("/");
        } else {
            path = ClassLoaderUtil.getAbsolutePathOfClassLoaderClassPath();
            path = StringUtil.replace(path, "file:", "").replace("/WEB-INF/classes/", "");
        }
        String savePath = path + toDistLocation;
        GenerateStaticPage staticPage = new GenerateStaticPage(sourceUrl, savePath, fileName);
        staticPage.setCharset(charset);
        if (StringUtil.isNotBlank(sPara.get("parameter"))) {
            staticPage.setParameter(sPara.get("parameter").toString());
            request.setAttribute("parameter", sPara.get("parameter").toString());
        }
        generateStaticPageService.generateOnePage(staticPage);
        Msg.success("生成成功");
        request.setAttribute(Msg.SUCCESSMESSAGESKEY, Msg.getMessages());
        return "forward:build";
    }

    @RequestMapping(value = "/address")
    public String generateStaticAddress(Model model) throws Exception {
        addressBaseService.findAllProvince();
        addressBaseService.getAllCityMap();
        return "/config/createAddress";
    }

    @RequestMapping(value = "/cleanMemcached")
    public String cleanMemcached(@RequestParam(required = false) String memkey) throws Exception {

        XMemcachedClient xMemcachedClient = SpringContextHolder.getBean("xMemcachedClient");
        if (xMemcachedClient == null) {
            Msg.warn("得不到xMemcachedClient缓存实例");
        } else {
            if (StringUtil.isBlank(memkey))
                xMemcachedClient.flushAll();
            else {
                xMemcachedClient.delete(memkey);
                xMemcachedClient.delete(MemcachedUtils.shaKey(memkey));
            }
            Msg.success("清除成功");
        }
        return "redirect:./build";
    }

    @Autowired
    private SitemapServiceImpl sitemapService;

    @RequestMapping(value = "/gen/sitemap", method = {RequestMethod.GET, RequestMethod.POST})
    public String createXml(Model model) {
        try {
            sitemapService.genSitemapXml("");
            // sitemapService.genSitemapHtml("");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/system/build";
    }

    @RequestMapping(value = "/gen/sitemap/html", method = {RequestMethod.GET, RequestMethod.POST})
    public String createHtml(Model model, String path) {
        try {
            List<SitemapHTMLBean> sitemapList;
            switch (path) {
                case "article":
                    break;
                default:
                    sitemapList = Lists.newArrayList();
                    break;
            }
            // model.addAttribute("sitemapList", sitemapList);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/config/sitemap";
    }

    @RequestMapping(value = "menubuild", method = RequestMethod.GET)
    public String build(Model model) {
        Properties properties = PropertiesUtils.loadProperties("classpath:security.properties", "classpath:properties/security.properties");
        String systemType = (String) properties.get("system.type");
        List<MenuBean> list = menuGroupService.findByCode(systemType);
        model.addAttribute("menus", list);
        return "menu/build";
    }


}
