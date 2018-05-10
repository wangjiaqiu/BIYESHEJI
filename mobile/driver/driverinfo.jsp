<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String driverid = request.getParameter("driverid");
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
<script type="text/javascript">
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
			
			$.ajax( {
				type : "post",
				url : path + "/common/queryAutoTypeCombobox.do",
				dataType : "json",
				cache : false,
				success:function(result) { 
					var htmlselect = [];
					//alert('result.combo count:'+result.combo.length);
					for(var i in result.combo) {  
			            //alert(i+":"+result.combo[i].autotypeid+result.combo[i].autotypename);
			            htmlselect.push('<option value="'+result.combo[i].autotypeid+'">'+result.combo[i].autotypename+'</option>\n');
			        }
					//alert('htmlselect:'+htmlselect);
					
					$("#autoTypeId").selectedIndex = 0;
					$("#autoTypeId").append( htmlselect ).selectmenu("refresh");
					
		        }, 				
				error : function(request, errinfo, errobject) {			
					//alert("errinfo："+errinfo);
				}
			});
			
			$.ajax( {
				type : "post",
				url : path + "/common/queryBoxTypeCombobox.do",
				dataType : "json",
				cache : false,
				success:function(result) { 
					var htmlselect = [];
					for(var i in result.combo) {  
			            htmlselect.push('<option value="'+result.combo[i].boxtypeid+'">'+result.combo[i].boxtypename+'</option>\n');
			        }
					//alert('htmlselect:'+htmlselect);
					
					$("#boxTypeId").selectedIndex = 0;
					$("#boxTypeId").append( htmlselect ).selectmenu('refresh');
					
		        }, 				
				error : function(request, errinfo, errobject) {			
					//alert("errinfo："+errinfo);
				}
			});
			
			$.ajax( {
				type : "post",
				url : path + "/common/queryBoxOwnerCombobox.do",
				dataType : "json",
				cache : false,
				success:function(result) { 
					var htmlselect = [];
					for(var i in result.combo) {  
			            //alert(i+":"+result.combo[i].autotypename);
			            htmlselect.push('<option value="'+result.combo[i].boxownerid+'">'+result.combo[i].boxownername+'</option>\n');
			        }
					//alert('htmlselect:'+htmlselect);
					
					$("#boxOwnerId").selectedIndex = 0;
					$("#boxOwnerId").append( htmlselect ).selectmenu('refresh');
					
		        }, 				
				error : function(request, errinfo, errobject) {			
					//alert("errinfo："+errinfo);
				}
			});		
			
			//根据id获取用户信息
			var driverid = '<%=driverid%>';
			
			$.ajax({
				type : "post",
				url : path + "/driver/mQueryDriver.do",
				dataType : "json",
				cache : false,
				data : {
					"driverid" : driverid
				},
				success:function(result) { 
					//alert('result.driverinfo count:'+result.driverinfo.length);				

					$("#driverId").val( result.driverinfo[0].driverid);	
	 				$("#driverName").val( result.driverinfo[0].drivername);
	 				$("#idcardNo").val( result.driverinfo[0].idcardno);
					$("#autoNo").val( result.driverinfo[0].autono);					
					$("#autoTypeId")[0].selectedIndex = result.driverinfo[0].autotypeid-1;
					$("#loadNum").val( result.driverinfo[0].loadnum);
					$("#boxTypeId")[0].selectedIndex = result.driverinfo[0].boxtypeid-1;
					$("#boxOwnerId")[0].selectedIndex = result.driverinfo[0].boxownerid-1;
					$("#bankName").val( result.driverinfo[0].bankname);
					$("#bankCount").val( result.driverinfo[0].bankcount);
					$("#phoneNo").val( result.driverinfo[0].phoneno);
					if( result.driverinfo[0].otherphoneno == null){
						$("#otherPhoneNo").val( '' );	
					}else{
						$("#otherPhoneNo").val( result.driverinfo[0].otherphoneno);	
					}				
					
					
					$("#autoTypeId").selectmenu("refresh");
					$("#boxTypeId").selectmenu('refresh');
					$("#boxOwnerId").selectmenu('refresh');
					
					//查询司机评价信息
					$.ajax({
						type : "post",
						url : path + "/manifest/queryAppraise.do",
						dataType : "json",
						cache : false,
						data : {
							"driverId" : driverid,
							"appraiseType" : 1
						},
						success:function(result) { 							
							//alert('result.driverinfo count:'+result.driverinfo.length);	
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
				url : path + "/driver/modifyDriver.do",
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
	<div data-role="page" class="jqm-demos" data-quicklinks="true">
		<div data-role="header" class="jqm-header" data-position="fixed"
			data-tap-toggle="false" data-theme="y">
			<h2>个人中心</h2>
		</div>
		<!-- /header -->

		<div data-role="main">
			<form id="callAjaxForm" data-ajax="false">
				<div>
					<input type="hidden" id="driverId" name="driverId"/>
					<table class="dataintable" cellpadding="0" cellspacing="0"
						width=100% id="tablemy">
						<tr>
							<td width=27% align="right">姓名：</td>
							<td width=55%>
								<input type="text" id="driverName" name="driverName"  readonly="true" />
								</td>
							<td width=18%>*</td>
						</tr>
						<tr>
							<td align="right">身份证号：</td>
							<td>
								<input type="text" id="idcardNo" name="idcardNo"  readonly="true" />
								</td>
							<td>*</td>
						</tr>
						<tr>
							<td align="right">车牌号：</td>
							<td><input type="text" name="autoNo" id="autoNo"
								required="true" maxlength="7"/></td>
							<td>*</td>
						</tr>
						<tr>
							<td align="right">车型：</td>
							<td><select name="autoTypeId" id="autoTypeId" data-theme="x">
							</select></td>
							<td>*</td>
						</tr>
						<tr>
							<td align="right">载重：</td>
							<td><input type="number" name="loadNum" pattern="[0-9]*"
								id="loadNum" precision=0 min="1" max="500" maxlength="3"
								required="true" /></td>
							<td>吨*</td>
						</tr>
						<tr style="display:none;">
							<td align="right" >箱型：</td>
							<td><select name="boxTypeId" id="boxTypeId" data-theme="x">

							</select></td>
							<td>*</td>
						</tr>
						<tr style="display:none;">
							<td align="right">箱属：</td>
							<td><select name="boxOwnerId" id="boxOwnerId" data-theme="x">

							</select></td>
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
							<td align="right">手机号：</td>
							<td>
								<input type="number" id="phoneNo" name="phoneNo" pattern="[0-9]*"/>
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
									value="提交"  data-theme="x" style="width: 100%;" />
								</div>
							</th>
		

						</tr>
					</table>
				</div>
			</form>			

		</div>

		
		<!-- /content -->
		<div data-role="footer" data-position="fixed" data-tap-toggle="false">
		</div>
		<!-- /底部 -->
	</div>
	<!-- /page -->
</body>
</html>
