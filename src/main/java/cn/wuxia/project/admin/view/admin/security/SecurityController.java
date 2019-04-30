/*
 * Copyright 2011-2020 wuxia.gd.cn All right reserved.
 */
package cn.wuxia.project.admin.view.admin.security;

import cn.wuxia.common.util.StringUtil;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.security.common.MyUserDetails;
import cn.wuxia.project.security.common.SpringSecurityUtils;
import cn.wuxia.project.security.core.bean.PermissionResourcesDto;
import cn.wuxia.project.security.core.bean.RolePermissionsDto;
import cn.wuxia.project.security.core.bean.UserRoleDto;
import cn.wuxia.project.security.core.entity.SecurityPermission;
import cn.wuxia.project.security.core.entity.SecurityResources;
import cn.wuxia.project.security.core.entity.SecurityRole;
import cn.wuxia.project.security.core.enums.SystemType;
import cn.wuxia.project.security.core.service.SecurityPermissionResourcesService;
import cn.wuxia.project.security.core.service.SecurityRolePermissionsService;
import cn.wuxia.project.security.core.service.SecurityUserRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.stream.Collectors;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/security/**")
public class SecurityController extends BaseController {

    @Autowired
    private SecurityPermissionResourcesService permissionResourcesService;

    @Autowired
    private SecurityRolePermissionsService rolePermissionsService;

    @Autowired
    private SecurityUserRoleService userRoleService;

    @RequestMapping(value = "/role/list", method = RequestMethod.GET)
    public String roleList(Model model) {
        model.addAttribute("list", userRoleService.findAllRole());
        return "security/role/list";
    }

    @RequestMapping(value = "/permission/list", method = RequestMethod.GET)
    public String permissionsList(Model model, String type) {
        SystemType systemType = null;
        if (StringUtil.isNotBlank(type)) {
            systemType = SystemType.valueOf(type);
        }
        model.addAttribute("list", permissionResourcesService.findPermissionsByType(systemType));
        model.addAttribute("systems", SystemType.values());
        return "security/permission/list";
    }

    @RequestMapping(value = "/resources/list", method = RequestMethod.GET)
    public String resourcesList(Model model, String type) {
        SystemType systemType = null;
        if (StringUtil.isNotBlank(type)) {
            systemType = SystemType.valueOf(type);
        }
        model.addAttribute("list", permissionResourcesService.findResourcesByType(systemType));
        model.addAttribute("systems", SystemType.values());
        return "security/resources/list";
    }

    @RequestMapping(value = "/resources/create", method = RequestMethod.GET)
    public String resourcesCreate(Model model) {
        return resourcesEdit(model, null);
    }

    @RequestMapping(value = "/role/create", method = RequestMethod.GET)
    public String roleCreate(Model model) {
        return roleEdit(model, null);
    }

    @RequestMapping(value = "/permission/create", method = RequestMethod.GET)
    public String permissionCreate(Model model) {
        return permissionEdit(model, null);
    }

    @RequestMapping(value = "/resources/edit/{resourcesId}", method = RequestMethod.GET)
    public String resourcesEdit(Model model, @PathVariable String resourcesId) {
        if (StringUtil.isNotBlank(resourcesId)) {
            SecurityResources allresources = permissionResourcesService.getResoucesById(resourcesId);
            model.addAttribute("securityResources", allresources);
        }
        model.addAttribute("systems", SystemType.values());
        return "security/resources/edit";
    }

    @RequestMapping(value = "/permission/edit/{permissionId}", method = RequestMethod.GET)
    public String permissionEdit(Model model, @PathVariable String permissionId) {
        if (StringUtil.isNotBlank(permissionId)) {
            PermissionResourcesDto dto = permissionResourcesService.getPermissionResource(permissionId);
            model.addAttribute("permissionResources", dto);
            List<SecurityResources> resources = permissionResourcesService.findResourcesByType(dto.getSystemType());
            model.addAttribute("allresources", resources);
        } else {
            PermissionResourcesDto dto = new PermissionResourcesDto();
            dto.setPermissionName(StringUtil.random(6));
            model.addAttribute("permissionResources", dto);
            List<SecurityResources> allresources = permissionResourcesService.findAllResources();
            model.addAttribute("allresources", allresources);
        }
        model.addAttribute("systems", SystemType.values());
        return "security/permission/edit";
    }

    @RequestMapping(value = "/permission/del/{permissionId}", method = RequestMethod.GET)
    public String permissionDel(Model model, @PathVariable String permissionId) {
        if (StringUtil.isNotBlank(permissionId)) {
            permissionResourcesService.deletePermission(permissionId);
        }
        return "redirect:/security/permission/list";
    }

    @RequestMapping(value = "/permission/save", method = RequestMethod.POST)
    public String savePermissionResources(Model model, PermissionResourcesDto vo) {
        permissionResourcesService.savePermissionResources(vo);
        return "redirect:/security/permission/list";
    }

    @RequestMapping(value = "/role/edit/{roleId}", method = RequestMethod.GET)
    public String roleEdit(Model model, @PathVariable String roleId) {
        if (StringUtil.isNotBlank(roleId)) {
            RolePermissionsDto dto = rolePermissionsService.getRolePermission(roleId);
            model.addAttribute("rolePermissions", dto);
        } else {
            RolePermissionsDto dto = new RolePermissionsDto();
            dto.setRoleName(StringUtil.random(6));
            model.addAttribute("rolePermissions", dto);
        }
        List<SecurityPermission> allPermissions = permissionResourcesService.findAllPermissions();
        model.addAttribute("allpermissions", allPermissions);
        model.addAttribute("systems", SystemType.values());
        return "security/role/edit";
    }

    @RequestMapping(value = "/resources/del/{resourcesId}", method = RequestMethod.GET)
    public String resourcesDel(Model model, @PathVariable String resourcesId, String type) {
        if (StringUtil.isNotBlank(resourcesId)) {
            permissionResourcesService.deleteResoucesById(resourcesId);
        }
        return "redirect:/security/resources/list" + (StringUtil.isNotBlank(type) ? "?type=" + type : "");
    }

    @RequestMapping(value = "/role/del/{roleId}", method = RequestMethod.GET)
    public String roleDel(Model model, @PathVariable String roleId) {
        if (StringUtil.isNotBlank(roleId)) {
            rolePermissionsService.deleteRole(roleId);
        }
        return "redirect:/security/role/list";
    }

    @RequestMapping(value = "/role/save", method = RequestMethod.POST)
    public String saveRolePermissions(Model model, RolePermissionsDto vo) {
        rolePermissionsService.saveRolePermissions(vo);
        return "redirect:/security/role/list";
    }

    @RequestMapping(value = "/resources/save", method = RequestMethod.POST)
    public String saveResources(Model model, SecurityResources resources) {
        permissionResourcesService.saveResouces(resources);
        return "redirect:/security/resources/list?type=" + resources.getType();
    }

    @RequestMapping(value = "/user/edit/{userId}", method = RequestMethod.GET)
    public String userEdit(Model model, @PathVariable String userId, String userName) {
        model.addAttribute("userId", userId);
        model.addAttribute("userName", userName);
        UserRoleDto dto = userRoleService.getUserRole(userId);
        model.addAttribute("userRole", dto);
        List<SecurityRole> allroles = userRoleService.findAllRole();
        MyUserDetails currentUser = SpringSecurityUtils.getCurrentUser();
        /**
         * 只有管理员才允许出现超级管理员角色
         */
        if (StringUtil.isNotBlank(currentUser.getRoles()) && !currentUser.getRoles().contains("root")) {
            allroles.stream().filter(role -> !role.getRoleName().equalsIgnoreCase("root"))
                    .collect(Collectors.toList());
        }
        model.addAttribute("allroles", allroles);
        return "security/user/edit";
    }

    @RequestMapping(value = "/user/save", method = RequestMethod.POST)
    public String saveUserRole(Model model, UserRoleDto vo, String callback) {
        userRoleService.saveUserRole(vo);
        if (StringUtil.isNotBlank(callback))
            return "redirect:" + callback;
        return "redirect:/admin/user/list";
    }

    @RequestMapping("cache/clean")
    @ResponseBody
    public String cleanCache() {
        for (SystemType systemType : SystemType.values()) {
            permissionResourcesService.cleanLoginResourcesCache(systemType);
        }
        return "";
    }
}
