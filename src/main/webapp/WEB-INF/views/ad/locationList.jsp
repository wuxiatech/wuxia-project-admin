<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/layouts_admin/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>子账户管理</title>
    <link type="text/css" href="${resources_ctx }/script/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet"/>
</head>
<div class="row">
    <div class="col-xs-9">
        <div class="col-xs-8">
            <form id="xForm" action="/advert/location/list">
                <div class="input-group">
                    <span class="input-group-btn">搜索页面：</span>
                    <span class="isp col-xs-12 pt_0 pl_0 pr_0" id="dpmName_div"> <input name="name" autocomplete="off"
                                                                                        tabindex="4" class="col-xs-12"
                                                                                        readonly="readonly" id="dpmName"
                                                                                        type="text" value=""/> <input
                            name="parentId" id="dpmId" type="hidden" value="${param.id}"/>
				</span>
                    <div id="departmentSel" class="tree_dpm_sel">
                        <ul id="treeDemo" class="ztree"></ul>
                    </div>
                    <span class="input-group-btn pl_10">
					<button class="btn btn-sm btn-info no-radius" type="submit">
						<i class="icon-search icon-on-right bigger-110"></i> 查找
					</button>
				</span>
                </div>
            </form>
        </div>
    </div>

    <div class="col-xs-3">
        <button class="btn btn-xs btn-info"
                onclick="window.location.href='/advert/location/edit?parentId=${param.parentId}'">
            <i class="icon-plus bigger-120"></i> 添加广告位
        </button>
        <button class="btn btn-xs btn-info"
                onclick="window.location.href='/advert/list'">
            <i class="icon-list bigger-120"></i> 广告列表
        </button>
    </div>

    <div class="table-responsive">
        <form id="deleteSubuserForm" action=""
              method="post">
            <table class="table table-striped table-bordered table-hover mb_0"
                   id="sample-table-1">
                <thead>
                <tr>
                    <th class="center"><input autocomplete="off" id="allCheckbox"
                                              type="checkbox" class="ace"/> <span class="lbl"></span></th>
                    <th class="center">广告所在</th>
                    <th class="center">所属</th>
                    <th class="center">广告个数</th>
                    <th class="center">Level</th>
                    <th>加载方式</th>
                    <th class="center">用户操作</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="adl" items="${page.result}">

                    <tr class="">
                        <td class="center"><label> <input class="ace"
                                                          autocomplete="off" type="checkbox" name="id"
                                                          value="${adl.id}"> <span class="lbl"></span>
                        </label></td>
                        <td><a href="/advert/location/list?parentId=${adl.id }">${adl.name}</a></td>
                        <td><a href="/advert/location/list?parentId=${adl.parent.parent.id }">${adl.parent.parent.name}
                            - ${adl.parent.name}</a></td>
                        <td>${adl.adLength }</td>
                        <td>${adl.level }</td>
                        <td><c:if test="${adl.loadType eq 'sync'  }">同步加载</c:if>
                            <c:if test="${adl.loadType eq 'async'  }">异步加载</c:if>
                        </td>
                        <td class="center">
                            <!-- 页面级别以下才可以添加广告 -->
                            <c:if test="${ not empty adl.adLength}">
                                <button class="btn btn-xs btn-info" type="button"
                                        onclick="window.location.href='/advert/edit?locationId=${adl.id }'">
                                    <i class="icon-plus bigger-120"></i>
                                </button>
                            </c:if>
                            <button class="btn btn-xs btn-info" type="button"
                                    onclick="window.location.href='/advert/location/edit?id=${adl.id }&parentId=${param.parentId }'">
                                <i class="icon-edit bigger-120"></i>
                            </button>
                            <c:if test="${adl.level > 2 }">
                                <button class="btn btn-xs btn-danger" value="${adl.id }" type="button"
                                        onclick="deleteUserSingle(this)">
                                    <i class="icon-trash bigger-120"></i>
                                </button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot>
                </tfoot>
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
                location.href = "/advert/location/delete?id="
                    + $(self).val();
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

        $(function () {
            var setting = {
                async: {
                    enable: true,
                    url: "/advert/location/tree?type=LT&level=4",
                    autoParam: ["id", "name"],
                    dataType: 'json',
                    type: 'get'
                },
                view: {
                    selectedMulti: false,
                    showIcon: false,
                    dblClickExpand: true
                },
                data: {
                    key: {
                        name: 'name'
                    },
                    simpleData: {
                        enable: true,
                        pIdKey: "parentId"
                    }
                },
                callback: {
                    onClick: zTreeOnClick,
                    onAsyncSuccess: zTreeOnAsyncSuccess
                }
            };

            // 异步数据加载完毕进行展开操作
            function zTreeOnAsyncSuccess() {
                $.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
            }

            $.fn.zTree.init($("#treeDemo"), setting);
        })
        // 所属部门选择效果，当输入框失去焦点时也要隐藏掉下拉框
        $("#dpmName").click(function () {
            $("#dpmName_div").addClass("rz_hover");
            $("#departmentSel").slideDown();
        }).blur(function () {
            $("#departmentSel").mouseenter(function () {
                $("#dpmName_div").addClass("rz_hover");
                $("#departmentSel").slideDown();
            }).mouseleave(function () {
                $("#dpmName_div").removeClass("rz_hover");
                $("#departmentSel").slideUp();
            });
        });
    </script>
</myjs>
</body>
</html>