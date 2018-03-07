<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/easyui/demo.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript">
	var url;
	
	function openTab(text,url,iconCls){
		if($("#tabs").tabs("exists",text)){
			$("#tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='/admin/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	}
	
	function openModifyPassword(){
		$('#dd').dialog('open').dialog('setTitle','修改密码');
		url='${pageContext.request.contextPath}/admin/user/update.do';
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
	
	function saveUser(){
		$('#fm').form('submit',{
		    url:url,
		    onSubmit: function(){
		    	return $(this).form("validate");
		    },
		    success:function(result){
		    	var result = eval('('+result+')');  // change the JSON string to javascript object
		        if (result.success){
		        	$.messager.alert('系统提示','修改成功！');
		        	resetValue();
		        	$('#dd').dialog('close');
		        	$("#dg").datagrid("reload");
		        }else{
		        	$.message.alert('系统提示','修改失败！');
		        	return;
		        }
		    }
		});
	}
	function logout(){
		window.location.href='${pageContext.request.contextPath}/admin/user/logout.do';
	}
	function refreshSystem(){
		$.post('${pageContext.request.contextPath}/admin/system/refreshSystem.do',{},function(result){
			if (result.success){
	        	$.messager.alert('系统提示','刷新成功！');
	        }else{
	        	$.message.alert('系统提示','刷新失败！');
	        }
		},'json');
	}
</script>
<style type="text/css">
.a-menu{
	text-align: left;
	width: 100% !important;
	/* padding-left: 20px; */
}
.a-menu a:hover{
	background-color: white;
	border: 0px solid;
}
</style>
<title>博客后台管理</title>
</head>
<body  class="easyui-layout">
	<div data-options="region:'north'" style="height:50px;padding-top: 10px;">
		<font color="red" style="font-size: 2rem;padding-left: 30px;font-family:cursive;">博客后台管理页</font>
	</div><!-- 上 -->
	<div data-options="region:'west',split:true" title="导航菜单" style="width:20%;">
		<div class="easyui-accordion" style="width:100%;height: 100%"><!-- 手风琴菜单栏 -->
			<div title="常用操作" data-options="iconCls:'icon-docs'" style="padding:10px;">
				<a href="javascript:openTab('写博客','writeBlog.jsp','icon-write')" class="easyui-linkbutton a-menu"  data-options="plain:true,iconCls:'icon-write'" >写博客</a>
				<a href="javascript:openTab('评论审核','commentAdmin.jsp','icon-comments')" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-comments'" >评论审核</a>
			</div>
			<div title="博客管理" data-options="iconCls:'icon-blog'" style="padding:10px;">
				<a href="javascript:openTab('博客管理','blogList.jsp','icon-blog')" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-blog'" >博客管理</a> 		
			</div>
			<div title="博客类别管理" data-options="iconCls:'icon-category'" style="padding:10px;">
				<a href="javascript:openTab('博客类别管理','blogTypeList.jsp','icon-category')" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-category'" >博客类别管理</a> 	
			</div>
			<div title="评论管理" data-options="iconCls:'icon-comments'" style="padding:10px;">
				<a href="javascript:openTab('评论审核','commentAdmin.jsp','icon-comments')" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-comments'" >评论管理</a>
			</div>
			<div title="个人信息管理" data-options="iconCls:'icon-man'" style="padding:10px;">
				<a href="javascript:openTab('个人信息管理','modifyInfo.jsp','icon-man')" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-man'" >个人信息管理</a> 	
			</div>
			<div title="系统管理" data-options="iconCls:'icon-config'" style="padding:10px;">
				<a href="javascript:openTab('系统管理','linkManage.jsp','icon-link')" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-link'" >友情链接管理</a> 
				<a href="javascript:openModifyPassword()" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-password'" >修改密码</a> 	
				<a href="javascript:refreshSystem()" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-refresh'" >刷新缓存</a> 		
				<a href="javascript:logout()" class="easyui-linkbutton a-menu" data-options="plain:true,iconCls:'icon-close'" >退出系统</a> 		
			</div>
		</div>
	</div><!-- 左侧菜单栏 -->
	<div data-options="region:'center'" style="width:20%;">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-home'">
				<div align="center" style="padding-top: 100px"><font color="red" size="10">欢迎使用</font></div>
			</div>
		</div>
	</div><!-- 中间内容 -->
	<div data-options="region:'south'" style="height:30px;">
	</div><!-- 下 -->
	
	<div id="dd"  class="easyui-dialog" style="width:400px;height:200px;padding: 5px 15px" closed='true' buttons='#dd-button'>
		<form id="fm"  method="post">
			<table cellpadding="5px">
				<tr>
					<td width="90px">用户名：</td>
					<td>
						<input type="hidden" id="id" name="id" value="${currentUser.id }"/>
						<input type="text" id="userName" name="userName" value="${currentUser.userName }" readonly="readonly" size="30"/>
					</td>
				</tr>
				<tr>
					<td>新密码：</td>
					<td>
						<input type="password" class="easyui-validatebox" id="password" name="password" required="true" size="30"/>
					</td>
				</tr>
				<tr>
					<td>确认新密码：</td>
					<td>
						<input type="password" class="easyui-validatebox" id="password2" name="password2" required="true" size="30"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div id="dd-button" style="padding:5px;">
		<a href="javascript:saveUser()" class="easyui-linkbutton" iconCls="icon-save"  >保存</a>
		<a href="javascript:cancel()" class="easyui-linkbutton" iconCls="icon-cancel">返回</a>
	</div>
</body>
</html>