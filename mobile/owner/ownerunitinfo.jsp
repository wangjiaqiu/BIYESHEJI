<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String ownerid = request.getParameter("ownerid");
	String usertype = request.getParameter("usertype");
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
	//根据id获取用户信息
	var ownerid = '<%=ownerid%>';
	var usertype = '<%=usertype%>';
	
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
			

			$.ajax({
				type : "post",
				url : path + "/owner/person/mQueryPersonOwner.do",
				dataType : "json",
				cache : false,
				data : {
					"ownerid" : ownerid
				},
				success:function(result) { 
					//alert('result.personownerinfo count:'+result.personownerinfo.length);
					$("#userName").val( result.personownerinfo[0].username);	
					$("#ownerId").val( result.personownerinfo[0].ownerid);	
	 				$("#ownerName").val( result.personownerinfo[0].ownername);
	 				$("#organizationNum").val( result.personownerinfo[0].organizationnum);
					$("#bankName").val( result.personownerinfo[0].bankname);
					$("#bankCount").val( result.personownerinfo[0].bankcount);
					$("#unitContact").val( result.personownerinfo[0].unitcontact);
					$("#phoneNo").val( result.personownerinfo[0].phoneno);
					$("#otherPhoneNo").val( result.personownerinfo[0].otherphoneno);
					
					//查询司机评价信息
					$.ajax({
						type : "post",
						url : path + "/manifest/queryAppraise.do",
						dataType : "json",
						cache : false,
						data : {
							"driverId" : ownerid,
							"appraiseType" : 2
						},
						success:function(result) { 							
							$("#pingjia1").html( result.appraise[0].gradecnt);	
			 				$("#pingjia2").html( result.appraise[1].gradecnt);
			 				$("#pingjia3").html( result.appraise[2].gradecnt);

				        }, 				
						error : function(request, errinfo, errobject) {			
							alert("errinfo："+errinfo);
						}
					});
					

		        }, 				
				error : function(request, errinfo, errobject) {			
					alert("errinfo："+errinfo);
				}
			});
			
			
	})
	
	$(document).ready(function() {
		$("#submit").click(function() {

			//alert($("#callAjaxForm").serialize());
			var formData = $("#callAjaxForm").serialize();

			$.ajax({
				type : "POST",
				url : path + "/owner/unit/modifyUnitOwner.do",
				cache : false,
				data : formData,
				success : function(data) {
					//注册成功，点击提示框，返回微信
					//WeixinJSBridge.call('closeWindow');

					if (data.code == CODE_CAUSE_SUCCESS) {
						alert('修改成功，返回微信平台！');
						WeixinJSBridge.call('closeWindow');
					} else {
						alert('修改失败！');
					}
				},
				error : function(request, errinfo, errobject) {
					//注册失败，继续注册
					alert('修改失败！');

				}
			});

			return false;
		});
	});
</script>
</head>

<body>
<div data-role="page" class="jqm-demos"  data-quicklinks="true"  data-theme="b">
  <div data-role="header" class="jqm-header" data-position="fixed" data-tap-toggle="false"  data-theme="y"> 
    <h2>个人中心</h2>
  </div>
  <!-- /header -->
  
  <div data-role="main">
		<form id="callAjaxForm" data-ajax="false">
			<div>
				<input type="hidden" id="ownerId" name="ownerId"/>
				<table class="dataintable" cellpadding="0" cellspacing="0"
					width=100% id="tablemy">
					<tr>
						<td width=27% align="right">用户名：</td>
						<td width=55%>
							<input type="text" id="userName" name="userName"  readonly="true" />
							</td>
						<td width=18%>*</td>
					</tr>
					<tr>
						<td align="right">单位名称：</td>
						<td>
							<input type="text" id="ownerName" name="ownerName"  readonly="true" />
							</td>
						<td>*</td>
					</tr>
					<tr>
						<td align="right">营业执照号：</td>
						<td>
							<input type="text" id="organizationNum" name="organizationNum"  readonly="true" />
							</td>
						<td>*</td>
					</tr>					
					<tr>
						<td align="right">开户银行：</td>
						<td><input type="text" name="bankName" id="bankName"
							maxlength="30" value="" /></td>
						<td></td>
					</tr>
					<tr>
						<td align="right">银行账户：</td>
						<td><input type="number" name="bankCount" pattern="[0-9]*"
							id="bankCount" maxlength="30" value=""/></td>
						<td></td>
					</tr>
					<tr>
						<td align="right">联系人：</td>
						<td ><input type="text" name="unitContact"
							id="unitContact" required="true" maxlength="10" value=""/></td>
						<td >*</td>
					</tr>
					<tr>
						<td align="right">手机号：</td>
						<td>
							<input type="number" id="phoneNo" name="phoneNo"  pattern="[0-9]*" />
						</td>
						<td><font color="green">*</font></td>
					</tr>
					<tr>
						<td align="right">其他手机：</td>
						<td><input type="number" name="otherPhoneNo" pattern="[0-9]*"
							maxlength="11" id="otherPhoneNo"/></td>
						<td></td>
					</tr>
					<tr>
						<th colspan="3">
							<div data-role="navbar" class="ui-body-c">
								<ul>
									<li><a href="#" class="ui-disabled">好评 <span
											class="ui-li-count" id ="pingjia1"></span></a></li>
									<li><a href="#" class="ui-disabled">中评 <span
											class="ui-li-count" id ="pingjia2"></span></a></li>
									<li><a href="#" class="ui-disabled">差评 <span
											class="ui-li-count" id ="pingjia3"></span></a></li>
								</ul>
							</div>
							<!-- /navbar -->
						</th>
					</tr>
					<tr>
						<th colspan="3">
							<div>
								<input type="submit" name="submit" id="submit"
								value="提交" data-inline="true" data-theme="x"  style="width: 100%;"/>
							</div>
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
