package cn.wuxia.project.admin.view.config.bean;

import java.util.List;

import cn.wuxia.project.basic.core.conf.entity.CustomTag;
import cn.wuxia.project.basic.core.conf.entity.CustomTagCategory;
import cn.wuxia.common.util.ListUtil;
import cn.wuxia.common.util.reflection.BeanUtil;
import cn.wuxia.common.util.reflection.ConvertUtil;

public class TagCategoryVo {

    String categoryId;

    String categoryName;

    String categoryCode;

    String checktype;

    Boolean openquery;

    List<CustomTag> tags;

    public TagCategoryVo() {
    }

    public TagCategoryVo(CustomTagCategory tagCategory, List<CustomTag> tags) {
        BeanUtil.copyProperties(this, tagCategory);
        this.categoryId = tagCategory.getId();
        this.categoryName = tagCategory.getName();
        this.categoryCode = tagCategory.getCode();
        this.tags = tags;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public List<CustomTag> getTags() {
        return tags;
    }

    public void setTags(List<CustomTag> tags) {
        this.tags = tags;
    }

    public String getCategoryCode() {
        return categoryCode;
    }

    public void setCategoryCode(String categoryCode) {
        this.categoryCode = categoryCode;
    }

    public String getChecktype() {
        return checktype;
    }

    public void setChecktype(String checktype) {
        this.checktype = checktype;
    }

    public Boolean getOpenquery() {
        return openquery;
    }

    public void setOpenquery(Boolean openquery) {
        this.openquery = openquery;
    }

    public String tagsToString() {
        if (ListUtil.isNotEmpty(this.tags)) {
            return ConvertUtil.convertElementPropertyToString(tags, "tagName", ",");
        }
        return "";
    }
}
