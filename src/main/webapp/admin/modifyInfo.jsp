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

<script type="text/javascript">
	
	function submitData(){
		var nickName = $("#nickName").val();
		var sign = $("#sign").val();
		var editor = UE.getEditor('editor').getContent();
		if(nickName==null || nickName==""){
			alert("请输入昵称！");
		}else if(sign==null || sign==''){
			alert("请输入个性签名！");
		}else if(editor==null || editor==''){
			alert("请输入个人简介！");
		}else{
			$("#profile").val(editor);
			$("#fm").submit();
		}
	}
	
</script>
</head>
<body>
	<div id="p" class="easyui-panel" title="编写博客" style="width:99%;background:#fafafa;">
		<form id="fm" action="${pageContext.request.contextPath}/admin/user/save.do" method="post" enctype="multipart/form-data">
			<table cellpadding="5px">
				<tr>
					<td style="width: 80px">用户名：</td>
					<td>
						<input type="text" id="userName" name="userName" readonly="readonly" value="${currentUser.userName }"/>
						<input type="hidden" id="id" name="id" readonly="readonly" value="${currentUser.id }"/>
					</td>
				</tr>
				<tr>
					<td>昵称：</td>
					<td>
						<input type="text" id="nickName" name="nickName" />
					</td>
				</tr>
				<tr>
					<td>个性签名：</td>
					<td>
						<input type="text" id="sign" name="sign"  style="width: 400px"/>
					</td>
				</tr>
				<tr>
					<td>个人头像：</td>
					<td>
						<input type="file" id="imageFile" name="imageFile"/>
					</td>
				</tr>
				<tr>
					<td>个人简介：</td>
					<td>
						<script id="editor" name="editor" type="text/plain" style="height:400px;width:99.9%;"></script>
						<input type="hidden" id="profile" name="profile"/>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-publish'" >提交</a>
					</td>
				</tr>
			</table>
		</form>
    </div>
    <script type="text/javascript">
        var ue = UE.getEditor('editor');
       
        ue.addListener("ready",function(){
        	// 通过ajax请求数据
        	UE.ajax.request("${pageContext.request.contextPath}/admin/user/getUserInfo.do",
        			{
        				method:"post",
        				async:false,
        				data:{userName:'${currentUser.userName}'},
        				 //请求成功后的回调， 该回调接受当前的XMLHttpRequest对象作为参数。
        				onsuccess:function(result){
        					result=eval("("+result.responseText+")");
        					$("#nickName").val(result.nickName);
        					$("#sign").val(result.sign);
        					UE.getEditor('editor').setContent(result.profile);
        				}
       			});
        });
       /* ue.editor.fireEvent("ready"); */
    </script>
</body>
</html>