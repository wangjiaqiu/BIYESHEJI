<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<% 
String path = request.getContextPath();
%>
<%@page import="com.tpmgr.manage.utils.Constant" %>
   <head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
    <title>微运输后台管理系统</title>
	<c:import url="/common/css/base-css.jsp"></c:import>
	<c:import url="/common/jquery.jsp"></c:import>
	<c:import url="/common/jquery-easyui.jsp"></c:import>
	<c:import url="/common/html5shiv.jsp"></c:import>
	<c:import url="/common/default.jsp"></c:import>
	<script type="text/javascript">
		var path = '<%=path%>';
		var ps = '';
		var CODE_CAUSE_SUCCESS = '<%=Constant.CODE_CAUSE_SUCCESS%>';
		var CODE_CAUSE_FAILURE = '<%=Constant.CODE_CAUSE_FAILURE%>';
	</script>	
	<script type="text/javascript" src="<c:url value="/pages/basicdata/boxownerlist.js" />"></script>
  </head>
<body>
	<div>
		<table id="grid1"></table>
	</div>
	<div id="boxowner" width=100% align="left">
		<form id="formCondition" action="" method="post" enctype="multipart/form-data">
			<table id="base_t" class="tbFormCss" align="center" width=100%>
				<br/>
				<tr>
					<td width="30%" style="font-weight: bold;" align="right">箱属名称：</td>
					<td width="70%" align="left">
						<input type="text" id="boxOwnerName" name="boxOwnerName" style="width:120px" class="easyui-validatebox" required="true" maxlength="10"/>
					</td>
				</tr>
			</table>
			<br/>
			<div width=100% align="center">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="btnSubmit">保存</a>&nbsp;&nbsp;
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="btnClose">关闭</a>
			</div>
		</form>
	</div>
</body>
</html>
