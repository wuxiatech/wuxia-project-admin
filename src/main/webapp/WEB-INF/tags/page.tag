<%@ tag pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/project/functions" prefix="ifn"%>
<%@ attribute name="pageVo" type="cn.wuxia.common.orm.query.Pages" rtexprvalue="true" required="true" description="要显示的数据集合" %>
<%@ attribute name="currUrl" type="java.lang.String"  required="true" description="当前web的地址，由于不能取到controller映射地址，所以必须输入" %>
<%@ attribute name="isJumpByJs" type="java.lang.Boolean" required="false" description="是不是需要js控制" %>
<%@ attribute name="clazzStyle" type="java.lang.String" required="false" description="改变样式" %>

<c:if test='${not fn:contains(currUrl,"?")}'><c:set var="currUrl">${currUrl}?</c:set></c:if>
<c:if test='${fn:contains(currUrl,"pageNo")}'>
	<c:set var="currUrl">
		${ifn:replace(currUrl,'pageNo=\\d+', '') }
	</c:set>
</c:if>
<c:if test='${fn:contains(currUrl,"pageSize")}'>
	<c:set var="currUrl">
		${ifn:replace(currUrl,'pageSize=\\d+', '') }
	</c:set>
</c:if>
<c:set var="hrefTag"><c:if test='${isJumpByJs}'>data-href</c:if><c:if test='${not isJumpByJs}'>href</c:if></c:set>
<%--分页 --%>

<c:set var="pageclazz"><c:if test='${empty clazzStyle}'>pagination</c:if><c:if test='${not clazzStyle}'>${clazzStyle }</c:if></c:set>
<div class="text-center pl_0 pr_0">
	<ul class="${pageclazz }" data-currurl="${currUrl}&pageNo=${pageVo.pageNo}&pageSize=${pageVo.pageSize}">
		<li><a class="ibm_info">当前 ${pageVo.pageNo}/${pageVo.totalPages}页 共${pageVo.totalCount }条
			&nbsp;</a></li><li> <a id="firstPage" title="第一页"
								   class="ibm_first" data-page="1"
		<c:if test="${ pageVo.isHasPre() }">
			${hrefTag}="${currUrl}&pageNo=1&pageSize=${pageVo.pageSize}"
		</c:if>>«
		第一页</a></li><li> <a title="上一页" class="previous" data-page="1"
							id="prePage"
		<c:if test="${ pageVo.isHasPre() }">
			${hrefTag}="${currUrl}&pageNo=${pageVo.getPrePage() }&pageSize=${pageVo.pageSize}"
		</c:if>>«
		上一页</a></li>
		<c:if test="${ pageVo.getTotalPages() > 4 }">
			<c:set var="begin" value="1" />
			<c:if test="${(pageVo.pageNo - 3) > 0 }" >
				<c:set var="begin" value="${pageVo.pageNo - 2}" />
			</c:if>
			<c:if test="${begin ==1 }">
				<c:set var="end" value="${pageVo.pageNo + 3 }" />
			</c:if>
			<c:if test="${begin !=1 }">
				<c:set var="end" value="${pageVo.pageNo}" />
			</c:if>
			<c:if test="${end > pageVo.getTotalPages() }" >
				<c:set var="end" value="${pageVo.getTotalPages() }" />
			</c:if>
			<%-- <c:if test="${ begin > 2}">
                <a class="more">...</a>
            </c:if> --%>
			<c:forEach begin="${begin}" end="${ end}" varStatus="status">
				<li><a <c:if test="${pageVo.pageNo == status.index }">class='hover'</c:if>
						${hrefTag}="${currUrl}&pageNo=${status.index }&pageSize=${pageVo.pageSize}">${status.index}</a></li>
			</c:forEach>
			<c:if test="${ (pageVo.getTotalPages() - end) > 2}">
				<li><a class="more">...</a></li>
			</c:if>
		</c:if>
		<li><a title="下一页" class="disabled" data-page="1" id="nextPage"
			<c:if test="${ pageVo.isHasNext() }">
				${hrefTag}="${currUrl}&pageNo=${pageVo.getNextPage() }&pageSize=${pageVo.pageSize}"
			</c:if>>下一页
			»</a></li><li> <a title="最后一页" class="last"
							  data-page="-1" id="lastPage"
		<c:if test="${ pageVo.isHasNext() }">
			${hrefTag}="${currUrl}&pageNo=${pageVo.getTotalPages() }&pageSize=${pageVo.pageSize}"
		</c:if>>最后一页
		»</a></li>

		<li>
		<span style="color: #777; padding: 0px 5px;" class="last">

		<c:set var="pageIndexs">10,15,20,25,30,50,100,500,1000</c:set>
		每页
		<select class="pageSizeSelect">
			<c:forTokens items="${pageIndexs}" delims="," var="indexItem">
				<option value="${indexItem}" <c:if test="${pageVo.pageSize == indexItem}"> selected="selected"</c:if>  >${indexItem}</option>
			</c:forTokens>
		</select>
		条
		</span>
		</li>
	</ul>
	<c:if test='${not isJumpByJs}'>

			<script type="text/javascript">
                $(function () {
                    $(".pagination").off("change").on("change", "select.pageSizeSelect", function () {
                        var pageSize=$(this).val();
                        var currurl = $(this).parents(".pagination:first").data("currurl");
                        var oldHref=changeUrlArg(currurl,'pageSize',pageSize);
                        oldHref=changeUrlArg(oldHref,'pageNo',1);
                        window.location.href=oldHref;
                    });
                    /**
                     * 用于替换参数值
                     * @param url
                     * @param arg
                     * @param val
                     * @returns {string}
                     */
                    function changeUrlArg(url, arg, val){
                        var pattern = arg+'=([^&]*)';
                        var replaceText = arg+'='+val;
                        return url.match(pattern) ? url.replace(eval('/('+ arg+'=)([^&]*)/gi'), replaceText) : (url.match('[\?]') ? url+'&'+replaceText : url+'?'+replaceText);
                    }
                });
			</script>

	</c:if>
</div>