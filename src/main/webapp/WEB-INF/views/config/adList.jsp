<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/taglibs.jsp"%>
<html>
<%--  广告 列表的模板 默认使用装饰器 --%>
	<head>
		<title>广告列表</title>
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
					<input name="conditions[0].property" value="adName"
						type="hidden">
				</div>
			</div>
			<div class="col-md-6" id="buttons">
				<button data-type="submit" class="btn btn-blue">查询</button>
				<button data-href="${pathname}" class="btn btn-blue">重置条件</button>
				<%--<a href="/ad/${appid}/create">新增</a>--%>
				<button class="btn btn-blue" type="button" data-href="/ad/${appid}/create"><i
						class="fa fa-plus"></i>
					新增
				</button>
			</div>
	</form>
		</div>
	<hr>
				<table class="table  table-striped table-hover " id="ad1list">
					<thead>
						<tr>
							<th>序号</th>
							<th>广告ID</th>
						<th>广告位置</th>
                            <th>广告位名称</th>
						<th>广告名称</th>
						<th>广告标题</th>
						<th>主图</th>
						<th>图2</th>
						<th>图3</th>
						<th>开始时间</th>
						<th>结束时间</th>
						<th>投放地域</th>
						<th>是否显示</th>
						<th>状态</th>
						<%--<th>创建人</th>--%>
						<th>修改人</th>
						<th>更新时间</th>
						<%--<th>广告跳转地址</th>--%>
						<th>置顶显示类型</th>
						<th>广告类型</th>
						<%--<th>标签文案</th>--%>
						<th>列表广告位置序号</th>
						
							<th>操作</th>
						</tr>
					</thead>
					<c:if test="${pages.totalCount>0}">
					<tbody>
						<c:forEach items="${pages.result}" var="ad1" varStatus="vs">
							<tr>
								<td>${vs.index+1}</td>
								<td>
								${ad1.ad_id}
							</td>
							<td>
								${ad1.ad_position_id}
							</td>
                                <td>${ad1.positionName}</td>
							<td>
								${ad1.adName}
							</td>
							<td>
								${ad1.title}
							</td>
								<td><c:if test="${not empty ad1.pic1}">
									<img src="${ad1.pic1}" width="60" height="50"/></c:if>
								</td>
								<td>
									<c:if test="${not empty ad1.pic2}">
									<img src="${ad1.pic2}" width="60" height="50"/></c:if>
								</td>
								<td><c:if test="${not empty ad1.pic3}">
									<img src="${ad1.pic3}" width="60" height="50"/></c:if>
								</td>
							<td>
								<tags:date timestamp="${ad1.startDate}"/>

							</td>
							<td>
								<tags:date timestamp="${ad1.endDate}"/>
							</td>
							<td>
								${ad1.regions}
							</td>
							<td>
                                <c:choose>
                                    <c:when test="${ad1.isShow}">
                                        <span class="label label-sm label-success">显示</span></c:when>
                                    <c:otherwise><span class="label label-sm label-warning">隐藏</span></c:otherwise>
                                </c:choose>

							</td>
							<td>
                                <c:choose>
                                    <c:when test="${ad1.status}"><span class="label label-sm label-success">正常</span></c:when>
                                    <c:otherwise><span class="label label-sm label-warning">下线</span></c:otherwise>
                                </c:choose>
							</td>
							<%--<td>--%>
								<%--${ad1.creator}--%>
							<%--</td>--%>
							<td>
								${ad1.updater}
							</td>
							<td>
								<tags:date timestamp="${ad1.updateTime}"/>
							</td>
							<%--<td>--%>
								<%--${ad1.url}--%>
							<%--</td>--%>
							<td>
								${ad1.view_type}
							</td>
							<td>
								 <c:if test="${ad1.ad_type == 100}">H5</c:if>
								 <c:if test="${ad1.ad_type == 101}">下载</c:if>
								 <c:if test="${ad1.ad_type == 102}">拉应用</c:if>
								 <c:if test="${ad1.ad_type == 103}">拉小程序</c:if>
							</td>

							<td>
								${ad1.list_position}
							</td>
							
								<td>
									<a class="btn btn-info btn-xs" href="${ctx}/ad/${appid}/edit/${ad1.ad_id}">修改<i class="icon-edit bigger-120"></i></a>
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
			<script type="text/javascript" src="${resources_ctx}/script/config/ad1List.js"></script>
    	</myjs>
	</body>
</html>