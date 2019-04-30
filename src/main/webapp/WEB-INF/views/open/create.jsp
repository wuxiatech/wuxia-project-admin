<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<title>代制券DEMO</title>

</head>

<body>
	<form action="/cardDemo/create" method="post" id="create">
		商户名字:<input type="text" name="brandName" value="分豆豆第三方平台" /><br />
		标题:<input type="text" name="title" value="100元优惠券" /><br />
		使用提醒:<input type="text" name="notice" value="结账时出示" /><br />
		使用说明:<input type="text" name="description" value="由第三方平台创建" /><br />
		fixedTerm:<input type="text" name="fixedTerm" value="10" /><br />
		fixedBeginTerm:<input type="text" name="fixedBeginTerm" value="0" /><br />
		数量:<input type="text" name="quantity" value="10" /><br />
		<input type="submit" value="提交" />
	</form>

<myjs>
<script type="text/javascript">
	$(function(){
		$('#create').ajaxForm({
		    dataType:'json',
		    success:function(data) {
		        alert(data.msg);
		    },
		    error:function(){
		        alert("错误");
		    }
		});
		
	});
</script>
</myjs>
</body>
</html>