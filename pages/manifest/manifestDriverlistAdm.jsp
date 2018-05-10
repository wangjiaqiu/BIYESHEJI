<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String manifestId = (String)request.getAttribute("manifestId");
%>
<%@page import="com.tpmgr.manage.utils.Constant"%>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
<title>微运输后台管理系统</title>
<c:import url="/common/css/base-css.jsp"></c:import>
<c:import url="/common/jquery.jsp"></c:import>
<c:import url="/common/jquery-easyui.jsp"></c:import>
<c:import url="/common/html5shiv.jsp"></c:import>
<c:import url="/common/default.jsp"></c:import>
<script type="text/javascript">
		var path = '<%=path%>';
		var ps = '';
		var manifestId='<%=manifestId%>';
		var CODE_CAUSE_SUCCESS = '<%=Constant.CODE_CAUSE_SUCCESS%>';
		var CODE_CAUSE_FAILURE = '<%=Constant.CODE_CAUSE_FAILURE%>';
		var DOTYPE_ADD ='<%=Constant.DOTYPE_ADD%>';
		var DOTYPE_UPDATE ='<%=Constant.DOTYPE_UPDATE%>';
		var MANIFEST_STATUS_1='<%=Constant.MANIFEST_STATUS_1%>';
		var MANIFEST_STATUS_2='<%=Constant.MANIFEST_STATUS_2%>';
		var MANIFEST_STATUS_2='<%=Constant.MANIFEST_STATUS_3%>';
		var STATUS_OPEN='<%=Constant.STATUS_OPEN%>';
		var STATUS_STOP='<%=Constant.STATUS_STOP%>';
		var APPRAISETYPE_1='<%=Constant.APPRAISETYPE_1%>';
		var APPRAISETYPE_2='<%=Constant.APPRAISETYPE_2%>';
		var GRADE_1='<%=Constant.GRADE_1%>';
		var GRADE_2='<%=Constant.GRADE_2%>';
		var GRADE_3='<%=Constant.GRADE_3%>';
		
		var GRABSTATUS_1='<%=Constant.GRABSTATUS_1%>';
		var GRABSTATUS_2='<%=Constant.GRABSTATUS_2%>';
		var GRABSTATUS_3='<%=Constant.GRABSTATUS_3%>';
</script>
<script type="text/javascript" src="<c:url value="/pages/manifest/manifestDriverlistAdm.js" />"></script>
<style>
		table.ordersInfoCss tr td {
			border: 10px solid #ffffff;
			padding: 2 5 2 5;
		}
	</style>
</head>
<body>
	<div align="center">
		<div id="pnlQuery" class="easyui-panel query-panel" collapsible="true"
			style="padding: 3px; width: 700px;" align="left">
			<form id="formCondition_query">
					<table id="manifestInfo" class="ordersInfoCss" width="100%" height="100%" border="0"></table>
					<table id="sendInfo" class="ordersInfoCss" width="100%" height="100%" border="0"></table>
					<table id="receiveInfo" class="ordersInfoCss" width="100%" height="100%" border="0"></table>
					<table id="remarkInfo" class="ordersInfoCss" width="100%" height="100%" border="0"></table>	
					<table id="grabInfo" class="ordersInfoCss" width="100%" height="100%" border="0"></table>	
			</form>
		</div>
	</div>
	<div>
		<table id="grid1"></table>
	</div>
</body>
</html>
