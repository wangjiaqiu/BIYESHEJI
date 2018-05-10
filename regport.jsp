<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">

<%
	String path = request.getContextPath();
	String openid = request.getParameter("openid");
%>

<%@page import="com.tpmgr.manage.utils.Constant"%>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>微运输</title>
<link rel="stylesheet" href="css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="css/my.css">
<script src="js/jquery.js"></script>
<script src="js/jquery.mobile-1.3.2.min.js"></script>
</head>

<body>
<div data-role="page" class="jqm-demos"  data-quicklinks="true" data-theme="b">
    <div data-role="header" class="jqm-header" data-position="fixed" data-tap-toggle="false" data-theme="y" >
        <h2>注册</h2>
        </div>
    <!-- /header -->
    
    <div  >
    	
        <table class="datain2table" cellpadding="0" cellspacing="0" align="center" >
            <tr>
                <td width=20%></td>
                <td width=60% align="center"><a href="mobile/driver/regdriver.jsp?openid=<%=openid%>"+ data-role="button" data-icon="arrow-r" data-iconpos="left" data-inline="true" data-ajax="false" data-theme="x">司  机注  册  </a></td>
                <td width=20%></td>
            </tr>
            <tr>
                <td width=20%></td>
                <td width=60% align="center"><a href="mobile/owner/reguserowner.jsp?openid=<%=openid%>" data-role="button" data-icon="arrow-r" data-iconpos="left" data-inline="true" data-ajax="false" data-theme="x">个人货主注册</a></td>
                <td width=20%></td>
            </tr>
            <tr>
                <td width=20%></td>
                <td width=60% align="center"><a href="mobile/owner/reguserownerunit.jsp?openid=<%=openid%>" data-role="button" data-icon="arrow-r" data-iconpos="left" data-inline="true" data-ajax="false" data-theme="x">单位货主注册</a></td>
                <td width=20%></td>
            </tr>
        </table>
        <div  class="ui-body ui-body-c"  style="margin:0 auto; text-align:center; margin-top:10px; width:80%;" >
            <p>温馨提示：</p>
            <p>亲爱的用户，您只能选择一种身份注册，注册成功后身份选择就不能更改了哦！ </p>
        </div>
    </div>
    <!-- /content -->
    <div  data-role="footer" data-position="fixed" data-tap-toggle="false" data-theme="y" >
        <h4>Copyright(C)2013</h4>
    </div>
    <!-- /底部 --> 
</div>
<!-- /page -->
</body>
</html>
