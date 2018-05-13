<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String manifestid = request.getParameter("manifestid");
	String ownerid = request.getParameter("ownerid");
	
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
		
		//根据货单id获取用户信息：manifestid
		var manifestid = '<%=manifestid%>';			
		//var manifestid = '4';	
	
		$.ajax({
			type : "post",
			url : path + "/manifest/mqueryGrabManifest.do",
			dataType : "json",
			cache : false,
			data : {
				"manifestId" : manifestid
			},
			success:function(result) { 
				//alert('result.manifest count:'+result.manifest.length);
				
				//获取抢单中同一货单ID的抢单数量总和，以便于计算剩余数量
				var countGrabBoxNumer = 0;
				var countGrabBoxNumertemp = 0;
				var syGrabBoxNumerYes = 0;
				var syGrabBoxNumerNo = 0;
				for(var i in result.grabDriverList) {  					
					if( result.grabDriverList[i].grabstatus != 1 ){
						countGrabBoxNumer += result.grabDriverList[i].grabboxnum;
					}
					
					
					if(result.grabDriverList[i].grabstatus != 1){
						countGrabBoxNumertemp += result.grabDriverList[i].grabboxnum;						
					}					
				}
				
				//货单剩余数量（包含待确认状态的数量）
				syGrabBoxNumerYes = result.manifest.boxNum - countGrabBoxNumer;
				
				//货单剩余数量（不包含待确认状态的数量）
				syGrabBoxNumerNO = result.manifest.boxNum - countGrabBoxNumertemp;
				//alert('syGrabBoxNumerNO:'+ syGrabBoxNumerNO);

				var manifestid = result.manifest.manifestId;
				
				var manifeststatus;
				if(result.manifest.manifestStatus == 1){
					manifeststatus = "抢单中";
				}else if(result.manifest.manifestStatus == 2){
					manifeststatus = "抢单结束";
				}else{
					manifeststatus = "已完成";
				}

				$("#manifestId").html('货单号：'+ result.manifest.manifestId );//替换标记内容
				$("#manifeststatus").html( manifeststatus );//替换标记内容
				$("#manifestName").html( result.manifest.manifestName );//替换标记内容
				$("#weight").html( result.manifest.weight );//替换标记内容
				$("#boxTypeName").html( result.manifest.boxTypeName );//替换标记内容
				$("#boxOwnerName").html( result.manifest.boxOwnerName );//替换标记内容
				$("#countGrabBoxNumer").html( countGrabBoxNumer+'箱' );//替换标记内容
				$("#boxNum").html( syGrabBoxNumerYes +'/'+ result.manifest.boxNum +'箱' );//替换标记内容
				$("#sendProvince").html( '出发地及日期：'+ result.manifest.sendProvince+ result.manifest.sendCity+ result.manifest.sendArea+ result.manifest.sendDate );//替换标记内容
				$("#receiveProvince").html( '送达地及日期：'+ result.manifest.receiveProvince+ result.manifest.receiveCity+ result.manifest.receiveArea+ result.manifest.receiveDate );//替换标记内容
				
				
				var grabstatus;
				var tempUrl;

				for(var i in result.grabDriverList) {
					
					if(result.grabDriverList[i].grabstatus == 1){
						grabstatus = '待确认';						
					}else if(result.grabDriverList[i].grabstatus == 2){
						grabstatus = '已确认';		
					}else if(result.grabDriverList[i].grabstatus == 3){
						grabstatus = '已完成';		
					}
					
					var row=$("#driverinfotemplate").clone();//克隆一份模板
					row.find("#drivername").html( result.grabDriverList[i].drivername );		//替换标记内容
					row.find("#grabboxnum").html( result.grabDriverList[i].grabboxnum +'箱');		//替换标记内容
					row.find("#grabprice").html( result.grabDriverList[i].grabprice +'元');		//替换标记内容
					row.find("#grabtime").html( result.grabDriverList[i].grabtime );			//替换标记内容
					row.find("#grabstatus").html( grabstatus );		//替换标记                    
    
                    row.attr("id",result.grabDriverList[i].driverid);//改变行的Id
                    
                    row.attr("onMouseOver","this.style.cursor='hand'");//改变行的Id
                    tempUrl = 'dialog-confirm.jsp?driverid='+ result.grabDriverList[i].driverid +'&grabid='+result.grabDriverList[i].grabid+'&grabstatus='+result.grabDriverList[i].grabstatus +'&manifestid='+manifestid +'&grabBoxNum='+result.grabDriverList[i].grabboxnum +'&syBoxNum='+ syGrabBoxNumerNO;
                    row.attr("onClick",'window.location.href="'+tempUrl+'"' );//改变行的Id
                    row.attr("data-rel","dialog");//改变行的Id
    
                    row.appendTo("#driverlist");//添加到模板的容器中
                    
                    $("#driverinfotemplate").css("display","none");//隐藏行模块

				}


				
	        }, 				
			error : function(request, errinfo, errobject) {			
				alert("errinfo："+errinfo);
			}
		});
		 
		
		
	});
	
	 		
</script>
</head>

<body>
	<div data-role="page" class="jqm-demos" data-quicklinks="true"
		data-theme="b">
		<div data-role="header" data-position="fixed" data-tap-toggle="false"
			data-theme="y">
			<a href="#" data-role="button" data-rel="back" class="ui-btn-left">返回</a>
			<h2>我的货单</h2>
			<a href="goodadd.jsp?ownerid=<%=ownerid%>" data-ajax="false"
				data-icon="plus" class="ui-btn-right">发货</a>
		</div>
		<!-- /header -->

		<div data-role="main" class="ui-content" id='goodlist'>
			<div>
				<table class="dataintable" cellpadding="0" cellspacing="0"
					width=100% id="tablemy">
					<tr align="center">
						<th colspan="3" align="center" id="manifestId"></th>
						<td align="right"><span
							style="background-color: #CCC; padding: 5px" id="manifeststatus"></span></td>
					</tr>
					<tr>
						<td width=25% align="right">货名：</td>
						<td width=25% align="left" id="manifestName">
						<td width=25% align="right">货重：</td>
						<td width=25% align="left" id="weight"></td>
					</tr>
					<tr>
						<td align="right">箱型：</td>
						<td align="left" id="boxTypeName"></td>
						<td align="right">箱属：</td>
						<td align="left" id="boxOwnerName"></td>
					</tr>
					<tr>
						<td align="right">抢单数量：</td>
						<td align="left" id="countGrabBoxNumer"></td>
						<td align="right">剩余数量：</td>
						<td align="left" id="boxNum"></td>
					</tr>
					<tr align="center">
						<th colspan="4"><span
							style="background-color: #ebc4cb; padding: 5px" id="sendProvince">
						</span></th>
					</tr>
					<tr align="center">
						<th colspan="4"><span
							style="background-color: #fbc496; padding: 5px"
							id="receiveProvince"> </span></th>
					</tr>
					<tr align="center">
						<th colspan="4">
							<table cellpadding="0" cellspacing="0" width=95% border="2px" bordercolor="#666666" id="driverlist">
								<tr id="trLoad" style="background-color: #fff">
									<td colspan="5" align="center"><strong><span id="spnLoad" >抢单司机信息</span></strong></td>
								</tr>
								<tr id="driverinfotemplate" data-rel="dialog" data-transition="pop">
									<td id="drivername" width=20% align="center"></td>
									<td id="grabboxnum" width=10% align="center"></td>
									<td id="grabprice" width=20% align="center"></td>
									<td id="grabtime" width=30% align="center"></td>
									<td id="grabstatusall" width=20% align="right">
										<font color="#FF0000" id="grabstatus"> </font>				
									</td>
								</tr>
							</table>							
						</th>
					</tr>
				</table>
			</div>


		</div>
		<!-- /content -->
	</div>
	<!-- /page -->
</body>
</html>
