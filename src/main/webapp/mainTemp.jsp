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

<title>${pageTitle }</title>
</head>
<body>
<jsp:include page="/forground/common/menu.jsp"/>

<div class="container-fluid content-data">
	<div class="row">
		<div class="col-md-3 content-left left-data">
			<jsp:include page="/forground/common/left.jsp"/>
		</div>
		<div class="col-md-9 content-right right-data">
			<jsp:include page="${mainPage }"></jsp:include>
		</div>
	</div>
</div>
</body>
</html>