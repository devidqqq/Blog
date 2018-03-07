<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评论管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	/* var states = 0; */
	var url = '${pageContext.request.contextPath}/admin/comment/list.do?state=0';
	window.onload=function(){
		InitDataGrid();
	}	
	
	function InitDataGrid(){
		$('#dg').datagrid({
		    url:url,
		    title:'评论审核管理',
		    fitColumns:"true",
		    pagination:"true",
		    rownumbers:"true",
		    toolbar:"#tb",
		    fit:true,
			pageSize:20,
		    columns:[[
		    	{field:"cb",checkbox:"true",align:"center"},
		        {field:'id',title:'编号',width:'50',align:'center'},
		        {field:'blog',title:'博客标题',width:'200',align:'center',
		        	formatter:function(val,row){
						if(val==null){
							return "<font color='red'>该博客已删除！</font>";
						}else{
							return "<a target='_blank' href='${pageContext.request.contextPath}/blog/articles/"+val.id+".html'>"+val.title+"</a>";
						}
				}}, 
		        {field:'content',title:'评论内容',width:'270',align:'center'},
		        {field:'userIp',title:'用户IP',width:'150',align:'center'},
		        {field:'commentDate',title:'评论日期',width:'150',align:'center'},
		        {field:'state',title:'评论状态',width:'100',align:'center'}
		    ]]
		});
	}
	
	$(function(){
		$("#state").combobox({  
			onChange: function () {
		    	   var states = $("#state").combobox('getValue');
		    	  /*  alert(states); */
 		           /* updateUrl(states); */
 		          url = '${pageContext.request.contextPath}/admin/comment/list.do?state='+states;
 		         /*  $('#dg').datagrid('reload') */
 		          InitDataGrid();
		       }  
			 });  
	});
	/* function updateUrl(states){
        $('#dg').datagrid('load', {
     	   state:states
        });
        alert(states);
	} */
	function agree(s){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要审核的评论！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		/* alert(".."); */
		$.post("${pageContext.request.contextPath}/admin/comment/review.do",{ids:ids,state:s},function(result){
			if(result.success){
				$.messager.alert("系统提示","提交成功！");
				$("#dg").datagrid("reload");
			}else{
				$.messager.alert("系统提示","提交失败！");
			}
		},"json");
	}
	function disagree(s){
		agree(s);
	}
	function deleteComment(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要刪除的评论！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.post("${pageContext.request.contextPath}/admin/comment/delete.do",{ids:ids},function(result){
			if(result.success){
				$.messager.alert("系统提示","刪除成功！");
				$("#dg").datagrid("reload");
			}else{
				$.messager.alert("系统提示","池、刪除失败！");
			}
		},"json");
	}
</script>
</head>
<body>
	<table id="dg"></table>
	<div id="tb" style="padding:5px;">
		<div style="margin:5px;margin:2px auto;">
			<select id="state" class="easyui-combobox" style="width: 200px" editable="false" panelHeight="auto">
				<option value="0">未审核</option>
				<option value="">全部评论</option>
				<option value="1">审核通过</option>
				<option value="2">审核未通过</option>
			</select>
			<a href="javascript:deleteComment()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" style="margin-top:-4px;">批量删除</a>
			<a href="javascript:agree(1)" class="easyui-linkbutton" iconCls="icon-ok" plain="true" style="margin-top:-4px;">审核通过</a>
			<a href="javascript:disagree(2)" class="easyui-linkbutton" iconCls="icon-no" plain="true" style="margin-top:-4px;">审核未通过</a>
		</div>		
	</div>
</body>
</html>