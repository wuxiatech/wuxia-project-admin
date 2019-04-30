<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/layouts_admin/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>基本信息</title>
    <link type="text/css" href="${resources_ctx }/script/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet"/>
</head>
<body>
<div class="bor_s_01 pt_20 pb_20 pr_20 pl_20 col-xs-12">
    <form id="updateOrSave" action="/advert/location/save" method="post">
        <input type="hidden" name="id" value="${adl.id}"/>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                名字 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="请输入好记的名字，哈哈" tabindex="1" autocomplete="off"
                       id="form-field-1" type="text" name="name" value="${adl.name }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                code ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="用于模版中调用" tabindex="2" autocomplete="off"
                       id="form-field-1" type="text" name="code" value="${adl.code }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                展示广告数 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="显示广告的数量" tabindex="3" autocomplete="off"
                       id="form-field-1" type="text" name="adLength" value="${adl.adLength }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                加载方式 ：
            </div>
            <div class="col-xs-5 pl_0">
                <select name="loadType" class="col-xs-12" tabindex="9">
                    <option value="sync"
                            <c:if test="${adl.loadType eq 'sync' || adl.parent.loadType eq 'sync' }">selected</c:if> >
                        同步加载
                    </option>
                    <option value="async"
                            <c:if test="${adl.loadType eq 'async' || adl.parent.loadType eq 'async'  }">selected</c:if>>
                        异步加载
                    </option>
                </select>
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                模版 ：
            </div>
            <div class="col-xs-9 pl_0">
                <textarea name="templateContent" rows="110" cols="120" id="content" style="height:300px"
                          autocomplete="off">${adl.templateContent}</textarea>
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">所属 ：</div>
            <div class="col-xs-5 pl_0">
				<span class="isp col-xs-12 pt_0 pl_0 pr_0" id="dpmName_div">
				<input autocomplete="off" tabindex="4" class="col-xs-12" readonly="readonly" id="dpmName" type="text"
                       value="${adl.parent.name}"/>
				<c:if test="${not empty param.parentId  }">
                    <input name="parentId" id="dpmId" type="hidden" value="${param.parentId}"/>
                </c:if>
				<c:if test="${ empty param.parentId  }">
                    <input name="parentId" id="dpmId" type="hidden" value="${adl.parent.id}"/>
                </c:if>
				</span>
                <div id="departmentSel" class="tree_dpm_sel">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="col-xs-11">
            <div class="ipt_box_rz submitWrapper1 tex_c mt_30  mb_30">
                <button id="updateOrSaveSubmitButton" type="button"
                        class="btn btn-sm btn-info no-radius btn_log">保存
                </button>
                <button type="button" class="btn  btn_log"
                        onclick="location.href='/advert/location/list?parentId=${param.parentId}'">返回
                </button>
            </div>
        </div>
    </form>
</div>
<!-- <script type="text/javascript" charset="utf-8" src="/resources/scripts/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="/resources/scripts/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="/resources/scripts/ueditor/lang/zh-cn/zh-cn.js"></script> -->
<myjs>
    <script src="${resources_ctx }/script/zTree/js/jquery.ztree.all-3.5.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {



            /*var ue = UE.getEditor('content',{
                toolbars: [['source']],
                //allHtmlEnabled : true,
                sourceEditorFirst : true,
                allowDivTransToP : false
            });*/
            //*ue.setContent('');

            //执行表单提交--start
            $("#updateOrSaveSubmitButton").click(function () {
                //$("textarea").val(ue.getContent());
                if (validateForm()) {
                    $('#updateOrSave').submit();
                }
            });

            //执行表单提交--end
            // 点击节点按钮
            function zTreeOnClick(event, treeId, treeNode) {
                $("#dpmName").val(treeNode.name);
                $("#dpmId").val(treeNode.id);
                $("#dpmName_div").removeClass("rz_hover");
                $("#departmentSel").hide();
                return true;
            }

            // 异步数据加载完毕进行展开操作
            function zTreeOnAsyncSuccess() {
                $.fn.zTree.getZTreeObj("treeDemo").expandAll(true);
            }

            var setting = {
                async: {
                    enable: true,
                    url: "/advert/location/tree",
                    autoParam: ["id", "name"],
                    dataType: 'json',
                    type: 'get'
                },
                view: {
                    selectedMulti: false,
                    showIcon: false,
                    dblClickExpand: false
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

            $.fn.zTree.init($("#treeDemo"), setting);

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
        });


        function validateForm() {
            return $("#updateOrSave").validate({
                rules: {
                    "name": {
                        required: true,
                        maxlength: 64
                    },
                    "dpmName": {
                        required: true
                    }
                },
                messages: {
                    "name": {
                        required: "请输入名字",
                        maxlength: "长度不能大于64"
                    },
                    "dpmName": {
                        required: "请选择所属"
                    }
                }
            }).form();
        }
    </script>
</myjs>
</body>
</html>