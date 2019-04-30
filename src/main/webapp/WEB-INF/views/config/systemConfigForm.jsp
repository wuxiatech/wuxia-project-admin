<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/taglibs.jsp"%>

<c:set var="dataId">${empty systemConfig.id?0:systemConfig.id}</c:set>
<c:set var="title">
	<c:choose>
		<c:when test="${empty systemConfig.id}">新增配置信息</c:when>
		<c:otherwise>
			查看配置信息-${systemConfig.id}
		</c:otherwise>
	</c:choose>
</c:set>
<html>
	<head>
		<title>${title}</title>
        <link rel="stylesheet" href="${resources_ctx}/assets/plugins/sky-forms-pro/skyforms/css/sky-forms.css">
        <link rel="stylesheet" href="${resources_ctx}/assets/plugins/sky-forms-pro/skyforms/custom/custom-sky-forms.css">
	</head>
	<body>
		<!-- start content -->
        <form action="${ctx}/config/systemConfig/save" method="post"
			  id="systemConfigForm" class="sky-form" novalidate="novalidate">
            <input type="hidden" name="id" value="${systemConfig.id}"/>
            <header>${title}</header>

			<!-- 根据表字段生成表单内容 -->
            <fieldset>

				<div class="row">
								<section class="col col-6">
									<label class="label">主键<span class="signicon">*</span>
									</label>
									<label class="input">
										<input type="text"  name="configId" value="${systemConfig.configId}"  maxlength="10" />
										<b class="tooltip tooltip-left">输入主键</b>
									</label>
								</section>
							<section class="col col-6">
									<label class="label">值内容<span class="signicon">*</span>
									</label>
									<label class="input">
										<input type="text"  name="configValue" value="${systemConfig.configValue}"  maxlength="200" />
										<b class="tooltip tooltip-left">输入值内容</b>
									</label>
								</section>
							</div>

							<div class="row">
								<section class="col col-6">
									<label class="label">配置类型名<span class="signicon">*</span>
									</label>
									<label class="input">
										<input type="text"  name="configType" value="${systemConfig.configType}"  maxlength="200" />
										<b class="tooltip tooltip-left">输入配置类型名</b>
									</label>
								</section>
							<section class="col col-6">
									<label class="label">描述</label>
									<label class="input">
										<input type="text"  name="describe" value="${systemConfig.describe}"  maxlength="255" />
										<b class="tooltip tooltip-left">输入描述</b>
									</label>
								</section>
							</div>

							<div class="row">
								<section class="col col-6">
									<label class="label">排序</label>
									<label class="input">
										<input type="text"  name="ordinalNum" value="${systemConfig.ordinalNum}"  maxlength="7" />
										<b class="tooltip tooltip-left">输入排序</b>
									</label>
								</section>
							<section class="col col-6">
									<label class="label">状态<span class="signicon">*</span>
									</label>
									<label class="input">
										<input type="text"  name="status" value="${systemConfig.status}"  maxlength="1" />
										<b class="tooltip tooltip-left">输入状态</b>
									</label>
								</section>
							</div>

							<div class="row">
								</div>
							

			</fieldset>

            <footer>
                <button type="submit" class="btn-u">保存</button>
                <a type="button" class="btn-u btn-u-default" href="${ctx}/config/systemConfig/list">返回</a>
            </footer>
		</form>
		<!-- myjs 可以将此模板的 JavaScript 到装饰器的 body 之前-->
		<myjs>
            <script type="text/javascript" src="//ace.zjcdn.cn/assets/js/spin.min.js"></script>
            <script type="text/javascript" src="/resources/script/plugin/spin.config.js"></script>
			<script type="text/javascript" src="/resources/script/config/systemConfigForm.js"></script>
            <script type="text/javascript">
                jQuery(document).ready(function() {
						systemConfigForm.initForm();
                });
            </script>
            <script src="${resources_ctx}/assets/plugins/sky-forms-pro/skyforms/js/jquery.maskedinput.min.js"></script>
            <script src="${resources_ctx}/assets/plugins/sky-forms-pro/skyforms/js/jquery-ui.min.js"></script>
            <!--[if lt IE 9]>
			<script src="${resources_ctx}/assets/plugins/sky-forms-pro/skyforms/js/sky-forms-ie8.js"></script>
            <![endif]-->
		</myjs>
	</body>
</html>