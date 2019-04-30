<%@ page language="java" pageEncoding="UTF-8" %>
<!-- start message -->
<%@page import="cn.wuxia.common.spring.mvc.MessageInterceptor" %>
<%@page import="javax.validation.MessageInterpolator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="cn.wuxia.common.spring.support.Msg" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ include file="taglibs.jsp" %>
<!-- infoMsgs -->
<%
    List<Map<String, Object>> messagesList = (List<Map<String, Object>>) session.getAttribute(Msg.ALLMESSAGESKEY);
    if (messagesList != null && messagesList.size() > 0) {
        for (Map<String, Object> map : messagesList) {
            String type = (String) map.get(MessageInterceptor.TYPEKEY);
            List<String> messages = (List<String>) map.get(MessageInterceptor.MESSAGEKEY);
            if (messages != null) {
                for (String msg : messages) {
%>
<div style="width: 400px; position: fixed; left: 50%; margin-top: 20%; margin-left: -200px; z-index: 9999;"
     class="alert _message fade in one">
    <div class="col-xs-12 text_c mb_15">
        <i class="<%=type%>_icon"></i>
    </div>
    <div class="col-xs-12 text_c"></div>
</div>

<div class="am-alert am-alert-<%=type%>" data-am-alert>
    <button type="button" class="am-close">&times;</button>
    <p><%=msg%>
    </p>
</div>
<%
                }
            }
        }
        session.removeAttribute(Msg.ALLMESSAGESKEY);
    }
%>