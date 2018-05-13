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
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>微运输</title>
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
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="css/my.css">
<script src="js/jquery.js"></script>
<script src="js/jquery.mobile-1.3.2.min.js"></script>
</head>

<body>
	<div data-role="page" class="jqm-demos" data-quicklinks="true"
		data-theme="b">
		<div data-role="header" data-position="fixed" data-tap-toggle="false"
			data-theme="y">
			<a href="goodadd.jsp" data-ajax="false" data-icon="plus"
				class="ui-btn-right">发货</a>
			<h2>我的货单信息</h2>
		</div>
		<!-- /header -->

		<div data-role="main" data-theme="b">

			<div>
				<table class="dataintable" cellpadding="0" cellspacing="0"
					width=100% id="tablemy">
					<tr align="center" bgcolor="#1ba9ba">
						<th colspan="3" align="center">货单号：NO52563</th>
						<td align="right"><a href="#" data-role="button"
							class="ui-disabled" data-theme="a" data-mini="true">抢单中</a></td>
					</tr>
					<tr>
						<td width=25% align="right">货名：</td>
						<td width=25% align="left">大米</td>
						<td width=25% align="right">货重：</td>
						<td width=25% align="left">10吨/箱</td>
					</tr>
					<tr>
						<td align="right">箱型：</td>
						<td align="left">40尺</td>
						<td align="right">箱属：</td>
						<td align="left">中远</td>
					</tr>
					<tr>
						<td align="right">剩余数量：</td>
						<td align="left"><input type="BoxNumber" name="BoxNumber"
							pattern="[0-9]*" id="BoxNumber" value="26"
							style="width: 60%; height: 24px"> 箱</td>
						<td align="right">总数量：</td>
						<td align="left">26/40箱</td>
					</tr>
					<tr align="center">
						<th colspan="4" style="background-color: #09F;">
							出发地及日期：大连沙河口区 5月2日</th>
					</tr>
					<tr align="center">
						<th colspan="4" style="background-color: #0C0;">送达地及日期鞍山市铁东区
							5月3日</th>
					</tr>
					<tr align="center">
						<th colspan="4">
							<table cellpadding="0" cellspacing="0" width=95% border="2px"
								bordercolor="#666666">
								<tr>
									<td align="center">
										<ul data-role="listview" data-theme="c" id="my-listview"
											data-icon="search">
											<ul data-role="listview" data-theme="d"
												data-divider-theme="d" data-split-icon="search">
												<li data-role="list-divider">抢单司机信息</li>
												<li data-icon="search"><a
													href="dialog-rightclosebtn1.jsp" data-rel="dialog"
													data-transition="pop"> <strong> <span>王大鹏</span>
															<span style="padding-left: 20px">辽B12345</span> <span
															style="padding-left: 20px">2014/05/12 13:18</span></font>
													</strong> <span class="ui-li-count"><font color="#FF0000">
																待确认</font></span>
												</a></li>
												<li data-icon="search"><a
													href="dialog-rightclosebtn1.jsp" data-rel="dialog"
													data-transition="pop"> <strong> <span>王大鹏</span>
															<span style="padding-left: 20px">辽B12345</span> <span
															style="padding-left: 20px">2014/05/12 13:18</span></font>
													</strong> <span class="ui-li-count"><font color="#FF0000">
																已确认</font></span>
												</a></li>
												<li data-icon="search"><a
													href="dialog-rightclosebtn1.jsp" data-rel="dialog"
													data-transition="pop"> <strong> <span>王大鹏</span>
															<span style="padding-left: 20px">辽B12345</span> <span
															style="padding-left: 20px">2014/05/12 13:18</span></font>
													</strong> <span class="ui-li-count"><font color="#FF0000">
																已确认</font></span>
												</a></li>
											</ul>

											<!-- /navbar -->
									</td>
								</tr>
							</table>
						</th>
					</tr>

				</table>

			</div>




			<!-- /content -->
		</div>
		<!-- /page -->
</body>
</html>
