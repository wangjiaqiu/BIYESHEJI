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
	href="../../css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="../../css/my.css">
<script src="../../js/jquery.js"></script>
<script src="../../js/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript" src="../../js/jsAddress.js"></script>
<script type="text/javascript">
    var myGoto = function(id){
        var a = document.getElementById(id);
        window.scroll(0,a.offsetTop);
    }
</script>
<title>JS锚点</title>
</head>
<body>

<script type="text/javascript">
	function click_scroll() {
		alert("start11");
		document.getElementById("anchor_scroll").click();
	}
 
	function movetop(){
		alert("start");
		var n = 500;
		var x;
		for (x=n; x>=1; x--){
			window.scrollBy(0,-1);  
		}
		alert("end");
	}
 </script>
	<input type="button" value="点击button跳转" onclick="movetop();" />
	<a id="anchor_scroll" href="#pos" style="display: none">点击这里本页跳转</a>
	... 这里是很多文字，把页面撑开，撑出滚动条 ...
	<div style="height: 1000px;"></div>
	<div id="pos" style="height: 100px;">滚动到这里</div>
	隐藏之后滚动到这里 ... 再加点文字 ...
</body>
</html>