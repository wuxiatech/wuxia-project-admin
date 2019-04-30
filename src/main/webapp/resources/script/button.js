	function makeInputInvalid(inputId) {
		$("#" + inputId).attr("disabled", "disabled");
		$("#" + inputId).val("提交中...");
	}

	function makeInputEffective(inputId, inputTitle) {
		$("#" + inputId).removeAttr("disabled");
		$("#" + inputId).val(inputTitle);
	}
	
	function makeInputInvalidObj(inputId,inputTitle) {
		inputId.attr("disabled", "disabled");
		inputId.html(inputTitle);
	}

	function makeInputEffectiveObj(inputId, inputTitle) {
		inputId.removeAttr("disabled");
		inputId.html(inputTitle);
	}