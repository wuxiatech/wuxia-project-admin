<%@ page language="java" pageEncoding="UTF-8"%>
<!-- start message -->
<%@page import="cn.wuxia.common.spring.mvc.MessageInterceptor"%>
<%@page import="javax.validation.MessageInterpolator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="cn.wuxia.common.spring.support.Msg"%>
<%@ page import="java.util.List"%>
<%@ include file="/WEB-INF/views/common/taglibs.jsp"%>
<!-- infoMsgs -->
<%
    //è·å¾ææçä¿¡æ¯
    List<Map<String, Object>> messagesList = (List<Map<String, Object>>) session.getAttribute(Msg.ALLMESSAGESKEY);
    if (messagesList != null && messagesList.size() > 0) {
        for (Map<String, Object> map : messagesList) {
            //è·å¾ä¿¡æ¯ç±»åï¼ä¸æ­¤ç±»åä¸ºæ§å¶å¼¹åºdivçæ ·å¼å
            String type = (String) map.get(MessageInterceptor.TYPEKEY);
            List<String> messages = (List<String>) map.get(MessageInterceptor.MESSAGEKEY);
            if (messages != null) {
                //å¾ªç¯å¼¹åºä¿¡æ¯æç¤ºæ¡
                for (String msg : messages) {
%>
<div style="width: 400px; position: fixed; left: 50%; margin-top: 20%; margin-left: -200px; z-index: 9999;"
	class="alert <%=type%>_message fade in one">
	<div class="col-xs-12 text_c mb_15">
		<i class="<%=type%>_icon"></i>
	</div>
	<div class="col-xs-12 text_c"><%=msg%></div>
</div>
<%
    }
            }
        }
        //ç§»é¤session
        session.removeAttribute(Msg.ALLMESSAGESKEY);
    }
%>