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
<link rel="stylesheet" href="../../css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="../../css/my.css">
<script src="../../js/jquery.js"></script>
<script src="../../js/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript">
	
	$(function(){	
		$("#wxopenid").val('<%=openid%>');
		
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
	
	$(document).ready(function() {
		$("#submit").click(function() {
			
			//手机号码
			if(!document.getElementById || !document.createTextNode) 
				return false;
			var utel=document.getElementById("phoneNo");
			var str=utel.value;
			var regPartton=/1[3-8]+\d{9}/;
			if(!str || str==null){
				alert('手机号码不能为空！');
				utel.focus();
				return false;
			}else if( str.length > 11){
				alert('手机号码格式不正确！');
				utel.focus();
				return false;
			}else if(!regPartton.test(str)){
				alert('手机号码格式不正确！');
				utel.focus();
				return false;
			}


			var formData = $("#callAjaxForm").serialize();

			$.ajax({
				type : "POST",
				url : path + '/owner/unit/addUnitOwner.do',
				cache : false,
				data : formData,
				success : function(data) {
					//注册成功，点击提示框，返回微信					
					if (data.code == CODE_CAUSE_SUCCESS){
						alert('注册成功，返回微信平台！');
						WeixinJSBridge.call('closeWindow');
					}else{
						alert('注册失败！');
					}
				},
				error : function(request, errinfo, errobject) {
					//注册失败，继续注册
					alert('注册失败！');

				}
			});

			return false;
		});
	});
</script>
</head>

<body >
<div data-role="page" class="jqm-demos"  data-quicklinks="true" data-theme="b">
  <div data-role="header" class="jqm-header" data-position="fixed" data-tap-toggle="false"  data-theme="y">
  <a href="#" data-ajax="false" data-rel="back" data-icon="back" class="ui-btn-left">返回</a>
    <h2>货主注册</h2>
  </div>
  <!-- /header -->
 <div >
			<form id="callAjaxForm" data-ajax="false">
				<input type="hidden" id="wxopenid" name="wxopenid" />
				<div >
					<table class="dataintable" cellpadding="0" cellspacing="0"  width=100% id="tablemy">
						<tr>
							<td width=27% align="right">用户名：</td>
							<td width=63%><input type="text" name="userName"
								id="userName" required="true" maxlength="30" value=""/></td>
							<td width=10%>*</td>
						</tr>
						<tr>
							<td align="right">单位名称：</td>
							<td ><input type="text" name="ownerName"
								id="ownerName" required="true" maxlength="30" value=""/></td>
							<td >*</td>
						</tr>
						<tr>
							<td align="right"><span style="background-color: #D28A1E; padding:10px 5px 10px 5px">营业执照号：</span></td>
							<td><input type="number" name="organizationNum" pattern="[0-9]*"
								id="organizationNum" required="true" maxlength="25" value=""/></td>
							<td>*</td>
						</tr>						
						<tr>
							<td align="right">开户银行：</td>
							<td><input type="text" name="bankName" 
								id="bankName" maxlength="30" value=""/></td>
							<td></td>
						</tr>
						<tr>
							<td align="right">银行账户：</td>
							<td><input type="number" name="bankCount" pattern="[0-9]*" id="bankCount" maxlength="30"
								value=""/></td>
							<td></td>
						</tr>
						<tr>
							<td width=27% align="right">联系人：</td>
							<td width=63%><input type="text" name="unitContact"
								id="unitContact" required="true" maxlength="10" value=""/></td>
							<td width=10%>*</td>
						</tr>
						<tr>
							<td align="right">手机号：</td>
							<td><input type="number" name="phoneNo" pattern="[0-9]*" maxlength="11"
								id="phoneNo"  required="true" value=""/></td>
							<td>*</td>
						</tr>
						

						<tr>
							<th colspan="3" align="center">
								<input type="submit" id="submit" value="注册并绑定微信号"  style="width: 100%;" data-theme="x" />	

							</th>
						</tr>
					</table>
				</div>
			</form>
		</div>
  <!-- /content -->
  <div  data-role="footer" data-position="fixed" data-tap-toggle="false"  > </div>
  <!-- /底部 --></div>
</div>
<!-- /page -->
</body>
</html>
