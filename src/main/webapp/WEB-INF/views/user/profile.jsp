<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户资料</title>
    <style>
        .profile-info-name {
            width: 160px;
        }

        .profile-info-value {
            margin-left: 160px;
        }
    </style>
</head>
<body>
<div class="page-header">
    <h1>用户资料
        <small><i class="icon-double-angle-right"></i>

        </small>
    </h1>
</div>
<!-- /.page-header -->

<div class="row ">
    <div class="col-xs-12">
        <!-- PAGE CONTENT BEGINS -->
        <div id="user-profile-2" class="user-profile">
            <div class="tabbable">
                <ul class="nav nav-tabs padding-18">
                    <li class="active">
                        <a data-toggle="tab" href="#home" aria-expanded="true">
                            <i class="green ace-icon fa fa-user bigger-120"></i>
                            用户资料
                        </a>
                    </li>
                    <li class="" id="mystatistics">
                        <a data-toggle="tab" href="#pictures" aria-expanded="false">
                            <i class="pink ace-icon fa fa-picture-o bigger-120"></i>
                            数据分析
                        </a>
                    </li>
                    <li class="">
                        <a href="/coin/coinFlow/list/${user.id}" target="_blank" aria-expanded="false">
                            <i class="orange ace-icon fa fa-rss bigger-120"></i>
                            金币流水
                        </a>
                    </li>

                    <li class="">
                        <a href="/news/user/prentices/${user.id}" aria-expanded="false">
                            <i class="blue ace-icon fa fa-users bigger-120"></i>
                            我的好友
                        </a>
                    </li>
                    <li class="">
                        <a href="/news/user/family/tree/${user.id}" target="_blank" aria-expanded="false">
                            <i class="orange ace-icon fa fa-rss bigger-120"></i>
                            我的关系图
                        </a>
                    </li>
                    <li class="">
                        <a href="/coin/masterCommission/list/${user.id}" target="_blank" aria-expanded="false">
                            <i class="orange ace-icon fa fa-rss bigger-120"></i>
                            好友贡献
                        </a>
                    </li>
                    <li class="">
                        <a href="/user/logined/list/${user.mobile}" target="_blank" aria-expanded="false">
                            <i class="orange ace-icon fa fa-rss bigger-120"></i>
                            登录历史
                        </a>
                    </li>
                    <li class="">
                        <a href="/user/checkin/list/${user.id}" target="_blank" aria-expanded="false">
                            <i class="orange ace-icon fa fa-rss bigger-120"></i>
                            签到记录
                        </a>
                    </li>
                    <li class="">
                        <a href="/user/installed/list/${user.id}" target="_blank" aria-expanded="false">
                            <i class="orange ace-icon fa fa-rss bigger-120"></i>已安装应用
                        </a>
                    </li>
                </ul>

                <div class="tab-content no-border padding-24">
                    <c:if test="${user.dubiousUser}">
                        <div class="alert alert-warning">
                            <button type="button" class="close" data-dismiss="alert">
                                <i class="icon-remove"></i>
                            </button>
                            <strong>警告⚠️</strong>

                            此用户已被系统判断为可疑用户，此用户无法提现。
                            <br>
                        </div>
                        <div class="hr dotted"></div>
                    </c:if>
                    <c:if test="${user.status == 'delete'}">
                        <div class="alert alert-danger">
                            <button type="button" class="close" data-dismiss="alert">
                                <i class="icon-remove"></i>
                            </button>

                            <strong>
                                <i class="icon-remove"></i>
                                警告⚠️
                            </strong>

                            此用户已被管理员禁用，此用户无法登录领取金币。
                            <br>
                        </div>
                        <div class="hr dotted"></div>
                    </c:if>
                    <div id="home" class="tab-pane active">
                        <div class="row">
                            <div class="col-xs-12 col-sm-2 center">
                                <span class="profile-picture">
                                         <c:if test="${not empty user.avatar}">
                                    <img class="editable img-responsive" alt="可惜了我的头像"
                                         id="avatar2"
                                    <c:choose>
                                    <c:when test="${fn:startsWith(user.avatar, 'http://') || fn:startsWith(user.avatar, 'https://')}">
                                         src="${user.avatar}"
                                    </c:when>
                                    <c:otherwise>
                                         src="${img_ctx}/${user.avatar}"
                                    </c:otherwise>
                                    </c:choose>

                                    >
                                         </c:if>
                                </span>

                                <div class="space space-4"></div>
                                <div class="profile-contact-info">
                                    <div class="profile-contact-links align-left">
                                        <c:choose>
                                            <c:when test="${user.status == 'delete'}">
                                                <a data-href="/news/user/unlock/${user.id}" data-async="true"
                                                   data-alert="你确定解封当前账号吗？" data-callback="window.location.reload();"
                                                   class="btn btn-sm btn-block btn-success">
                                                    <i class="ace-icon fa fa-plus-circle bigger-120"></i>
                                                    <span class="bigger-110">解禁</span>
                                                </a></c:when>

                                            <c:otherwise>
                                                <a data-href="/news/user/lock/${user.id}" data-async="true"
                                                   data-alert="你确定封禁当前账号吗？" data-callback="window.location.reload();"
                                                   class="btn btn-sm btn-block btn-danger">
                                                    <i class="ace-icon fa fa-envelope-o bigger-110"></i>
                                                    <span class="bigger-110">禁用</span>
                                                </a></c:otherwise>
                                        </c:choose>


                                        <c:choose>
                                            <c:when test="${user.dubiousUser}">
                                                <a data-href="/news/user/disdubious/${user.id}" data-async="true"
                                                   data-alert="用户将可使用提现功能" data-callback="window.location.reload();"
                                                   class="btn btn-sm btn-block btn-success">
                                                    <i class="ace-icon fa fa-plus-circle bigger-120"></i>
                                                    <span class="bigger-110">申诉解封可提现</span>
                                                </a></c:when>
                                            <c:otherwise>
                                                <a data-href="/news/user/dubious/${user.id}" data-async="true"
                                                   data-alert="你将禁用该账号提现功能。" data-callback="window.location.reload();"
                                                   class="btn btn-sm btn-block btn-danger">
                                                    <i class="ace-icon fa fa-envelope-o bigger-110"></i>
                                                    <span class="bigger-110">点我禁用此用户提现</span>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="space-6"></div>
                                </div>


                            </div><!-- /.col -->

                            <div class="col-xs-12 col-sm-10">
                                <div class="col-xs-12 col-sm-6">
                                    <h4 class="blue">
                                        <span class="middle">基本信息</span>

                                    </h4>

                                    <div class="profile-user-info">
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> ID</div>

                                            <div class="profile-info-value">
                                                <span>${user.id}</span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 性别</div>

                                            <div class="profile-info-value">
                                                <i class="fa fa-map-marker light-orange bigger-110"></i>
                                                <span>${user.gender.displayName}&nbsp;</span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 手机号</div>

                                            <div class="profile-info-value">
                                                <span>${user.mobile}</span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 注册时间</div>

                                            <div class="profile-info-value">
                                                <span><tags:date timestamp="${user.createTime}"/> </span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 注册IP (IP注册人数)</div>

                                            <div class="profile-info-value">
                                                <span>${user.lastLoginIp}（${ifn:ipaddr(user.lastLoginIp)}  ${user.countUserByIp}人）</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 注册来源</div>

                                            <div class="profile-info-value">
                                                <span>${user.registerFrom.displayName}&nbsp;</span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 注册渠道</div>

                                            <div class="profile-info-value">
                                                <span>${user.registerChannel}&nbsp;</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 注册版本</div>

                                            <div class="profile-info-value">
                                                <span>${user.registerVersion}&nbsp;</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 支付宝名字</div>

                                            <div class="profile-info-value">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${not empty user.alipayAccount}">${user.alipayAccount.externName} </c:when>
                                                    <c:otherwise>无</c:otherwise>
                                                </c:choose>

                                            </span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 支付宝账号</div>

                                            <div class="profile-info-value">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${not empty user.alipayAccount}">
                                                        ${user.alipayAccount.externAccount} (<a href="#alipay-modal-form" role="button" class="blue" data-toggle="modal">点击修改</a>)</c:when>
                                                    <c:otherwise>无</c:otherwise>
                                                </c:choose></span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 是否关注公众号</div>

                                            <div class="profile-info-value">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${not empty user.wechatAccount && not empty user.wechatAccount.externAccount}">
                                                        已绑定（${user.wechatAccount.externName}）
                                                    </c:when>
                                                    <c:when test="${not empty user.wechatAccount && not empty user.wechatAccount.externName}">
                                                        微信认证（${user.wechatAccount.externName}）
                                                    </c:when>
                                                    <c:otherwise>没绑定</c:otherwise>
                                                </c:choose></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="hr hr-8 dotted"></div>


                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <h4 class="blue">
                                        <span class="middle">&nbsp;</span>


                                    </h4>

                                    <div class="profile-user-info">
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 昵称</div>

                                            <div class="profile-info-value">
                                                <span>${user.nickName}</span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 用户行为</div>

                                            <div class="profile-info-value">
                                                <i class="fa fa-map-marker light-orange bigger-110"></i>
                                                <span>&nbsp;</span>
                                            </div>
                                        </div>


                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 好友数量</div>

                                            <div class="profile-info-value">
                                                <span><a
                                                        href="/news/user/prentices/${user.id}">${user.countPrentice}</a></span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 好友异常数量</div>

                                            <div class="profile-info-value">
                                                <span>${user.exceptionPrentice}&nbsp;</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 师傅id</div>

                                            <div class="profile-info-value">
                                                <span>
                                                    <c:choose>
                                                        <c:when test="${not empty user.masterUserId}">
                                                    <a href="/news/user/profile/${user.masterUserId}">${user.masterUserName}</a>
                                                        </c:when>
                                                        <c:otherwise>无</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 师傅状态</div>

                                            <div class="profile-info-value">
                                                <span>${user.masterStatus}&nbsp;</span>
                                            </div>
                                        </div>


                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 最后登录IP（IP出现人数）</div>

                                            <div class="profile-info-value">
                                                <span><a
                                                        href="/news/user/iplist?ip=${user.lastLoginIp}">${user.lastLoginIp}</a>（${user.countUserByIp}人）</span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 最后登录时间</div>

                                            <div class="profile-info-value">
                                                <span><tags:date timestamp="${user.lastLoginTime}"/></span>
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 封号处理人</div>

                                            <div class="profile-info-value">
                                                <a href="#" target="_blank">${user.deletedOperator}&nbsp;</a>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 账号状态</div>

                                            <div class="profile-info-value">
                                                ${user.status.displayName}
                                            </div>
                                        </div>
                                        <div class="profile-info-row">
                                            <div class="profile-info-name"> 封号原因</div>

                                            <div class="profile-info-value">
                                                ${user.dubiousReason}&nbsp;
                                            </div>
                                        </div>
                                    </div>

                                    <div class="hr hr-8 dotted"></div>

                                </div>
                            </div><!-- /.col -->
                        </div><!-- /.row -->

                        <div class="space-20"></div>

                        <div class="row">


                            <div class="col-xs-12 col-sm-12">
                                <div class="widget-box transparent">
                                    <div class="widget-header widget-header-small header-color-blue2">
                                        <h4 class="widget-title smaller">
                                            <i class="ace-icon fa fa-lightbulb-o bigger-120"></i>
                                            个人资产
                                        </h4>
                                    </div>

                                    <div class="widget-body">
                                        <div class="widget-main padding-16">
                                            <div class="clearfix">
                                                <div class="grid4 center">
                                                    <div class="easy-pie-chart percentage" data-percent="45"
                                                         data-color="#CA5952"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(202, 89, 82);">
                                                        <span class="percent">${user.totalApplyWithdraw}</span>元
                                                    </div>

                                                    <div class="space-2"></div>
                                                    成功提现/总提现
                                                </div>

                                                <div class="grid4 center">
                                                    <div class="center easy-pie-chart percentage" data-percent="90"
                                                         data-color="#59A84B"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(89, 168, 75);">
                                                        <span class="percent">${user.applyWithdrawCount}</span>次
                                                    </div>

                                                    <div class="space-2"></div>
                                                    成功次数/总申请提现次数
                                                </div>

                                                <div class="grid4 center">
                                                    <div class="center easy-pie-chart percentage" data-percent="80"
                                                         data-color="#9585BF"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(149, 133, 191);">
                                                        <span class="percent">${user.todayInCoin}/${user.todayOutCoin}</span>金币
                                                    </div>

                                                    <div class="space-2"></div>
                                                    今日收益/今日支出
                                                </div>
                                                <div class="grid4 center">
                                                    <div class="center easy-pie-chart percentage" data-percent="80"
                                                         data-color="#9585BF"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(149, 133, 191);">
                                                        <span class="percent">${user.totalInCoin}/${user.totalOutCoin}</span>金币
                                                    </div>

                                                    <div class="space-2"></div>
                                                    总收益/总支出
                                                </div>
                                            </div>
                                            <div class="clearfix">


                                                <div class="grid4 center">
                                                    <div class="center easy-pie-chart percentage" data-percent="80"
                                                         data-color="#9585BF"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(149, 133, 191);">
                                                        <span class="percent">${user.availableCoin}</span>金币
                                                    </div>

                                                    <div class="space-2"></div>
                                                    余额
                                                </div>
                                                <div class="grid4 center">
                                                    <div class="center easy-pie-chart percentage" data-percent="80"
                                                         data-color="#9585BF"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(149, 133, 191);">
                                                        <span class="percent">${user.inCoinFromChild}</span>金币
                                                    </div>

                                                    <div class="space-2"></div>
                                                    好友贡献收益
                                                </div>
                                                <div class="grid4 center">
                                                    <div class="center easy-pie-chart percentage" data-percent="80"
                                                         data-color="#9585BF"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(149, 133, 191);">
                                                        <span class="percent">${user.readedInCoin}</span>金币
                                                    </div>

                                                    <div class="space-2"></div>
                                                    阅读收益
                                                </div>
                                                <div class="grid4 center">
                                                    <div class="center easy-pie-chart percentage" data-percent="80"
                                                         data-color="#9585BF"
                                                         style="height: 72px; width: 192px; line-height: 71px; color: rgb(149, 133, 191);">
                                                        <span class="percent">${user.childJoinInCoin}</span>金币
                                                    </div>

                                                    <div class="space-2"></div>
                                                    收徒收益
                                                </div>
                                            </div>

                                            <div class="hr hr-16"></div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- /#home -->

                    <div id="friends" class="tab-pane">
                        <div class="profile-users clearfix">
                            <c:forEach items="${prentices.result}" var="prentice">
                                <div class="itemdiv memberdiv">
                                    <div class="inline pos-rel">
                                        <div class="user">
                                            <a href="/news/user/profile/${prentice.id}">
                                                <img
                                                <c:choose>
                                                <c:when test="${fn:startsWith(prentice.avatar, 'http://') || fn:startsWith(prentice.avatar, 'https://')}">
                                                        src="${prentice.avatar}"
                                                </c:when>
                                                <c:otherwise>
                                                        src="${img_ctx}/${prentice.avatar}"
                                                </c:otherwise>
                                                </c:choose>
                                                        alt="${prentice.nickName}">
                                            </a>
                                        </div>

                                        <div class="body">
                                            <div class="name">
                                                <a href="/news/user/profile/${prentice.id}">
                                                    <span class="user-status status-online"></span>
                                                        ${prentice.nickName}
                                                </a>
                                            </div>
                                        </div>

                                        <div class="popover">
                                            <div class="arrow"></div>

                                            <div class="popover-content">
                                                <div class="bolder">Content Editor</div>

                                                <div class="time">
                                                    <i class="ace-icon fa fa-clock-o middle bigger-120 orange"></i>
                                                    <span class="green"> 20 mins ago </span>
                                                </div>

                                                <div class="hr dotted hr-8"></div>

                                                <div class="tools action-buttons">
                                                    <a href="#">
                                                        <i class="ace-icon fa fa-facebook-square blue bigger-150"></i>
                                                    </a>

                                                    <a href="#">
                                                        <i class="ace-icon fa fa-twitter-square light-blue bigger-150"></i>
                                                    </a>

                                                    <a href="#">
                                                        <i class="ace-icon fa fa-google-plus-square red bigger-150"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="hr hr10 hr-double"></div>

                        <ul class="pager pull-right">
                            <li class="previous disabled">
                                <a href="#">← Prev</a>
                            </li>

                            <li class="next">
                                <a href="#">Next →</a>
                            </li>
                        </ul>
                    </div><!-- /#friends -->

                    <div id="pictures" class="tab-pane">
                        <div class="row">
                            <div class="col-md-6 col-xs-12">
                                <div id="main11" style="width: 100%;height:300px;"></div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <div id="main12" style="width: 100%;height:300px;"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-xs-12">
                                <div id="main1" style="width: 100%;height:300px;"></div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <div id="main2" style="width: 100%;height:300px;"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-xs-12">
                                <div id="main3" style="width: 100%;height:300px;"></div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <div id="main4" style="width: 100%;height:300px;"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-xs-12">
                                <div id="main5" style="width: 100%;height:300px;"></div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <div id="main6" style="width: 100%;height:300px;"></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-xs-12">
                                <div id="main7" style="width: 100%;height:300px;"></div>
                            </div>
                            <div class="col-md-6 col-xs-12">
                                <div id="main8" style="width: 100%;height:300px;"></div>
                            </div>
                        </div>
                    </div><!-- /#pictures -->
                </div>
            </div>
        </div>
    </div>
</div>
<div id="alipay-modal-form" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="blue bigger">请填写用户支付宝信息（注意仅允许修改一次）</h4>
            </div>
            <div class="modal-body overflow-visible">
                <form id="modify-alipay-form">
                    <input type="hidden" name="userId" value="${user.id}">
                    <div class="row">
                        <div class="col-xs-12">

                            <div class="form-group">
                                <label for="form-field-externName">真实姓名</label>

                                <div>
                                    <input class="input-large" type="text" name="externName" placeholder="支付宝实名认证的名字"
                                           value="${user.alipayAccount.externName}"/>
                                </div>
                            </div>

                            <div class="space-4"></div>

                            <div class="form-group">
                                <label for="form-field-externAccount">支付宝账号</label>

                                <div>
                                    <input class="input-large" type="text" id="form-field-externAccount"
                                           name="externAccount" placeholder="支付宝账号"
                                           value="${user.alipayAccount.externAccount}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button class="btn btn-sm" data-dismiss="modal">
                    <i class="icon-remove"></i>
                    放弃
                </button>

                <button class="btn btn-sm btn-primary" id="alipay-submit">
                    <i class="icon-ok"></i>
                    保存
                </button>
            </div>
        </div>
    </div>
</div><!-- PAGE CONTENT ENDS -->
<myjs>
    <script src="https://cdn.bootcss.com/echarts/3.6.2/echarts.js"></script>
    <script src="/resources/script/profile/modifyAlipayForm.js?1"></script>
    <script type="text/javascript">
        $(function () {
            // 基于准备好的dom，初始化echarts实例
            //var myChart = echarts.init(document.getElementById('main'));

            // 指定图表的配置项和数据
            var firstload = true;
            $("#mystatistics a").click(function (e) {
                e.preventDefault()
                $(this).tab('show');
                if (firstload) {
                    var perLayz = 200;
                    var mychar11 = echarts.init(document.getElementById('main11'));
                    $.getJSON("/news/statistics/chart/countWithdraw/byHour?countHours=24&userId=${user.id}", function (data) {
                        mychar11.setOption(data);
                    })
                    setTimeout(function () {
                        var mychar12 = echarts.init(document.getElementById('main12'));
                        $.getJSON("/news/statistics/chart/countWithdraw/byDate?userId=${user.id}", function (data) {
                            mychar12.setOption(data);
                        })
                    }, perLayz * 1);
                    setTimeout(function () {
                        var mychar1 = echarts.init(document.getElementById('main1'));
                        $.getJSON("/news/statistics/chart/sumCoin/byHour?countHours=24&userId=${user.id}", function (data) {
                            mychar1.setOption(data);
                        })
                    }, perLayz * 2);
                    setTimeout(function () {
                        var mychar2 = echarts.init(document.getElementById('main2'));
                        $.getJSON("/news/statistics/chart/sumCoin/byDate?userId=${user.id}", function (data) {
                            mychar2.setOption(data);
                        })
                    }, perLayz * 3);
                    setTimeout(function () {
                        var mychar3 = echarts.init(document.getElementById('main3'));
                        $.getJSON("/news/statistics/chart/countAmountApply/byHour?countHours=24&userId=${user.id}", function (data) {
                            mychar3.setOption(data);
                        })
                    }, perLayz * 4);
                    setTimeout(function () {
                        var mychar4 = echarts.init(document.getElementById('main4'));
                        $.getJSON("/news/statistics/chart/countAmountApply/byDate?userId=${user.id}", function (data) {
                            mychar4.setOption(data);
                        })
                    }, perLayz * 5);
                    setTimeout(function () {
                        var mychar5 = echarts.init(document.getElementById('main5'));
                        $.getJSON("/news/statistics/chart/countAmountStatus/byHour?countHours=24&userId=${user.id}", function (data) {
                            mychar5.setOption(data);
                        })
                    }, perLayz * 6);
                    setTimeout(function () {
                        var mychar6 = echarts.init(document.getElementById('main6'));
                        $.getJSON("/news/statistics/chart/countAmountStatus/byDate?userId=${user.id}", function (data) {
                            mychar6.setOption(data);
                        })
                    }, perLayz * 7);
                    setTimeout(function () {
                        var mychar7 = echarts.init(document.getElementById('main7'));
                        $.getJSON("/news/statistics/chart/countTask?userId=${user.id}", function (data) {
                            mychar7.setOption(data);
                        })
                    }, perLayz * 8);
                    setTimeout(function () {
                        var mychar8 = echarts.init(document.getElementById('main8'));
                        $.getJSON("/news/statistics/chart/sumUserTask?userId=${user.id}", function (data) {
                            mychar8.setOption(data);
                        })
                    }, perLayz * 9);
                    // 使用刚指定的配置项和数据显示图表。
                    //myChart.setOption(option);
                }
                firstload = false;
            })

            modifyalipayform.initForm();
            $("#alipay-submit").click(function () {
                $("#modify-alipay-form").submit();

            })
        })

        function refresh() {
            window.location.reload();
        }
    </script>
</myjs>
</body>
</html>