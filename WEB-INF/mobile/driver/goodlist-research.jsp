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
<script type="text/javascript" src="../../js/jsAddress-research.js"></script>
<script type="text/javascript">

	var arraySy = new Array(); 	//创建一个数组
	var arrayMax = new Array(); 	//创建一个数组 最大抢单数
	var arrayManifestId = new Array(); 	//创建一个数组
	//根据id获取用户信息
	var driverid = '<%=driverid%>';	
	
	var researchjudge = 1 ;	//1:搜索，2：显示

	
	$(function() {
		$("#research").css("display","block");//隐藏
		//$("#goodlist").css("display","none");//隐藏
		document.getElementById("goodlist").style.display="none";
		document.getElementById("templetediv").style.display="none";
		
		$.ajax( {
			type : "post",
			url : path + "/common/queryBoxTypeCombobox.do",
			dataType : "json",
			cache : false,
			success:function(result) { 
				var htmlselect = [];
				htmlselect.push('<option value="无">无</option>\n');
				for(var i in result.combo) {  
		            htmlselect.push('<option value="'+result.combo[i].boxtypeid+'">'+result.combo[i].boxtypename+'</option>\n');
		        }
				
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
				
				//$("#boxOwnerId").selectedIndex = 0;
				$("#boxOwnerId").append( htmlselect ).selectmenu('refresh');
				
	        }, 				
			error : function(request, errinfo, errobject) {			
				//alert("errinfo："+errinfo);
			}
		});
		
		
	});
	
	
	
	$(document).ready(function() {
		//货单筛选
		$("#submit").click(function() {
			startRefresh();
		});
		
	});
	
	//开始搜索
	function startRefresh()
	{
		//var formData = $("#callAjaxForm").serialize();
		//alert('submit');
		//alert('sendProvince'+$("#sendProvince").options[0].value);
		//alert($("#boxTypeId").find("option:selected").text());  //获取当前的 value 值 			
		//alert($("#sendProvince").find("option:selected").text());   //获取 select 当前值的文本值

		document.getElementById("templetediv").style.display="block"; 
		//清除记录
		for (var x = 0; x < arrayManifestId.length; x++)
		{
			var my = document.getElementById(arrayManifestId[x]);
			if (my != null)
		        my.parentNode.removeChild(my);					
		}
		
		//位置跳转
		$("#research").css("display","none");//隐藏
		researchjudge = 2;
   

		$.ajax({
			type : "post",
			url : path + "/manifest/mQueryResearchManifest.do",
			dataType : "json",
			cache : false,
			data : {
				"driverId" : driverid,
				"boxTypeName" : $("#boxTypeId").find("option:selected").text(),
				"boxOwnerName" : $("#boxOwnerId").find("option:selected").text(),
				"sendProvince" : $("#sendProvince").find("option:selected").text(),
				"sendCity" : $("#sendCity").find("option:selected").text(),
				"sendArea" : $("#sendArea").find("option:selected").text(),
				"receiveProvince" : $("#receiveProvince").find("option:selected").text(),
				"receiveCity" : $("#receiveCity").find("option:selected").text(),
				"receiveArea" : $("#receiveArea").find("option:selected").text()
			},
			success:function(result) { 			
				
				//alert('result.manifestinglist.length'+result.manifestinglist.length);

				if( result.manifestinglist.length > 0 ){
					$("#Tetsid").css("display","block");//隐藏行模块
					document.getElementById("templetediv").style.display="none";
					document.getElementById("goodlist").style.display="block";
					

					//清除记录
					for (var x = 0; x < arrayManifestId.length; x++)
    				{
						var my = document.getElementById(arrayManifestId[x]);
						if (my != null)
					        my.parentNode.removeChild(my);					
					}
	
					var manifestId;
					var grabboxNumall;
					
					var btnQiangdanmanifestId;
					var btnPhonemanifestId;
					var BoxNumbermanifestId;
					
					
					for(var i in result.manifestinglist) {  
						var divContent=$("#Tetsid").clone();//克隆一份模板
						
						manifestId = result.manifestinglist[i].manifestId;	
						
						
						btnQiangdanmanifestId = "btnQiangdan" + manifestId;
						btnPhonemanifestId = "btnPhone" + manifestId;						
						BoxNumbermanifestId = "BoxNumber" + manifestId;
						
						var manifestStatus;
						if(result.manifestinglist[i].manifestStatus == 1){
							manifestStatus = "抢单中";
						}else if(result.manifestinglist[i].manifestStatus == 2){
							manifestStatus = "已完成";
						}else{
							manifestStatus = "抢单结束";
						}
						
						grabboxNumall = result.manifestinglist[i].boxNum - result.manifestinglist[i].grabboxnumall;
						//将剩余箱数存入数组，以便于检测箱数是否合法
						arraySy.push(grabboxNumall);						
						arrayManifestId.push(manifestId);
						
						if(result.manifestinglist[i].boxTypeName == '20'){
							
							//判断剩余一箱
							if(grabboxNumall==1){
								arrayMax.push('1');
								divContent.find("#BoxNumber").attr("readonly",true);//改变行的Id								
							}else{
								arrayMax.push('2');
								
								if(result.manifestinglist[i].manifestStatus == 1){	
									divContent.find("#BoxNumber").val("2");	//设置val	
								}
							}
						}else{
							arrayMax.push('1');
							divContent.find("#BoxNumber").attr("readonly",true);//改变行的Id	
						}
						
						divContent.attr("id",manifestId);//改变行的Id
						divContent.find("#manifestId").html('货单号：'+ result.manifestinglist[i].manifestId);//替换标记内容
						divContent.find("#manifestStatus").html(manifestStatus);//替换标记内容
						divContent.find("#manifestName").html(result.manifestinglist[i].manifestName);//替换标记内容
						divContent.find("#weight").html(result.manifestinglist[i].weight +'吨/箱');//替换标记内容
						divContent.find("#boxTypeNameGood").html(result.manifestinglist[i].boxTypeName +'尺');//替换标记内容
						divContent.find("#boxOwnerName").html(result.manifestinglist[i].boxOwnerName);//替换标记内容
						divContent.find("#sendProvinceGood").html( '<span style="background-color: #ebc4cb; padding:2px"> 出发地及日期：'+ result.manifestinglist[i].sendProvince+ result.manifestinglist[i].sendCity+ result.manifestinglist[i].sendArea+ result.manifestinglist[i].sendDetailedAddress + result.manifestinglist[i].sendDate +'</span>' );//替换标记内容
						divContent.find("#receiveProvinceGood").html( '<span style="background-color: #fbc496; padding:2px"> 送达地及日期：'+ result.manifestinglist[i].receiveProvince+ result.manifestinglist[i].receiveCity+ result.manifestinglist[i].receiveArea + result.manifestinglist[i].receiveDetailedAddress + result.manifestinglist[i].receiveDate +'</span>' );//替换标记内容
				
						divContent.find("#ownerName").html(result.manifestinglist[i].ownerName);//替换标记内容
						divContent.find("#grade1").html( result.manifestinglist[i].grade1 );//替换标记内容
						divContent.find("#grade2").html( result.manifestinglist[i].grade2 );//替换标记内容
						divContent.find("#grade3").html( result.manifestinglist[i].grade3 );//替换标记内容
						divContent.find("#price").html( "价格："+result.manifestinglist[i].price +result.manifestinglist[i].priceUnit);//替换标记内容
						divContent.find("#remark").html( "备注："+result.manifestinglist[i].remark );//替换标记内容
						divContent.find("#boxNum").html( grabboxNumall +'/'+ result.manifestinglist[i].boxNum +'箱 ');//替换标记内容
						divContent.find("#btnQiangdanmanifestId").attr("id",btnQiangdanmanifestId);//改变行的Id
						divContent.find("#btnPhonemanifestId").attr("href","tel:"+result.manifestinglist[i].phoneNo  );//改变行的Id						
						divContent.find("#btnPhonemanifestId").attr("id",btnPhonemanifestId);//改变行的Id
	
										
						if(result.manifestinglist[i].manifestStatus != 1){	
							divContent.find("#"+btnQiangdanmanifestId).attr("style","display:none;");//隐藏行模块
						}else{
							divContent.find("#BoxNumber").attr("id",BoxNumbermanifestId);//改变行的Id
						}
						
						divContent.appendTo("#goodlist");//添加到模板的容器中

					}
					$("#Tetsid").css("display","none");//隐藏行模块
					
					
				}else{
					//document.getElementById("templetediv").style.display="none";
					$("#spnLoad").html("<font color=green>没有查询到数据！</font>");
				}
				$("#wxopenid").focus();
				
	        }, 				
			error : function(request, errinfo, errobject) {			
				alert("errinfo："+errinfo);
			}
		});
	
	}
	
	//发货地和目的地替换
	function btnreplace()
	{
		var arraySend = new Array($("#sendProvince").find("option:selected").text(),$("#sendCity").find("option:selected").text(),$("#sendArea").find("option:selected").text());//直接定义并初始化
		var arrayReceive = new Array($("#receiveProvince").find("option:selected").text(),$("#receiveCity").find("option:selected").text(),$("#receiveArea").find("option:selected").text());//直接定义并初始化
		
		addressInit('sendProvince', 'sendCity', 'sendArea', arrayReceive[0], arrayReceive[1], arrayReceive[2]);
		addressInit('receiveProvince', 'receiveCity',	'receiveArea', arraySend[0], arraySend[1], arraySend[2]);
		
		$("#sendProvince").selectmenu("refresh");  
		$("#sendCity").selectmenu("refresh");
		$("#sendArea").selectmenu("refresh");
		$("#receiveProvince").selectmenu("refresh");  
		$("#receiveCity").selectmenu("refresh");
		$("#receiveArea").selectmenu("refresh");
		
	}
	
	//页面刷新
	function myrefresh()
	{
	   window.location.reload();
	}
	
	//抢单最大数
	function funNumber(buttonId) 
	{ 	
		//alert("抢单数量:"+buttonId);		

		var manifestId = buttonId.replace("BoxNumber","");
		var grabboxNum = document.getElementById("BoxNumber"+manifestId).value;
		//alert("grabboxNum now:"+grabboxNum);
		
		//获取当前货单的剩余数量
		var i;
		//获取当前货单的剩余数量
		var i;
		var tempIndexNumer,tempIndexSy;;
		//alert('manifestId:'+manifestId);
		//alert('arrayManifestId.length:'+arrayManifestId.length);
		for (i = 0; i < arrayManifestId.length; i++)
	    {
			//alert('arrayManifestId.'+i+':'+arrayManifestId[i]);
	        if ( manifestId == arrayManifestId[i] ){
	        	tempIndexNumer = arrayMax[i];
	        	tempIndexSy = arraySy[i];
	        	//alert('manifestId tempIndexNumer:'+tempIndexNumer);
				break;
	        }
		}
		//alert("tempIndexNumer:"+ tempIndexNumer);
		if( grabboxNum > tempIndexNumer){
			if( grabboxNum > tempIndexSy){
				$("#BoxNumber"+manifestId).val( tempIndexSy );
			}else{
				$("#BoxNumber"+manifestId).val( tempIndexNumer );
			}
			
			//document.getElementById("BoxNumber"+manifestId).val( tempIndexNumer );
		}
	}
	
	function displayHide_research() 
	{ 	
		if( researchjudge == 1){
			startRefresh();
		}else if ( researchjudge == 2){
			$("#research").css("display","block"); //显示
			researchjudge = 1;
		}
	}
	
	function displayHide_control(buttonId) 
	{ 	
		//
		//buttonId:btnQiangdan5
		//alert("选择的是"+buttonId);		

		var manifestId = buttonId.replace("btnQiangdan","");
		var driverId = '<%=driverid%>';
		//var driverId = 5;
		var grabboxNum = document.getElementById("BoxNumber"+manifestId).value;

	
		//获取当前货单的剩余数量
		var i;
		var tempIndexNumer;
		for (i = 1; i < arrayManifestId.length; i++)
	    {
	        if ( manifestId == arrayManifestId[i] ){
	        	tempIndexNumer = arraySy[i];
				break;
	        }
		}
		
		var _controlFrom = document.getElementById("btnQiangdan"+manifestId);
		var _controlTo = document.getElementById("btnPhone"+manifestId); 
		
		//alert('tempIndexNumer:'+tempIndexNumer);
	
		if(grabboxNum=='' || grabboxNum == null){
			alert('请填写抢单数量！');
		}if( grabboxNum > tempIndexNumer ){
			alert('请正确填写抢单数量！');			
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
						
				
						$.ajax({
							type : "post",
							url : path + '/manifest/mAddDriverGrab.do',
							dataType : "json",
							cache : false,
							data : {
								"manifestId" : manifestId,
								"driverId" : driverId,
								"grabboxNum" : grabboxNum
							},
							success : function(data) {
								//添加成功，返回路况列表
								if (data.code == CODE_CAUSE_SUCCESS) {
									_controlFrom.style.display="none";
									_controlTo.style.display="block"; 						
									alert('抢单成功！');
									//WeixinJSBridge.call('closeWindow');
									//myrefresh();
									//window.location='goodlistdrivermy.jsp?driverid='+'<%=driverid%>';
								} else {
									alert('抢单失败！');
								}
							},
							error : function(request, errinfo, errobject) {
								//添加失败，继续添加
								alert('抢单失败！');

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
	

</script>
</head>

<body>

	<div data-role="page" class="jqm-demos jqm-demos-index"
		data-quicklinks="true" data-theme="b">
		<div data-role="header" class="jqm-header" data-position="fixed"
			data-tap-toggle="false" data-theme="y">
			<a href="goodlist.jsp?driverid=<%=driverid%>" data-ajax="false"
				data-icon="refresh" class=" ui-btn-left" data-theme="y">返回</a>
			<h2>货单筛选</h2>
			<a onclick="javascript:displayHide_research();return false;" href="#" class=" ui-btn-right" data-ajax="false" data-icon="search" data-theme="y">筛选 </a>
		</div>
		<!-- /header -->



		<div data-role="main" class="ui-content">
			<div id="research">
					<input type="hidden" id="ownerId" name="ownerId"
						value=<%=driverid%> />
					<table class="dataintable" cellpadding="0" cellspacing="0"
						width=100% id="researchTable">

						<tr>
							<td width=27% align="right">箱型：</td>
							<td width=65%><select name="boxTypeId" id="boxTypeId"
								data-theme="x">
							</select></td>
							<td width=8%></td>
						</tr>
						<tr>
				          <td align="right">箱属：</td>
				          <td>
				              <select name="boxOwnerId" id="boxOwnerId" data-theme="x">
				              </select>
				            </td>
				          <td>&nbsp;</td>
				        </tr>
						<tr>
						<tr bgcolor="#FFff00">
							<th colspan="3" style="background-color: #00bec8;"><label>发货地</label></th>
						</tr>
						<tr>
							<td align="right">省：</td>
							<td><select id="sendProvince" name="sendProvince"
								data-theme="x"></select></td>
							<td></td>
						</tr>
						<tr>
							<td align="right">市：</td>
							<td><select id="sendCity" name="sendCity" data-theme="x"></select>
							</td>
							<td></td>
						</tr>
						<tr style="display:none;">
							<td align="right">区/县：</td>
							<td><select id="sendArea" name="sendArea" data-theme="x"></select>
							</td>
							<td></td>
						</tr>

						<tr bgcolor="#FFff00">
							<th colspan="3" style="background-color: #00bec8;"><label>送达地</label></th>
						</tr>
						<tr>
							<td align="right">省：</td>
							<td><select id="receiveProvince" name="receiveProvince"
								data-theme="x"></select></td>
							<td></td>
						</tr>
						<tr>
							<td align="right">市：</td>
							<td><select id="receiveCity" name="receiveCity"
								data-theme="x"></select></td>
							<td></td>
						</tr>
						<tr style="display:none;">
							<td align="right">区/县：</td>
							<td><select id="receiveArea" name="receiveArea"
								data-theme="x"></select></td>
							<td></td>
						</tr>
						
						<tr bgcolor="#FFff00">
							<th colspan="3" style="background-color: #00bec8;">
								<a href="#" onclick="btnreplace();" data-role="button" data-icon="arrow-r" data-iconpos="right" data-inline="true"  data-theme="x" >发货地和目的地交换</a>
							</th>
						</tr>


						<tr>
							<th colspan="3">
							
							<input type="submit" name="submit" id="submit" value="筛选" data-theme="x" style="width: 100%;" data-icon="search"/></th>
						</tr>
					</table>
				<script type="text/javascript">
					//alert("init");
					addressInit('sendProvince', 'sendCity', 'sendArea', '辽宁', '无', '无');
					addressInit('receiveProvince', 'receiveCity',	'receiveArea', '辽宁', '无', '无');
				</script>

				
			</div>
			
			<div id='posaction'>
				
				<div  id='templetediv'>
					<table class="dataintable"  cellpadding="0" cellspacing="0" border="0px" width=100% id="tableTemp">
						<tr id="trLoad" style="background-color: #fff">
							<td colspan="4" align="center"><span id="spnLoad">加载数据中...</span></td>
						</tr>	
					</table>			
		
				</div>
	
				<div id='goodlist'>
	
					<div id="Tetsid">
			       		<table class="dataintable" cellpadding="0" cellspacing="0"  width=100% id="tablemy" >
			               	<tr align="center">
			                       <th colspan="3"  align="center" id="manifestId">     	
			                       </th>
			                       <td align="right"><span style="background-color: #00bec8; padding:5px"><font  id="manifestStatus" style="text-shadow: 0px 0px 0px #fff;"></font></span></td>
			                   </tr>
			                   <tr>
			                       <td width=25% align="right">货名：</td>
			                       <td width=25% align="left" id="manifestName"></td>
			                       <td width=25% align="right">货重：</td>
			                       <td width=25% align="left" id="weight"></td>
			                   </tr>
			                   <tr>
			                       <td align="right">箱型：</td>
			                       <td align="left" id ="boxTypeNameGood"></td>
			                       <td align="right">箱属：</td>
			                       <td align="left" id="boxOwnerName"> </td>
			                   </tr>   
			                   <tr>
			                       <td align="right">抢单数量：</td>
			                       <td align="left" >
					                    <table>
											<tr >
												<td align="left" width=50%><input type="number"  pattern="[0-9]*" id="BoxNumber" name="BoxNumber" maxlength="1" value="1" style="width:100%; height:24px;" onchange="funNumber(this.id)"/></td>
												<td align="left" width=50%>箱</td>
											</tr>
										</table>
									</td>
			                       <td align="right">剩余数量：</td>
			                       <td align="left" id="boxNum"></td>
			                   </tr>
			                   <tr align="center">
			                       <th colspan="4" id="sendProvinceGood">       				
			                       </th>
			                   </tr>
			                   <tr align="center">
			                       <th colspan="4" id="receiveProvinceGood" >
			                       </th>
			                   </tr>
			                   <tr align="center">
			                       <th colspan="4">
			                      		<table cellpadding="0" cellspacing="0" width=95% border="2px" bordercolor="#666666" >
			                               <tr>
			                                   <td align="center">
			       								<label style="line-height:30px; text-align:center; margin-top:0px" id="ownerName" ></label>
			                                       <div data-role="navbar" class="ui-body-c" id="navbardiv" >
			                                           <ul>
			                                               <li><a href="#" class="ui-disabled">好评 <span class="ui-li-count" id="grade1" ></span></a></li>
			                                               <li><a href="#" class="ui-disabled">中评 <span class="ui-li-count" id="grade2" ></span></a></li>
			                                               <li><a href="#" class="ui-disabled">差评 <span class="ui-li-count" id="grade3" ></span></a></li>
			                                           </ul>
			                                      </div>
			       							</td>
			                               </tr>
			                           </table>
			       				</th>
			                   </tr>
			                   <tr align="center">
			                       <th colspan="4">
			                       	<span id="price"></span>
			                       </th>
			                   </tr>
			                   <tr align="center">
			                       <th colspan="4">
			                       	<span id="remark"></span>
			                       </th>
			                   </tr>
			                   <tr align="center" id="buttonqiangdan">
			                       <th colspan="4">
			                       	<a onclick="javascript:displayHide_control(this.id);return false;" href="#" id="btnQiangdanmanifestId">
			                           	<img src="../../img/button-qiangdan.png">
			                           </a>
			                           <a href="tel:13812341234" id="btnPhonemanifestId" style="display:none;">
			                           	<img src="../../img/button-phone.png"> 
			                           </a>
			                       </th>
			                   </tr>
			               </table>
	              	</div> 
				</div>
			
			</div>
			



		</div>
		<!-- /content -->
		<div data-role="footer" data-position="fixed"></div>
		<!-- /底部 -->


	</div>
	<!-- page -->
</body>
</html>
