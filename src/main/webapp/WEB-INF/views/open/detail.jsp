<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>公众号详情</title>

</head>

<body>
<div class="row">
    <div class="col-xs-12">

        <form class="sky-form sky-form-v2 form-page-bg" action="/wxopen/oauth/submit" method="post">
            <input type="hidden" name="id" value="${account.id}">
            <div class="row">
                <div class="col-xs-8">
                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">公众号头像：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="user-headpic">
                                <img src="${account.headImg }" class="img-responsive" width="100">
                            </div>
                        </div>
                    </div>

                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">公众微信号：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    ${account.userName }</div>
                                <div class="col-xs-4 l_h_34 bluelink">
                                    <div class="question-tip-bar">
                                        <a href="/wxopen/oauth/create" title="">重新授权 <i
                                                class="fa fa-question-circle"></i></a>
                                        <div class="question-tip">

                                            您的账号已获得该公众号的接口权限，可以正常对接微信， 如果使用中发现账号功能有异常，请点击重新授权试试
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">公众号名称：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    ${account.nickName }</div>
                            </div>
                        </div>
                    </div>
                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">公众号类型：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    ${account.serviceTypeInfo.desc }
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">认证类型：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    ${account.verifyTypeInfo.desc }
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">授权可用域名：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    <input name="authorizationDomain" value="${account.authorizationDomain }">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">对接云客服secret：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    <input name="yunkefuSecret" value="${account.yunkefuSecret }">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">对接云客服token：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    <input name="yunkefuToken" value="${account.yunkefuToken }">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row input-item">
                        <div class="col-xs-3 item-left">
                            <label class="label">对接云客服gateway：</label>
                        </div>
                        <div class="col-xs-9 item-right">
                            <div class="clearfix item-right-text">
                                <div class="col-xs-6 l_h_34 pl_0 pr_0">
                                    <input name="yunkefuGateway" value="${account.yunkefuGateway }">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--<div class="col-xs-4">--%>

                                   <%--<div class="wx-code-pic"><img src="${account.qrcodeUrl }" width="100"></div>--%>
                                   <%--<div class="wx-code-text">公众号二维码</div>--%>
                        <%--</div>--%>

            </div>
            <div class="header smaller lighter blue" id="buttons">
                <button onclick="history.back()" class="btn-u">返回</button>
                <security:authorize url="/wxopen/oauth/submit">
                    <button type="submit" class="btn-u btn-u-blue">保存</button>
                </security:authorize>
            </div>
        </form>

    </div>
</div>
<!--内容结束-->

<myjs>
    <script type="text/javascript">
        $("div._head_menu").find('.active').removeClass('active');
        $("div._head_menu").find('a[href="/account/"]').parent('li').addClass('active');
    </script>
</myjs>
</body>
</html>