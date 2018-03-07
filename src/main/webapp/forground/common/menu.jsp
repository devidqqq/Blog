<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="container-fluid">
	<div class="row">
			<nav class="navbar navbar-default nav-padding">
			  <div class="container-fluid">
			    <div class="navbar-header">
			      <a class="navbar-brand" href="#">博客网</a>
			    </div>
			    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			      <ul class="nav navbar-nav">
			      	<li><a href="${pageContext.request.contextPath}/index.html">首页</a></li>
			        <li><a href="#">最新文章</a></li>
			        <li><a href="#">联系</a></li>
			      </ul>
			      <ul class="nav navbar-nav navbar-right">
			        <li><a href="#">丨登录</a></li>
			      </ul>
			      <form class="navbar-form navbar-right" action="${pageContext.request.contextPath}/blog/search.html" method="post">
			        <div class="form-group">
			          <input type="text" class="form-control" name="q" placeholder="Search">
			        </div>
			        <button type="submit" class="btn btn-default">搜索</button>
			      </form>
			    </div><!-- /.navbar-collapse -->
			  </div><!-- /.container-fluid -->
			</nav>
		</div>
</div>