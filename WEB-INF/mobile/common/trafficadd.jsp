<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String userid =request.getParameter("userid");
	String usertype =request.getParameter("usertype");
%>
<%@page import="com.tpmgr.manage.utils.Constant"%>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>微运输</title>
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
<!-- 系统中两个jsAddress.js，一个是面向 mobile，一个是PC-->

<script>
	
	var userid 		= '<%=userid%>';	
	var usertype 	= '<%=usertype%>';
	//alert("usertype:"+usertype);

	$(function() {
		var oTable = document.getElementById('tablemy');//获取table对象  
		var rows = oTable.rows;
		for ( var i = 0; i < rows.length; i++) {
			if (i % 2 == 0) {
				rows[i].style.backgroundColor = "#FFFFFF";
				rows[i].style.color = "#000000";
			} else {
				rows[i].style.backgroundColor = "#f6f6f6";
				rows[i].style.color = "#000000";
			}
		}		
	})
	
	function initcmb() {
		//alert('iniycomb');
		//addressInit('cmbProvince', 'cmbCity', 'cmbArea', '辽宁', '大连市','沙河口区');
	}

	$(document).ready(function() {
		$("#submit").click(function() {

			var province=$("#cmbProvince").val();
			var city = $("#cmbCity").val();
			//var area = $("#cmbArea").val();
			
			//var address=province+city+area;
			var address=province+city;
			var note = $("#note").val();
			
			//alert('address:'+address);
			//alert('note:'+note);
			
			

			if(note=='' || note == null){
				alert('请填写路况描述！');
			}else{
				$.ajax({
					type : "post",
					url : path + '/traffic/mAddTraffic.do',
					dataType : "json",
					cache : false,
					data : {
						"userId" : userid,
						"userType" : usertype,
						"address" : address,
						"note" : note,
						"status" : 1
					},
					success : function(data) {
						//添加成功，返回路况列表
						 //window.location.href="trafficlist.jsp"; 

						if (data.code == CODE_CAUSE_SUCCESS) {
							alert('提交成功！');
							//WeixinJSBridge.call('closeWindow');
							window.location='trafficlist.jsp';
						} else {
							alert('提交失败！');
						}
					},
					error : function(request, errinfo, errobject) {
						//添加失败，继续添加
						alert('提交失败！');

					}
				});
				
				return false;
			}
		
		});
	});
</script>
</head>

<body onload="initcmb()">
	<div data-role="page" class="jqm-demos" data-quicklinks="true">
		<div data-role="header" class="jqm-header" data-position="fixed"
			data-tap-toggle="false" data-theme="y">
			<h2>上报路况</h2>
			<a href="trafficlist.jsp" data-ajax="false" data-icon="bars"
				class="ui-btn-right">路况列表</a>

		</div>
		<!-- /header -->

		<div>
			<form id="callAjaxForm">
				<div>
					<table class="dataintable" cellpadding="0" cellspacing="0" width=100% id="tablemy">
						<tr>
							<td width=27% align="right">省：</td>
							<td width=65%><select id="cmbProvince" data-theme="x"></select>
							</td>
							<td width=8%></td>
						</tr>
						<tr>
							<td align="right">市：</td>
							<td><select id="cmbCity" data-theme="x"></select></td>
							<td></td>
						</tr>	
						
						<tr style="display:none;">
							<td align="right">区/县：</td>
							<td><select id="cmbArea" data-theme="x"></select></td>
							<td></td>
						</tr>
	
						<tr >
							<td align="right">路况描述：</td>
							<td><textarea name="note" id="note"></textarea></td>
							<td></td>
						</tr>
						<tr>
							<th colspan="3" align="center">
								<input type="submit" id="submit" value="提交路况信息" data-theme="x" />
	
							</th>
						</tr>
					</table>
				</div>
			</form>


		</div>
		<script type="text/javascript">
			addressInit('cmbProvince', 'cmbCity', 'cmbArea', '辽宁省', '营口市','鲅鱼圈区');

		</script>
		<!-- /content -->
		<div data-role="footer" data-position="fixed" data-tap-toggle="false">
		</div>

		<!-- /底部 -->
	</div>
	<!-- /page -->
</body>
</html>
