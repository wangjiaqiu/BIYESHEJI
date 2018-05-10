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
	window.setInterval('refreshCalendarClock()', 1000);
		var path = '<%=path%>';

	$(function() {
		
		/* 提交按钮点击事件 */
		$("#btnSubmit").click(function() {
			rePwd();
		});

		/* 重置按钮点击事件 */
		$("#btnReset").click(function() {
			document.getElementById("formCondition").reset();
		});
	})

	function Year_Month() {
		var now = new Date();
		var mm = now.getMonth();
		var mmm = new Array();
		mmm[0] = "1";
		mmm[1] = "2";
		mmm[2] = "3";
		mmm[3] = "4";
		mmm[4] = "5";
		mmm[5] = "6";
		mmm[6] = "7";
		mmm[7] = "8";
		mmm[8] = "9";
		mmm[9] = "10";
		mmm[10] = "11";
		mmm[11] = "12";
		mm = mmm[mm];
		return (mm);
	}

	function thisYear() {
		var now = new Date();
		var yy = now.getFullYear();
		return (yy);
	}

	function Date_of_Today() {
		var now = new Date();
		return (now.getDate());
	}

	function CurentTime() {
		var now = new Date();
		var hh = now.getHours();
		var mm = now.getMinutes();
		var ss = now.getTime() % 60000;
		ss = (ss - (ss % 1000)) / 1000;
		var clock = hh + ':';
		if (mm < 10)
			clock += '0';
		clock += mm + ':';

		if (ss < 10)
			clock += '0';
		clock += ss;
		return (clock);
	}

	function refreshCalendarClock() {
		var time = thisYear() + "年" + Year_Month() + "月" + Date_of_Today()
				+ "日 " + CurentTime();
		$("#time").html(
				'<tr><td><font size="3" face="arial" color="blue">' + time
						+ '</font></br></td></tr>');
	}
</script>
</head>
<body class="easyui-layout">
	<div region="center" style="padding: 220px 220px; background: #E3F3FF;">
		<img src="<c:url value="/images/welcome.png" />">
	</div>
	<div region="east" style="width: 250px; background: #E3F3FF;">
		<div class="easyui-panel" title="时间" icon="pnl-icon3"
			style="padding: 10px; background: #E3F3FF;">
			<table id="time" align="center">
			</table>
		</div>
	</div>
</body>
</html>
