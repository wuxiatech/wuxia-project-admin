<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html id="ls-global" lang="en">
<!--<![endif]-->
<head>
    <title>${userInfo.realName}个人资料</title>
    <style>
        .sky-form .tooltip {
            background: #5599FF none repeat scroll 0 0;
            color: #fff;
            font-size: 11px;
            font-weight: 400;
            left: -9999px;
            line-height: 16px;
            opacity: 0;
            padding: 2px 8px 3px;
            position: absolute;
            transition: margin 0.3s ease 0s, opacity 0.3s ease 0s;
            z-index: 1;
        }
    </style>
</head>

<body>

<div class="row">
    <!-- Begin Content -->
    <div class="col-md-12">

        <!-- Tabs -->
        <div class="tab-v1 margin-bottom-60">
            <ul class="nav nav-tabs" style="padding:0; width:100%">
                <li class="active"><a href="#profile-1" data-toggle="tab" aria-expanded="false">个人资料</a></li>
                <li class=""><a href="#password-1" data-toggle="tab" aria-expanded="false">修改密码</a></li>
                <li class=""><a href="#logo-1" data-toggle="tab" aria-expanded="false">头像</a></li>
            </ul>

            <div class="tab-content">

                <!-- Tooltips -->
                <div id="profile-1" class="tab-pane fade active in">
                    <form class="sky-form" action="/admin/user/save" method="post">
                        <input type="hidden" value="${userInfo.id }" name="id"/>

                        <fieldset>
                            <section>
                                <label class="label">姓名</label> <label class="input">
                                <i class="icon-append fa fa-question-circle"></i>
                                <input name="realName" type="text" placeholder="请填写真实姓名"
                                       value="<c:if test="${userInfo.realName ne null }">${userInfo.realName }</c:if>">
                            </label>
                            </section>
                            <section>
                                <label class="label">手机</label> <label class="input">
                                <i class="icon-append fa fa-question-circle"></i>
                                <input id="oldmobile" type="hidden"
                                       value="<c:if test="${userInfo.mobile ne null }">${userInfo.mobile }</c:if>">
                                <input name="mobile" id="mobile" type="text" placeholder="请填写您的手机号码（作为账号登录）"
                                       value="<c:if test="${userInfo.mobile ne null }">${userInfo.mobile }</c:if>">
                            </label>
                            </section>
                            <section>
                                <label class="label">职称</label> <label class="input">
                                <i class="icon-append fa fa-question-circle"></i>
                                <input name="title" type="text" placeholder="请填写您的职称（如：经理 | 教授）"
                                       value="<c:if test="${userInfo.title ne null }">${userInfo.title }</c:if>">
                            </label>
                            </section>
                            <section>
                                <label class="label">部门</label> <label class="input">
                                <i class="icon-append fa fa-question-circle"></i>
                                <select id="departmentId" name="departmentId"  >
                                    <option value="">--请选择部门--</option>
                                    <c:forEach items="${depts}" var="dept">
                                        <option value="${dept.id}" <c:if test="${userInfo.departmentId == dept.id }">selected</c:if>>${dept.departmentName}</option>
                                    </c:forEach>
                                </select>
                            </label>
                            </section>
                            <section>
                                <label class="label">权重（1-1000）</label> <label class="input">
                                <i class="icon-append fa fa-question-circle"></i>
                                <input name="order_" type="text" placeholder="越小权重越大，请保留一定的数字间隔"
                                       value="<c:if test="${userInfo.order_ ne null }">${userInfo.order_ }</c:if><c:if test="${userInfo.order_ eq null }">1000</c:if>">
                            </label>
                            </section>
                        </fieldset>

                        <fieldset>
                            <section>
                                <label class="label">个人简介</label> <label class="textarea">
                                <i class="icon-append fa fa-question-circle"></i>
                                <textarea name="description" placeholder="让患者更加了解并信任您" rows="3"><c:if
                                        test="${userInfo.description ne null }">${userInfo.description }</c:if></textarea>
                            </label>
                            </section>

                        </fieldset>

                        <footer>
                            <button id="submit_Form" class="btn-u btn btn-primary"
                                    style="background: #5599FF none repeat scroll 0 0;"
                                    type="submit">提交
                            </button>
                            <button onclick="window.history.back();"
                                    class="btn-u btn-u-default btn" type="button">返回
                            </button>
                            <p id="remind" style="display:inline;margin-left:10px;color:red;"></p>
                        </footer>
                    </form>
                </div>
                <div id="password-1" class="tab-pane fade in">
                    <form class="sky-form" action="/admin/user/changepw" method="post">

                        <input type="hidden" value="${userInfo.id }" name="id"/>


                        <fieldset>
                            <c:if test="${userDetail.uid == userInfo.id }">
                                <section>
                                    <label class="label">原密码</label> <label class="input">
                                    <i class="icon-append fa fa-question-circle"></i>
                                    <input name="oldpassword" type="password" placeholder="请填写原密码">
                                </label>
                                </section>
                            </c:if>
                            <section>
                                <label class="label">新密码</label> <label class="input">
                                <i class="icon-append fa fa-question-circle"></i>
                                <input name="password" id="password" type="password" placeholder="请填写新密码">
                            </label>
                            </section>

                            <section>
                                <label class="label">再次输入新密码</label> <label class="input">
                                <i class="icon-append fa fa-question-circle"></i>
                                <input name="repassword" type="password" placeholder="请再次输入新密码">
                            </label>
                            </section>

                        </fieldset>


                        <footer>
                            <button class="btn-u btn btn-primary"
                                    style="background: #5599FF none repeat scroll 0 0;"
                                    type="submit">提交
                            </button>
                            <button onclick="window.history.back();"
                                    class="btn-u btn-u-default btn" type="button">返回
                            </button>
                            <p id="remind" style="display:inline;margin-left:10px;color:red;"></p>
                        </footer>
                    </form>
                </div>

                <div id="logo-1" class="tab-pane fade  in">
                    <div id="dropzone">
                       <form class="sky-form" action="/admin/user/save" method="post"  <%--enctype="multipart/form-data"--%>>
                            <input type="hidden" value="${userInfo.id }" name="id"/>
                            <fieldset>
                                <section>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <label class="label"> <span
                                                    class="color-red f_18 f_l mt_5 mr_5">*</span> 头像Logo <span
                                                    class="color99">（大图片建议尺寸：400像素 * 400像素）</span>
                                            </label>
                                        </div>
                                        <div class="col-md-7 dropzone">
                                            <%--<input id="uploadPic" multiple="" type="file"/>--%>
                                                <button id="uploadPic"
                                                        style="background: #5599FF none repeat scroll 0 0;"
                                                        class="btn-u btn btn-success" type="button">上传头像</button>
                                        </div>
                                    </div>
                                    <div id="pictureDiv" class="img_max_h_180 img_max_w_180 of_h">
                                        <c:set var="logo">${ifn:filepath(userInfo.logo) }</c:set>
                                        <c:if test="${ not empty logo && logo != ''}">
                                            <img alt="" id="pic" src="${logo }?x-oss-process=image/resize,w_200"/>
                                        </c:if>
                                        <c:if test="${empty logo }">
                                            <img alt="" id="pic"/></c:if>
                                        <input type="hidden" name="logo"
                                               value="<c:if test="${userInfo.logo ne null }">${userInfo.logo }</c:if>"/>
                                    </div>
                                    <label id="picError" class="input state-error"
                                           style="display: none;"> <em class="invalid">请上传图片</em>
                                    </label>
                                    <!-- <div class="mb_15">
                                <label class="checkbox">
                                    <input type="checkbox">
                                    <i></i> 封面图片显示在正文中
                                </label>
                            </div> -->
                                </section>
                            </fieldset>


                            <footer>
                                <button class="btn-u btn btn-primary" id="imgSubmit"
                                        style="background: #5599FF none repeat scroll 0 0;"
                                        type="submit">提交
                                </button>
                                <button onclick="window.history.back();"
                                        class="btn-u btn-u-default btn" type="button">返回
                                </button>
                            </footer>
                        </form>
                    </div>
                </div>

                <!-- End Tooltips -->
            </div>
        </div>
        <!-- End Tabs -->
    </div>
    <!-- End Content -->
</div>

<myjs>
    <%@include file="/WEB-INF/views/common/uploadify.jsp"%>
    <%--<script src="http://ace.zjcdn.cn/assets/js/dropzone.min.js"></script>--%>
    <script type="text/javascript" src="/resources/script/base.js"></script>
    <script type="text/javascript" src="/resources/script/profile/editForm.js"></script>
    <script type="text/javascript" src="/resources/script/profile/edit.js"></script>
    <script type="text/javascript" src="/commons/js/common.js"></script>
    <script
            type="text/javascript">
        $(function () {
            //点击上传图片

            $("#uploadPic").uploadFile({
                data:{uploadCategory: 'logo'},
                callback : function(obj, data) {
                    $("#pic").prop("src", data.downloadUrl+"?x-oss-process=image/resize,w_200");

                    $("#picError").hide();
                    $("[name='logo']").val(data.uploadFileInfoId);

                }
            });


            //随便校验
            /*$("#submit_Form").click(function() {
                var picUrl = $("[name='logo']").val();
                var displayName = $("[name='realName']").val();
                var professional = $("[name='title']").val();
                //var description = $("[name='vo.description']").val();
                if(null == picUrl || "" == picUrl) {
                    $("#remind").html("请上传图片");
                    return false;
                }
                if(null == displayName || "" == displayName) {
                    $("#remind").html("请填写真实姓名");
                    return false;
                }
                if(null == professional || "" == professional) {
                    $("#remind").html("请填写职称信息");
                    return false;
                }*/
            /*if(null == description || "" == description) {
                $("#remind").html("请填写简介");
                return false;
            }*/
            //});



            $("#logo-1 form").submit(function () {

                $(this).ajaxSubmit({
                    success: function (d) {
                        alert("修改成功");
                    }, error(t) {
                        alert(t.responseText);
                    }
                });
                return false;
            })
        });
    </script>
</myjs>

</body>