/*
 * Created on :08 Nov, 2014
 * Author     :huangzhihua
 * Change History
 * Version       Date         Author           Reason
 * <Ver.No>     <date>        <who modify>       <reason>
 * Copyright 2014-2020 www.ibmall.cn All right reserved.
 */
package cn.wuxia.project.admin.view.auth.bean;

import cn.wuxia.common.util.JsonUtil;
import cn.wuxia.common.util.StringUtil;

import java.io.Serializable;

public class RegisterVo implements Serializable {

    /**
     * Comment for <code>serialVersionUID</code>
     */
    private static final long serialVersionUID = 1L;

    private String id;

    private String mobile; //账号

    private String oldpassword; //原用户密码

    private String password; //当前用户密码

    private String repassword; //重复密码

    private String verifycode; //验证码

    private String openid; //微信openid

    private String unionId; //微信联合id，用于统一用户在每个微信应用唯一标识

    private String registerVerifyCode; //注册验证码

    private String realName;// 用户名称

    private String title;

    private String description;

    private Long cityId;

    private String logo; //头像

    private String qrcode; //二维码

    private String departmentId;

    private String type;

    private String order_; //排序

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRepassword() {
        return repassword;
    }

    public void setRepassword(String repassword) {
        this.repassword = repassword;
    }

    public String getVerifycode() {
        return verifycode;
    }

    public void setVerifycode(String verifycode) {
        this.verifycode = verifycode;
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getUnionId() {
        return unionId;
    }

    public void setUnionId(String unionId) {
        this.unionId = unionId;
    }

    public String getRegisterVerifyCode() {
        return registerVerifyCode;
    }

    public void setRegisterVerifyCode(String registerVerifyCode) {
        this.registerVerifyCode = registerVerifyCode;
    }

    /***
     * Get detailed information of the currently logged on user must rewrite the
     * times method
     **/
    public boolean equals(RegisterVo obj) {
        if (obj != null & StringUtil.equalsIgnoreCase(this.getMobile(), obj.getMobile())) {
            return true;
        }
        return false;
    }

    @Override
    public String toString() {
        return JsonUtil.toFullJson(this);
    }

    public Long getCityId() {
        return cityId;
    }

    public void setCityId(Long cityId) {
        this.cityId = cityId;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getOldpassword() {
        return oldpassword;
    }

    public void setOldpassword(String oldpassword) {
        this.oldpassword = oldpassword;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getQrcode() {
        return qrcode;
    }

    public void setQrcode(String qrcode) {
        this.qrcode = qrcode;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOrder_() {
        return order_;
    }

    public void setOrder_(String order_) {
        this.order_ = order_;
    }

}
