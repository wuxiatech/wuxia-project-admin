<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@include file="/WEB-INF/layouts_admin/taglibs.jsp"%>
<jsp:useBean id="random" class="java.util.Random" scope="application" />
<c:choose>
	<c:when test="${html ne null }">
		${ html}	
	</c:when>
	<c:otherwise>
		<a href="/service/article/directBuy?newsId=${newsVo.id }&author=${newsVo.author }&picUrl=${newsVo.picUrl }&title=${newsVo.title }&readCount=${newsVo.readCount }">	                   
 			<div style="font-size: 1em; line-height: 1.4; font-family: inherit; box-sizing: border-box; ">
				<div style="color:gray;text-align:center;padding: 5px">广告主福利</div>
				<div class="bor-b-1"> 
					<c:set var="funy">${random.nextInt(4) % 2 == 0 ? '2' : '1'}</c:set>    
					<img width="640" height="200" class="img-responsive lazy" src="${resources_ctx }/images/ad_buy0${funy }.jpg" alt="一元轻松做推广"/>							
				</div>		                       
			</div>
		</a>
	</c:otherwise>
</c:choose>

