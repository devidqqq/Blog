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
	/* window.onload=function(){
		InitDataGrid();
	} */
	
	var url;
	
	$(function(){
		InitDataGrid();
	});
	
	function InitDataGrid(){
		$('#dg').datagrid({
		    url:'${pageContext.request.contextPath}/admin/blogType/list.do',
		    title:'博客类别管理',
		    fitColumns:true,
		    pagination:true,
		    rownumbers:true,
		    toolbar:"#tb",
		    fit: true,
		    pageSize:20,
		    columns:[[
		    	{field:"cb",checkbox:"true",align:"center"},
		        {field:'id',title:'编号',width:'100',align:'center'},
				{field:'typeName',title:'类别名称',width:'450',align:'center'},
				{field:'orderNo',title:'序号',width:'150',align:'center'},
		    ]]
		});
	}
	
	function deleteBlogType(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要刪除的博客类别！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){ $.post("${pageContext.request.contextPath}/admin/blogType/delete.do",{ids:ids},function(result){
					if(result.success){
						if(result.exist){
							$.messager.alert("系统提示","数据未能全部删除，编号为<font color='red'>"+result.exist+"</font>的博客类别下有博客，不能删除！");
						}else{
							$.messager.alert("系统提示","数据已全部成功删除！");							
						}
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","刪除失败！");
					}
					},"json");
				}
		});
	}
	
	function addBlogType(){
		$('#dd').dialog('open').dialog('setTitle','添加博客类别');
		url='${pageContext.request.contextPath}/admin/blogType/save.do';
	}
	function updateBlogType(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要修改的博客类别！");
			return;
		}
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择<font color='red'>1</font>条数据！");
			return;
		}
		var row=selectedRows[0];
		$('#dd').dialog('open').dialog('setTitle','修改博客类别');
		$('#fm').form('load',row);
		url="${pageContext.request.contextPath}/admin/blogType/save.do?id="+row.id;
	}
	
	function saveBlogType(){
		$('#fm').form('submit',{
		    url:url,
		    onSubmit: function(){
		    	return $(this).form("validate");
		    },
		    success:function(result){
		    	var result = eval('('+result+')');  // change the JSON string to javascript object
		        if (result.success){
		        	$.messager.alert('系统提示','保存成功！');
		        	resetValue();
		        	$('#dd').dialog('close');
		        	$("#dg").datagrid("reload");
		        }else{
		        	$.message.alert('系统提示','保存失败！');
		        	return;
		        }
		    }
		});
	}
	
	function resetValue(){
		$("#typeName").val("");
		$("#orderNo").numberbox('setValue', '');
	}
	
	function cancel(){
		resetValue();
		$('#dd').dialog('close');
	}
</script>
</head>
<body>
	<table id="dg"></table>
	<div id="dd"  class="easyui-dialog" style="width:500px;height:200px;padding-top: 30px" closed='true' buttons='#dd-button'>
		<form id="fm"  method="post">
			<table cellpadding="5px">
				<tr>
					<td>博客类型名称：</td>
					<td>
						<input class="easyui-validatebox" id="typeName" name="typeName" required="true" size="50"/>
					</td>
				</tr>
				<tr>
					<td>博客类型序号：</td>
					<td>
						<input type="text" class="easyui-numberbox" id="orderNo" name="orderNo" required="true"/>&nbsp;&nbsp;&nbsp;（博客类型根据序号大小排列）
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="tb" style="padding:5px;">
		<div style="margin:5px;margin:2px auto;">
			<a href="javascript:addBlogType()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
			<a href="javascript:deleteBlogType()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
			<a href="javascript:updateBlogType()" class="easyui-linkbutton" iconCls="icon-ok" plain="true" >修改类别</a>
		</div>		
	</div>
	<div id="dd-button" style="padding:5px;">
		<a href="javascript:saveBlogType()" class="easyui-linkbutton" iconCls="icon-save"  >保存</a>
		<a href="javascript:cancel()" class="easyui-linkbutton" iconCls="icon-cancel">返回</a>
	</div>
</body>
</html>