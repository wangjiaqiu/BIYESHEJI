<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path 		= request.getContextPath();
	String driverid 	= request.getParameter("driverid"); 
	String grabid		= request.getParameter("grabid"); 
	String grabnumber	= request.getParameter("grabnumber");
	String grabstatus	= request.getParameter("grabstatus"); 
	String manifestid	= request.getParameter("manifestid"); 
	String grabBoxNum	= request.getParameter("grabBoxNum"); 
	String syBoxNum		= request.getParameter("syBoxNum"); 
	String grabmoneyowner		= request.getParameter("grabmoneyowner"); 
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
	href="css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="css/my.css">

<script src="js/jquery.js"></script>
<script src="js/jquery.mobile-1.3.2.min.js"></script>

</head>
<body>

	<div data-role="page" data-close-btn="right">
		<script type="text/javascript">	

			var driverid 	= '<%=driverid%>';
			var grabid 		= '<%=grabid%>';
			var grabnumber 	= '<%=grabnumber%>';
			var grabstatus 	= '<%=grabstatus%>';
			
			var manifestid  = '<%=manifestid%>';
			var grabBoxNum  = '<%=grabBoxNum%>';
			var syBoxNum 	= '<%=syBoxNum%>';
			var grabmoneyowner 	= '<%=grabmoneyowner%>';			
	
			//alert("grabBoxNum =="+grabBoxNum);
			//alert("syBoxNum =="+syBoxNum);
			//页面刷新已收款按钮
			function myrefreshdiv()
			{	   
				if( grabstatus != 1 ){
					if( grabmoneyowner == 'null' || grabmoneyowner == 'undefined' || grabmoneyowner == ''|| grabmoneyowner == '0' ){
						document.getElementById('grabmoneyownerdiv').style.display = "block";
					}else{
						document.getElementById('grabmoneyownerdiv').style.display = "none";
					}		
				}
			}
			myrefreshdiv();
			//司机抢单状态：
			if( grabstatus == 1){
				$("#tableStatus2").css("display","none");//隐藏
				$("#tableStatus3").css("display","none");//隐藏
			
				$(function() {				
					$.ajax({
						type : "post",
						url : path + "/driver/mQueryDriver.do",
						dataType : "json",
						cache : false,
						data : {
							"driverid" : driverid
						},
						success:function(result) { 
							if( result.driverinfo.length > 0 ){
			                    $("#t1drivername").html( result.driverinfo[0].drivername );//替换标记内容
			                    $("#t1idcardno").html(result.driverinfo[0].idcardno );//替换标记内容
			                    $("#t1autono").html(result.driverinfo[0].autono );//替换标记内容
			                    $("#t1autotypename").html(result.driverinfo[0].autotypename );//替换标记内容
			                    $("#t1loadnum").html(result.driverinfo[0].loadnum + '吨' );//替换标记内容
			                    $("#t1bankName").html( result.driverinfo[0].bankname );//替换标记内容
			                    $("#t1bankCount").html( result.driverinfo[0].bankcount );//替换标记内容
			                    $("#t1phoneno").html( result.driverinfo[0].phoneno );//替换标记内容
			                    
			            		if( result.driverinfo[0].otherphoneno == null){
									$("#t1otherphoneno").html('' );//替换标记内容
								}else{
									$("#t1otherphoneno").html( result.driverinfo[0].otherphoneno );//替换标记内容
								}
			                    
			                    $("#t1manifestid").html( manifestid + '-' + grabnumber );//替换标记内容

			                    $("#t1trLoad").css("display","none");//隐藏提示行模块
			                    
			                    
			                    
								var divContent=$("#tableStatus1");//克隆一份模板
								divContent.find("#driverPhone").attr("href","tel:"+result.driverinfo[0].phoneno  );//改变行的Id
			                    
							} else{
								$("#t1spnLoad").html("<font color=green>没有查询到数据！</font>");
							}
							
							
							//请求评价
							$.ajax({
								type : "post",
								url : path + "/manifest/queryAppraise.do",
								dataType : "json",
								cache : false,
								data : {
									"driverId" : driverid,
									"appraiseType": 1
								},
								success:function(result) { 
				
									$("#t1grade1").html( result.appraise[0].gradecnt );//替换标记内容
									$("#t1grade2").html( result.appraise[1].gradecnt );//替换标记内容
									$("#t1grade3").html( result.appraise[2].gradecnt );//替换标记内容
	
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
					
					//表格颜色
					var oTable = document.getElementById('tabledriverdialog');//获取table对象  
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
			}else if( grabstatus == 2 ){
				$("#tableStatus1").css("display","none");//隐藏
				$("#tabledriverdialog").css("display","none");//隐藏				
				$("#tableStatus3").css("display","none");//隐藏
				
				$(function() {				
					$.ajax({
						type : "post",
						url : path + "/driver/mQueryDriver.do",
						dataType : "json",
						cache : false,
						data : {
							"driverid" : driverid
						},
						success:function(result) { 
							//alert('result.driverinfo.length:'+ result.driverinfo.length);
							if( result.driverinfo.length > 0 ){
			                    $("#t2drivername").html('姓名：' + result.driverinfo[0].drivername );//替换标记内容
			                    $("#t2idcardno").html('身份证号：' +result.driverinfo[0].idcardno );//替换标记内容
			                    $("#t2autotypename").html(result.driverinfo[0].autotypename );//替换标记内容
			                    $("#t2loadnum").html(result.driverinfo[0].loadnum + '吨' );//替换标记内容
			                    $("#t2bankName").html( '开户银行：' + result.driverinfo[0].bankname );//替换标记内容
			                    $("#t2bankCount").html('银行账号：' +  result.driverinfo[0].bankcount );//替换标记内容
			                    $("#t2phoneno").html('手机号：' + result.driverinfo[0].phoneno );//替换标记内容
			                    
			            		if( result.driverinfo[0].otherphoneno == null){
									$("#t2otherphoneno").html('其他手机号：' + ' ' );//替换标记内容
								}else{
									$("#t2otherphoneno").html('其他手机号：' + result.driverinfo[0].otherphoneno );//替换标记内容
								}				
								
			                    
			                    $("#t2manifestid").html('单号：' + manifestid + '-' + grabnumber );//替换标记内容
			                    
			                    $("#t2trLoad").css("display","none");//隐藏提示行模块
			                    
							} else{
								$("#t2spnLoad").html("<font color=green>没有查询到数据！</font>");
							}
			

				        }, 				
						error : function(request, errinfo, errobject) {			
							alert("errinfo："+errinfo);
						}
					});
				});
				//表格颜色
				var oTable = document.getElementById('tableStatus2');//获取table对象  
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
			}else if( grabstatus == 3 ){
				$("#tableStatus1").css("display","none");//隐藏
				$("#tabledriverdialog").css("display","none");//隐藏
				$("#tableStatus2").css("display","none");//隐藏
				
				$(function() {				
					$.ajax({
						type : "post",
						url : path + "/driver/mQueryDriverAndAppraise.do",
						dataType : "json",
						cache : false,
						data : {
							"driverid" : driverid,
							"grabid" : grabid,
							"appraisetype" : 1
						},
						success:function(result) { 
							//alert('result.driverinfo.length:'+ result.driverinfo.length);
							if( result.driverinfo.length > 0 ){
								
			                    $("#t3drivername").html('姓名：' + result.driverinfo[0].drivername );//替换标记内容
			                    $("#t3idcardno").html('身份证号：' +result.driverinfo[0].idcardno );//替换标记内容
			                    $("#t3autotypename").html(result.driverinfo[0].autotypename );//替换标记内容
			                    $("#t3loadnum").html(result.driverinfo[0].loadnum + '吨' );//替换标记内容
			                    $("#t3bankName").html('开户银行：' +  result.driverinfo[0].bankname );//替换标记内容
			                    $("#t3bankCount").html('银行账号：' +  result.driverinfo[0].bankcount );//替换标记内容
			                    $("#t3phoneno").html('手机号：' + result.driverinfo[0].phoneno );//替换标记内容
			            		if( result.driverinfo[0].otherphoneno == null){
									$("#t3otherphoneno").html('其他手机号：' + '' );//替换标记内容
								}else{
									$("#t3otherphoneno").html('其他手机号：' + result.driverinfo[0].otherphoneno );//替换标记内容
								}	
			                    
			                    $("#t3manifestid").html('单号：' + manifestid + '-' + grabnumber );//替换标记内容			                    
			                    $("#t3trLoad").css("display","none");//隐藏提示行模块
			                    
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
			                    
								
								
			                   
	
							} else{
								$("#t3spnLoad").html("<font color=green>没有查询到数据！</font>");
							}
				        }, 				
						error : function(request, errinfo, errobject) {			
							alert("errinfo："+errinfo);
						}
					});
				});
				//表格颜色
				var oTable = document.getElementById('tableStatus3');//获取table对象  
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
			}
			
			
			//拒绝司机
			function conformno(){
				//alert('conformno');
				$.ajax({
					type : "post",
					url : path + '/manifest/confirmGrabNo.do',
					dataType : "json",
					cache : false,
					data : {
						"grabId" : grabid	
					},
					success : function(r) {
						alert('拒绝成功!');
						myrefresh();
					},
					error : function(request, errinfo, errobject) {
						alert('拒绝失败!');
					}
				});

			  }
			
			//确认司机
			function conformyes() {	
				//alert("grabBoxNum =="+grabBoxNum);
				//alert("syBoxNum =="+syBoxNum);

				if( parseInt(grabBoxNum) > parseInt(syBoxNum) ){
					alert('抢单数量大于剩余箱数，将删除此抢单！');
					conformno();
				}else{
					$.ajax({
						type : "post",
						url : path + '/manifest/mJudgeAppDriver.do',
						dataType : "json",
						cache : false,
						data : {
							"driverId" : driverid
							
						},
						success : function(data) {
							//判断是否具备抢单条件：评价完成
							if (data.code == CODE_CAUSE_SUCCESS) {								
						
								var grabPrice = document.getElementById("VerificationPrice").value;				
								
								if(grabPrice==null || grabPrice==""){
									grabPrice='0.00';
								}								
								
								//alert('conformyes price:'+ grabPrice);
								$.ajax({
									type : "post",
									url : path + '/manifest/confirmGrab.do',
									dataType : "json",
									cache : false,
									data : {
										"grabId" : grabid,
										"grabPrice" : grabPrice,
										"manifestId": manifestid,
										"grabBoxNum": grabBoxNum,
										"syBoxNum": syBoxNum
									},
									success : function(r) {
										alert('订单状态修改成功!');
										myrefresh();
										
									},
									error : function(request, errinfo, errobject) {
										alert('订单状态修改失败!');
									}
								});
								
							} else {
								alert('抢单失败：超过规定抢单数量！');
							}
						},
						error : function(request, errinfo, errobject) {
							//添加失败，继续添加
							alert('抢单失败！');

						}
					});	
					
				}
				
	
			}
			
			//页面刷新
			function myrefresh()
			{
			   window.location.reload();
			}
			
			//抢单付款
			function moneyCondition() 
			{ 	
				//alert("抢单号:"+grabid);
				
				if(confirm('确认货主已经付款?')){					
					
					$.ajax({
						type : "post",
						url : path + '/manifest/mModifiedMoney.do',
						dataType : "json",
						cache : false,
						data : {
							"grabId" : grabid,
							"statusDO" : 'o'		//d:司机，o:货主		
						},
						success : function(r) {
							//alert('完成状态修改-----------:'+ grade);
							if (r.code == CODE_CAUSE_SUCCESS) {
								grabmoneyowner = '1';
								myrefreshdiv();
								myrefresh();

							}
							if (r.code == CODE_CAUSE_FAILURE) {
								alert('确认已付款!');
							}
						},
						error : function(request, errinfo, errobject) {
							alert('付款失败!');
						}	
					});
				}	
			}
			
			//确认收货，并调用'评价司机'函数
			function confirmGet(grade) {
				
				if(confirm('确认评价司机?')){					
				
					$.ajax({
						type : "post",
						url : path + '/manifest/confirmApp.do',
						dataType : "json",
						cache : false,
						data : {
							"grabId" : grabid,
							"grade" : grade,
							"appraiseType" : 1,
							"grabStatus" : 3
						},
						success : function(r) {
							//alert('huo ping siji ok-xiugai');
							if (r.code == CODE_CAUSE_SUCCESS) {
								alert('货主对司机的评价成功!');
								myrefresh();
			
							}
							if (r.code == CODE_CAUSE_FAILURE) {
								alert('货主对司机的评价失败!');
							}
						},
						error : function(request, errinfo, errobject) {
							alert('货主对司机的评价失败!');
						}
					});
				
				}

			}		
		
		
		</script>
		<div data-role="header" data-theme="y">
			<h1>司机详情</h1>
		</div>

		<div data-role="content" id='driverconfirm'>
			<table class="dataintable" cellpadding="0" cellspacing="0" id="tabledriverdialog">		
				<tr id="t1trLoad" style="background-color: #fff">
					<td colspan="3"><span id="t1spnLoad">加载数据中...</span></td>
				</tr>		
				<tr>
					<td width=30% align="right">姓名：</td>
					<td width=65% align="left" id="t1drivername"></td>
					<td width=5% align="left"></td>
				</tr>
				<tr>
					<td align="right">身份证号：</td>
					<td align="left" id="t1idcardno"></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">车牌号：</td>
					<td align="left" id="t1autono"></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">车型：</td>
					<td align="left" id="t1autotypename"></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">载重：</td>
					<td align="left" id="t1loadnum"></td>
					<td></td>
				</tr>	
				<tr>
					<td align="right">开户银行：</td>
					<td align="left" id="t1bankName"></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">银行账户：</td>
					<td align="left" id="t1bankCount"></td>
					<td></td>
				</tr>		
				<tr>
					<td align="right">手机号：</td>
					<td align="left" id="t1phoneno"></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">其他手机号：</td>
					<td align="left" id="t1otherphoneno"></td>
					<td></td>
				</tr>
				<tr>
					<td align="right">价格：</td>
					<td align="left" ><input type="number" name="VerificationPrice" id="VerificationPrice"  pattern="[0-9]*" value=""></td>
					<td align="left" >元</td>
				</tr>
				<tr>
					<td align="right">单号：</td>
					<td align="left" id="t1manifestid"></td>
					<td></td>
				</tr>
				<tr align="center">
                       <th colspan="4">
                      		<table cellpadding="0" cellspacing="0" width=95%  >
                               <tr>
                                   <td align="center">
                                       <div data-role="navbar" class="ui-body-c" id="navbardiv" >
                                           <ul>
                                               <li><a href="#" class="ui-disabled">好评 <span class="ui-li-count" id="t1grade1" ></span></a></li>
                                               <li><a href="#" class="ui-disabled">中评 <span class="ui-li-count" id="t1grade2" ></span></a></li>
                                               <li><a href="#" class="ui-disabled">差评 <span class="ui-li-count" id="t1grade3" ></span></a></li>
                                           </ul>
                                      </div>
       							</td>
                               </tr>
                           </table>
       				</th>
                   </tr>
	

			</table>
			<table align="center" id="tableStatus1">
				<tr align="center">
					<th colspan="2">
						<a href="tel:158" data-role="button" data-inline="true" style="width: 100%;" data-theme="x" id="driverPhone" >拨打司机电话</a>
					</th>
				</tr>
				<tr id="statues1">
					<td width=50% align="right"><a href="" onclick="conformyes();"
						data-role="button" data-rel="back" data-inline="true"
						style="width: 110px;" data-ajax="false" data-theme="x">确认司机</a></td>
					<td width=50% align="left"><a href="" onclick="conformno();"
						data-role="button" data-rel="back" data-inline="true"
						style="width: 110px;" data-ajax="false" data-theme="x">拒绝</a></td>
				</tr>

			</table>

			<table class="dataintable"  cellpadding="0" cellspacing="0" align="center" id="tableStatus2">
				<tr id="t2trLoad" style="background-color: #fff">
					<td colspan="3"><span id="t2spnLoad">加载数据中...</span></td>
				</tr>
				<tr>
					<th colspan="4" id="t2drivername"></th>
				</tr>
				<tr>
					<th colspan="4" id="t2idcardno"></th>
				</tr>
				<tr>
					<td width=25% align="right">车型：</td>
					<td width=25% align="left" id="t2autotypename"></td>
					<td width=25% align="right">载重：</td>
					<td width=25% align="left" id="t2loadnum"></td>
				</tr>
				<tr>
					<th colspan="4" id="t2bankName"></th>
				</tr>
				<tr>
					<th colspan="4" id="t2bankCount"></th>
				</tr>				
				<tr>
					<th colspan="4" id="t2phoneno"></th>
				</tr>
				<tr>
					<th colspan="4" id="t2otherphoneno"></th>
				</tr>
				<tr>
					<th colspan="4" id="t2manifestid"></th>
				</tr>
				<tr>
					<th colspan="4">
					
						<div data-role="navbar" class="ui-body-c" style="width:85%; margin: 0 auto;">
							<ul>
								<li><a href="" onclick="confirmGet(1);">好评 </a></li>
								<li><a href="" onclick="confirmGet(2);">中评 </a></li>
								<li><a href="" onclick="confirmGet(3);">差评 </a></li>
							</ul>
						</div>
					</th>
				</tr>


			</table>

			<table class="dataintable"  cellpadding="0" cellspacing="0" align="center" id="tableStatus3">
				<tr id="t3trLoad" style="background-color: #fff">
					<td colspan="3"><span id="t3spnLoad">加载数据中...</span></td>
				</tr>
				<tr>
					<th colspan="4" id="t3drivername"></th>
				</tr>
				<tr>
					<th colspan="4" id="t3idcardno"></th>
				</tr>
				<tr>
					<td width=25% align="right">车型：</td>
					<td width=25% align="left" id="t3autotypename"></td>
					<td width=25% align="right">载重：</td>
					<td width=25% align="left" id="t3loadnum"></td>
				</tr>
				<tr>
					<th colspan="4" id="t3bankName"></th>
				</tr>
				<tr>
					<th colspan="4" id="t3bankCount"></th>
				</tr>	
				<tr>
					<th colspan="4" id="t3phoneno"></th>
				</tr>
				<tr>
					<th colspan="4" id="t3otherphoneno"></th>
				</tr>
				<tr>
					<th colspan="4" id="t3manifestid"></th>
				</tr>	
								
				<tr id="navbarall">
					<th colspan="4">					
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
						
						
					</th>
				</tr>			
	
			</table>
			
			<!-- 已收款情况  -->
			<div id="grabmoneyownerdiv" style="display: none;">
				<a href="javascript:moneyCondition()" data-role="button" style="width:100%; margin: 0 auto;" data-theme="x">已付款</a>								
			</div>
		</div>
	</div>


</body>
</html>