<%@ page language="java" pageEncoding="UTF-8" %>
<!-- basic scripts -->
<!--[if IE]>
<script type="text/javascript">
window.jQuery || document.write("<script src='//ace.zjcdn.cn/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script src="//ace.zjcdn.cn/assets/js/ace-extra.min.js"></script>
<script type="text/javascript">
    try {
        ace.settings.check('main-container', 'fixed')
    } catch (e) {
    }
    $(".submenu", "#sidebar").each(function () {
        var submenuLength = $(this).children().length;
        if (submenuLength == 0) {
            $(this).parent("li").remove();
        }
    })
</script>


<script type="text/javascript">
    if ("ontouchend" in document)
        document
            .write("<script src='//ace.zjcdn.cn/assets/js/jquery.mobile.custom.min.js'>"
                + "<" + "/script>");
</script>
<script src="//ace.zjcdn.cn/assets/js/bootstrap.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/typeahead-bs2.min.js"></script>

<!-- page specific plugin scripts -->

<!--[if lte IE 8]>
<script src="//ace.zjcdn.cn/assets/js/excanvas.min.js"></script>
<![endif]-->

<script
        src="//ace.zjcdn.cn/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/chosen.jquery.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/fuelux/fuelux.spinner.min.js"></script>
<script
        src="//ace.zjcdn.cn/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script
        src="//ace.zjcdn.cn/assets/js/date-time/bootstrap-timepicker.min.js"></script>
<script
        src="//ace.zjcdn.cn/assets/js/date-time/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="//ace.zjcdn.cn/assets/js/date-time/locales/bootstrap-datetimepicker.zh-CN.js"
        charset="UTF-8"></script>
<script src="//ace.zjcdn.cn/assets/js/date-time/moment.min.js"></script>
<script
        src="//ace.zjcdn.cn/assets/js/date-time/daterangepicker.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/bootstrap-colorpicker.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/jquery.knob.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/jquery.autosize.min.js"></script>
<script
        src="//ace.zjcdn.cn/assets/js/jquery.inputlimiter.1.3.1.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/jquery.maskedinput.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/bootstrap-tag.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/bootbox.min.js"></script>
<!-- ace scripts -->

<script src="//ace.zjcdn.cn/assets/js/ace-elements.min.js"></script>
<script src="//ace.zjcdn.cn/assets/js/ace.min.js"></script>
<%@ include file="/WEB-INF/views/common/jquery-validation_ajaxform-js.jsp" %>
<!--[if lt IE 9]>
<script src="//17.zjcdn.cn/assets/plugins/sky-forms-pro/skyforms/js/sky-forms-ie8.js"></script>
<![endif]-->
<script src="/commons/js/common.js"></script>
<script type="text/javascript" src="/commons/js/custom.base.js"></script>