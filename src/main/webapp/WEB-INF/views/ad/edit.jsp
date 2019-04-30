<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/layouts_admin/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>基本信息</title>

    <style>
        .upload {
            background: #f4f4f4 none repeat scroll 0 0;
            border: 1px dashed #ccc;
            display: block;
            font-size: 15px;
            font-weight: bold;
            height: 68px;
            line-height: 68px;
            text-align: center;
            width: 68px;
        }
    </style>
</head>
<body>
<div class="bor_s_01 pt_20 pb_20 pr_20 pl_20 col-xs-12">
    <form id="updateOrSave" action="/advert/save" method="post">
        <input type="hidden" name="ad.id" value="${ad.id}"/> <input
            type="hidden" id="ad_location_id" name="ad.location.id"
            value="${ad.location.id}"/>

        <div class="col-xs-12 pt_20" id="select_location">
            <div class="col-xs-2 pl_0 ml_100">
                <select id="location_0" class="col-xs-12" size="10">
                    <c:forEach items="${page_location }" var="page_">
                        <option value="${page_.id }"
                                <c:if test="${ad.location.parent.parent.parent.parent.id eq page_.id || ad.location.parent.parent.parent.id eq page_.id
					  || ad.location.parent.parent.id eq page_.id || ad.location.parent.id eq page_.id 
					}">selected=selected</c:if>>${page_.name }</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-xs-2 pl_0 ml_10">
                <select id="location_1" class="col-xs-12" size="10">
                    <c:forEach items="${location1 }" var="page_">
                        <option value="${page_.id }"
                                <c:if test="${ad.location.parent.parent.id eq page_.id  || ad.location.parent.parent.parent.id eq page_.id
					||  ad.location.parent.id eq page_.id || ad.location.id eq page_.id
					}">selected=selected</c:if>>${page_.name }</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-xs-2 pl_0">
                <select id="location_2" class="col-xs-12" size="10">
                    <c:forEach items="${location2 }" var="page_">
                        <option value="${page_.id }"
                                <c:if test="${ad.location.id eq page_.id || ad.location.parent.id eq page_.id
							|| ad.location.parent.parent.id eq page_.id 
							 }">selected=selected</c:if>>${page_.name }</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <%-- <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                产品ID ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="请输入产品的CODE" tabindex="2" id="form-field-1" type="text" name="ad.priceCode" value="${ad.priceCode}">
            </div>
        </div> --%>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;">*</samp>
                别名 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="请输入好记的名字，描述该广告" tabindex="3"
                       id="form-field-1" type="text" name="ad.alias" value="${ad.alias }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;">*</samp>
                标题 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="一句成功的广告语" tabindex="4"
                       id="form-field-1" type="text" name="ad.title" value="${ad.title }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;">*</samp>
                广告超链接 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="请输入广告超链接" tabindex="6"
                       id="form-field-1" type="text" name="ad.url" value="${ad.url }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                一句话描述 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="广告少不了一个弱弱的描述" tabindex="5"
                       id="form-field-1" type="text" name="ad.keyword"
                       value="${ad.keyword }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                价格 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="如有价格则填在这" tabindex="6"
                       id="form-field-1" type="text" name="ad.fee" value="${ad.fee }">
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">打开方式 ：</div>
            <div class="col-xs-5 pl_0">
                <select name="ad.target" class="col-xs-12" tabindex="7">
                    <option value="_blank"
                            <c:if test="${ad.target == '_blank' }">selected</c:if>>_blank
                    </option>
                    <option value="_self"
                            <c:if test="${ad.target == '_self' }">selected</c:if>>_self
                    </option>
                </select>
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">级别 ：</div>
            <div class="col-xs-5 pl_0">
                <select name="ad.level" class="col-xs-12" tabindex="8">
                    <option value="">请选择级别</option>
                    <c:set var="count" value="9"></c:set>
                    <c:forEach begin="1" end="${count }" varStatus="status">
                        <option value="${count+1-status.index}"
                                <c:if test="${ad.level == (count+1-status.index) }">selected</c:if>>${count+1-status.index}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">是否有效 ：</div>
            <div class="col-xs-5 pl_0">
                <select name="ad.selected" class="col-xs-12" tabindex="9">
                    <option value="true">有效</option>
                    <option value="false">无效</option>
                </select>
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">有效开始时间 ：</div>
            <div class="col-xs-5 pl_0">
                <input type="text" tabindex="9" data-date-format="yyyy-mm-dd"
                       id="id-date-picker-1"
                       class="form-control date-picker datetimepicker"
                       readonly="readonly"
                       value="<fmt:formatDate value="${ad.beginTime }" pattern="yyyy-MM-dd hh:mm:ss"/>"
                       autocomplete="off"> <span class="input-group-addon">
						<i class="icon-calendar bigger-110"></i>
					</span>
            </div>
            <%-- <div class="col-xs-2 pl_0 bootstrap-timepicker">
                <input type="text" tabindex="10" class="form-control" id="timepicker1" readonly="readonly" value="<fmt:formatDate value="${ad.beginTime }" pattern="HH:mm:ss"/>" autocomplete="off"> <span
                    class="input-group-addon"> <i class="icon-time bigger-110"></i>
                </span>
            </div> --%>
            <input disabled="disabled" id="ad_begin_time" type="hidden"
                   name="ad.beginTime"
                   value="<fmt:formatDate value="${ad.beginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   autocomplete="off">
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">有效结束时间 ：</div>
            <div class="col-xs-5 pl_0">
                <input type="text" tabindex="11" data-date-format="yyyy-mm-dd"
                       id="id-date-picker-2"
                       class="form-control date-picker datetimepicker"
                       readonly="readonly"
                       value="<fmt:formatDate value="${ad.effectiveTime }" pattern="yyyy-MM-dd hh:mm:ss"/>"
                       autocomplete="off"> <span class="input-group-addon">
						<i class="icon-calendar bigger-110"></i>
					</span>
            </div>
            <%-- <div class="col-xs-2 pl_0 bootstrap-timepicker">
                <input type="text" tabindex="12" class="form-control" id="timepicker2" readonly="readonly" value="<fmt:formatDate value="${ad.effectiveTime }" pattern="HH:mm:ss"/>" autocomplete="off"> <span
                    class="input-group-addon"> <i class="icon-time bigger-110"></i>
                </span>
            </div> --%>
            <input disabled="disabled" id="ad_effective_time" type="hidden"
                   name="ad.effectiveTime"
                   value="<fmt:formatDate value="${ad.effectiveTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   autocomplete="off">
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                图片 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input id="ad_pic_fileset" name="ad.picFilesetId"
                       value="${ad.picFilesetId }" type="hidden"> <input
                    id="ad_pic_file" name="ad.picFile.id" value="${ad.picFile.id}"
                    type="hidden">
                <button type="button" class="btn-u" id="ad_file">上传图片</button>
                (建议大小：600 * 200)
            </div>
        </div>
        <div class="col-xs-12 pt_20">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                图片的超链接 ：
            </div>
            <div class="col-xs-5 pl_0">
                <input class="col-xs-12" placeholder="没有填写则使用广告的超链接哦" tabindex="6"
                       id="form-field-1" type="text" name="ad.picUrl"
                       value="${ad.picUrl }">
            </div>
        </div>
        <div id="ad_pic"
             class="col-xs-12 pt_20  <c:if test="${ empty pics }" >hide</c:if> ">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                网站图片 ：
            </div>
            <c:forEach items="${pics}" var="fileInfo">
                <div
                        class="col-xs-2 f_l mr_25 ad_pic <c:if test="${ fileInfo.id eq ad.picFile.id}">selected_pic</c:if>">
                    <div class="bord_all pl_5 pr_5 pt_5 pb_5 bg_f">
                        <img width="150" height="150"
                             src="${download_ctx}${fileInfo.location }" data-id="${ad.id }"
                             data-file="${fileInfo.id}"/>
                        <div class="tex_c l_h_22 mt_5 bg_f2">
                            <a class="_delPic">删除</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div id="ad_app_pic"
             class="col-xs-12 pt_20  <c:if test="${ empty appPics }" >hide</c:if> ">
            <div class="col-xs-2 tex_r pr_5 pt_7">
                <samp style="color: #FF0000;"></samp>
                APP图片 ：
            </div>
            <c:forEach items="${ appPics}" var="fileInfo">
                <div
                        class="col-xs-2 f_l mr_25 ad_app_pic <c:if test="${ fileInfo.id eq ad.picFile.id}">selected_pic</c:if>">
                    <div class="bord_all pl_5 pr_5 pt_5 pb_5 bg_f">
                        <img width="150" height="150"
                             src="${download_ctx}${fileInfo.location }" data-id="${ad.id }"
                             data-file="${fileInfo.id}"/>
                        <div class="tex_c l_h_22 mt_5 bg_f2">
                            <a class="_delPic">删除</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="col-xs-11">
            <div class="ipt_box_rz submitWrapper1 tex_c mt_30  mb_30">
                <button id="updateOrSaveSubmitButton" type="button"
                        class="btn btn-sm btn-info no-radius btn_log">保存
                </button>
                <button type="button" class="btn  btn_log"
                        onclick="location.href='/advert/list'">返回
                </button>
            </div>
        </div>
    </form>
    <div class="hide" id="pic_template">
        <div class="col-xs-2 f_l mr_25">
            <div class="bord_all pl_5 pr_5 pt_5 pb_5 bg_f">
                <img width="150" height="150" src="" data-id="${ad.id }"
                     data-file=""/>
                <div class="tex_c l_h_22 mt_5 bg_f2">
                    <a class="deletePic">删除</a>
                </div>
            </div>
        </div>
    </div>
</div>

<textarea name="news.description" id="description" class="fn-hide"></textarea>

<form id="fileForm" method="post" action="/upload/uploadFile"
      enctype="multipart/form-data">
    <input autocomplete="off" type="hidden" name="uploadCategory"
           value="def"> <input autocomplete="off" id="file" type="file"
                               name="Filedata" style="display: none;">
</form>

<myjs>
    <script type="text/javascript" charset="utf-8"
            src="/resources/script/plugin/ueditor/ueditor.config.js"></script>
    <script
            type="text/javascript" src="/resources/script/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="/resources/script/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script
            type="text/javascript">
        //编辑器
        var ue = UE.getEditor("description", {
            UEDITOR_HOME_URL: "/resources/script/ueditor/",
            autoClearinitialContent: false,
            maximumWords: 5000,
            initialFrameHeight: 200,
            initialContent: '',
            imageUrl: "/plugin/pic/ueditor/upload/img",
            imagePath: '/'
        });

        $(function () {
            function getChild(parentId, target) {
                $.ajax({
                    url: "/advert/location/get?parentId=" + parentId,
                    success: function (data) {
                        $(target).empty();
                        $.each(data,
                            function (i, l) {
                                var option = $("#location_0").children(
                                    "option:first").clone(true);
                                $(target).append(
                                    option.val(l.id).text(l.name));
                            })
                    },
                    error: function (data) {
                        log(data);
                    }
                });
            }

            $("#select_location select").each(function (current, o) {
                $(this).on("click", "option", function () {
                    var cur = $(this).parent().attr("id").substring(9);
                    var i = parseInt(cur);
                    switch (i) {
                        case 0:
                            $("#location_" + (i + 1)).empty();
                            $("#location_" + (i + 2)).empty();
                            $("#location_" + (i + 3)).empty();
                            break;
                        case 1:
                            $("#location_" + (i + 1)).empty();
                            $("#location_" + (i + 2)).empty();
                            break;
                        case 2:
                            $("#location_" + (i + 1)).empty();
                            break;
                    }
                    getChild($(this).val(), $("#location_" + (i + 1)));
                })

            })

            /* $("#id-date-picker-1,#id-date-picker-2").datepicker({
                autoclose : true
            }).next().on("click", function() {
                $(this).prev().focus();
            }); */

            //时间控件初始化
            $('.datetimepicker').datetimepicker({
                format: 'yyyy-mm-dd hh:ii:mm',
                autoclose: true,
                todayHighlight: true,
                language: 'zh-CN',
                startView: 2
            }).on('changeDate', function (ev) {
                $(this).prev().focus();
            });

            /* $("#timepicker1,#timepicker2").timepicker({
                minuteStep : 1,
                showSeconds : true,
                showMeridian : false
            }).next().on("click", function() {
                $(this).prev().focus();
            }); */

            //执行表单提交--start
            $("#updateOrSaveSubmitButton").click(
                function () {
                    var locationId = "";
                    if (isNotBlank($("#location_2").val())) {
                        locationId = $("#location_2").val();
                    } else if (isNotBlank($("#location_1").val())) {
                        locationId = $("#location_1").val();
                    } else {
                        alert("请选择所在广告位");
                        return false;
                    }

                    $("#ad_location_id").val(locationId);

                    var date1 = $("#id-date-picker-1").val();
                    if (isNotBlank(date1)) {
                        var time = $("#timepicker1").val();
                        if (isNotBlank(time)) {
                            date1 += " " + time;
                        }
                        $("#ad_begin_time").removeAttr("disabled").val(
                            date1);
                    }

                    var date2 = $("#id-date-picker-2").val();
                    if (isNotBlank(date2)) {
                        var time = $("#timepicker2").val();
                        if (isNotBlank(time)) {
                            date2 += " " + time;
                        }
                        $("#ad_effective_time").removeAttr("disabled")
                            .val(date2);
                    }

                    /* if (validateForm()) { */
                    $('#updateOrSave').submit();
                    /* } */
                });

            $("#ad_file")
                .opengallery(
                    {
                        maxFiles: 1,
                        needgallery: true,
                        callback: function (data) {
                            $("#ad_pic_file").val(
                                data[0].uploadFileInfoId);
                            $('#ad_pic_fileset').val(
                                data[0].uploadFileSetInfoId);
                            var img = $("#pic_template").children()
                                .clone(true);
                            img.find("img").attr("data-file",
                                data[0].uploadFileInfoId).attr(
                                "src", data[0].downloadUrl);
                            img.appendTo($("#ad_pic").removeClass(
                                "hide"));
                            img.addClass("ad_app_pic");
                        }
                    });

            $("#ad_app_file").opengallery(
                {
                    maxFiles: 1,
                    needgallery: true,
                    callback: function (data) {
                        $("#ad_app_pic_file").val(
                            data[0].uploadFileInfoId);
                        $('#ad_app_pic_fileset').val(
                            data[0].uploadFileSetInfoId);
                        var img = $("#pic_template").children().clone(
                            true);
                        img.find("img").attr("data-file",
                            data[0].uploadFileInfoId).attr("src",
                            data[0].downloadUrl);
                        img.appendTo($("#ad_app_pic").removeClass(
                            "hide"));
                        img.addClass("ad_app_pic");
                    }
                });

            // 上传图片
            /* $("body").on('click', '#ad_pic_file', function() {
                uploadFile($('#ad_pic_fileset').val(), "seckill", function(uploadBean) {
                    uploadBean = eval("(" + uploadBean + ")");
                    $('#ad_pic_fileset').val(
                            uploadBean.uploadFileSetInfoId);
                    $("#ad_pic_file").val(
                            uploadBean.uploadFileInfoId);
                    var img = $("#pic_template").children()
                            .clone(true);
                    img.find("img").attr("data-file",
                            uploadBean.uploadFileInfoId).attr(
                            "src", uploadBean.downloadUrl);
                    img.appendTo($("#ad_pic").removeClass(
                            "hide"));
                    img.addClass("ad_app_pic");
                }, 'pic');
                $("#file").click();
            });

            $("body").on('click', '#ad_app_pic_file', function() {
                uploadFile($('#ad_app_pic_fileset').val(), "seckill", function(uploadBean) {
                    uploadBean = eval("(" + uploadBean + ")");
                    $('#ad_app_pic_fileset').val(
                            uploadBean.uploadFileSetInfoId);
                    $("#ad_app_pic_file").val(
                            uploadBean.uploadFileInfoId);
                    var img = $("#pic_template").children()
                            .clone(true);
                    img.find("img").attr("data-file",
                            uploadBean.uploadFileInfoId).attr(
                            "src", uploadBean.downloadUrl);
                    img.appendTo($("#ad_app_pic").removeClass(
                            "hide"));
                    img.addClass("ad_app_pic");
                }, 'pic');
                $("#file").click();
            }); */

            // 删除图片
            $("._delPic").on('click', function () {
                var _delCode = $("#_seckillPic").val();
                if (isNotBlank(_delCode)) {
                    $.ajax({
                        url: "/upload/deleteUploadFile",
                        data: {
                            delCode: _delCode
                        },
                        contentType: false,
                        processData: true,
                        success: function (data) {
                            if (data.success) {
                                div.remove();
                                app_div.remove();
                            } else {
                                alert(data.message);
                            }
                        }
                    });

                }

            });

            //执行表单提交--end
            /* $('#ad_file')
                    .uploadFile(
                            {
                                uploadFileSet : $('#ad_pic_fileset'),
                                url : "/upload/uploadFile",
                                data : {
                                    uploadCategory : 'AD'
                                },
                                removeCompleted : true,
                                fileType : '*.jpg;*.jpeg;*.png;*.bmp;*.gif',
                                callback : function(obj, uploadBean) {
                                    $('#ad_pic_fileset').val(
                                            uploadBean.uploadFileSetInfoId);
                                    $("#ad_pic_file").val(
                                            uploadBean.uploadFileInfoId);
                                    var img = $("#pic_template").children()
                                            .clone(true);
                                    img.find("img").attr("data-file",
                                            uploadBean.uploadFileInfoId).attr(
                                            "src", uploadBean.downloadUrl);
                                    img.appendTo($("#ad_pic").removeClass(
                                            "hide"));
                                    img.addClass("ad_app_pic");
                                }
                            });
            $('#ad_app_file')
            .uploadFile(
                    {
                        uploadFileSet : $('#ad_app_pic_fileset'),
                        url : "/upload/uploadFile",
                        data : {
                            uploadCategory : 'AD'
                        },
                        removeCompleted : true,
                        fileType : '*.jpg;*.jpeg;*.png;*.bmp;*.gif',
                        callback : function(obj, uploadBean) {
                            $('#ad_app_pic_fileset').val(
                                    uploadBean.uploadFileSetInfoId);
                            $("#ad_app_pic_file").val(
                                    uploadBean.uploadFileInfoId);
                            var img = $("#pic_template").children()
                                    .clone(true);
                            img.find("img").attr("data-file",
                                    uploadBean.uploadFileInfoId).attr(
                                    "src", uploadBean.downloadUrl);
                            img.appendTo($("#ad_app_pic").removeClass(
                                    "hide"));
                            img.addClass("ad_app_pic");
                        }
                    }); */
            /* $(".deletePic").on("click", function() {
                var img = $(this).parent().prev("img");
                var id = $(img).attr("data-id");
                var location = $(img).attr("data-file");
                var div = $(img).parents(".ad_pic");
                var app_div = $(img).parents(".ad_app_pic");
                $.ajax({
                    url : "/advert/deletePicture",
                    data : {
                        "id" : id,
                        "fileInfoId" : location,
                        "platform" : div.length > 0 ?'':'app'
                    },
                    contentType: false,
                    processData: true,
                    success : function(data) {
                        if (data.success) {
                            div.remove();
                            app_div.remove();
                        } else {
                            alert(data.message);
                        }
                    }
                });
            }) */

            $("#ad_pic").on("click", "img", function () {
                $("#ad_pic_file").val($(this).attr("data-file"));
            })
            $("#ad_app_pic").on("click", "img", function () {
                $("#ad_app_pic_file").val($(this).attr("data-file"));
            })
        });

        // 图片上传
        function uploadFile(uploadFileSetId, uploadCategory, doSometing,
                            typeName) {
            $("#file").unbind("change"); // 解绑原有事件
            $("#file").change(function () {
                var isFlag = false;
                var image = $("#file")[0];
                var filesize = image.files[0].size;
                filesize = filesize / 1024;
                if (filesize > 500) {
                    msgError('请上传小于500K的图片');
                    return false;
                } else {
                    isFlag = true;
                }
                if (isFlag) {
                    $("#fileForm").ajaxSubmit({
                        data: {
                            uploadFileSetId: uploadFileSetId,
                            uploadCategory: uploadCategory
                        },
                        contentType: "application/json;charset=utf-8",
                        success: doSometing
                    });
                }
            });
        }

        function validateForm() {
            return $("#updateOrSave").validate({
                rules: {
                    "location_1": {
                        required: true
                    }
                },
                messages: {
                    "location_1": {
                        required: "请选择"
                    }
                }
            }).form();
        }
    </script>
</myjs>
</body>
</html>