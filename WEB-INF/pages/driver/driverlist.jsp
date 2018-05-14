<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
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
		var driverId_pub='';
		var driverStatus_pub = '';
		var CODE_CAUSE_SUCCESS = '<%=Constant.CODE_CAUSE_SUCCESS%>';
		var CODE_CAUSE_FAILURE = '<%=Constant.CODE_CAUSE_FAILURE%>';
		var DOTYPE_ADD ='<%=Constant.DOTYPE_ADD%>';
		var DOTYPE_UPDATE ='<%=Constant.DOTYPE_UPDATE%>';
		var STATUS_OPEN='<%=Constant.STATUS_OPEN%>';
		var STATUS_STOP='<%=Constant.STATUS_STOP%>';
</script>
<script type="text/javascript" src="<c:url value="/pages/driver/driverlist.js" />"></script>
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
			style="padding: 6px; width: 1000px;" align="center">
			<form id="formCondition_query">
				<table>
					<tr>
						<td>
							<table width="100%">
								<tr>
									<td><label for="query_driverName">姓名：</label> </td>
									<td><input type="text" style="width: 120px;" name="query_driverName"
										id="query_driverName" class="easyui-validatebox" /> 
									</td>	
									<td><label for="query_autoNo">车牌号</label></td>
									<td><input type="text" style="width: 120px;" name="query_autoNo"
										id="query_autoNo" class="easyui-validatebox" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right" colspan="4"></br> <a href="#" class="easyui-linkbutton"
							id="btnSearch">查询</a>&nbsp; <a href="#"
							class="easyui-linkbutton" id="btnReset">重置</a></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<br />
	<div>
		<table id="grid1"></table>
	</div>
	<div id="driver" width=100% align="left">
		<form id="formCondition" action="" method="post" enctype="multipart/form-data" >
			<input type="hidden" id="doType" name="doType"/>
			<input type="hidden" id="driverId" name="driverId"/>
			<table id="base_t" class="ordersInfoCss" width=100%>
				<br/>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">姓名：</td>
					<td width="35%" align="left">
						<input type="text" id="driverName" name="driverName" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%" style="font-weight: bold;" align="left">手机号：</td>
					<td width="35%" align="left">
						<input type="text" id="phoneNo" name="phoneNo" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">车牌号：</td>
					<td width="35%" align="left">
						<input type="text" id="autoNo" name="autoNo" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">车型：</td>
					<td width="35%" align="left">
						<input class="easyui-combobox" id="autoTypeId" name="autoTypeId" valueField="autotypeid" textField="autotypename" 
						   panelHeight="auto" panelWidth="auto" style="width:150px" editable="false" />
					</td>
				</tr>
				<tr>
					<td width="15%"  style="font-weight: bold;" align="left">载重：</td>
					<td width="35%" align="left">
						<input type="text" id="loadNum" name="loadNum" style="width:150px" class="easyui-numberbox" precision=0 min="1" max="999" required="true" >
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">身份证号：</td>
					<td width="35%" align="left">
						<input type="text" id="idcardNo" name="idcardNo" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
				</tr>
				<tr>
					<td width="15%"  style="font-weight: bold;" align="left">其他手机：</td>
					<td width="35%" align="left">
						<input type="text" id="otherPhoneNo" name="otherPhoneNo" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left"></td>
					<td width="35%" align="left"></td>
				</tr>
				<tr>
					<td width="15%"  style="font-weight: bold;" align="left">开户银行：</td>
					<td width="35%" align="left">
						<input type="text" id="bankName" name="bankName" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">开户账号：</td>
					<td width="35%" align="left">
						<input type="text" id="bankCount" name="bankCount" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
				</tr>
			</table>
			<br/><br/>
			<div width=100% align="center">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="btnSubmit">保存</a>&nbsp;&nbsp;
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="btnClose">关闭</a>
			</div>
		</form>
		</div>
		<div id="div_driverinfo" title="司机详细信息">
			<form id="formCondition_ordersInfo" method="post" contentType="charset=GBK">
				<br/>
				<table id="driverInfo" class="ordersInfoCss" width="100%" height="100%" border="2"></table>
				<br/>
				<div width=100% align="center">
					<a href="#" class="easyui-linkbutton" iconCls="icon-edit" id="btnModStatus">更新状态</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" iconCls="icon-remove" id="btnClose_info">关闭</a>
				</div>
			</form>
		</div>
		
</body>
</html>
