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
<script type="text/javascript" 	src="<c:url value="/pages/driver/driverlist.js" />"></script>
<link rel="stylesheet" 	href="../../css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="../../css/my.css">
<script src="../../js/jquery.js"></script>
<script src="../../js/jquery.mobile-1.3.2.min.js"></script>

<script>
	$(function() {
		
		$("#wxopenid").val('<%=openid%>');
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
				$("#autoTypeId").append( htmlselect ).selectmenu('refresh');
				
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


	})


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

			//alert($("#callAjaxForm").serialize());
			var formData = $("#callAjaxForm").serialize();

			$.ajax({
				type : "POST",
				url : path + "/driver/addDriver.do",
				cache : false,
				data : formData,
				success : function(data) {
					//注册成功，点击提示框，返回微信
					//WeixinJSBridge.call('closeWindow');

					if (data.code == CODE_CAUSE_SUCCESS) {
						alert('注册成功，返回微信平台！');
						WeixinJSBridge.call('closeWindow');
					} else {
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
	
	//车牌号长度  max = 5 
	function funNumber() 
	{
		var autoNoContent = document.getElementById("autoNo").value;
		
		//获取当前货单的剩余数量		
		if( autoNoContent.length > 5 ){
			autoNoContent.val( autoNoContent.substr(0, 5) );		
		}
		
	}
</script>
</head>

<body>
	<div data-role="page" class="jqm-demos" data-quicklinks="true"
		data-theme="b">
		<div data-role="header" class="jqm-header" data-position="fixed"
			data-tap-toggle="false" data-theme="y">
			<a href="#" data-ajax="false" data-rel="back" data-icon="back"
				class="ui-btn-left">返回</a>
			<h2>司机注册</h2>
		</div>
		<!-- /header -->

		<div>
			<form id="callAjaxForm" data-ajax="false">			
				<input type="hidden" id="wxopenid" name="wxopenid" />
				<div>
					<table class="dataintable" cellpadding="0" cellspacing="0"
						width=100% id="tablemy">
						<tr>
							<td width=27% align="right">姓名：</td>
							<td width=63%><input type="text" name="driverName"
								id="driverName" required="true" maxlength="30" value="" /></td>
							<td width=10%>*</td>
						</tr>
						<tr>
							<td align="right">身份证号：</td>
							<td><input type="number" name="idcardNo" 
								id="idcardNo" required="true" maxlength="20" value="" /></td>
							<td>*</td>
						</tr>
						<tr>
							<td align="right">车牌号：</td>
							<td>
								<table>
									<tr>
										<td width = 20%>
											<select name="autoNoTitle" id="autoNoTitle" data-theme="x">
											  <option value="辽A">辽A</option>
											  <option value="辽B">辽B</option>
											  <option value="辽C">辽C</option>
											  <option value="辽D">辽D</option>
											  <option value="辽E">辽E</option>
											  <option value="辽F">辽F</option>
											  <option value="辽G">辽G</option>
											  <option value="辽H">辽H</option>
											  <option value="#J">辽J</option>
											  <option value="辽K">辽K</option>
											  <option value="辽L">辽L</option>
											  <option value="辽M">辽M</option>
											  <option value="辽N">辽N</option>
											  <option value="辽P">辽P</option>
											</select>
										</td>
											
										<td width = 80%>
											<input type="text" name="autoNo" id="autoNo" required="true" maxlength="5" value="" onchange="funNumber()"/>
										</td>
									</tr>
								
								</table>
								
							
								
								</td>
								
							<td>*</td>
						</tr>
						<tr >
							<td align="right">车型：</td>
							<td><select name="autoTypeId" id="autoTypeId" data-theme="x">
			
							</select></td>
							<td>*</td>
						</tr>
						<tr>
							<td align="right">载重：</td>
							<td><input type="number" name="loadNum" pattern="[0-9]*"
								id="loadNum" precision=0 min="1" max="500" maxlength="3"
								required="true" value="" /></td>
							<td>吨*</td>
						</tr>
						<tr style="display:none;">
							<td align="right">箱型：</td>
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
								id="bankCount" maxlength="30" value="" /></td>
							<td></td>
						</tr>
						<tr>
							<td align="right">手机号：</td>
							<td><input type="number" name="phoneNo" pattern="[0-9]*"
								maxlength="11" id="phoneNo" required="true" required="true"
								value="" /></td>
							<td>*</td>
						</tr>

						<tr>
							<th colspan="3" align="center"><input type="submit"
								id="submit" value="注册并绑定微信号" style="width: 100%;" data-theme="x" />

							</th>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<!-- /content -->
		<div data-role="footer" data-position="fixed" data-tap-toggle="false"
			data-theme="y">
			<h4>Copyright(C)2013 大连天翼信息科技有限公司</h4>
		</div>
		<!-- /底部 -->
	</div>
	<!-- /page -->
</body>
</html>
