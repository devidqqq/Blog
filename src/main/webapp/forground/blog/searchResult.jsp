<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="right-title"><img src="${pageContext.request.contextPath}/static/images/list_icon.png"/>最新文章</div>

<div class="datas">
  	<ul>
  		<c:choose>
  			<c:when test="${blogSearchList.size()==0 }">
  				<div align="center" style="padding-top: 20px">未查询到结果，请换个关键字试试看！</div>
  			</c:when>
  			<c:otherwise>
		  		<c:forEach var="blog" items="${blogSearchList }">
		  			<li style="margin-bottom: 10px">
					  	<span class="title"><a href="${pageContext.request.contextPath}/blog/articles/${blog.id }.html">${blog.title }</a></span>
					  	<span class="summary">摘要: ${blog.summary }...</span>
					  	<span><a href="${pageContext.request.contextPath}/blog/articles/${blog.id }.html">http:/${pageContext.request.contextPath}/blog/articles/${blog.id }.html</a></span>
					  	<span class="info">发表于 <fmt:formatDate value="${blog.releaseDate }" type="date" pattern="yyyy-MM-dd HH:mm"/> 阅读(${blog.clickHit }) 评论(${blog.replyHit }) </span>
		  			</li>
		  			<hr style="height:5px;border:none;border-top:1px dashed gray;padding-bottom:10px;" />
		  		</c:forEach>
  			</c:otherwise>
  		</c:choose>
  	</ul>
</div>
<%-- <div class="pageCode">
	${pageCode }
</div> --%>
