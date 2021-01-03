<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="#" style="font-size: 25px">校园二手交易系统</a>
		</div>
		
		<div id="navbar" class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<c:choose>
					<c:when test="${sessionScope.user!=null}">
						<li><a href="<c:url value="/view/home/homeGoods.jsp"/>">首页</a></li>
						<li><a target="_blank" href="/secondshop/UserServlet?method=display">我的</a></li>
						<li><a target="_blank" href="<c:url value="/view/goods/publishGood.jsp" />">发布</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="<c:url value="/view/home/homeGoods.jsp"/>">首页</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
			
			<ul class="nav navbar-nav navbar-right">
				<c:choose>
					<c:when test="${sessionScope.user!=null}">
						<li><img src="<c:url value="${sessionScope.user.getPhotoUrl()}"/>" height="50px" width="50px"></li>
						<li><a target="_blank" href="<c:url value=""/>">${sessionScope.user.getName()}</a></li>
						<li><a href="/secondshop/LogoutServlet?userLogout=true">退出</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="<c:url value="/view/home/login.jsp" />">登录</a></li>
						<li><a href="<c:url value="/view/home/register.jsp" />">注册</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</nav>
<div class="col-md-12" style="height: 70px"></div>