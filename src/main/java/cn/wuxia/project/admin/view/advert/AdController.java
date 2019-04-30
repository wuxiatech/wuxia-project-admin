/*
 * Created on :24 Jun, 2014
 * Author     :songlin
 * Change History
 * Version       Date         Author           Reason
 * <Ver.No>     <date>        <who modify>       <reason>
 * Copyright 2014-2020 www.ibmall.cn All right reserved.
 */
package cn.wuxia.project.admin.view.advert;

import cn.wuxia.common.exception.AppWebException;
import cn.wuxia.common.orm.query.Conditions;
import cn.wuxia.common.orm.query.MatchType;
import cn.wuxia.common.orm.query.Pages;
import cn.wuxia.common.orm.query.Sort;
import cn.wuxia.common.orm.query.Sort.Direction;
import cn.wuxia.common.spring.mvc.annotation.FormModel;
import cn.wuxia.common.util.StringUtil;
import cn.wuxia.common.util.reflection.BeanUtil;
import cn.wuxia.project.ad.core.entity.Ad;
import cn.wuxia.project.ad.core.entity.AdLocation;
import cn.wuxia.project.ad.core.service.AdLocationService;
import cn.wuxia.project.ad.core.service.AdService;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.security.common.MyUserDetails;
import cn.wuxia.project.security.common.SpringSecurityUtils;
import cn.wuxia.project.storage.core.service.UploadFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping(value = "/advert/*")
@Controller
public class AdController extends BaseController {

    @Autowired
    protected AdService adService;

    @Autowired
    protected AdLocationService adLocationService;

    @Autowired
    private UploadFileService uploadFileService;

    /**
     * 保存广告
     *
     * @param model
     * @param ad
     * @return
     * @author songlin
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(Model model, @FormModel("ad") Ad ad) {
        // 当新增的时候修改图片的url格式
        /*
         * if (StringUtil.isNotBlank(ad.getPic()) &&
         * StringUtil.startsWith(ad.getPic(), "/image/")) { String url =
         * StringUtil.replace(ad.getPic(), "/image/" +
         * UploadFileCategoryEnum.AD.getValue(), ""); String og =
         * StringUtil.substringBeforeLast(url, "/"); String filename =
         * StringUtil.substringAfterLast(url, "/"); String monthStr =
         * DateUtil.format(DateUtil.newInstanceDate(),
         * DateFormatter.FORMAT_YYYY_MM); url = InitializationFile.downloadUrl +
         * UploadFileCategoryEnum.AD.getValue() + File.separator + monthStr + og
         * + filename; ad.setPic(url); }
         */
        if (StringUtil.isNotBlank(ad.getPicFilesetId()))
            ad.setPicFilesetId(null);
        //		if (StringUtil.isNotBlank(ad.getPicFile()) && StringUtil.isBlank(ad.getPicFile().getId())) {
        //			ad.setPicFilesetId(null);
        //		}
        if (StringUtil.isBlank(ad.getUrl()) || StringUtil.equalsIgnoreCase(ad.getUrl(), "javascript:void('0');")) {
            ad.setUrl("javascript:void('0');");
            ad.setTarget(Ad.TargetEnum._self);
        }
        ad.setUserId(((MyUserDetails) SpringSecurityUtils.getCurrentUser()).getUid());
        adService.save(ad);
        if (ad.getLocation().getParentId() != null)
            return "redirect:/advert/list?locationid=" + ad.getLocation().getParentId();
        return "redirect:/advert/list?locationid=" + ad.getLocation().getId();
    }

    /**
     * 编辑广告
     *
     * @param model
     * @param id
     * @return
     * @author songlin
     */
    @RequestMapping(value = "edit", method = RequestMethod.GET)
    public String edit(Model model, String id, String locationId) {
        Ad ad = new Ad();
        AdLocation adl = null;
        // 编辑单个广告
        if (null != id) {
            ad = adService.findById(id);
            adl = ad.getLocation();
            if (ad != null) {
                /**
                 * FIXME
                 * 20160927注释
                 */
                //				List<UploadFileInfo> pics = uploadFileService
                //						.getUploadFileInfoListByUploadFileSetInfoId(ad.getPicFilesetId());
                //				model.addAttribute("pics", pics);
            }
        } else if (locationId != null) {
            // 定位到当前添加的广告位
            adl = adLocationService.findById(locationId);
        }
        // 如果从广告位过来，则进入新增广告
        if (adl != null) {
            // 将选中的广告位赋到广告中
            ad.setLocation(adl);
            // 如果当前广告位的级别为2（楼层级别）
            if (adl.getLevel() == 2) {
                // 找出同级别同父（页面）的广告位
                List<AdLocation> location1 = adLocationService.findAdLocationByParentId(adl.getParent().getId());
                model.addAttribute("location1", location1);
            }
            // 如果级别去到3（tab级别）
            else if (adl.getLevel() == 3) {
                // 找出父广告位
                List<AdLocation> location1 = adLocationService.findAdLocationByParentId(adl.getParent().getParent().getId());
                model.addAttribute("location1", location1);
                // 找出同级别同父（页面）的广告位
                List<AdLocation> location2 = adLocationService.findAdLocationByParentId(adl.getParent().getId());
                model.addAttribute("location2", location2);
            }
            // 如果 4 一下级别
            else if (adl.getLevel() == 4) {
                // 找出父广告位
                List<AdLocation> location1 = adLocationService.findAdLocationByParentId(adl.getParent().getParent().getParent().getId());
                model.addAttribute("location1", location1);
                // 找出同级别同父（页面）的广告位
                List<AdLocation> location2 = adLocationService.findAdLocationByParentId(adl.getParent().getParent().getId());
                model.addAttribute("location2", location2);
                // 找出同级别同父（页面）的广告位
                List<AdLocation> location3 = adLocationService.findAdLocationByParentId(adl.getParent().getId());
                model.addAttribute("location3", location3);
            }
            // FIXME 当前只支持 5 一下级别
            else if (adl.getLevel() == 5) {
                // 找出父广告位
                List<AdLocation> location1 = adLocationService.findAdLocationByParentId(adl.getParent().getParent().getParent().getParent().getId());
                model.addAttribute("location1", location1);
                // 找出父广告位
                List<AdLocation> location2 = adLocationService.findAdLocationByParentId(adl.getParent().getParent().getParent().getId());
                model.addAttribute("location2", location2);
                // 找出同级别同父（页面）的广告位
                List<AdLocation> location3 = adLocationService.findAdLocationByParentId(adl.getParent().getParent().getId());
                model.addAttribute("location3", location3);
                // 找出同级别同父（页面）的广告位
                List<AdLocation> location4 = adLocationService.findAdLocationByParentId(adl.getParent().getId());
                model.addAttribute("location4", location4);
            }
        }
        // 顶层的广告位
        List<AdLocation> page_location = adLocationService.findAdLocationByParentId(null);
        model.addAttribute("page_location", page_location);
        model.addAttribute("ad", ad);
        return "ad/edit";
    }

    /**
     * 广告列表
     *
     * @param model
     * @return
     * @author songlin
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String list(Model model, Pages<Ad> page, String locationid, String name) {
        if (page.getPageSize() < 0)
            page.setPageSize(20);

        if (locationid == null) {
            locationid = "1";
        }
        page.addCondition(new Conditions("location.id", locationid));

        page.setSort(new Sort(Direction.DESC, "level", "modifiedOn"));
        Pages<Ad> list = adService.findAll(page);
        model.addAttribute("page", list);
        return "ad/list";
    }

    /**
     * 删除广告
     *
     * @param model
     * @param id
     * @return
     * @author songlin
     */
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public String delete(Model model, String id) {
        adService.delete(id);
        //wxNewsAdRefService.deleteAdRef(id);
        return "redirect:/advert/list";
    }

    /**
     * 异步获取广告位
     *
     * @param model
     * @return
     * @author songlin
     */
    @RequestMapping(value = "location/get", method = RequestMethod.GET)
    @ResponseBody
    public List<AdLocation> getLocation(Model model, String parentId) {
        return adLocationService.findAdLocationByParentId(parentId);
    }

    /**
     * 保存设置广告的模版
     *
     * @param
     * @author songlin
     */
    @RequestMapping(value = "location/save", method = RequestMethod.POST)
    public String saveTemplate(AdLocation adl) {
        //adl.setTemplateContent(EncodeUtils.htmlUnescape(adl.getTemplateContent()));
        // 如果是修改内容
        if (adl.getId() != null) {
            AdLocation adloc = adLocationService.findById(adl.getId());

            // 如果修改加载方式或修改继承，则修改当前下的所有子的加载方式及继承
            if (adloc.getLoadType().compareTo(adl.getLoadType()) != 0 || adloc.getLevel() != adl.getLevel()) {
                adl.setLevel(adloc.getParent().getLevel() + 1);
                BeanUtil.copyPropertiesWithoutNullValues(adloc, adl);
                adl = adloc;
                adLocationService.saveAndFlushAllChild(adl);
            } else {
                adl.setLevel(adloc.getParent().getLevel() + 1);
                BeanUtil.copyPropertiesWithoutNullValues(adloc, adl);
                adl = adloc;
                adLocationService.save(adl);
            }
        } else {
            if (StringUtil.isNotBlank(adl.getParentId())) {
                AdLocation adp = adLocationService.findById(adl.getParentId());
                adl.setLevel(adp.getLevel() + 1);
            }
            adLocationService.save(adl);
        }
        if (StringUtil.isNotBlank(adl.getParentId()))
            return "redirect:/advert/location/list?parentId=" + adl.getParentId();
        return "redirect:/advert/location/list";
    }

    /**
     * 进入编辑模版的页面
     *
     * @param model
     * @param id
     * @return
     * @author songlin
     */
    @RequestMapping(value = "location/edit", method = RequestMethod.GET)
    public String editLocation(Model model, String id, String parentId) {
        if (id != null) {
            AdLocation adl = adLocationService.findById(id);
            model.addAttribute("adl", adl);
        }
        model.addAttribute("parentId", parentId);
        return "ad/locationEdit";
    }

    /**
     * 进入广告位的列表页
     *
     * @param model
     * @param page
     * @return
     * @author songlin
     */
    @RequestMapping(value = "location/list", method = RequestMethod.GET)
    public String listLocation(Model model, Pages<AdLocation> page, String parentId) {
        if (page.getPageSize() < 0)
            page.setPageSize(20);
        if (parentId == null) {
            parentId = "1";
        }
        page.addCondition(new Conditions("parent.id", parentId));
        List<AdLocation> page_location = adLocationService.findAdLocationByParentId(null);
        model.addAttribute("page_location", page_location);
        page.setSort(new Sort(Direction.ASC, "sortOrder"));
        adLocationService.findAllAdLocation(page);
        model.addAttribute("page", page);
        return "ad/locationList";
    }

    /**
     * 异步获取广告位
     *
     * @param model
     * @return
     * @author songlin
     */
    @RequestMapping(value = "location/tree", method = RequestMethod.GET)
    @ResponseBody
    public List<AdLocation> treeLocation(Model model, Integer level, String type) {
        Pages<AdLocation> page = new Pages<AdLocation>(1, 200);
        page.setSort(new Sort(Direction.ASC, "sortOrder"));
        if (null != level) {
            page.addCondition(new Conditions("level", MatchType.valueOf(type), level));
        }
        adLocationService.findAll(page);
        return page.getResult();
    }

    /**
     * 删除广告
     *
     * @param model
     * @param id
     * @return
     * @author songlin
     */
    @RequestMapping(value = "location/delete", method = RequestMethod.GET)
    public String deleteLocation(Model model, String id) {
        adLocationService.delete(id);
        return "redirect:/advert/location/list";
    }

    /**
     * 生成广告
     *
     * @param model
     * @param id
     * @return
     * @author songlin
     */
    @RequestMapping(value = "gen", method = RequestMethod.GET)
    public String genAd(Model model, String id, String code, String adId) {

        String s = "";
        if (id != null)
            s = adLocationService.generatePageAdByPageId(id, false);
        else if (StringUtil.isNotBlank(code))
            s = adLocationService.generatePageAdByPageCode(code, false);
        else if (StringUtil.isNotBlank(adId))
            s = adService.generatePageAdById(adId);
        else {
            throw new AppWebException("参数id或code不能为空");
        }
        model.addAttribute("html", s);
        return "ad/ad";
    }

    @RequestMapping(value = "load", method = RequestMethod.GET)
    public String asyncLoadAd(Model model, String id) {
        String s = adLocationService.generatePageAdByPageId(id, true);
        model.addAttribute("html", s);
        return "ad/ad";
    }

    @RequestMapping(value = "deletePicture")
    @ResponseBody
    public Map<String, Object> deletePicture(String id, Long fileInfoId, String platform) {
        Map<String, Object> ret = new HashMap<>();
        try {
            adService.deletePic(id, fileInfoId);
            ret.put("success", true);
            ret.put("message", "删除成功！");
        } catch (Exception e) {
            ret.put("success", false);
            ret.put("message", e.getMessage());
        }
        return ret;
    }

    /**
     * 预览首页
     *
     * @param locationId
     * @return
     * @author songlin
     */
    @RequestMapping(value = "/preview")
    public String preview(String locationId, String code) {
        if (null != locationId)
            adLocationService.cleanAdCacheByPageId(locationId, false);
        else if (StringUtil.isNotBlank(code)) {
            adLocationService.cleanAdCacheByPageCode(code, false);
        }
        // TODO 暂支持预览首页，需要拓展支持预览其它广告页
        return "index";
    }
}
