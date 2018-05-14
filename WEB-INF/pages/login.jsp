<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html lang="zh">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
<title>微运输后台管理系统</title>
<c:import url="/common/html5shiv.jsp"></c:import>
<c:import url="/common/css/base-css.jsp"></c:import>
<style type="text/css">
	tr,td,span {font-size:9pt; color:#3D3D3D; FONT-FAMILY:宋体; line-height:180%;}
	.btnop {
		cursor: hand;
		filter: Alpha(Opacity=100);
	}
	.btnop2{ 
		cursor:hand;
		filter:alpha(opacity=70);
	}
</style>
</head>
<body bgcolor="#E6EEF0">
<form id="loginform" name="loginform" action="<c:url value="/doLogin.do" />" method="post" style="margin:0;padding:0;">
<table border="0" cellspacing="0" cellpadding="0" style="height: 100%;width: 100%">
  <tbody>
 <tr>
	<td style="height:200px;"></td>
 </tr>
 <tr>
	<c:if test="${ !empty errorCode}">
		<fmt:setLocale value="zh_CN"/>
		<fmt:setBundle basename="applicationMessage" var="applicationBundle"/>
		<td colspan=2 style="color:red;" align="center">
			<fmt:message key="${errorCode }" bundle="${applicationBundle}" />
		</td>
	</c:if>
 </tr>
  <tr>
    <td align="center" valign="middle"><table style="height: 265px;width: 441px;" border="0" align="center" cellpadding="0" cellspacing="0" background="./images/login.jpg">
      <tbody><tr>
        <td width="441" align="center" valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tbody><tr>
            <td height="67" align="left" valign="middle" style=" font-family: &#39;黑体&#39;; font-weight:bold; font-size:16pt; color:#FFF; padding-left:33px;">微运输后台管理系统</td>
          	<td></td>
          </tr>
        </tbody></table>
          <table width="95%" border="0" cellspacing="0" cellpadding="0">
            <tbody><tr>
              <td height="35" colspan="2">&nbsp;</td>
            </tr>
            <tr>
              <td height="35" width="150" align="right" valign="middle">登录名：</td> 
              <td align="left" valign="middle">
              <input type="text" name="userName" value="" id="userName" style="margin-left:5px;font:12px;width:147px;height:18px;border-right:0px;border-left:0px;border-bottom:1px solid #cccccc;border-top: 0px;background-color:#FDFDFF" onkeydown="if(event.keyCode==13){ frmcheck();}"></td>
            </tr>
            <tr>
              <td height="35" align="right" valign="middle">密　码：</td>
               <td align="left" valign="middle">
               <input type="password" name="password" id="password" style="margin-left:5px;font:12px;width:147px;height:18px;border-right:0px;border-left:0px;border-bottom:1px solid #cccccc;border-top: 0px;background-color:#FDFDFF" onkeydown="if(event.keyCode==13){ frmcheck();}"></td>
            </tr>
            <tr style="margin-top: 15px">
              <td height="35" width="150" align="right" valign="middle"></td>  
              <td align="left" valign="middle">
<!--               	<input type="submit" value="登陆"> -->
					<input type="image" src="<c:url value="/images/login_btn.gif" />"  name="img">
              </td>
            </tr>
          </tbody></table></td>
      </tr>
    </tbody></table>
      <table width="441" border="0" align="center" cellpadding="0" cellspacing="0">
        <tbody><tr>
          <td height="24" align="center" valign="middle" style="font-family:Arial, Helvetica, sans-serif; color:#72868b;">
         Copyright(C) 2014 微运输</td>
        </tr>
    </tbody></table></td>
  </tr>
</tbody></table>
</form>
</body>
</html>