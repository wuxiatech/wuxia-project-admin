<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/taglibs.jsp"%>
<html>
<%--  配置信息 列表的模板 默认使用装饰器 --%>
	<head>
		<title>配置信息列表</title>
	</head>
	<body>
		<!-- start content -->
		<div class="ucm-panel">
            <div class="headline row">
                <div class="col-md-10">
                    <h2 class="heading-sm">配置信息列表</h2>
                </div>
                <div class="col-md-2 " style="padding-left:40px">
                    <a class="btn-u btn-u-blue" style="float:right" href="/systemConfig/create"><i class="fa fa-plus"></i> 新增</a>
                </div>
            </div>
		<div class="row margin-top-20 margin-bottom-20">
            <form action="${pathname}" method="post">
			<div class="col-md-6">
				<div class="input-group">
					<span class="input-group-addon">商品名称</span> <input
						name="conditions[0].value" value="" class="form-control">
					<input name="conditions[0].conditionType" type="hidden" value="FL">
					<input name="conditions[0].property" value="productName"
						type="hidden">
				</div>
			</div>
			<div class="col-md-6" id="buttons">
				<button data-type="submit" class="btn-u btn-u-blue">查询</button>
				<button data-href="${pathname}" class="btn-u btn-u-blue">重置条件</button>
			</div>
	</form>
		</div>
	<hr>
				<table class="table  table-striped table-hover " id="systemConfiglist">
					<thead>
						<tr>
							<th>序号</th>
							<th>主键</th>
						<th>值内容</th>
						<th>配置类型名</th>
						<th>描述</th>
						<th>排序</th>
						<th>状态</th>
						
							<th>操作</th>
						</tr>
					</thead>
					<c:if test="${pages.totalCount>0}">
					<tbody>
						<c:forEach items="${pages.result}" var="systemConfig" varStatus="vs">
							<tr>
								<td>${vs.index+1}</td>
								<td>
								${systemConfig.configId}
							</td>
							<td>
								${systemConfig.configValue}
							</td>
							<td>
								${systemConfig.configType}
							</td>
							<td>
								${systemConfig.describe}
							</td>
							<td>
								${systemConfig.ordinalNum}
							</td>
							<td>
								${systemConfig.status}
							</td>
							
								<td>
									<a class="btn btn-info btn-xs" href="${ctx}/config/systemConfig/edit/${systemConfig.id}"><i class="fa fa-share"></i></a>
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
			<script type="text/javascript" src="${resources_ctx}/script/config/systemConfigList.js"></script>
    	</myjs>
	</body>
</html>