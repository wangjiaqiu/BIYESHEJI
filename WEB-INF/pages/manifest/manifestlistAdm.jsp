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
<script type="text/javascript" src="<c:url value="/pages/traffic/jsAddress.js" />"></script>
<script type="text/javascript">
		var path = '<%=path%>';
		var ps = '';
		var manifestId_pub='';
		var manifestStatus_pub = '';
		var CODE_CAUSE_SUCCESS = '<%=Constant.CODE_CAUSE_SUCCESS%>';
		var CODE_CAUSE_FAILURE = '<%=Constant.CODE_CAUSE_FAILURE%>';
		var DOTYPE_ADD ='<%=Constant.DOTYPE_ADD%>';
		var DOTYPE_UPDATE ='<%=Constant.DOTYPE_UPDATE%>';
		var MANIFEST_STATUS_1='<%=Constant.MANIFEST_STATUS_1%>';
		var MANIFEST_STATUS_2='<%=Constant.MANIFEST_STATUS_2%>';
		var MANIFEST_STATUS_3='<%=Constant.MANIFEST_STATUS_3%>';
		var APPRAISETYPE_1='<%=Constant.APPRAISETYPE_1%>';
		
</script>
<script type="text/javascript" src="<c:url value="/pages/manifest/manifestlistAdm.js" />"></script>
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
									<td><label for="query_manifestId">货单号：</label> </td>
									<td><input type="text" style="width: 120px;" name="query_manifestId"
										id="query_manifestId" class="easyui-validatebox" /> 
									</td>
									<td><label for="query_manifestName">货名：</label> </td>
									<td><input type="text" style="width: 120px;" name="query_manifestName"
										id="query_manifestName" class="easyui-validatebox" /> 
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
	<div id="manifest" width=100% align="left">
		<form id="formCondition" action="" method="post" enctype="multipart/form-data" >
			<input type="hidden" id="manifestId" name="manifestId"/>
			<table id="base_t" class="ordersInfoCss" width=100%>
				<br/>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">货名：</td>
					<td width="35%" align="left">
						<input type="text" id="manifestName" name="manifestName" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%" style="font-weight: bold;" align="left">货重：</td>
					<td width="35%" align="left">
						<input type="text" id="weight" name="weight" style="width:150px" class="easyui-numberbox" precision=0 min="1" max="9999999" required="true" >&nbsp;&nbsp;吨/箱
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">需求箱型：</td>
					<td width="35%" align="left">
						<input class="easyui-combobox" id="boxTypeId" name="boxTypeId" valueField="boxtypeid" textField="boxtypename" 
						   panelHeight="auto" panelWidth="auto" style="width:150px" editable="false" />
					</td>
					<td width="15%" style="font-weight: bold;" align="left">箱属：</td>
					<td width="35%" align="left">
						<input class="easyui-combobox" id="boxOwnerId" name="boxOwnerId" valueField="boxownerid" textField="boxownername" 
						   panelHeight="auto" panelWidth="auto" style="width:150px" editable="false" />
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">箱数：</td>
					<td width="35%" align="left">
						<input type="text" id="boxNum" name="boxNum" style="width:150px" class="easyui-numberbox" precision=0 min="1" max="99999999" required="true" >&nbsp;&nbsp;箱
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">价格：</td>
					<td width="35%" align="left">
						<input type="text" id="price" name="price" style="width:150px" class="easyui-numberbox" precision=2 min="1" max="99999999" required="true" >&nbsp;&nbsp;元
					</td>
				</tr>
				<tr>
					<td width="15%"  style="font-weight: bold;" align="left">收货联系人：</td>
					<td width="35%" align="left">
						<input type="text" id="contact" name="contact" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">收货人手机：</td>
					<td width="35%" align="left">
						<input type="text" id="contactPhone" name="contactPhone" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
				</tr>
			</table>
			<table id="base_t1" class="ordersInfoCss" width=100%>
				<tr>
					<td style="font-weight: bold;" align="left" colspan="8">发货地址</td>
				</tr>
				<tr>
					<td width="10%" style="font-weight: bold;" align="right">省：</td>
					<td width="10%" align="left"><select id="sendProvince"  style="width:80px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">市：</td>
					<td width="10%" align="left"><select id="sendCity" style="width:90px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">区：</td>
					<td width="10%" align="left"><select id="sendArea" style="width:120px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">日期：</td>
					<td width="30%" align="left">
					<input type="text" style="width:120px;"  name="sendDate" id="sendDate" required="true" class="easyui-datebox"/>
					</td>
				</tr>
			</table>
			<table id="base_t2" class="ordersInfoCss" width=100%>
				<tr>
					<td style="font-weight: bold;" align="left" colspan="8">收货地址</td>
				</tr>
				<tr>
					<td width="10%" style="font-weight: bold;" align="right">省：</td>
					<td width="10%" align="left"><select id="receiveProvince"  style="width:80px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">市：</td>
					<td width="10%" align="left"><select id="receiveCity" style="width:90px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">区：</td>
					<td width="10%" align="left"><select id="receiveArea" style="width:120px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">日期：</td>
					<td width="30%" align="left">
					<input type="text" style="width:120px;" name="receiveDate" id="receiveDate" required="true" class="easyui-datebox" r/>
					</td>
				</tr>
			</table>
			<table id="base_t3" class="ordersInfoCss" width=100%>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">备注：</td>
					<td width="85%" align="left" colspan="5">
						<textarea rows="3" cols="50" id="remark" name="remark"></textarea>
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
		
		<div id="MOD_manifest" width=100% align="left">
		<form id="MOD_formCondition" action="" method="post" enctype="multipart/form-data" >
			<input type="hidden" id="MOD_manifestId" name="MOD_manifestId"/>
			<table id="base_t" class="ordersInfoCss" width=100%>
				<br/>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">货名：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_manifestName" name="MOD_manifestName" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%" style="font-weight: bold;" align="left">货重：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_weight" name="MOD_weight" style="width:150px" class="easyui-numberbox" precision=0 min="1" max="9999999" required="true" >&nbsp;&nbsp;吨/箱
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">需求箱型：</td>
					<td width="35%" align="left">
						<input class="easyui-combobox" id="MOD_boxTypeId" name="MOD_boxTypeId" valueField="boxtypeid" textField="boxtypename" 
						   panelHeight="auto" panelWidth="auto" style="width:150px" editable="false" />
					</td>
					<td width="15%" style="font-weight: bold;" align="left">箱属：</td>
					<td width="35%" align="left">
						<input class="easyui-combobox" id="MOD_boxOwnerId" name="MOD_boxOwnerId" valueField="boxownerid" textField="boxownername" 
						   panelHeight="auto" panelWidth="auto" style="width:150px" editable="false" />
					</td>
				</tr>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">箱数：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_boxNum" name="MOD_boxNum" style="width:150px" class="easyui-numberbox" precision=0 min="1" max="99999999" required="true" >&nbsp;&nbsp;箱
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">价格：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_price" name="MOD_price" style="width:150px" class="easyui-numberbox" precision=2 min="1" max="99999999" required="true" >&nbsp;&nbsp;元
					</td>
				</tr>
				<tr>
					<td width="15%"  style="font-weight: bold;" align="left">收货联系人：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_contact" name="MOD_contact" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
					<td width="15%"  style="font-weight: bold;" align="left">收货人手机：</td>
					<td width="35%" align="left">
						<input type="text" id="MOD_contactPhone" name="MOD_contactPhone" style="width:150px" class="easyui-validatebox" required="true" maxlength="30"/>
					</td>
				</tr>
			</table>
			<table id="base_t1" class="ordersInfoCss" width=100%>
				<tr>
					<td style="font-weight: bold;" align="left" colspan="8">发货地址</td>
				</tr>
				<tr>
					<td width="10%" style="font-weight: bold;" align="right">省：</td>
					<td width="10%" align="left"><select id="MOD_sendProvince"  style="width:80px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">市：</td>
					<td width="10%" align="left"><select id="MOD_sendCity" style="width:90px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">区：</td>
					<td width="10%" align="left"><select id="MOD_sendArea" style="width:120px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">日期：</td>
					<td width="30%" align="left">
					<input type="text" style="width:120px;"  name="MOD_sendDate" id="MOD_sendDate" required="true" class="easyui-datebox"/>
					</td>
				</tr>
			</table>
			<table id="base_t2" class="ordersInfoCss" width=100%>
				<tr>
					<td style="font-weight: bold;" align="left" colspan="8">收货地址</td>
				</tr>
				<tr>
					<td width="10%" style="font-weight: bold;" align="right">省：</td>
					<td width="10%" align="left"><select id="MOD_receiveProvince"  style="width:80px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">市：</td>
					<td width="10%" align="left"><select id="MOD_receiveCity" style="width:90px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">区：</td>
					<td width="10%" align="left"><select id="MOD_receiveArea" style="width:120px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">日期：</td>
					<td width="30%" align="left">
					<input type="text" style="width:120px;" name="MOD_receiveDate" id="MOD_receiveDate" required="true" class="easyui-datebox" r/>
					</td>
				</tr>
			</table>
			<table id="base_t3" class="ordersInfoCss" width=100%>
				<tr>
					<td width="15%" style="font-weight: bold;" align="left">备注：</td>
					<td width="85%" align="left" colspan="5">
						<textarea rows="3" cols="50" id="MOD_remark" name="MOD_remark"></textarea>
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
		
	<script type="text/javascript">
		addressInit('sendProvince', 'sendCity', 'sendArea');
	</script>
	<script type="text/javascript">
		addressInit('receiveProvince', 'receiveCity', 'receiveArea');
	</script>
	<script type="text/javascript">
		addressInit('MOD_sendProvince', 'MOD_sendCity', 'MOD_sendArea');
	</script>
	<script type="text/javascript">
		addressInit('MOD_receiveProvince', 'MOD_receiveCity', 'MOD_receiveArea');
	</script>
</body>
</html>
