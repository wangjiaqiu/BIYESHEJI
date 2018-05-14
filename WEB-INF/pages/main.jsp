<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
  <head>
	<meta charset="UTF-8">
	<meta name="viewport"
		content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
    <title>微运输后台管理系统</title>
	<c:import url="/common/css/base-css.jsp"></c:import>
	<c:import url="/common/jquery.jsp"></c:import>
	<c:import url="/common/jquery-easyui.jsp"></c:import>
	<c:import url="/common/html5shiv.jsp"></c:import>
  </head>
  
  <body class="easyui-layout">
    <div region="north" style="height:70px; background-color:#3A8FE9; font-size: 18px;">
        <c:import url="/pages/common/logo.jsp"></c:import>
		<!-- LOGO -->
    </div>
    <div region="south" style="height:20px;width:100%;align:center;">
    	<center> Copyright(C) 2014 微运输</center>
    </div>
    <div region="west" title="导航菜单" split="true" style="width: 180px; background:#E3F3FF;">
		<c:if test="${ !empty sessionScope.session_context_user.info.userType }">
			<c:if test="${ sessionScope.session_context_user.info.userType == 'A' }">
				<c:import url="/pages/common/navLevel1.jsp"></c:import>
				<!-- 导航 -->
			</c:if>
			<c:if test="${ sessionScope.session_context_user.info.userType != 'A' }">
				<c:import url="/pages/common/navLevel1.jsp"></c:import>
				<!-- 导航 -->
			</c:if>
		</c:if>
    </div>
    <div region="center">
        <div id="tabPanel">
            <div title="欢迎页">
                <iframe  name="firstPage" scrolling="auto"  frameborder="0" src="<c:url value="/preWelcome.do" />" style="width:100%;height: 99%;"></iframe>
            </div>
        </div>
    </div>
    <div id="password" width=100% align="center">
			<form id="formCondition" action="" enctype="multipart/form-data">
				<table id="base_t" class="tbFormCss" align="center" width=100%>
					<tr>
						<td width="30%" align="right">新密码：</td>
						<td width="70%" align="left"><input type="password"
							id="pwd" name="pwd" style="width: 120px"
							class="easyui-validatebox" maxlength="10" /></td>
					</tr>
					<tr>
						<td width="30%" align="right">确认密码：</td>
						<td width="70%" align="left"><input type="password"
							id="rePwd" name="rePwd" style="width: 120px"
							class="easyui-validatebox" maxlength="10" /></td>
					</tr>
				</table>
				<br />
				<div width=100% align="center">
					<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="btnSubmit">修改</a>&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="btnClose">关闭</a>
				</div>

			</form>
		</div>
  </body>
</html>
