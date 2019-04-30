<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/taglibs.jsp"%>
<link rel="stylesheet" href="${resources_ctx }/js/dropzone/dropzone.css">
<link rel="stylesheet" href="${cdn_resources_ctx }/assets/css/pages/blog_masonry_3col.css">
<div id="uploadifyDiv">
	<button id="uploadPicShow" class="btn-u" data-toggle="modal" data-target="#responsive" style="display: none;">上传图片</button>
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="responsive">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
					<h4 class="modal-title">上传图片</h4>
				</div>
				<div class="col-xs-12">
					<div class="bg_f4 mt_10 mb_20 pt_5 pb_0 pl_10 pr_10">
						<section class="col col-5">
							<label class="select">
								<select id="groupSelect">
									<c:forEach items="${groupList }" var="group" varStatus="status">
										<option value="${group.id }" <c:if test="${status.count == 1 }">selected="selected"</c:if>>${group.groupName }</option>
									</c:forEach>
								</select> <i></i>
							</label>
						</section>
					</div>
				</div>
				<div class="col-xs-12">
					<div class="tab-v2">
						<ul class="nav nav-tabs">
							<li class="picType" data="gallery" style="display: none;"><a>素材库选取</a></li>
							<li class="active picType" data="local"><a>本地上传</a></li>
							<li class="picType" data="internet"><a>网络图片</a></li>
						</ul>
						<div class="tab-content mb_20">
							<div class="tab-pane fade" id="gallery"></div>
							<div class="tab-pane fade min_h_300 pt_50 pb_50 active in" id="local">
								<form class="dropzone dz-clickable tex_c " id="myUpload" enctype="multipart/form-data">
									<input type="hidden" name="groupId" class="group_code" id="groupId">
									<input type="hidden" name="uploadCategory" value="def">
									<div class="dz-default dz-message">
										<i class="fa fa-upload f_50 pb_15 color-grey cu-pot"></i>
										<p class="cu-pot">选择图片</p>
									</div>
								</form>
								<div class="clearfix"></div>
							</div>
							<div class="tab-pane fade min_h_300" id="internet">
								<div class="mt_10 mb_20">
									<div class="f_l pl_20 l_h_30 tex_r">网络图片：</div>
									<div class="col-md-9 pl_0 pr_0 ">
										<div class="input-group">
											<input type="text" class="form-control" placeholder="请输入图片链接" id="urlInput" autocomplete="off">
											<span class="input-group-btn">
												<button class="btn btn-danger" type="button" id="getButton" disabled="disabled">提取</button>
											</span>
										</div>
									</div>
									<div class="clearfix"></div>
								</div>
								<div class="mt_10 mb_20">
									<div class="f_l pl_20 l_h_30 tex_r">图片预览：</div>
									<div class="col-md-9 pt_10 min_h_200 tex_c" id="preview"></div>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xs-12 tex_c pb_10 mb_20">
						<button class="btn-u btn-twitter pl_30 pr_30" id="upload_picture_button" type="button" style="display: none;">上传</button>
						<button class="btn-u btn-twitter pl_30 pr_30" id="choose_picture_button" type="button">确定</button>
					</div>
				</div>
				<div class="clear-both"></div>
				<div id="hidePictureDiv" style="display: none;"></div>
			</div>
		</div>
	</div>
	</div>
	<script type="text/javascript" src="${resources_ctx }/js/dropzone/dropzone.min.js"> </script>
	<script type="text/javascript" src="/resources/script/plugin/picture/upload.plugin.js"></script> 
	<script type="text/javascript" src="${cdn_resources_ctx }/assets/plugins/masonry/jquery.masonry.min.js"></script>
	<script type="text/javascript">
		(function($) {
			jQuery.fn.opengallery = function(options) {
				options = jQuery.extend({
					needgallery : true,
					groupId : "",
					maxFiles : 100,
					logo : false,
				}, options || {})
				
				var logo="";
				var uploadId = "myUpload_"+this.attr("id");
				var divId = "div_pic_";
				divId += this.attr("id");
				var select = "#"+divId;
				//当前id元素未绑定
				if($(select).length==0){
					$div = $("<div id='"+divId+"'>").append($("#uploadifyDiv").html()).appendTo("body");
					//$("#uploadifyDiv").remove();
					$div.find("#uploadPicShow").attr("data-target","#responsive_"+this.attr("id"));
					$div.find("#responsive").attr("id","responsive_"+this.attr("id"));
					$div.find("#myUpload").attr("id",uploadId);
					
					//绑定本地上传图片插件
					$("#"+uploadId).uploadFile({
						uploadButton : select+" #upload_picture_button",
						maxFiles : options.maxFiles,
						callback : function(data) {
							options.callback(data);
							$(select+" button.close").click();
						}
					});
					
					//绑定素材库选择事件
					$("#gallery", select).on("click",".pic_choose_a",function() {
						var ok = $(this).find(".pic_choose_ok");
						var length = $(".pic_choose_ok:visible", select).length;
						//判断是否已经选择
						if (ok.is(":hidden")) {
							//判断是否是多选
							if (options.maxFiles == 1) {
								$(" .pic_choose_ok", select).hide();
								ok.show();
							} else {
								if(length < options.maxFiles) {
									ok.show();
								}else {
									msgWarn("最多只能选择"+options.maxFiles+"张图片");
								}
							}
						} else {
							ok.hide();
						}
					});
				
				//点击“获取”按钮
				$("#getButton", select).click(function() {
					var $img = $("<img>").addClass("w_300").attr("src", $("#urlInput", select).val());
					$("#preview",select).html($img);
				});
				
				//网络图片输入地址的键盘事件
				$("#urlInput", select).keyup(function() {
					if($(this).val() == 0) {
						$("#getButton", select).attr("disabled","disabled");
					}else {
						$("#getButton", select).removeAttr("disabled");
					}
				});
				
				//有图库分组id传进来时
				if(isNotBlank(options.groupId)) {
					$("#groupSelect", select).val(options.groupId);
				}

				//判断是否需要“默认头像”分组
				if(options.logo) {
					logo = "true";
				}else {
					$("#groupSelect", select).find("option[value='2']").remove();
				}
				
				//判断是否需要显示图库中的图片
				if (options.needgallery) {
					//查找图库中的素材图片
					queryGallery();
					$("#groupSelect", select).change(queryGallery);
					var active = $(".picType.active", select);
					
					//当前选中不为素材库时，自动选中为素材库
					if(active.attr("data") != "gallery") {
						active.removeClass("active");
						active.prev().addClass("active in");
						active.prev().removeAttr("style");
						$("#local", select).removeClass("active in");
						$("#gallery", select).addClass("active in");
					}
					
					

					//分页
					$("#gallery", select).on("click", ".pagination a[href_1]", function() {
							var href = $(this).attr("href_1");
							$.ajax({
								url : href,
								success : function(response) {
									$("#groupId",select).val($("#groupSelect", select).val());
									$("#gallery", select).html(response);
									masonry();
								}
							});
						});
				
				}
				
				//点击标签
				$(".picType", select).click(function() {
					var data = $(this).attr("data");
					$(".picType.active",select).removeClass("active");
					$(".tab-pane.active.in",select).removeClass("active in");
					$("#" + data, select).addClass("active in");
					$(this).addClass("active");
					if (data == "gallery") {
						$(".grid-boxes", select).masonry("reload");
						//当显示“默认头像”分组时，点击素材库时将其显示
						if(options.logo) {
							$("#groupSelect", select).find("option[value='2']").show();
						}
					}else {
						//当显示“默认头像”分组时，不是点击素材库时将其隐藏，当前选中时则自动选择“默认分组”
						if(options.logo) {
							$("#groupSelect",select).find("option[value='2']").hide();
							if($("#groupSelect",select).val() == "2") {
								$("#groupSelect",select).val("1");
								$("#groupSelect",select).change();
							}
						}
					}
				});

				//点击“选择”按钮
				$("#choose_picture_button", select).click(function() {
					var type = $(".picType.active", select).attr("data");
					//获取图库图片
					if (type == "gallery") {
						if($(select+" .pic_choose_ok:visible").length == 0) {
							msgWarn("请选择图片");
							return;
						}
						var picdata = [];
						$(select+" .pic_choose_ok:visible").each(function(s, e) {
							var selectedpicdata = {};
							selectedpicdata.downloadUrl = $(e).attr("data-src");
							selectedpicdata.newFileName = $(e).attr("data-name");
							selectedpicdata.uploadFileInfoId = $(e).attr("data-id");
							picdata.push(selectedpicdata);
						});
						options.callback(picdata);
						$(select+" button.close").click();
						$(".pic_choose_ok").hide();
					}
					//获取网络图片
					else if (type == "internet") {
						if (typeof ($(select+" #preview img").attr("src")) == "undefined") {
							msgWarn('请输入图片路径后点击"提取"');
							return;
						}
						$.ajax({
							url : "/plugin/pic/internetUpload",
							type : "GET",
							async : false,
							data : {
								httpUrl : $(select+" #preview img").attr("src"),
								group : $(select+" #groupSelect").val()
							},
							success : function(data) {
								var picdata = [];
								picdata.push(data);
								options.callback(picdata);
								$(select+" button.close").click();
							},
							error : function() {
								msgWarn("请输入正确的图片路径");
							}
						});
					}
					//获取本地上传图片
					else if (type == "local") {
						$(select+" #groupId").val($(select+" #groupSelect").val());
						$(select+" #upload_picture_button").click();
					}
				});
	
				}			
				//弹出窗口
				$(this).click(function() {
					$(select+" #uploadPicShow").click();
					if (options.needgallery) {
						setTimeout(function() {
							$(select+" .picType.active").click();
						}, 150);
					}
				})

				//查找图库图片
				function queryGallery() {
					$.ajax({
						url : "/plugin/pic/queryGallery",
						type : "GET",
						data : {
							group : $("#groupSelect", select).val(),
							defaultLogo : logo
						},
						success : function(response) {
							$("#groupId", select).val($(select+" #groupSelect").val());
							$("#gallery", select).html(response);
							masonry();
						}
					});
				}
				
				function masonry() {
					var $container = $(".grid-boxes", select);
					var gutter = 10;
					var min_width = 100;
					$container.imagesLoaded(function() {
						$container.masonry({
							itemSelector : ".grid-boxes-in",
							gutterWidth : gutter,
							isAnimated : true,
							columnWidth : function(containerWidth) {
								var box_width = (((containerWidth - 3 * gutter) / 4) | 0);
			
								if (box_width < min_width) {
									box_width = (((containerWidth - gutter) / 2) | 0);
								}
			
								if (box_width < min_width) {
									box_width = containerWidth;
								}
			
								$(".grid-boxes-in", select).width(box_width);
								return box_width;
							}
						});
					});
				}
			}
		})(jQuery);
	</script>
