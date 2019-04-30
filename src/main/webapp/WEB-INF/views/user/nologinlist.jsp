<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>
<html>
<%--  会员签到记录 列表的模板 默认使用装饰器 --%>
<head>
    <title>会员连续签到${param.countTimes}天记录列表</title>
</head>
<body>
<!-- start content -->
<div class="ucm-panel">
    <div class="header smaller lighter blue" id="buttons">
        <button data-href="/news/user/nologin?countTimes=10" class="btn-u btn-u-blue">连续10天没登陆的用户</button>
        <button data-href="/news/user/nologin?countTimes=20" class="btn-u btn-u-blue">连续20天没登陆的用户</button>
        <button data-href="/news/user/nologin?countTimes=30" class="btn-u btn-u-blue">连续30天没登陆的用户</button>
    </div>
    <div class="table-responsive">
        <table class="table  table-striped table-hover " id="userCheckinlist">
            <thead>
            <tr>
                <th>序号</th>
                <th>会员编码</th>
                <th>昵称</th>
                <th>最后一次登陆时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <c:if test="${pages.totalCount>0}">
                <tbody>
                <c:forEach items="${pages.result}" var="userCheckin" varStatus="vs">
                    <tr>
                        <td>${vs.index+1}</td>
                        <td>
                                ${userCheckin.user_id}
                        </td>
                        <td>
                                ${userCheckin.nick_name}
                        </td>
                        <td><tags:date timestamp="${userCheckin.last_login_time}"/>

                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${userCheckin.status}">正常</c:when>
                                <c:otherwise>删除</c:otherwise>
                            </c:choose>

                        </td>


                        <td>
                            <a class="btn btn-info btn-xs" href="${ctx}/news/user/profile/${userCheckin.user_id}"><i
                                    class="fa fa-share"></i>查看用户信息</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </c:if>
        </table>
        <c:if test="${pages.totalCount<1}">
            <div>
                <p> 暂无数据 </p>
            </div>
        </c:if>
        <c:if test="${pages.totalCount>0}">
            <div style="text-align: right" class="margin-bottom-40">
                <div class="col-md-12 order-table-ft">
                    <tags:page currUrl="" pageVo="${pages}"></tags:page>
                </div>
            </div>
        </c:if>
    </div>
</div>
<!-- myjs 可以将此模板的 JavaScript 到装饰器的 body 之前-->
<myjs>
    <script type="text/javascript" src="${resources_ctx}/script/user/userCheckinList.js"></script>
</myjs>
</body>
</html>