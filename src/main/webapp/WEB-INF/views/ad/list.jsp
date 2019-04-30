<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/layouts_admin/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>子账户管理</title>
<link type="text/css" href="${resources_ctx }/script/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
</head>
<div class="col-xs-9">
	<div class="col-xs-8">
		<form id="xForm" action="/advert/list">
			<div class="input-group">
				<span class="input-group-btn">所在广告位：</span> <span class="isp col-xs-12 pt_0 pl_0 pr_0" id="dpmName_div"> <input name="name" autocomplete="off" tabindex="4" class="col-xs-12"
					readonly="readonly" id="dpmName" type="text" value="" /> <input name="locationid" id="dpmId" type="hidden" value="${param.id}" />
				</span>
				<div id="departmentSel" class="tree_dpm_sel">
					<ul id="treeDemo" class="ztree"></ul>
				</div>
				<span class="input-group-btn">
					<button class="btn btn-sm btn-info no-radius" type="submit">
						<i class="icon-search icon-on-right bigger-110"></i> 查找
					</button>
				</span>
			</div>
		</form>
	</div>
</div>

<div class="col-xs-3">
	<button class="btn btn-xs btn-info" onclick="window.location.href='/advert/edit'">
		<i class="icon-edit bigger-120"></i> 添加广告
	</button>
	<button class="btn btn-xs btn-info" onclick="window.location.href='/advert/location/list'">
		<i class="icon-list bigger-120"></i> 返回广告位列表
	</button>
</div>
<div class="col-xs-12 pt_10 pl_0 pr_0 pb_0">
	<div class="table-responsive">
		<form id="deleteSubuserForm" action="" method="post">
			<table class="table table-striped table-bordered table-hover mb_0" id="sample-table-1">
				<thead>
					<tr>
						<th class="center"><input autocomplete="off" id="allCheckbox" type="checkbox" class="ace" /> <span class="lbl"></span></th>
						<th class="center">广告标题</th>
						<th class="center">广告别名</th>
						<th class="center">广告链接</th>
						<th class="center">所在广告位</th>
						<th class="center">广告图</th>
						<th class="center">用户操作</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="ad" items="${page.result}">
						<tr class="">
							<td class="center"><label> <input class="ace" autocomplete="off" type="checkbox" name="id" value="${ad.id}"> <span class="lbl"></span>
							</label></td>
							<td>${ad.title}</td>
							<td>${ad.alias }</td>
							<td>${ad.url }</td>
							<td class="hidden-480">${ad.location.parent.name}-${ad.location.name}</td>
							<td><c:if test="${not empty ad.picFile}">
									<img width="100" src="${download_ctx}${ad.picFile.location}@640w_356h_1e_1c" />
								</c:if></td>
							<td class="center">
								<button class="btn btn-xs btn-info" type="button" onclick="window.location.href='/advert/edit?id=${ad.id }'">
									<i class="icon-edit bigger-120"></i>
								</button>
								<button class="btn btn-xs btn-danger" value="${ad.id }" type="button" onclick="deleteUserSingle(this)">
									<i class="icon-trash bigger-120"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
	<tags:page currUrl="${currentUrl}" pageVo="${page}"></tags:page>
</div>

<myjs>
	<script src="${resources_ctx }/script/zTree/js/jquery.ztree.all-3.5.js" type="text/javascript"></script>
	<script>
		function deleteUserSingle(self) {
			if (confirm("删除操作无法恢复，确认删除？")) {
				location.href = "/advert/delete?id=" + $(self).val();
			}
		}
		//点击节点按钮
		function zTreeOnClick(event, treeId, treeNode) {
			$("#dpmName").val(treeNode.name);
			$("#dpmId").val(treeNode.id);
			$("#dpmName_div").removeClass("rz_hover");
			$("#departmentSel").hide();
			return true;
		}
	
		$(function() {
			var setting = {
				async : {
					enable : true,
					url : "/advert/location/tree?type=gt&level=1",
					autoParam : [ "id", "name" ],
					dataType : 'json',
					type : 'get'
				},
				view : {
					selectedMulti : false,
					showIcon : false,
					dblClickExpand : true
				},
				data : {
					key : {
						name : 'name'
					},
					simpleData : {
						enable : true,
						pIdKey : "parentId"
					}
				},
				callback : {
					onClick : zTreeOnClick,
					onAsyncSuccess : zTreeOnAsyncSuccess
				}
			};
			// 异步数据加载完毕进行展开操作
			function zTreeOnAsyncSuccess() {
				$.fn.zTree.getZTreeObj("treeDemo").expandAll(false);
			}
			$.fn.zTree.init($("#treeDemo"), setting);
		})
		// 所属部门选择效果，当输入框失去焦点时也要隐藏掉下拉框
		$("#dpmName").click(function() {
			$("#dpmName_div").addClass("rz_hover");
			$("#departmentSel").slideDown();
		}).blur(function() {
			$("#departmentSel").mouseenter(function() {
				$("#dpmName_div").addClass("rz_hover");
				$("#departmentSel").slideDown();
			}).mouseleave(function() {
				$("#dpmName_div").removeClass("rz_hover");
				$("#departmentSel").slideUp();
			});
		});
	</script>
</myjs>
</body>
</html>