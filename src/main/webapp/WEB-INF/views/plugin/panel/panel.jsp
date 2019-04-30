<%@ page pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${cdn_resources_ctx }/assets/css/pages/blog_masonry_3col.css">
<div id="panel_model">
	<button data-target="#show_panel" data-toggle="modal" class="btn-u" id="showPanelButton" style="display: none;"></button>
	<div id="show_panel" aria-hidden="false" aria-labelledby="showPanelLabel" role="dialog" tabindex="-1" class="modal fade in" style="display: none;">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button id="panel_close" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="panel_title"></h4>
				</div>
				<div class="modal-body" id="panel_body_div"></div>
				<div id="errorDiv" class="alert alert-warning" style="display: none;">
					<em class="invalid">请选择图文</em>
				</div>
				<div class="modal-footer tex_c">
					<button class="btn-u" id="choose_ok">确定</button>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="${cdn_resources_ctx }/assets/plugins/masonry/jquery.masonry.min.js"></script>
<script type="text/javascript">
	(function($) {
		jQuery.fn.panel = function(options) {
			options = jQuery.extend({
				url : "",
				type : "",
				data : {},
				title : "",
				isMulti : true,
				success : function(data) {
					return false;
				}
			}, options || {});

				var divId = "div_panel_";
				divId += this.attr("id");
				var select = "#"+divId;
				$div = $("<div id='"+divId+"'>").append($("#panel_model").html()).appendTo("body");
				$div.find("#showPanelButton").attr("data-target","#show_panel_"+this.attr("id"));
				$div.find("#show_panel").attr("id","show_panel_"+this.attr("id"));
				//$div.find("#myUpload").attr("id",uploadId);

			//点击功能
			$(this).click(function() {
				var url = options.url;
				if (url.length > 0) {
					$.ajax({
						url : url,
						type : options.type,
						data : options.data,
						success : function(data) {
							$(select+" #panel_body_div").html(data);
							$(select+" #showPanelButton").click();
							setTimeout(function() {
								$(select+" .panel").masonry("reload");
							}, 150);
						}
					});
				}
			});

			//选择功能
			$(select+" #panel_body_div").on("click", ".choose_a", function() {
				$(select+" #errorDiv").hide();
				var ok = $(this).find(".choose_ok");
				//判断是否已经选择
				if (ok.is(":hidden")) {
					//判断是否是多选
					if (options.isMulti) {
						ok.show();
					} else {
						$(select+" .choose_ok").hide();
						ok.show();
					}
				} else {
					ok.hide();
				}
			});

			//确定功能
			$(select+" #choose_ok").click(function() {
				if ($(select+" .choose_ok").not(":hidden").length == 0) {
					$(select+" #errorDiv").show();
					return;
				}
				var datas = [];
				var objs = [];
				//所有选择的图文
				$(select+" .choose_ok").not(":hidden").each(function() {
					var a = $(this).parents(".choose_a");
					//多图文下的每个图文
					a.find(".choose_data").each(function() {
						var data = $(this).text();
						var json = eval("(" + data + ")");
						datas.push(json);
					});
					$(this).remove();
					var obj = a.find(".grid-boxes-in").removeAttr("style");
					objs.push(obj);
				});
				options.success(datas, objs);
				$(select+" #panel_close").click();
			});

			//分页
			$("[href_1]", select+" .pagination").live("click", function() {
				var href = $(this).attr("href_1");
				$.ajax({
					url : href,
					success : function(response) {
						$(select+" #panel_body_div").html(response);
					}
				});
			});
		}
	})(jQuery)
</script>
