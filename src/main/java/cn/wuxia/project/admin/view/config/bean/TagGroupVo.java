package cn.wuxia.project.admin.view.config.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import cn.wuxia.project.basic.core.conf.bean.TagGroupCategory;
import cn.wuxia.project.basic.core.conf.entity.CustomTagGroup;
import cn.wuxia.common.util.JsonUtil;
import cn.wuxia.common.util.ListUtil;
import cn.wuxia.common.util.MapUtil;
import cn.wuxia.common.util.StringUtil;
import cn.wuxia.common.util.reflection.ConvertUtil;

public class TagGroupVo {

    List<TagGroupCategory> groupCategories;

    String categoryNames;

    String groupCode;

    String groupName;

    String groupId;

    String[] departmentIds;

    String filters;

    public TagGroupVo() {
    }

    public TagGroupVo(CustomTagGroup tagGroup) {
        this.groupId = tagGroup.getId();
        this.groupCode = tagGroup.getCode();
        this.groupName = tagGroup.getName();
        this.groupCategories = tagGroup.getChildren();
        if (ListUtil.isNotEmpty(tagGroup.getChildren())) {
            this.categoryNames = ConvertUtil.convertElementPropertyToString(tagGroup.getChildren(), "categoryName", ",");
        }
        if (MapUtil.isNotEmpty(tagGroup.getFilters())) {
            ArrayList<String> filtersDeptIds = (ArrayList) tagGroup.getFilters().get("departmentId");
            departmentIds = ListUtil.listToArray(filtersDeptIds);
            tagGroup.getFilters().remove("departmentId");
            this.filters = JsonUtil.toFullJson(tagGroup.getFilters());
        }
    }

    public String getCategoryNames() {
        return categoryNames;
    }

    public void setCategoryNames(String categoryNames) {
        this.categoryNames = categoryNames;
    }

    public String getGroupCode() {
        return groupCode;
    }

    public void setGroupCode(String groupCode) {
        this.groupCode = groupCode;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public List<TagGroupCategory> getGroupCategories() {
        return groupCategories;
    }

    public void setGroupCategories(List<TagGroupCategory> groupCategories) {
        this.groupCategories = groupCategories;
    }

    public String[] getDepartmentIds() {
        return departmentIds;
    }

    public void setDepartmentIds(String[] departmentIds) {
        this.departmentIds = departmentIds;
    }

    public String getFilters() {
        return filters;
    }

    public void setFilters(String filters) {
        this.filters = filters;
    }

    @JsonIgnore
    public CustomTagGroup getTagGroup() {
        CustomTagGroup tagGroup = new CustomTagGroup();
        tagGroup.setId(this.groupId);
        tagGroup.setCode(this.groupCode);
        tagGroup.setName(this.groupName);
        Map<String, Object> filters = Maps.newHashMap();
        if (StringUtil.isNotBlank(filters)) {
            filters = JsonUtil.fromJson(this.filters);
        }
        if (StringUtil.isNotBlank(departmentIds)) {
            filters.put("departmentId", departmentIds);
        }
        tagGroup.setFilters(filters);
        if (StringUtil.isNotBlank(this.categoryNames)) {
            String[] categoryIds = StringUtil.split(this.categoryNames, ",");
            this.groupCategories = Lists.newArrayList();
            for (String categoryId : categoryIds) {
                this.groupCategories.add(new TagGroupCategory(categoryId));
            }
            tagGroup.setChildren(this.groupCategories);
        }
        return tagGroup;
    }
}
