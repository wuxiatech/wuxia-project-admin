<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>
<html>
<%--  广告位 列表的模板 默认使用装饰器 --%>
<head>
    <title>广告位列表</title>
</head>
<body>
<!-- start content -->
<div class="ucm-panel">
    <div class=" margin-bottom-20" style="margin-bottom: 20px">
        <form action="${pathname}" method="post">
            <div class="col-md-6">
                <div class="input-group">
                    <span class="input-group-addon">名称</span> <input
                        name="conditions[0].value" value="" class="form-control">
                    <input name="conditions[0].conditionType" type="hidden" value="FL">
                    <input name="conditions[0].property" value="name"
                           type="hidden">
                </div>
            </div>
            <div class="col-md-6" id="buttons">
                <button data-type="submit" class="btn btn-u-blue">查询</button>
                <button data-href="${pathname}" class="btn btn-u-blue">重置条件</button>
                <%--<a href="" class="btn-u btn-u-blue">新增</a>--%>
                <button class="btn btn-u-blue" type="button" data-href="/ad/position/${appid}/create"><i
                        class="fa fa-plus"></i>
                    新增
                </button>
            </div>
        </form>
    </div>
    <hr>
    <table class="table  table-striped table-hover " id="adPositionlist">
        <thead>
        <tr>
            <th>序号</th>
            <th>广告位编码</th>
            <th>appid</th>
            <th>广告位名</th>
            <th>广告位描述</th>
            <th>创建人</th>
            <th>创建时间</th>
            <th>修改人</th>
            <th>更新时间</th>

            <th>操作</th>
        </tr>
        </thead>
        <c:if test="${pages.totalCount>0}">
            <tbody>
            <c:forEach items="${pages.result}" var="adPosition" varStatus="vs">
                <tr>
                    <td>${vs.index+1}</td>
                    <td>
                            ${adPosition.id}
                    </td>
                    <td>
                            ${adPosition.appid.displayName}
                    </td>
                    <td>
                            ${adPosition.name}
                    </td>
                    <td>
                            ${adPosition.description}
                    </td>
                    <td>
                            ${adPosition.creator}
                    </td>
                    <td>
                            <tags:date timestamp="${adPosition.createTime}"/>
                    </td>
                    <td>
                            ${adPosition.updater}
                    </td>
                    <td>
                        <tags:date timestamp="${adPosition.updateTime}"/>
                    </td>

                    <td>
                        <a class="btn btn-info btn-xs" href="${ctx}/ad/position/${appid}/edit/${adPosition.id}"><i
                                class="fa fa-share"></i>修改</a>
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
<!-- myjs 可以将此模板的 JavaScript 到装饰器的 body 之前-->
<myjs>
    <script type="text/javascript" src="${resources_ctx}/script/config/adPositionList.js"></script>
</myjs>
</body>
</html>