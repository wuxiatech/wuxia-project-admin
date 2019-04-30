<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>WaiMaoGang.control.panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="/Statics/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Statics/css/self.css" rel="stylesheet">
    <link href="/Statics/css/temp.css" rel="stylesheet">

    <style type="text/css">
      body{padding-top: 60px;}
    </style>
    <link href="/Statics/css/bootstrap-responsive.css" rel="stylesheet">
    <script type="text/javascript" src="/Statics/img/charts/Charts/FusionCharts.js"></script>
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link type="image/x-icon" rel="shortcut icon" href="<c:url value="/resources/images/favicon.ico"/>" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="/ico/apple-touch-icon-57-precomposed.png">
  </head>

  <body quick-markup_injected="true">
   <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <!--#include file="header.html" -->

    <div class="container-fluid"><!--内容正文区开始-->

          <div class="row-fluid">
            <div class="widget-box">

              <div class="widget-title"><span class="icon"><i class="icon-signal"></i></span><h5>业务统计</h5>
                <div class="buttons"><a href="#" class="btn btn-mini btn-primary"><i class="icon-refresh"></i> 更新</a>
                  <a href="#" class="btn btn-mini"><i class="icon-refresh"></i>修改状态</a>
                </div>
              </div>

              <div class="widget-content-light widget-nopad">
              
                <table class="table table-striped table-bordered table-hover">
                  <tbody>
                <tr>
                  <td id="" width="10%">订单编号：</td>
                  <td id=""></td>
                  <td id="" width="10%">会员名称</td>
                  <td id=""><a href=""></a></td>
                  <td id="">客户名称</td>
                  <td id=""></td>
                </tr>   
                <tr>
                  <td id=""><a href="">公司简介</a></td>
                  <td id="" colspan="5"></td>
                </tr>   
                <tr>
                  <td id=""><a href="">3325</a></td>
                  <td id="" colspan="2">1ZW09W310441749131</td>
                  <td id="">文件</td>
                  <td id="" colspan="2">UPS</td>
                </tr>   
                <tr>
                  <td id="" width="10%">订单编号：</td>
                  <td id="">1ZW09W310441749131</td>
                  <td id="" width="10%">会员名称</td>
                  <td id=""><a href="">Waimaokaifa</a></td>
                  <td id="">客户名称</td>
                  <td id="">广东省外贸开发有限公司</td>
                </tr>                             
                </tbody>
                </table>
              </div>

            </div>  
          </div>    

          <div class="row-fluid">

            <div class="span6">
              <div class="widget-box">

                <div class="widget-title"><span class="icon"><i class="icon-signal"></i></span><h5>业务统计</h5>
                  <div class="buttons"><a href="#" class="btn btn-mini"><i class="icon-refresh"></i> 更新</a>
                </div>
                </div>

                <div class="widget-content-light widget-nopad">
                </div>
              </div>
            </div>

            <div class="span6">
              <div class="widget-box">
                <div class="widget-title"><span class="icon"><i class="icon-signal"></i></span><h5>业务统计</h5>
                  <div class="buttons"><a href="#" class="btn btn-mini btn-primary"><i class="icon-refresh"></i> 更新</a>
                  </div>
                </div>

                <div class="widget-content-light widget-nopad">
                
                </div>
              </div>
            </div>

          </div>

        </div><!--内容正文区结束-->

      <!--#include file="footer.html" -->
    </div>

    <script src="/Statics/js/jquery-1.8.2.min.js"></script>
    <script src="/Statics/bootstrap.min.js"></script>

  </body>
</html>
