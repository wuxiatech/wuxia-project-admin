$(function() {
			
	var url;
	
	/**
	 *  初始化年月日控件的value
	 */
/*	var objD = new Date();
	var MM = objD.getMonth()+1;  
	if(MM<10) MM = '0' + MM;  
	var dd = objD.getDate();  
	if(dd<10) dd = '0' + dd;  
	var hh = objD.getHours();  
	if(hh<10) hh = '0' + hh;  
	var mm = objD.getMinutes(); 
	if(mm<10) mm = '0' + mm;
	$(".datepicker").val(objD.getFullYear()+'-'+MM+'-'+dd);*/
	
	/**
	 *  validate
	 */
	var valid = jQuery("#main_form").validate({
	         submitHandler: function(form){
	        
	                $(form).ajaxSubmit({
	                    beforeSend: function(){
	                    	
	                    },
	                    success: function(rts){
	                    	afterSubmit(rts);
	                    },
	                    error:	function(){
	                    	alert("本次编辑保存失败，无法跳转!");
	                    }
	                });
	            }
	});
	
	var readOnly = $("[name='readOnly']").val();
	var node =  $("li.current", ".buy-process-bar");
	$("[name='nodeId']").val(node.data("nodeid"));
	$("title").text(node.data("nodename"));
	
	var clickType;
	var hasPrev = $("li.current", ".buy-process-bar").prev("li");
	if(hasPrev.length > 0){
		$("#prev_action").removeClass("hide").click(function(){
			var redirect = $(this).data("action") + "?followCode="+$("[name='followCode']").val();
			if(readOnly == 'true'){
				location.href=redirect;
			} else if(confirm("上一步将不保存当页资料，如已修改请先保存当页，确定上一步吗？")){
				location.href=redirect;
			}
		});
	}
	var hasNext = $("li.current", ".buy-process-bar").next("li");
	if(hasNext.length > 0){
		$("#next_action").removeClass("hide").click(function(){
			var redirect = $(this).data("action") + "?followCode="+$("[name='followCode']").val();
			if(readOnly == 'true'){
				location.href=redirect;
			} else if(confirm("下一步将不保存当页资料，如已修改请先保存当页，确定下一步吗？")){
				location.href=redirect;
			}
		});

	}
		

	/**
	 * 病人资料不明则不能完成随访
	 */
	var patientId = $("[name='patientId']").val();
	//只读不提交表单
	if(readOnly == 'false' ){
		if(hasNext.length == 0 && patientId != ''){
			$("#finish_action").removeClass("hide").click(function(){
				clickType = $(this).prop("id");
				$("form").append("<input type=\"hidden\" name=\"followStatus\" value=\"Done\">");
				url=$(this).data("action");			
				$("form").submit();			
			});
		}
		if(hasNext.length > 0){				
			$("#save_and_next_action").removeClass("hide").click(function(){
				clickType = $(this).prop("id");
				url=$(this).data("action") + "?followCode="+$("[name='followCode']").val();
				$("form").submit();	
			});
		}
		$("#save_action").removeClass("hide").click(function(){	
			$("form").submit();		
		});
	}
	$("#back_action").click(function(){
		var redirect = $(this).data("action");
		if(readOnly == 'true'){
			location.href=redirect;
		} else if(confirm("返回列表将不保存当页资料，如已修改请先保存当页，确定返回列表吗？")){
			location.href=redirect;
		}
	});
	
	function afterSubmit(status){
		if(status == 'success' && (clickType == 'save_and_next_action' || clickType == 'finish_action')){
			location.href = url;
		}else{
			alert("保存成功");
		}
	}
	
});