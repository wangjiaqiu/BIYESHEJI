<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String driverid =request.getParameter("driverid");
	
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
		
		var driverid = '<%=driverid%>';		
		
		//alert('driverid:'+driverid);
	
		$.ajax({
			type : "post",
			url : path + "/manifest/mqueryDriverGrabList.do",
			dataType : "json",
			cache : false,
			data : {
				"driverId" : driverid
			},
			success:function(result) { 
				
				if( result.driverGrabList.length > 0 ){
					
					var grabstatus;	
					
					var tempUrl,tempUrl2;
					
					
					for(var i in result.driverGrabList) { 
												
						if(result.driverGrabList[i].grabstatus == 1){
							grabstatus = '待确认';						
						}else if(result.driverGrabList[i].grabstatus == 2 && result.driverGrabList[i].grabstatusdriver != 3){
							grabstatus = '已确认';		
						}else if(result.driverGrabList[i].grabstatus == 3 && result.driverGrabList[i].grabstatusdriver != 3){
							//货主评价完成，但是司机未评价
							grabstatus = '已确认';		
						}else if(result.driverGrabList[i].grabstatus == 2 && result.driverGrabList[i].grabstatusdriver == 3){
							grabstatus = '已完成';		
						}else if(result.driverGrabList[i].grabstatus == 3 && result.driverGrabList[i].grabstatusdriver == 3){
							grabstatus = '已完成';		
						}
						
						var row=$("#template").clone();//克隆一份模板
	                    row.find("#divNum").html( result.driverGrabList[i].manifestid+'-'+result.driverGrabList[i].grabnumber );//替换标记内容
	                    row.find("#divName").html(result.driverGrabList[i].manifestname);
	                    row.find("#divStatus").html(grabstatus);
	                    
	                    if( result.driverGrabList[i].grabmoneydriver == 0 ||result.driverGrabList[i].grabmoneydriver == null || result.driverGrabList[i].grabmoneydriver == undefined || result.driverGrabList[i].grabmoneydriver == ''){
	                    	row.find("#divSearch").html("【未收款】");
	                    }else{
	                    	row.find("#divSearch").html('【已收款】');
	                    }	                    
	                    row.attr("id",i);//改变行的Id
	                    row.attr("onMouseOver","this.style.cursor='hand'");//改变行的Id
	                    tempUrl = 'goodlistdrivermyinfo.jsp?manifestid='+ result.driverGrabList[i].manifestid + '&grabid=' + result.driverGrabList[i].grabid +'&grabnumber=' + result.driverGrabList[i].grabnumber +'&driverid='+driverid +'&grabstatus='+result.driverGrabList[i].grabstatus+'&grabstatusdriver='+result.driverGrabList[i].grabstatusdriver+'&grabmoneydriver='+result.driverGrabList[i].grabmoneydriver;
	                    row.attr("onClick",'window.location.href="'+tempUrl+'"');//改变行的Id
	                    row.appendTo("#tableTemp");//添加到模板的容器中	
					}
					
					$("#template").css("display","none");//隐藏行模块
	                $("#trLoad").css("display","none");//隐藏提示行模块
					
	
	            }
	            else{
	                $("#spnLoad").html("<font color=green>没有查询到数据！</font>");
	            }
				
	        }, 				
			error : function(request, errinfo, errobject) {			
				alert("errinfo："+errinfo);
			}
		});
		
		
		
		
		var oTable = document.getElementById('tableTemp');//获取table对象  
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
	
	
</script>
</head>

<body>
	<div data-role="page" data-quicklinks="true">
		<div data-role="header" data-position="fixed" data-tap-toggle="false"
			data-theme="y">
			<h2>我的货单</h2>
			<a href="" onclick="history.go(0)" data-ajax="false" data-icon="refresh"  class=" ui-btn-right" data-theme="y">刷新</a> 
		</div>
		<!-- /header -->

		<div data-role="main">
			<table class="dataintable"  cellpadding="0" cellspacing="0" border="0px" width=100% id="tableTemp">
				<tr id="trLoad" style="background-color: #fff">
					<td colspan="4"><span id="spnLoad">加载数据中...</span></td>
				</tr>
				<tr id="template">
					<td id="divNum" width=25% align="center"></td>
					<td id="divName" width=25% align="center"></td>
					<td id="divStatus" width=25% align="center"></td>
					<td id="divSearch" width=25% align="right">

					</td>
				</tr>
			</table>			

		</div>
		<!-- /content -->
		<div data-role="footer" data-position="fixed"></div>

		<!-- /底部 -->
	</div>
	<!-- /page -->
</body>
</html>
