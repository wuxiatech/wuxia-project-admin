<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<title>公众号授权</title>

</head>

<body>
	<!--内容开始-->
	<div class="container equipment">
		
					
					
						<form class="sky-form sky-form-v2 form-page-bg">
							<div class="row">
								<div class="col-xs-12">
									<div class="clearfix wx-member">
										<div class="col-xs-6 wx-member-l">
											<div class="wx-member-l-01">您还未进行微信公众号授权</div>
											<div class="wx-member-l-02">已认证服务号在授权后,即可在分豆豆网拥有更强大的创建优惠券和管理门店的功能</div>
										</div>
										<div class="col-xs-6 wx-member-r">
											<div class="wx-member-r-01">
												<a class="wx-login" href="/wxopen/oauth/jumpaccountoauth"><i
													class="fa fa-weixin"></i> 我有微信公众号，立即授权</a>
											</div>
											<div class="wx-member-r-02">
												没有公众号，<a target="_blank" href="https://mp.weixin.qq.com/"><span
													class="bluelink">立即去申请</span></a>
											</div>
										</div>
									</div>
									<div class="col-xs-12 pb_20">
										<div class="clearfix area-line"></div>
									</div>
									<div class="attention-4 col-xs-12 clearfix">
										<div class="attention-4-tit">温馨提示：</div>
										<div class="attention-4-tex">
											<p>* 微信公众号必须是已认证服务号。</p>
											<p>* 一个微信公众号只能和一个分豆豆账号绑定。</p>
											<p>* 账号绑定后不支持解除绑定。</p>
										</div>
									</div>

								</div>
							</div>
						</form>
			
	</div>
	<!--内容结束-->

	<myjs> <script type="text/javascript">
		$("div._head_menu").find('.active').removeClass('active');
		$("div._head_menu").find('a[href="/account/"]').parent('li').addClass('active');
	</script> </myjs>
</body>
</html>