<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap.min.css" >
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap3/css/bootstrap-responsive.css" >
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap3/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap3/js/bootstrap.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/blog.css" >

<title>博客首页</title>
</head>
<body>
<div class="container-fluid">
	<div class="row">
			<nav class="navbar navbar-default nav-padding">
			  <div class="container-fluid">
			    <div class="navbar-header">
			      <a class="navbar-brand" href="#">博客网</a>
			    </div>
			    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			      <ul class="nav navbar-nav">
			      	<li><a href="#">首页</a></li>
			        <li><a href="#">最新文章</a></li>
			        <li><a href="#">联系</a></li>
			      </ul>
			      <ul class="nav navbar-nav navbar-right">
			        <li><a href="#">丨登录</a></li>
			      </ul>
			      <form class="navbar-form navbar-right">
			        <div class="form-group">
			          <input type="text" class="form-control" placeholder="Search">
			        </div>
			        <button type="submit" class="btn btn-default">搜索</button>
			      </form>
			    </div><!-- /.navbar-collapse -->
			  </div><!-- /.container-fluid -->
			</nav>
		</div>
</div>

<div class="container-fluid content-data">
	<div class="row">
		<div class="col-md-3 content-left left-data">
			<div>
				<div class="left-title">关于作者</div>
				<div class="left-content">
					<span class="userImage"><img src="${pageContext.request.contextPath}/static/userImage/${currentUser.imageName}"></span>
					<div class="userInfo"><p>${currentUser.nickName}</p><p>联系博主：1017283839@qq.com</p></div>
				</div>
			</div>
			<div>
				<div class="left-title">按时间分类</div>
				<div class="left-content">
					<ul class="list-group" style="padding-bottom: 0px;margin-bottom: 0px;">
						<c:forEach items="${blogCountListWithTime }" var="blogCount">
							 <a class="list-group-item" style="padding: 5px 20px 5px 0px; border: 1px solid white;" href="#">
							 	<span class="badge">${blogCount.blogCount }</span>${blogCount.releaseDateStr }
							 </a>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div>
				<div class="left-title">按标签分类</div>
				<div class="left-content">
					<ul class="list-group" style="padding-bottom: 0px;margin-bottom: 0px;">
						<c:forEach items="${blogTypeList }" var="blogType">
							 <a class="list-group-item" style="padding: 5px 20px 5px 0px; border: 1px solid white;" href="#">
							 	<span class="badge">${blogType.blogCount }</span>${blogType.typeName }
							 </a>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div>
				<div class="left-title">阅读排行</div>
				<div class="left-content">内容</div>
			</div>
			<div>
				<div class="left-title">友情链接</div>
				<div class="left-content">
					<c:forEach items="${linkList }" var="link">
						 <a class="list-group-item" style="padding: 5px 20px 5px 0px; border: 1px solid white;" href="${link.linkUrl }">
						 	${link.linkName }
						 </a>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="col-md-9 content-right right-data">
			<div class="right-title">最新文章</div>
		</div>
	</div>
</div>
</body>
</html>