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
		var CODE_CAUSE_SUCCESS = '<%=Constant.CODE_CAUSE_SUCCESS%>';
		var CODE_CAUSE_FAILURE = '<%=Constant.CODE_CAUSE_FAILURE%>';
		var TRAFFIC_USERTYPE_0 = '<%=Constant.TRAFFIC_USERTYPE_0%>';
		var TRAFFIC_USERTYPE_1 = '<%=Constant.TRAFFIC_USERTYPE_1%>';
		var TRAFFIC_USERTYPE_2 = '<%=Constant.TRAFFIC_USERTYPE_2%>';
		var TRAFFIC_STAUTS_1 = '<%=Constant.TRAFFIC_STAUTS_1%>';
		var TRAFFIC_STAUTS_2 = '<%=Constant.TRAFFIC_STAUTS_2%>';
</script>
<script type="text/javascript" src="<c:url value="/pages/traffic/trafficlist.js" />"></script>
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
									<td><label for="startTime">发布日期：</label> <input
										type="text" style="width: 120px;" name="startTime"
										id="startTime" class="easyui-datebox" /> <label for="endTime">&nbsp;&nbsp;~&nbsp;&nbsp;</label>
										<input type="text" style="width: 120px;" name="endTime"
										id="endTime" class="easyui-datebox" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="right"></br> <a href="#" class="easyui-linkbutton"
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
	<div id="traffic" width=100% align="left">
		<form id="formCondition" action="" method="post"
			enctype="multipart/form-data">
			<table id="base_t" class="tbFormCss" align="center" width=100%>
				<br />
				<tr>
					<td width="20%" style="font-weight: bold;" align="right">省：</td>
					<td width="10%" align="left"><select id="province"  style="width:80px"></select></td>
					<td width="10%" style="font-weight: bold;" align="right">市：</td>
					<td width="20%" align="left"><select id="city" style="width:90px"></select></td>
					<td width="10%" style="font-weight: bold; display:none;" align="right">区111：</td>
					<td width="30%" style="display:none;" align="left"><select id="area" style="width:120px"></select></td>
				</tr>
				<tr>
					<td width="20%" style="font-weight: bold;" align="right">路况描述：</td>
					<td width="80%" align="left" colspan="5">
						<textarea rows="5" cols="50" id="note" name="note"></textarea>
					</td>
				</tr>
			</table>
			<br />
			<div width=100% align="center">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok"
					id="btnSubmit">保存</a>&nbsp;&nbsp; <a href="#"
					class="easyui-linkbutton" iconCls="icon-cancel" id="btnClose">关闭</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		addressInit('province', 'city', 'area');
	</script>
</body>
</html>
