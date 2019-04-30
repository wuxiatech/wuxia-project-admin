<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/taglibs.jsp"%>
<div class="blog_masonry_3col">
	<div id="masonry" class="grid-boxes col-md-12 pr_0 pl_0">
		<c:forEach items="${pages.result }" var="page" varStatus="vs">
			<a class="pic_choose_a">
				<div class="grid-boxes-in of_h">
					<div class="easy-bg-v2 rgba-default pic_choose_ok" style="display: none;" data-id="${page.fileId }"
						data-src="${download_ctx}/${page.location}" data-name="${page.originalName }">已选择</div>
					<img class="img-responsive" style="width: 200px; height: 150px;" src="${download_ctx}/${page.location}?x-oss-process=image/resize,m_fixed,h_200,w_150" alt="">
					<div class="grid-boxes-caption">
						<label class=""> <c:if test="${empty page.originalName }">默认图片${vs.index+1 }</c:if> <c:if
								test="${not empty page.originalName }">${page.originalName }</c:if>
						</label>
					</div>
				</div>
			</a>
		</c:forEach>
	</div>
</div>
<div class="clear-both"></div>
<tags:page currUrl="${currentUrl }" pageVo="${pages }" isJumpByJs="true"></tags:page>
