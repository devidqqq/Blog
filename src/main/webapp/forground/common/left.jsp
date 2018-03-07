<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    

			<div>
				<div class="left-title">关于作者</div>
				<div class="left-content">
					<span class="userImage"><img src="${pageContext.request.contextPath}/static/userImages/${currentUser.imageName}"></span>
					<div class="userInfo"><p>${currentUser.nickName}</p><p>联系博主：1017283839@qq.com</p></div>
				</div>
			</div>
			<div>
				<div class="left-title">按时间分类</div>
				<div class="left-content">
					<ul class="list-group" style="padding-bottom: 0px;margin-bottom: 0px;">
						<c:forEach items="${blogCountListWithTime }" var="blogCount">
							 <a class="list-group-item" style="padding: 5px 20px 5px 0px; border: 1px solid white;" href="${pageContext.request.contextPath}/index.html?releaseDateStr=${blogCount.releaseDateStr }">
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
							 <a class="list-group-item" style="padding: 5px 20px 5px 0px; border: 1px solid white;" href="${pageContext.request.contextPath}/index.html?typeId=${blogType.id }">
							 	<span class="badge">${blogType.blogCount }</span>${blogType.typeName }
							 </a>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div>
				<div class="left-title">阅读排行</div>
				<div class="left-content">
					<ul class="list-group" style="padding-bottom: 0px;margin-bottom: 0px;">
						<c:forEach items="${blogHotList }" var="hotblog">
							 <a class="list-group-item" style="padding: 5px 20px 5px 0px; border: 1px solid white;" href="${pageContext.request.contextPath}/blog/articles/${hotblog.id }.html">
							 	<span class="badge">阅读量:${hotblog.clickHit }</span>${hotblog.title }
							 </a>
						</c:forEach>
					</ul>
				</div>
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
				  
