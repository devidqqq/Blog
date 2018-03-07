<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/third-party/SyntaxHighlighter/shCore.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/ueditor/third-party/SyntaxHighlighter/shCoreDefault.css">
<script type="text/javascript">
    SyntaxHighlighter.all();
    
    function showOtherComment(){
    	$(".otherComment").show();
    }
    
    function submitData(){
    	var content=$("#content").val();
    	if(content==null || content==""){
    		alert("请输入评论内容！");
    	}else{
    		$.post("${pageContext.request.contextPath}/comment/save.do",{"content":content,'blog.id':'${blog.id}'},function(result){
    			if(result.success){
    				alert("评论成功，待管理员审核！");
    			}else{
    				alert(result.errorInfo);
    			}
    		},"json");
    	}
    }
</script>


<div class="right-title">
			<img src="/static/images/blog_show_icon.png"/>
			博客信息
		</div>

<div class="datas">
	<div class="data_list">
		<div>
			<div class="blog_title"><h3><strong>${blog.title }</strong></h3></div>
			<div class="blog_info">
				发布时间：『 <fmt:formatDate value="${blog.releaseDate }" type="date" pattern="yyyy-MM-dd HH:mm"/>』&nbsp;&nbsp;博客类别：${blog.blogType.typeName }&nbsp;&nbsp;阅读(${blog.clickHit }) 评论(${blog.replyHit })
			</div>
			<div class="blog_content">
				${blog.content }
			</div>
			<div>
				<p>关键字：
					<c:choose>
						<c:when test="${keyWords==null }">
							无
						</c:when>
						<c:otherwise>
							<c:forEach var="keyWord" items="${keyWords }">
								<a href="${pageContext.request.contextPath}/blog/search.html?q=${keyWord }">${keyWord }</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</p>
			</div>
			<hr style="height:5px;border:none;border-top:1px dashed gray;padding-bottom:  10px;" />
			<div>
				${lastAndNextBlog }
			</div>
		</div>
	</div>
</div>

<div class="data_list">
	
	<div class="publish_comment">
		<div class="right-title">
			<img src="/static/images/publish_comment_icon.png"/>
			发表评论
		</div>
		<div class="publish_comment">
			<form action="">
				<div>
					<textarea style="width: 100%" rows="3" id="content" name="content" placeholder="来说两句吧..."></textarea>
				</div>
				<div class="publishButton">
					<button class="btn btn-primary" type="button" onclick="submitData()">发表评论</button>
				</div>
			</form>
		</div>
	</div>
	<div class="right-title">
			<img src="/static/images/comment_icon.png"/>
			评论信息
		<c:if test="${commentList.size()>10 }">
			<a href="javascript:showOtherComment()" style="float: right;padding-right: 40px;font-size: 1.5rem;">显示所有评论</a>
		</c:if>
	</div>
	<div class="commentDatas">
		<c:choose>
			<c:when test="${commentList.size()==0 }">
				暂无评论
			</c:when>
			<c:otherwise>
				<c:forEach var="comment" items="${commentList}" varStatus="status">
					<c:choose>
						<c:when test="${status.index<10 }">
							<div class="comment">
								<span><font>${status.index+1 }楼&nbsp;&nbsp;&nbsp;&nbsp;${comment.userIp }</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发表于：[&nbsp;<fmt:formatDate value="${comment.commentDate }" type="date" pattern="yyyy-MM-dd HH:mm"/>&nbsp;]</span>			
								<p>评论内容：&nbsp;${comment.content }</p>
							</div>
						</c:when>
						<c:otherwise>
							<div class="otherComment">
								<span><font>${status.index+1 }楼&nbsp;&nbsp;&nbsp;&nbsp;${comment.userIp }</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;发表于：[&nbsp;<fmt:formatDate value="${comment.commentDate }" type="date" pattern="yyyy-MM-dd HH:mm"/>&nbsp;]</span>			
								<p>评论内容：&nbsp;${comment.content }</p>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</div>
