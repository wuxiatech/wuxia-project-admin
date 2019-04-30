<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>

<c:set var="dataId">${empty ad1.id?0:ad1.id}</c:set>
<c:set var="title">
    <c:choose>
        <c:when test="${empty ad1.id}">新增广告</c:when>
        <c:otherwise>
            查看广告-${ad1.id}
        </c:otherwise>
    </c:choose>
</c:set>
<html>
<head>
    <title>${title}</title>
    <link rel="stylesheet" type="text/css" href="//cdn.doctorm.cn/js/webuploader-0.1.5/webuploader.css">
    <style>
        #upload-container {
            width: 200px;
            height: 40px;
            border: 1px solid #9d9d9d;
            border-radius: 6px;
            /*margin:50px auto;*/
            position: relative;
            overflow: hidden;
        }

        .upload-progress {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 5;
            color: #fff;
            line-height: 40px;
            text-align: center;
            display: none;
        }

        #uploadImage {
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 2;
            text-align: center;
            line-height: 40px;
            cursor: pointer;
        }

        #upload-container img {
            width: 100%;
            position: absolute;
            top: 0;
            left: 0;
            z-index: 1;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/resources/styles/base.css">
    <link rel="stylesheet" type="text/css" href="/resources/styles/common.css?abc">
</head>
<body>
<!-- start content -->
<form action="${ctx}/ad/${appid}/save" method="post"
      id="ad1Form" class="sky-form" novalidate="novalidate">
    <input type="hidden" name="id" value="${ad1.id}"/>
    <header>${title}</header>

    <!-- 根据表字段生成表单内容 -->
    <fieldset>

        <div class="row">
            <section class="col col-4">
                <label >广告位置<span class="signicon">*</span>
                </label>
                <label class="input">
                    <select  name="adPositionId"  >
                        <option>请选择</option>
                        <c:forEach items="${positionList}" var="position">
                            <option value="${position.id}" <c:if test="${ad1.adPositionId == position.id}">selected</c:if>>${position.name}(${position.description})</option>
                        </c:forEach>
                    </select>
                    <b class="tooltip tooltip-left">输入广告位置</b>
                </label>
            </section>
            <section class="col col-4">
                <label >名称</label>
                <label class="input">
                    <input type="text" name="adName" value="${ad1.adName}" maxlength="100"/>
                    <b class="tooltip tooltip-left">输入名称</b>
                </label>
            </section>
            <section class="col col-4">
                <label >广告标题<span class="signicon">*</span>
                </label>
                <label class="input">
                    <input type="text" name="title" value="${ad1.title}" maxlength="150"/>
                    <b class="tooltip tooltip-left">输入广告标题</b>
                </label>
            </section>
        </div>
        <hr>
        <div class="row">
            <section class="col col-4 upload-file">
                <label >展示图片1</label>
                <label class="input">
                    <input type="hidden" name="pic1" value="${ad1.pic1}" maxlength="128"/>
                    <div class="uploader-list col-md-10 col-xs-10">
                        <c:if test="${not empty ad1.pic1}">
                            <div class="col-md-6 exists-img"><img src="${ad1.pic1}" height="120"
                                                                  style="width: 100%;"/></div>
                        </c:if>
                        <div class="col-md-6 filePicker">选择图片</div>
                    </div>
                </label>
            </section>

            <section class="col col-4 upload-file">
                <label >展示图片2</label>
                <label class="input">
                    <input type="hidden" name="img2" value="${ad1.pic2}" maxlength="128"/>
                    <div class="uploader-list col-md-10 col-xs-10">
                        <c:if test="${not empty ad1.pic2}">
                            <div class="col-md-6 exists-img"><img src="${ad1.pic2}" height="120"
                                                                  style="width: 100%;"/></div>
                        </c:if>
                        <div class="col-md-6 filePicker">选择图片</div>
                    </div>
                </label>
            </section>

            <section class="col col-4 upload-file">
                <label >展示图片3</label>
                <label class="input">
                    <input type="hidden" name="pic3" value="${ad1.pic3}" maxlength="255"/>
                    <div class="uploader-list col-md-10 col-xs-10">
                        <c:if test="${not empty ad1.pic3}">
                            <div class="col-md-6 exists-img"><img src="${ad1.pic3}" height="120"
                                                                  style="width: 100%;"/></div>
                        </c:if>
                        <div class="col-md-6 filePicker">选择图片</div>
                    </div>
                </label>
            </section>
        </div>
        <hr>
        <div class="row">
            <section class="col col-4">
                <label >开始时间</label>
                <label class="input">
                    <c:set var="startdate"><tags:date timestamp="${ad1.startDate}"/></c:set>
                    <input type="text" name="startDate" value="${fn:trim(startdate)}" maxlength="20"
                           id="starttime" data-date-format="yyyy-mm-dd hh:ii" class="date-picker" autocomplete="false"/>
                    <b class="tooltip tooltip-left">输入开始时间</b>
                </label>
            </section>

            <section class="col col-4">
                <label >结束时间</label>
                <label class="input">
                    <c:set var="enddate"><tags:date timestamp="${ad1.endDate}"/></c:set>
                    <input type="text" name="endDate" value="${fn:trim(enddate)}" maxlength="20"
                           id="expirytime"  data-date-format="yyyy-mm-dd hh:ii" class="date-picker" autocomplete="false"/>
                    <b class="tooltip tooltip-left">输入结束时间</b>
                </label>
            </section>
            <section class="col col-4">
                <label >投放地域</label>
                <label class="input">
                    <input type="text" name="regions" value="${ad1.regions}" maxlength="1000"/>
                    <b class="tooltip tooltip-left">输入投放地域</b>
                </label>
            </section>
        </div>
        <hr>
        <div class="row">
            <section class="col col-4">
                <label >是否显示</label>
                <label class="input">
                    <select type="text" name="isShow" maxlength="1">
                        <option value="true"
                                <c:if test="${ad1.isShow}">selected</c:if> > 显示
                        </option>
                        <option value="false" <c:if test="${empty ad1.isShow || !ad1.isShow}">selected</c:if>>不显示</option>
                    </select>
                    <b class="tooltip tooltip-left">输入是否显示</b>
                </label>
            </section>
            <section class="col col-4">
                <label >状态</label>
                <label class="input">
                    <select type="text" name="status" maxlength="1">
                        <option value="true"
                                <c:if test="${ad1.status}">selected</c:if> > 正常
                        </option>
                        <option value="false" <c:if test="${empty ad1.status || !ad1.status}">selected</c:if>>不可用</option>
                    </select>
                    <b class="tooltip tooltip-left">选择状态</b>
                </label>
            </section>

            <section class="col col-4">
                <label >广告跳转地址</label>
                <label class="input">
                    <input type="text" name="url" value="${ad1.url}" maxlength="255"/>
                    <b class="tooltip tooltip-left">输入广告跳转地址</b>
                </label>
            </section>
        </div>
        <hr>
        <div class="row">
            <section class="col col-4">
                <label >置顶显示类型</label>
                <label class="input">
                    <input type="number" name="viewType" value="${ad1.viewType}" maxlength="10"/>
                    <b class="tooltip tooltip-left">输入置顶显示类型</b>
                </label>
            </section>

            <section class="col col-4">
                <label >广告类型</label>
                <label class="input">
                    <select name="adType">
                        <option value="">请选择广告类型</option>
                        <option value="100" <c:if test="${ad1.adType == 100}">selected</c:if>>H5</option>
                        <option value="101" <c:if test="${ad1.adType == 101}">selected</c:if>>下载</option>
                        <option value="102" <c:if test="${ad1.adType == 102}">selected</c:if>>拉应用</option>
                        <option value="103" <c:if test="${ad1.adType == 103}">selected</c:if>>拉小程序</option>
                    </select>
                    <b class="tooltip tooltip-left">输入广告类型</b>
                </label>
            </section>
            <section class="col col-4">
                <label >标签文案</label>
                <label class="input">
                    <input type="text" name="tagDes" value="${ad1.tagDes}" maxlength="10" placeholder="如：精选"/>
                    <b class="tooltip tooltip-left">输入标签文案</b>
                </label>
            </section>
        </div>
        <hr>
        <div class="row">
            <section class="col col-4">
                <label >列表广告位置序号</label>
                <label class="input">
                    <input type="number" name="listPosition" value="${ad1.listPosition}" maxlength="10"/>
                    <b class="tooltip tooltip-left">输入列表广告位置序号</b>
                </label>
            </section>
        </div>
        <hr>
        <c:if test="${not empty ad1.id}">
            <div class="row">
            <section class="col col-4">
                <label >创建人</label>
                <label class="input">
                    <input type="text" name="creator" value="${ad1.creator}" maxlength="45" readonly/>
                </label>
            </section>
            <section class="col col-4">
                <label >创建时间</label>
                <label class="input">
                    <input type="text" name="createTime" value="<tags:date timestamp="${ad1.createTime}"/>" readonly/>
                </label>
            </section>

            <section class="col col-4">
                <label >修改人</label>
                <label class="input">
                    <input type="text" name="updater" value="${ad1.updater}" maxlength="45" readonly/>
                </label>
            </section>
            </div>
            <hr>
            <div class="row">
            <section class="col col-4">
                <label >更新时间</label>
                <label class="input">
                    <input type="text" name="updateTime" value="<tags:date timestamp="${ad1.updateTime}"/>" readonly/>
                </label>
            </section>
        </div>
        </c:if>


    </fieldset>

    <footer>
        <button type="submit" class="btn btn-info">保存</button>
        <a type="button" class="btn btn-default" href="${ctx}/ad/${appid}/list">返回</a>
    </footer>
</form>
<!-- myjs 可以将此模板的 JavaScript 到装饰器的 body 之前-->
<myjs>
    <script type="text/javascript" src="//ace.zjcdn.cn/assets/js/spin.min.js"></script>
    <script type="text/javascript" src="/resources/script/plugin/spin.config.js"></script>
    <script type="text/javascript" src="/resources/script/config/ad1Form.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            ad1Form.initForm();
        });
    </script>
    <script type="text/javascript" src="//cdn.doctorm.cn/js/webuploader-0.1.5/webuploader.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            $("[name='startDate']").datetimepicker({
                timepicker:true,
                autoclose: true, //这里最好设置为false
                todayHighlight : true,
                language : 'zh-CN',
                startDate : new Date(),
            });
            $("[name='endDate']").datetimepicker({
                timepicker:true,
                startDate:$("[name='startDate']", $(this).parents("form")).val(),
                autoclose: true, //这里最好设置为false
            });

            $(".upload-file").each(function (a, b) {
                initImageUpload($(b));
            })

            function initImageUpload(template) {
                // template.find(".filePicker").each(function () {
                //     initUpload($(this));
                // })
                var uploader = initUpload(template.find(".filePicker:first"), "gallery");
                // 文件上传成功，给item添加成功class, 用样式标记上传成功。
                uploader.on('uploadSuccess', function (file, response) {
                    console.log(response);
                    $('#' + file.id).parents(".upload-file").find("input:first").val(response.downloadUrl);
                    $('#' + file.id).addClass('upload-state-done');
                });

                uploader.on("uploadBeforeSend", function (object, data, header) {

                    $("#" + data.id).parents(".upload-file").find(".uploader-list").find(".exists-img").remove();
                })
            }

            function initUpload(uploadbtn, filecat) {
                var thumbnailWidth, thumbnailHeight = 80;
                // 初始化Web Uploader
                var uploader = WebUploader.create({

                    // 选完文件后，是否自动上传。
                    auto: true,
                    //需要将图片归集，所以需要设置为一条一条的上传
                    threads: 1,
                    // swf文件路径
                    swf: '//cdn.doctorm.cn/js/webuploader-0.1.5/Uploader.swf',

                    // 文件接收服务端。
                    server: '/upload/uploadFile',
                    formData: {
                        uploadCategory: filecat ? filecat : "gallery",
                        generateMD5: 'true'
                        //uploadFileSetId: $(uploadbtn).parents(".upload-file").find("[name='fileSetId']").val()
                    },
                    // 选择文件的按钮。可选。
                    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                    pick: uploadbtn,

                    // 只允许选择图片文件。
                    accept: {
                        title: 'Images',
                        extensions: 'gif,jpg,jpeg,bmp,png,app,apk',
                        mimeTypes: 'image/*'
                    },
                    thumb: {
                        width: 110,
                        height: 110,

                        // 图片质量，只有type为`image/jpeg`的时候才有效。
                        quality: 70,

                        // 是否允许放大，如果想要生成小图的时候不失真，此选项应该设置为false.
                        allowMagnify: true,

                        // 是否允许裁剪。
                        crop: true,

                        // 为空的话则保留原有图片格式。
                        // 否则强制转换成指定的类型。
                        type: 'image/jpeg'
                    }
                });

                var $list = $(uploadbtn).parent();
                // 当有文件添加进来的时候
                uploader.on('fileQueued', function (file) {
                    var $li = $(
                        '<div id="' + file.id + '" class="file-item thumbnail2">' +
                        '<img>' +
                        '<div class="info">' + file.name + '</div>' +
                        '</div>'
                        ),
                        $img = $li.find('img');

                    if ($list.hasClass("col-xs-12")) {
                        $li.addClass("col-xs-2").insertBefore(uploadbtn);
                    } else {
                        if ($list.children(".file-item").length > 0) {
                            $list.children(".file-item:first").remove();
                        }
                        $li.addClass("col-xs-6").insertBefore(uploadbtn);
                    }
                    // $list为容器jQuery实例
                    //$list.append($li);
                    // 创建缩略图
                    // 如果为非图片文件，可以不用调用此方法。
                    // thumbnailWidth x thumbnailHeight 为 100 x 100
                    uploader.makeThumb(file, function (error, src) {
                        if (error) {
                            $img.replaceWith('<span>不能预览</span>');
                            return;
                        }

                        $img.attr('src', src);
                    }, thumbnailWidth, thumbnailHeight);
                });


                // 文件上传过程中创建进度条实时显示。
                uploader.on('uploadProgress', function (file, percentage) {
                    var $li = $('#' + file.id),
                        $percent = $li.find('.progress span');

                    // 避免重复创建
                    if (!$percent.length) {
                        $percent = $('<p class="progress"><span></span></p>')
                            .appendTo($li)
                            .find('span');
                    }

                    $percent.css('width', percentage * 100 + '%');
                });


// 文件上传失败，显示上传出错。
                uploader.on('uploadError', function (file, reason) {
                    var $li = $('#' + file.id),
                        $error = $li.find('div.error');

                    // 避免重复创建
                    if (!$error.length) {
                        $error = $('<div class="error"></div>').appendTo($li);
                    }

                    $error.text('上传失败');
                });

// 完成上传完了，成功或者失败，先删除进度条。
                uploader.on('uploadComplete', function (file) {
                    $('#' + file.id).find('.progress').remove();
                });

                return uploader;
            }
        });
    </script>
</myjs>
</body>
</html>