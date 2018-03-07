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
		    url:'${pageContext.request.contextPath}/admin/link/list.do',
		    title:'友情链接管理',
		    fitColumns:true,
		    pagination:true,
		    rownumbers:true,
		    toolbar:"#tb",
		    fit: true,
		    pageSize:20,
		    columns:[[
		    	{field:"cb",checkbox:"true",align:"center"},
		        {field:'id',title:'编号',width:'100',align:'center'},
				{field:'linkName',title:'友情链接名称',width:'350',align:'center'},
				{field:'linkUrl',title:'友情链接地址',width:'350',align:'center'},
				{field:'orderNo',title:'序号',width:'150',align:'center'},
		    ]]
		});
	}
	
	function deleteLink(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要刪除的友情链接！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){ $.post("${pageContext.request.contextPath}/admin/link/delete.do",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已全部成功删除！");							
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","刪除失败！");
					}
					},"json");
				}
		});
	}
	
	function addLink(){
		$('#dd').dialog('open').dialog('setTitle','添加友情链接');
		url='${pageContext.request.contextPath}/admin/link/save.do';
	}
	function updateLink(){
		var selectedRows=$("#dg").datagrid("getSelections");
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要修改的友情链接！");
			return;
		}
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择<font color='red'>1</font>条数据！");
			return;
		}
		var row=selectedRows[0];
		$('#dd').dialog('open').dialog('setTitle','修改友情链接');
		$('#fm').form('load',row);
		url="${pageContext.request.contextPath}/admin/link/save.do?id="+row.id;
	}
	
	function saveLink(){
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
		$("#linkName").val("");
		$("#linkUrl").val("");
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
	<div id="dd"  class="easyui-dialog" style="width:500px;height:200px;padding-top: 10px;" closed='true' buttons='#dd-button'>
		<form id="fm"  method="post">
			<table cellpadding="5px">
				<tr>
					<td width="90px">友情链接名称:</td>
					<td>
						<input class="easyui-validatebox" id="linkName" name="linkName" required="true" size="40"/>
					</td>
				</tr>
				<tr>
					<td>友情链接地址:</td>
					<td>
						<input class="easyui-validatebox" id="linkUrl" name="linkUrl" validType="url" required="true" size="40"/>
					</td>
				</tr>
				<tr>
					<td>友情链接序号:</td>
					<td>
						<input type="text" class="easyui-numberbox" id="orderNo" name="orderNo" required="true"/>&nbsp;（友情链接根据序号大小排列）
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="tb" style="padding:5px;">
		<div style="margin:5px;margin:2px auto;">
			<a href="javascript:addLink()" class="easyui-linkbutton" iconCls="icon-add" plain="true" >添加</a>
			<a href="javascript:deleteLink()" class="easyui-linkbutton" iconCls="icon-remove" plain="true" >删除</a>
			<a href="javascript:updateLink()" class="easyui-linkbutton" iconCls="icon-ok" plain="true" >修改类别</a>
		</div>		
	</div>
	<div id="dd-button" style="padding:5px;">
		<a href="javascript:saveLink()" class="easyui-linkbutton" iconCls="icon-save"  >保存</a>
		<a href="javascript:cancel()" class="easyui-linkbutton" iconCls="icon-cancel">返回</a>
	</div>
</body>
</html>