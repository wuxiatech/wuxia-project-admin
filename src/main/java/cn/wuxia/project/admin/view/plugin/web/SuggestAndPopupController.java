package cn.wuxia.project.admin.view.plugin.web;

import java.util.List;

import cn.wuxia.project.ad.core.bean.SuggestBoxVo;
import cn.wuxia.project.ad.core.entity.AddressBase2015;
import cn.wuxia.project.ad.core.service.AddressBase2015Service;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.google.common.collect.Lists;

import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.common.util.StringUtil;

@Controller
@RequestMapping("/suggest/*")
public class SuggestAndPopupController extends BaseController {

    @Autowired
    private AddressBase2015Service addressBaseService;

    /**
     * 根据关键字查找省级与城市
     * 
     * @param keyword
     * @return
     */
    @RequestMapping(value = "/address/findByParentId")
    @ResponseBody
    public Object findProvinceOrCity(Long parentId, @RequestParam(required = false) String callback) {
        List<SuggestBoxVo> result = addressBaseService.findCityByProvinceId(parentId);
        if (StringUtils.isNotBlank(callback)) {
            return new JSONPObject(callback, result);
        } else {
            return result;
        }
    }

    /**
     * 根据省份ID查找地市
     * @author wuwenhao
     * @param model
     * @param adCode 省份ID 
     * @return
     */
    @RequestMapping(value = "/address/cityList")
    @ResponseBody
    public List<AddressBase2015> cityList(Model model, String adCode) {
        List<AddressBase2015> ret = Lists.newArrayList();
        List<AddressBase2015> cityMap = addressBaseService.getAllCityMap();
        for (int i = 0; i < cityMap.size(); i++) {
            if (StringUtil.equals(cityMap.get(i).getParentId().toString(), adCode)) {
                ret.add(cityMap.get(i));
            }
        }
        return ret;
    }

    /**
     * 根据城市ID查找下属区
     * @author wuwenhao
     * @param model
     * @param adCode 城市ID  
     * @return
     */
    @RequestMapping(value = "/address/areaList")
    @ResponseBody
    public List<AddressBase2015> areaList(Model model, String adCode) {
        Assert.notNull("查找县区有误！！！", adCode);
        List<AddressBase2015> ret = Lists.newArrayList();
        List<AddressBase2015> areaMap = addressBaseService.getAllAreaMap();
        for (int i = 0; i < areaMap.size(); i++) {
            if (StringUtil.equals(areaMap.get(i).getParentId().toString(), adCode)) {
                ret.add(areaMap.get(i));
            }
        }
        return ret;
    }
}
