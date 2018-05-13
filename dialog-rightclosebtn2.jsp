<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String openid =request.getParameter("openid"); 
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
<script type="text/javascript">
	$(function() {	
			var oTable = document.getElementById('tablemy');//获取table对象  
			var rows=oTable.rows;  
			for(var i=0;i<rows.length;i++)  
			{  
				if(i%2==0) {  
					rows[i].style.backgroundColor = "#FFFFFF";  
					rows[i].style.color = "#000000";  
				} else {  
					rows[i].style.backgroundColor = "#f6f6f6";  
					rows[i].style.color = "#000000";  
				}  
			}
	});
</script>
</head>
<body>

	<div data-role="page" data-close-btn="right">
		<div data-role="header" data-theme="y">
			<h1>评价司机</h1>
		</div>

		<div data-role="content">
			<table class="dataintable" cellpadding="0" cellspacing="0"
				id="tablemy">
				<tr>
					<th colspan="4">姓名：李小冉</th>
				</tr>
				<tr>
					<th colspan="4">身份证号：210304198811118888</th>
				</tr>
				<tr>
					<td width=25% align="right">车型：</td>
					<td width=25% align="left"><label>一拖二</label></td>
					<td width=25% align="right">载重：</td>
					<td width=25% align="left"><label>20吨</label></td>
				</tr>
				<tr>
					<td align="right">箱型：</td>
					<td align="left">40尺</td>
					<td align="right">箱属：</td>
					<td align="left">中远</td>
				</tr>
				<tr>
					<td align="right">运输数量：</td>
					<td align="left">10箱</td>
					<td align="right">总数量：</td>
					<td align="left">40箱</td>
				</tr>
				<tr>
					<th colspan="4">手机号：13812341234</th>
				</tr>
				<tr>
					<th colspan="4">其他电话：：13812341234</th>
				</tr>
				<tr>
					<th colspan="4">货单号：NO525632</th>
				</tr>

				<tr>
					<th colspan="4">
						<div data-role="navbar" class="ui-body-c">
							<ul>
								<li><a href="#">好评 <span class="ui-li-count">9</span></a></li>
								<li><a href="#">中评 <span class="ui-li-count">6</span></a></li>
								<li><a href="#">差评 <span class="ui-li-count">1</span></a></li>
							</ul>
						</div>
						<!-- /navbar -->

					</th>
				</tr>
				<tr>
					<th colspan="4" align="center"><a href="goodlistownermy.jsp"
						data-role="button" data-icon="arrow-r" style="width: 150px;"
						data-theme="x">提 交</a></th>
				</tr>

			</table>
		</div>
	</div>


</body>
</html>