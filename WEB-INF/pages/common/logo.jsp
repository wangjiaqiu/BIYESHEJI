<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String path = request.getContextPath();
%>
<script type="text/javascript">
	var path = '<%=path%>';
	$(function() {	
		
		// 修改密码弹出层
		$("#password").dialog({
			height : 170,
			width : 260,
			modal : true,
			resizable : false,
			closed : true
		});
		
		/* 提交按钮点击事件 */
		$("#btnSubmit").click(function() {
			rePwd();
		});

		/* 关闭按钮点击事件 */
		$("#btnClose").click(function() {
			document.getElementById("formCondition").reset();
			$("#password").dialog("close");
		});
	})
	
	function prePassword(){
		$("#password").dialog("setTitle", "修改密码");
		$("#password").dialog("open");
		document.getElementById("formCondition").reset();
	}
	//修改密码校验
	function preRePwd(password,rePassword) {
		if (password == null || password == "") {
			$.messager.alert("提示", "新密码不能为空!", "info");
			return false;
		} else {
			if (rePassword == null || rePassword == "") {
				$.messager.alert("提示", "确认密码不能为空!", "info");
				return false;
			} else {
				if (rePassword == password) {
					return true;
				} else {
					$.messager.alert("提示", "新密码与确认密码不同!", "info");
					return false;
				}
			}
		}
	}

	
	//修改密码
	function rePwd() {
		var password = $("#pwd").val();
		var rePassword = $("#rePwd").val();
		if (preRePwd(password,rePassword)) {		
			$.ajax({
				type : "post",
				url : path + "/rePassword.do",
				dataType : "json",
				data : {
					"password" : password
				},
				cache : false,
				success : function(r) {
					document.getElementById("formCondition").reset();
					if (r.code) {	
						$("#password").dialog("close");
						$.messager.show({
							title : "提示",
							msg : "密码修改成功!",
							timeout : 3000
						});

					} else {
						$.messager.alert("提示", "密码修改失败！", "info");
					}
				},
				error : function(request, errinfo, errobject) {
					$.messager.alert("系统错误", "密码修改失败！" + errobject, "error");
				}
			});
		}
	}
</script>
<div class="page-logo">
	&nbsp;<img src="<c:url value="/images/logo.png" />">
	<c:if test="${ !empty sessionScope.session_context_user.info.ownerName }">
		<span style="float:right;color:#E3F3FF">
			${sessionScope.session_context_user.info.ownerName }&nbsp;
			[<a href="#" onclick="prePassword();"><font color="#E3F3FF">修改密码</font></a>&nbsp;|&nbsp;<a href="<c:url value="/logout.do" />"><font color="#E3F3FF">安全退出</font></a>]
		</span>
	</c:if>
</div>