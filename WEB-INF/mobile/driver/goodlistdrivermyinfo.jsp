<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String manifestid =request.getParameter("manifestid"); 
	String grabId =request.getParameter("grabid");
	String grabNumber =request.getParameter("grabnumber");
	String driverid =request.getParameter("driverid");
	String grabstatus =request.getParameter("grabstatus");
	String grabstatusdriver =request.getParameter("grabstatusdriver");
	String grabmoneydriver =request.getParameter("grabmoneydriver");
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
	//根据货单id获取用户信息：manifestid
	var manifestid 	= '<%=manifestid%>';	
	var grabId		= '<%=grabId%>';
	var grabNumber		= '<%=grabNumber%>';
	var grabstatus	= '<%=grabstatus%>';
	var grabstatusdriver	= '<%=grabstatusdriver%>';
	var grabmoneydriver		= '<%=grabmoneydriver%>';
	
	$(function() {	
		
		
		if( grabstatus == 1 ){
			//待确认状态
			//alert("待确认状态");
			document.getElementById('tableappraise').style.display = "none";
			//alert('待确认状态  over2');
			
		}else if(grabstatus == 2 && grabstatusdriver != 3){
			//已确认状态
			//alert("已确认状态 1");	
		}else if(grabstatus == 3 && grabstatusdriver != 3){
			//已确认状态
			//alert("已确认状态 2");	
		}else if(grabstatus == 2 && grabstatusdriver == 3){
			//已完成状态	
			//alert("已完成状态  1");
			document.getElementById('tableappraise').style.display = "none";
			document.getElementById('navbarall').style.display = "";

		}else if(grabstatus == 3 && grabstatusdriver == 3){
			//已完成状态	
			//alert("已完成状态  2");	
			document.getElementById('tableappraise').style.display = "none";
			document.getElementById('navbarall').style.display = "";
		}
		
		 myrefresh();
		
		$.ajax({
			type : "post",
			url : path + "/manifest/mqueryDriverGrabManifest.do",
			dataType : "json",
			cache : false,
			data : {
				"manifestId" : manifestid,
				"grabId" : grabId
			},
			success:function(result) { 
				//alert('result.manifest count:'+result.manifest.length);
				
				//获取抢单中同一货单ID的抢单数量总和，以便于计算剩余数量
				var countGrabBoxNumer = 0;
				var currentGrabBoxNumer = 0;
				var countGrabBoxNumertemp = 0;
				var syGrabBoxNumerYes = 0;
				var syGrabBoxNumerNo = 0;
				for(var i in result.grabDriverList) { 
					if( result.grabDriverList[i].grabstatus != 1 ){
						countGrabBoxNumer += result.grabDriverList[i].grabboxnum;
					}
					//countGrabBoxNumer += result.grabDriverList[i].grabboxnum;
					if(result.grabDriverList[i].grabid == grabId){
						currentGrabBoxNumer = result.grabDriverList[i].grabboxnum;						
					}
					
					if(result.grabDriverList[i].grabstatus != 1){
						countGrabBoxNumertemp += result.grabDriverList[i].grabboxnum;						
					}
					
				}
				
				//alert('result.manifest.boxNum:'+ result.manifest.boxNum);
				//alert('countGrabBoxNumertemp:'+ countGrabBoxNumertemp);
				//货单剩余数量（包含待确认状态的数量）
				syGrabBoxNumerYes = result.manifest.boxNum - countGrabBoxNumer;
				
				//货单剩余数量（不包含待确认状态的数量）
				syGrabBoxNumerNO = result.manifest.boxNum - countGrabBoxNumertemp;
				
				var htmlgoodlist = [];
				var htmlgoodlist2 = [];
				var htmlgoodlist3 = [];
				var manifestid = result.manifest.manifestId;
				
				htmlgoodlist.push(
		            		'<div id='+ result.manifest.manifestId + '>'+
			            		'<table class="dataintable" cellpadding="0" cellspacing="0"  width=100% id="tablemycontent" >'+
			                    	'<tr align="center" >'+
			                            '<th colspan="4"  align="center">'+            	
			                                '货单号：'+ result.manifest.manifestId + '-' + grabNumber +
			                            '</th>'+
			                        '</tr>'+
			                        '<tr>'+
			                            '<td width=25% align="right">货名：</td>'+
			                            '<td width=25% align="left">'+ result.manifest.manifestName +'</td>'+
			                            '<td width=25% align="right">货重：</td>'+
			                            '<td width=25% align="left">'+ result.manifest.weight +'吨/箱</td>'+
			                        '</tr>'+
			                        '<tr>'+
			                            '<td align="right">箱型：</td>'+
			                            '<td align="left">'+ result.manifest.boxTypeName +'尺</td>'+
			                            '<td align="right">箱属：</td>'+
			                            '<td align="left">'+ result.manifest.boxOwnerName +'</td>'+
			                        '</tr>'+
			                        '<tr>'+
			                            '<td align="right">抢单数量：</td>'+
			                            '<td align="left">'+currentGrabBoxNumer +'箱</td>'+
			                            '<td align="right">剩余数量：</td>'+
			                            '<td align="left">'+ syGrabBoxNumerYes +'/'+ result.manifest.boxNum +'箱</td>'+
			                       '</tr>'+
			                        '<tr align="center">'+
			                            '<th colspan="4"><span style="background-color: #ebc4cb; padding:2px">'+
			            					'出发地及日期：'+ result.manifest.sendProvince+ result.manifest.sendCity+ result.manifest.sendArea+ result.manifest.sendDetailedAddress+ result.manifest.sendDate +
			                            '</span></th>'+
			                        '</tr>'+
			                        '<tr align="center">'+
			                            '<th colspan="4"><span style="background-color: #fbc496; padding:2px">'+
			            					'送达地及日期：'+ result.manifest.receiveProvince+ result.manifest.receiveCity+ result.manifest.receiveArea+ result.manifest.receiveDetailedAddress+ result.manifest.receiveDate +

			                            '</span></th>'+
			                        '</tr>'+
			                        '<tr align="center">'+
				                        '<th colspan="4">'+
				                        	'价格：'+ result.grabDriverPriceList[0].grabprice  + result.manifest.priceUnit +
				                            '</th>'+
				                    '</tr>'+	
				                    '<tr align="center">'+
				                        '<th colspan="4">'+
				                        	'备注：'+ result.manifest.remark  +
				                            '</th>'+
				                    '</tr>'+
				                    '<tr align="center">'+
				                        '<th colspan="4">'+
					                        '<a href="tel:'+ result.manifest.phoneNo +'" id="btnPhonemanifestId"><img src="../../img/button-phone.png"> </a>'+		
				                            '</th>'+
				                    '</tr>'+
								 '</table>'+
								'</div>\n' 
															
		            		);		
				
				 
				htmlgoodlist = htmlgoodlist + htmlgoodlist2 + htmlgoodlist3;				

				$("#goodlist").append( htmlgoodlist );
				//$("#goodlist").append( htmlgoodlist ).main('refresh');
				//$("#navbardiv").navbar('refresh');
				
				//alert('result.driverappraise[0].grade:'+ result.driverappraise[0].grade);
                if(  result.driverappraise[0].grade == 1 ){
                	$("#navbar2").css("display","none");//隐藏
                	$("#navbar3").css("display","none");//隐藏
                }else if(  result.driverappraise[0].grade == 2 ){
                	$("#navbar1").css("display","none");//隐藏
                	$("#navbar3").css("display","none");//隐藏
                }else if(  result.driverappraise[0].grade == 3 ){
                	$("#navbar1").css("display","none");//隐藏
                	$("#navbar2").css("display","none");//隐藏
                }else{
                	$("#navbarall").css("display","none");//隐藏
                }
                
	        }, 				
			error : function(request, errinfo, errobject) {			
				alert("errinfo："+errinfo);
			}
		});
		 
		
		
		var oTable = document.getElementById('tablemycontent');//获取table对象  
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
	
	//页面刷新已收款按钮
	function myrefresh()
	{	   
		if( grabstatus != 1 ){
			if( grabmoneydriver == 'null' || grabmoneydriver == 'undefined' || grabmoneydriver == ''|| grabmoneydriver == '0' ){
				document.getElementById('grabmoneydriverdiv').style.display = "block";
			}else{
				document.getElementById('grabmoneydriverdiv').style.display = "none";
			}		
		}
	}
	//评价货主
	function appraise(grade) {
		//alert('param:'+ grade);
		//alert("grabId:"+ grabId);
		
		if(confirm('确认评价货主?')){					
				
			$.ajax({
				type : "post",
				url : path + '/manifest/confirmAppToOwner.do',
				dataType : "json",
				cache : false,
				data : {
					"grabId" : grabId,
					"grade" : grade,
					"appraiseType" : 2,
					"grabStatus" : 3				
				},
				success : function(r) {
					//alert('完成状态修改-----------:'+ grade);
					if (r.code == CODE_CAUSE_SUCCESS) {
						alert('司机对货主的评价成功!');
						//完成状态修改，并且评价
						//appraiseOwner(grade);	
						window.location='goodlistdrivermy.jsp?driverid='+'<%=driverid%>';
					}
					if (r.code == CODE_CAUSE_FAILURE) {
						alert('司机对货主的评价失败!');
					}
				},
				error : function(request, errinfo, errobject) {
					alert('司机对货主的评价失败!');
				}
	
			});
		}
	}
	
	function appraiseOwner(grade) {
		//alert('param2:'+ grade);
		
		$.ajax({
			type : "post",
			url : path + '/manifest/confirmApp.do',
			dataType : "json",
			cache : false,
			data : {
				"grabId" : grabId,
				"grade" : grade,
				"appraiseType" : 2
			},
			success : function(r) {
				if (r.code == CODE_CAUSE_SUCCESS) {
					alert('司机对货主的评价成功!');
					window.location='goodlistdrivermy.jsp?driverid='+'<%=driverid%>';


				}
				if (r.code == CODE_CAUSE_FAILURE) {
					alert('司机对货主的评价成功!');
				}
			},
			error : function(request, errinfo, errobject) {
				alert('司机对货主的评价失败!');
			}
		});		
	}
	
	//抢单最大数
	function moneyCondition() 
	{ 	
		//alert("抢单号:"+grabId);
		
		if(confirm('确认货主已经付款?')){					
			
			$.ajax({
				type : "post",
				url : path + '/manifest/mModifiedMoney.do',
				dataType : "json",
				cache : false,
				data : {
					"grabId" : grabId,
					"statusDO" : 'd'				
				},
				success : function(r) {
					//alert('完成状态修改-----------:'+ grade);
					if (r.code == CODE_CAUSE_SUCCESS) {
						grabmoneydriver = '1';
						myrefresh();

					}
					if (r.code == CODE_CAUSE_FAILURE) {
						alert('确认货主已经付款失败!');
					}
				},
				error : function(request, errinfo, errobject) {
					alert('确认货主已经付款失败!');
				}	
			});
		}	
	}
</script>
</head>

<body>
	<div data-role="page" data-quicklinks="true">
		<div data-role="header" class="jqm-header" data-position="fixed"
			data-tap-toggle="false" data-theme="y">
			<a href="#" data-ajax="false" data-rel="back" data-icon="back"
				class="ui-btn-left">返回</a>
			<h2>评价货主</h2>
		</div>
		<!-- /header -->

		<div data-role="main"  >
			<div  id='goodlist'></div>
			
			<!-- 已确认状态  -->
			<div id="tableappraise">
				<table class="dataintable" cellpadding="0" cellspacing="0" width=100%>
					<tr>
						<th colspan="4">
							<div data-role="navbar" class="ui-body-c"
								style="width: 85%; margin: 0 auto;">
								<ul>
									<li><a href="" onclick="appraise(1);">好评
									</a></li>
									<li><a href="" onclick="appraise(2);">中评 </a></li>
									<li><a href="" onclick="appraise(3);">差评 </a></li>
								</ul>
							</div>
						</th>
					</tr>
				</table>			
			</div>
			
			<!-- 已完成  -->
			<div id="navbarall" style="display: none;">
					<div data-role="navbar" class="ui-body-c" style="width:85%; margin: 0 auto;" id="navbar1">
						<ul>
							<li><a href="#" class="ui-disabled" >好评 </a></li>
						</ul>
					</div>
					<div data-role="navbar" class="ui-body-c" style="width:85%; margin: 0 auto;" id="navbar2">
						<ul>
							<li><a href="#" class="ui-disabled" >中评 </a></li>
						</ul>
					</div>
					<div data-role="navbar" class="ui-body-c" style="width:85%; margin: 0 auto;" id="navbar3">
						<ul>
							<li><a href="#" class="ui-disabled" >差评 </a></li>
						</ul>
					</div>					
			</div>		
			
			<!-- 已收款情况  -->
			<div id="grabmoneydriverdiv" style="display: none;">
				<a href="javascript:moneyCondition()" data-role="button" style="width:100%; margin: 0 auto;" data-theme="x">已收款</a>								
			</div>
		</div>

		<!-- /content -->
		<div data-role="footer" data-position="fixed" data-tap-toggle="false">
		</div>
		<!-- /底部 -->
	</div>
	<!-- /page -->
</body>
</html>
