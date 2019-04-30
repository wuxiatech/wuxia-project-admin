<%@ page pageEncoding="UTF-8"%>
<div id="show_message_model_1" style="display: none;">
	<button data-target=".bs-example-modal-sm" data-toggle="modal" class="btn-u" id="showMessageButton" style="display: none;"></button>
	<div id="show_message_div" aria-hidden="false" aria-labelledby="mySmallModalLabel" role="dialog" tabindex="-1" class="modal fade bs-example-modal-sm in"
		style="display: none;">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button id="show_message_close" type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h3 class="modal-title" id="show_message_title"></h3>
				</div>
				<div class="modal-body" id="show_message_text"></div>
				<div class="modal-footer" id="">
					<button class="btn-u btn-u-primary" type="button" id="show_message_ok">确定</button>
					<button data-dismiss="modal" class="btn-u btn-u-default" type="button">取消</button>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="show_message_model_2" style="display: none;">
	<div style="width:400px; position:fixed; left:50%; margin-left:-200px;z-index:9999;" class="alert fade in model_2">
		<div class="col-xs-12 text_c mb_15">
			<i class=""></i>
		</div>
		<div class="col-xs-12 text_c" id="alert_message_text"></div>
	</div>
</div>
