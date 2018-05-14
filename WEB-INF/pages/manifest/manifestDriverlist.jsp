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
		var MANIFEST_STATUS_3='<%=Constant.MANIFEST_STATUS_3%>';
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
		var grabMoneyOwner_0='<%=Constant.grabMoneyOwner_0%>';
		var grabMoneyOwner_1='<%=Constant.grabMoneyOwner_1%>';
</script>
<script type="text/javascript" src="<c:url value="/pages/manifest/manifestDriverlist.js" />"></script>
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
	<br/>
		<div id="div_driverinfo" title="抢单处理">
			<form id="formCondition" method="post" contentType="charset=GBK">
				<br/>
				<table id="driverInfo" class="ordersInfoCss" width="100%" height="100%" border="0"></table>
				<table id="grabmanifest" class="ordersInfoCss" width="100%" height="100%" border="0" align="center">
					<tr>
						<td width="33%" style="font-weight: bold;" align="center" id="grade1"></td>
						<td width="34%" style="font-weight: bold;" align="center" id="grade2"></td>
						<td width="33%" style="font-weight: bold;" align="center" id="grade3"></td>						
					</tr>
				</table>
				<table id="grabmanifest1" class="ordersInfoCss" width="100%" height="100%" border="0" align="center">
					<input type="hidden" id="grabId" name="grabId">
					<input type="hidden" id="vargrabBoxNum" name="vargrabBoxNum">
					<input type="hidden" id="varsyBoxNum" name="varsyBoxNum">					
					<input type="hidden" id="grabStatus" name="grabStatus">
					<input type="hidden" id="driverId" name="driverId">
					<tr>
						<td width="20%" style="font-weight: bold;" align="right">抢单箱数：</td>
						<td width="20%" id="grabBoxNum"></td>
						<td width="20%" style="font-weight: bold;" align="right">运费：</td>
						<td width="40%"><input type="text" id="grabPrice" name="grabPrice" style="width:100px" class="easyui-numberbox" precision=2 min="1" max="99999999" >&nbsp;&nbsp;元</td>
					</tr>
				</table>
				<br/>
				<div width=100% align="center">
					<a href="#" class="easyui-linkbutton" id="btnSubmit">确认抢单</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" id="btnSubmitNO">拒绝抢单</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" id="btnClose">关闭</a>
				</div>
			</form>
		</div>
		
		<div id="get_driverinfo" title="收货处理">
			<form id="formCondition_get" method="post" contentType="charset=GBK">
				<br/>
				<table id="getDriverInfo" class="ordersInfoCss" width="100%" height="100%" border="2"></table>
				<table id="getmanifest" class="ordersInfoCss" width="100%" height="100%" border="2">
					<input type="hidden" id="get_grabId" name="get_grabId">
					<input type="hidden" id="get_grabStatus" name="get_grabStatus">
					<tr>
						<td width="30%" style="font-weight: bold;" align="right">抢单箱数：</td>
						<td width="20%" id="get_grabBoxNum"></td>
						<td width="30%" style="font-weight: bold;" align="right">运费：</td>
						<td width="20%" id="get_grabPrice"></td>
					</tr>
				</table>
				<br/>
<!-- 				<div id="get" width=100% align="center"> -->
<!-- 					<a href="#" class="easyui-linkbutton" iconCls="icon-edit" id="btnGetSubmit">确认收货</a>&nbsp;&nbsp;&nbsp; -->
<!-- 					<a href="#" class="easyui-linkbutton" iconCls="icon-remove" id="btnGetClose">关闭</a> -->
<!-- 				</div> -->
				<div id="app" width=100% align="center">
					<a href="#" class="easyui-linkbutton" id="btnGrade1Submit">好评</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" id="btnGrade2Submit">中评</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" id="btnGrade3Submit">差评</a>
				</div>
			</form>
		</div>
		
		<div id="pay_driverinfo" title="收货处理">
			<form id="formCondition_pay" method="post" contentType="charset=GBK">
				<br/>
				<table id="payDriverInfo" class="ordersInfoCss" width="100%" height="100%" border="2"></table>
				<table id="paymanifest" class="ordersInfoCss" width="100%" height="100%" border="2">
					<input type="hidden" id="pay_grabId" name="pay_grabId">
					<tr>
						<td width="30%" style="font-weight: bold;" align="right">抢单箱数：</td>
						<td width="20%" id="pay_grabBoxNum"></td>
						<td width="30%" style="font-weight: bold;" align="right">运费：</td>
						<td width="20%" id="pay_grabPrice"></td>
					</tr>
				</table>
				<br/>
				<div id="pay" width=100% align="center">
					<a href="#" class="easyui-linkbutton" id="btnPaySubmit">已支付</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" id="btnPayClose">关闭</a>
				</div>
			</form>
		</div>
</body>
</html>
