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
	window.onload=function(){
		InitDataGrid();
	}	
	
	function InitDataGrid(){
		$('#dg').datagrid({
		    url:'${pageContext.request.contextPath}/admin/blog/list.do',
		    title:'博客管理',
		    fitColumns:true,
		    pagination:true,
		    rownumbers:true,
		    toolbar:"#tb",
		    fit: true,
		    pageSize:20,
		    columns:[[
		    	{field:"cb",checkbox:"true",align:"center"},
		        {field:'id',title:'编号',width:'50',align:'center'},
		        {field:'title',title:'博客标题',width:'250',align:'center',
		        	formatter:function(val,row){
						if(val==null){
							return "<font color='red'>该博客已删除！</font>";
						}else{
							return "<a target='_blank' href='${pageContext.request.contextPath}/blog/articles/"+row.id+".html'>"+val+"</a>";
						}
				}}, 
		        {field:'releaseDate',title:'发布日期',width:'200',align:'center'},
		        {field:'blogType',title:'博客类型',width:'150',align:'center',
		        	formatter:function(val,row){
		        		return val.typeName;
					}
				},
				{field:'clickHit',title:'浏览量',width:'150',align:'center'},
				{field:'replyHit',title:'评论量',width:'50',align:'center'},
		    ]]
		});
	}
	
	function update(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要修改的博客！");
			return;
		}
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择<font color='red'>1</font>条数据！");
			return;
		}
		var id=selectedRows[0].id;
		
		window.parent.openTab('修改博客','modifyblog.jsp?id='+id,'icon-write');
	}
	function deleteBlog(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要刪除的博客！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){ $.post("${pageContext.request.contextPath}/admin/blog/delete.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","刪除成功！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","池、刪除失败！");
					}
					},"json");
				}
		});
	}
</script>
</head>
<body>
	<table id="dg"></table>
	<div id="tb" style="padding:5px;">
		<div style="margin:5px;margin:2px auto;">
			<a href="javascript:deleteBlog()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" style="margin-top:-4px;">批量删除</a>
			<a href="javascript:update()" class="easyui-linkbutton" iconCls="icon-ok" plain="true" style="margin-top:-4px;">修改博客</a>
		</div>		
	</div>
</body>
</html>