package cn.wuxia.project.admin.view.config.bean;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.google.common.collect.Lists;

import cn.wuxia.project.basic.core.conf.bean.MenuBean;
import cn.wuxia.project.basic.core.conf.entity.CustomMenu;
import cn.wuxia.project.basic.core.conf.entity.CustomMenuGroup;
import cn.wuxia.common.util.ListUtil;
import cn.wuxia.common.util.reflection.ConvertUtil;

public class MenuGroupVo {

    List<MenuBean> groupMenus;

    String menuNames;

    String groupCode;

    String groupName;

    String groupId;

    String filters;

    public MenuGroupVo() {
    }

    public MenuGroupVo(CustomMenuGroup menuGroup) {
        this.groupId = menuGroup.getId();
        this.groupCode = menuGroup.getGroupCode();
        this.groupName = menuGroup.getGroupName();
        if (ListUtil.isNotEmpty(menuGroup.getMenus())) {
            this.groupMenus = Lists.newArrayList();
            for (CustomMenu menu : menuGroup.getMenus()) {
                this.groupMenus.add(new MenuBean(menu));
            }
            this.menuNames = ConvertUtil.convertElementPropertyToString(menuGroup.getMenus(), "name", ",");
        }

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

    public List<MenuBean> getGroupMenus() {
        return groupMenus;
    }

    public void setGroupMenus(List<MenuBean> groupMenus) {
        this.groupMenus = groupMenus;
    }

    public String getMenuNames() {
        return menuNames;
    }

    public void setMenuNames(String menuNames) {
        this.menuNames = menuNames;
    }

    public String getFilters() {
        return filters;
    }

    public void setFilters(String filters) {
        this.filters = filters;
    }

    @JsonIgnore
    public CustomMenuGroup getMenuGroup() {
        CustomMenuGroup tagGroup = new CustomMenuGroup();
        tagGroup.setId(this.groupId);
        tagGroup.setGroupCode(this.groupCode);
        tagGroup.setGroupName(this.groupName);

        if (ListUtil.isNotEmpty(this.groupMenus)) {
            List<CustomMenu> menus = Lists.newArrayList();
            for (MenuBean menuBean : this.groupMenus) {
                menus.add(new CustomMenu(menuBean.getMenuId()));
            }
            tagGroup.setMenus(menus);
        }
        return tagGroup;
    }
}
