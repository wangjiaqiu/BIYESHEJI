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
		var ownerId_pub='';
		var ownerStatus_pub = '';
		var CODE_CAUSE_SUCCESS = '<%=Constant.CODE_CAUSE_SUCCESS%>';
		var CODE_CAUSE_FAILURE = '<%=Constant.CODE_CAUSE_FAILURE%>';
		var DOTYPE_ADD ='<%=Constant.DOTYPE_ADD%>';
		var DOTYPE_UPDATE ='<%=Constant.DOTYPE_UPDATE%>';
		var STATUS_OPEN='<%=Constant.STATUS_OPEN%>';
		var STATUS_STOP='<%=Constant.STATUS_STOP%>';
		var ROLE_TYPE_P='<%=Constant.ROLE_TYPE_P%>';
</script>
<script type="text/javascript" src="<c:url value="/pages/owner/person/personownerlist.js" />"></script>
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
									<td><label for="query_personOwnerName">姓名：</label> </td>
									<td><input type="text" style="width: 120px;" name="query_personOwnerName"
										id="query_personOwnerName" class="easyui-validatebox" /> 
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
	<div id="personowner" width=100% align="left">
		<form id="formCondition" action="" method="post" enctype="multipart/form-data" >
			<input type="hidden" id="ownerId" name="ownerId"/>
			<table id="base_t" class="ordersInfoCss" width=100%>
				<br/>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">登录名：</td>
					<td width="35%" align="left">
						<input type="text" id="userName" name="userName" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%" style="font-weight: bold;" align="left">密码：</td>
					<td width="35%" align="left">
						<font color="red">初始密码：654123</font>
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">姓名：</td>
					<td width="35%" align="left">
						<input type="text" id="ownerName" name="ownerName" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%" style="font-weight: bold;" align="left">身份证号：</td>
					<td width="35%" align="left">
						<input type="text" id="idcardNo" name="idcardNo" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">手机号：</td>
					<td width="35%" align="left">
						<input type="text" id="phoneNo" name="phoneNo" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">其他手机：</td>
					<td width="35%" align="left">
						<input type="text" id="otherPhoneNo" name="otherPhoneNo" style="width:150px" class="easyui-validatebox"  maxlength="30"/></td>
				</tr>
				<tr>
					<td width="15%"  style="font-weight: bold;" align="left">开户银行：</td>
					<td width="35%" align="left">
						<input type="text" id="bankName" name="bankName" style="width:150px" class="easyui-validatebox"  maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">开户账号：</td>
					<td width="35%" align="left">
						<input type="text" id="bankCount" name="bankCount" style="width:150px" class="easyui-validatebox" maxlength="30"/>
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
		<div id="MOD_personowner" width=100% align="left">
		<form id="MOD_formCondition" action="" method="post" enctype="multipart/form-data" >
			<input type="hidden" id="MOD_ownerId" name="MOD_ownerId"/>
			<table id="base_t" class="ordersInfoCss" width=100%>
				<br/>
					<tr>
					<td width="15%" style="font-weight: bold;" align="left">登录名：</td>
					<td width="35%" align="left" id="MOD_userName">
						
					</td>
					<td width="15%" style="font-weight: bold;" align="left"></td>
					<td width="35%" align="left">
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">姓名：</td>
					<td width="35%" align="left" id="MOD_ownerName">
						
					</td>
					<td width="15%" style="font-weight: bold;" align="left">身份证号：</td>
					<td width="35%" align="left" id="MOD_idcardNo">
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">手机号：</td>
					<td width="35%" align="left">
					<input type="text" id="MOD_phoneNo" name="MOD_phoneNo" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">其他手机：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_otherPhoneNo" name="MOD_otherPhoneNo" style="width:150px" class="easyui-validatebox"  maxlength="30"/></td>
				</tr>
				<tr>
					<td width="15%"  style="font-weight: bold;" align="left">开户银行：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_bankName" name="MOD_bankName" style="width:150px" class="easyui-validatebox" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">开户账号：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_bankCount" name="MOD_bankCount" style="width:150px" class="easyui-validatebox" maxlength="30"/>
					</td>
				</tr>
			</table>
			<br/><br/>
			<div width=100% align="center">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" id="btnMODSubmit">保存</a>&nbsp;&nbsp;
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" id="btnMODClose">关闭</a>
			</div>
		</form>
		</div>
		<div id="div_personownerinfo" title="个人货主详细信息">
			<form id="formCondition_ordersInfo" method="post" contentType="charset=GBK">
				<br/>
				<table id="personownerInfo" class="ordersInfoCss" width="100%" height="100%" border="2"></table>
				<br/>
				<div width=100% align="center">
					<a href="#" class="easyui-linkbutton" iconCls="icon-edit" id="btnStatus">更新状态</a>&nbsp;&nbsp;&nbsp;
					<a href="#" class="easyui-linkbutton" iconCls="icon-remove" id="btnClose_info">关闭</a>
				</div>
			</form>
		</div>
		
</body>
</html>
