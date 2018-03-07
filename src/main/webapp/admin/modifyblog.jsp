<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>

<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/static/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/static/ueditor/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/static/ueditor/lang/zh-cn/zh-cn.js"></script>

<title>Insert title here</title>
<style type="text/css">
	.publish{
	float:right;
	margin-top: 10px;
	margin-right:50px;
	margin-bottom: 20px;
	}
	.writeBlog-head{
		padding: 10px;
		display: inline-block;
	}
	.writeBlog-head>span{
		display: inline-block;
		width: 80px;
	}
	.drop-down{
		
	}
</style>

<script type="text/javascript">
	
	function submitData(){
		var title = $("#title").val();
		var blogType = $("#blogType").combobox('getValue');
		var content = UE.getEditor('editor').getContent();
		var keyWord=$("#keyword").val();
		
		if(title==null || title==""){
			alert("请输入标题！");
		}else if(blogType==null || blogType==''){
			alert("请选择博客类别！");
		}else if(content==null || content==''){
			alert("请填写内容！");
		}else{
			$.post("${pageContext.request.contextPath}/admin/blog/save.do",{
				'id':'${param.id}',
				'title':title,
				'blogType.id':blogType,
				'content':content,
				'summary':UE.getEditor('editor').getContentTxt().substr(0,155),
				'contentNoTag':UE.getEditor('editor').getContentTxt(),
				'keyWord':keyWord
			},function(result){
				if(result.success){
					alert('发表成功！');
					resetValue();
				}else{
					alert('发表失败！');
				}
			},'json');
		}
	}
	
	function resetValue(){
		$("#title").textbox('setValue','');
		$("#keyword").textbox('setValue','');
		$("#blogType").combobox('setValue','');
		UE.getEditor('editor').setContent('');
	}
</script>
</head>
<body>
	<div id="p" class="easyui-panel" title="编写博客" style="width:100%;background:#fafafa;">
		<div class="writeBlog-head">
			<span>标题：</span><input class="easyui-textbox" type="text" id="title" style="width: 300px"/>
		</div>
		<div class="writeBlog-head">
	    	<span>博客类别：</span>
	    	<select id="blogType" class="easyui-combobox" style="width: 200px" editable="false" panelHeight="auto">
	    		<option value="">请选择博客类别...</option>
	    		<c:forEach var="blogType" items="#{blogTypeList }">
	    			<option value="${blogType.id }">${blogType.typeName }</option>
	    		</c:forEach>
	    	</select>
	    </div>
	 	<!-- 加载编辑器的容器 -->
	    <script id="editor" name="content" type="text/plain" style="height:500px;width:100%;"></script>
	    <div >
	    	<div class="writeBlog-head"><span>关键字：</span><input class="easyui-textbox" type="text" id="keyword" name="keyword" style="width: 400px"/>&nbsp;(关键字以空格分隔)</div>
	    	<a href="javascript:submitData()" class="easyui-linkbutton publish" data-options="iconCls:'icon-publish'" >发布博客</a>
	    </div>
    </div>
    <script type="text/javascript">
        var ue = UE.getEditor('editor');
       
        ue.addListener("ready",function(){
        	// 通过ajax请求数据
        	UE.ajax.request("${pageContext.request.contextPath}/admin/blog/getBlogById.do",
        			{
        				method:"post",
        				async:false,
        				data:{"id":"${param.id}"},
        				 //请求成功后的回调， 该回调接受当前的XMLHttpRequest对象作为参数。
        				onsuccess:function(result){
        					result=eval("("+result.responseText+")");
        					$("#title").textbox('setValue',result.title);
        					$("#keyword").textbox('setValue',result.keyWord);
        					$("#blogType").combobox("setValue",result.blogType.id);
        					UE.getEditor('editor').setContent(result.content);
        				}
       			});
        });
       /* ue.editor.fireEvent("ready"); */
    </script>
</body>
</html>