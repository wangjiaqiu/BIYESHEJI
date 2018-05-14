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

	var manifestid = '<%=manifestid%>';
	
	var manifestSum;
	var manifestSy;
	
	
	$(function() {	
		
		//根据货单id获取用户信息：manifestid
	
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
				
				manifestSy = syGrabBoxNumerYes;
				manifestSum = result.manifest.boxNum;
				
				//货单剩余数量（不包含待确认状态的数量）
				syGrabBoxNumerNO = result.manifest.boxNum - countGrabBoxNumertemp;
				//alert('syGrabBoxNumerNO:'+ syGrabBoxNumerNO);

				var manifestid = result.manifest.manifestId;
				
				var manifeststatus;
				if(result.manifest.manifestStatus == 1){
					manifeststatus = "抢单中";
					$("#modifiedCount").css("display","");//隐藏清除剩余箱数按钮
					//$("#modifiedCount").css("align","center");//隐藏提示行模块

				}else if(result.manifest.manifestStatus == 2){
					manifeststatus = "已完成";
				}else{
					manifeststatus = "抢单结束";
				}

				$("#manifestId").html('货单号：'+ result.manifest.manifestId );//替换标记内容
				$("#manifeststatus").html( manifeststatus );//替换标记内容
				$("#manifestName").html( result.manifest.manifestName );//替换标记内容
				$("#weight").html( result.manifest.weight );//替换标记内容
				$("#boxTypeName").html( result.manifest.boxTypeName );//替换标记内容
				$("#boxOwnerName").html( result.manifest.boxOwnerName );//替换标记内容
				$("#countGrabBoxNumer").html( countGrabBoxNumer+'箱' );//替换标记内容
				$("#boxNum").html( syGrabBoxNumerYes +'/'+ result.manifest.boxNum +'箱' );//替换标记内容
				$("#sendProvince").html( '出发地及日期：'+ result.manifest.sendProvince+ result.manifest.sendCity+ result.manifest.sendArea + result.manifest.sendDetailedAddress+ result.manifest.sendDate );//替换标记内容
				$("#receiveProvince").html( '送达地及日期：'+ result.manifest.receiveProvince+ result.manifest.receiveCity+ result.manifest.receiveArea+result.manifest.receiveDetailedAddress+ result.manifest.receiveDate );//替换标记内容
				$("#price").val( result.manifest.price );//替换标记内容
				$("#priceUnit").html( result.manifest.priceUnit );//替换标记内容
		
				
				var grabstatus;
				var tempUrl1,tempUrl2;

				for(var i in result.grabDriverList) {
					
					if(result.grabDriverList[i].grabstatus == 1){
						grabstatus = '待确认';						
					}else if(result.grabDriverList[i].grabstatus == 2){
						grabstatus = '已确认';		
					}else if(result.grabDriverList[i].grabstatus == 3){
						grabstatus = '已完成';		
					}					
		
					
					tempUrl1 = '<a href="dialog-confirm.jsp?driverid='+ result.grabDriverList[i].driverid +'&grabid='+result.grabDriverList[i].grabid+'&grabnumber='+result.grabDriverList[i].grabnumber+'&grabstatus='+result.grabDriverList[i].grabstatus +'&manifestid='+manifestid +'&grabBoxNum='+result.grabDriverList[i].grabboxnum +'&syBoxNum='+ syGrabBoxNumerNO+'&grabmoneyowner='+result.grabDriverList[i].grabmoneyowner+'" data-rel="dialog" data-transition="pop">';
                    tempUrl2 = '</a>';
					var row=$("#driverinfotemplate").clone();//克隆一份模板
					row.find("#drivername").html(tempUrl1 + result.grabDriverList[i].drivername +tempUrl2  );		//替换标记内容
					row.find("#grabboxnum").html(tempUrl1 +  result.grabDriverList[i].grabboxnum +'箱' +tempUrl2 );		//替换标记内容
					row.find("#grabprice").html(tempUrl1 +  result.grabDriverList[i].grabprice +'元' +tempUrl2 );		//替换标记内容
					row.find("#grabtime").html(tempUrl1 +  result.grabDriverList[i].grabtime  +tempUrl2 );			//替换标记内容
					
					if( result.grabDriverList[i].grabmoneyowner == 0 ||result.grabDriverList[i].grabmoneyowner == null || result.grabDriverList[i].grabmoneyowner == undefined || result.grabDriverList[i].grabmoneyowner == ''){
                    	row.find("#grabmoneyowner").html(tempUrl1 +  "未付款"  +tempUrl2 );		//替换标记             
                    }else{
                    	row.find("#grabmoneyowner").html(tempUrl1 +  '已付款'  +tempUrl2 );		//替换标记             
                    }						
					
					row.find("#grabstatus").html(tempUrl1 +  grabstatus  +tempUrl2 );		//替换标记                    
    
                    row.attr("id",result.grabDriverList[i].driverid);//改变行的Id

                    row.attr("data-rel","dialog");//改变行的Id
    
                    row.appendTo("#driverlist");//添加到模板的容器中
                    
                  

				}
				
				  $("#driverinfotemplate").css("display","none");//隐藏行模块


				
	        }, 				
			error : function(request, errinfo, errobject) {			
				alert("errinfo："+errinfo);
			}
		});
		 
		
		
	});
	
	//货主修改货单价格
	function modifiedPrice() {
		
		//alert('modifiedPrice');

		if(confirm('确认修改价格?')){
			var price = document.getElementById("price").value;				
			
			if(price==null || price==""){
				price='0.00';
			}								
			
			//alert('conformyes price:'+ price+'-manifestid:'+manifestid);
			$.ajax({
				type : "post",
				url : path + '/manifest/mModifiedPrice.do',
				dataType : "json",
				cache : false,
				data : {
					"manifestId" : manifestid,
					"price" : price
				},
				success : function(r) {
					alert('价格修改成功!');
					
				},
				error : function(request, errinfo, errobject) {
					alert('价格修改失败!');
				}
			});
				
			}
	}
	

	//货主清除剩余的箱数
	function modifiedCount() {		

		if(confirm('确认清除剩余箱数?')){
			/*
			如果 manifestSum == manifestSy，说明还没有抢单，直接修改manifestStatus =2（已完成）；
			如果manifestSum > manifestSy > 0,说明已经有抢单，检测grab的grabstatus是否全为3，直接修改manifestStatus =2，否则manifestStatus =3；
			*/
						
			$.ajax({
				type : "post",
				url : path + '/manifest/mModifiedCount.do',
				dataType : "json",
				cache : false,
				data : {
					"manifestId" : manifestid,

					
				},
				success : function(r) {
					//页面刷新
					window.location.reload();

					alert('剩余箱数清零成功!');
					
				},
				error : function(request, errinfo, errobject) {
					alert('剩余箱数清零失败!');
				}
			});
	
		}
	}
	 		
</script>
</head>

<body>
	<div data-role="page" class="jqm-demos" data-quicklinks="true"
		data-theme="b">
		<div data-role="header" data-position="fixed" data-tap-toggle="false"
			data-theme="y">
			<a href="#" data-role="button" data-rel="back" class="ui-btn-left">返回</a>
			<h2>我的货单</h2>
			<a href="" onclick="history.go(0)" data-ajax="false" data-icon="refresh"  class=" ui-btn-right" data-theme="y">刷新</a> 

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
							style="background-color: #ebc4cb; padding: 2px" id="sendProvince">
						</span></th>
					</tr>
					<tr align="center">
						<th colspan="4"><span
							style="background-color: #fbc496; padding: 2px"
							id="receiveProvince"> </span></th>
					</tr>
					<tr>
						<th colspan="4">
							<table cellpadding="0" cellspacing="0" width=95% border="0px" bordercolor="#666666" >
								<tr >
									<td align="right" width=25%>价格：</td>
									<td align="left"  width=40%><input type="number"  pattern="[0-9]*" id="price" name="price" style=" height:24px;" /></td>
									<td align="right" width=5% id="priceUnit" ></td>
									<td align="right" width=30%><a href="#" onclick="modifiedPrice();" data-role="button" data-icon="arrow-r" data-iconpos="right" data-inline="true"  data-theme="x" >确认修改</a></td>

								</tr>
							</table>
						</th>
						
					</tr>
					<tr align="center">
						<th colspan="4">
							<table cellpadding="0" cellspacing="0" width=95% border="2px" bordercolor="#666666" id="driverlist">
								<tr id="trLoad" style="background-color: #fff">
									<td colspan="6" align="center"><strong><span id="spnLoad" >抢单司机信息</span></strong></td>
								</tr>
								<tr id="driverinfotemplate" data-rel="dialog" data-transition="pop">
									<td id="drivername" width=20% align="center"></td>
									<td id="grabboxnum" width=10% align="center"></td>
									<td id="grabprice" width=20% align="center"></td>
									<td id="grabtime" width=30% align="center"></td>
									<td id="grabmoneyowner" width=10% align="center"></td>
									<td id="grabstatusall" width=10% align="right">
										<font color="#FF0000" id="grabstatus"></font>				
									</td>
								</tr>
							</table>							
						</th>
					</tr>
					<tr id="modifiedCount" align="center" style="display:none;">
						<th colspan="4" align="center" >
							<a href="#" onclick="modifiedCount();" data-role="button" data-icon="arrow-r" data-iconpos="right" data-inline="true"  data-theme="x" >清空剩余箱数</a>
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
