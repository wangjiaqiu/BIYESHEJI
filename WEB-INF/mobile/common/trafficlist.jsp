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

<script type="text/javascript">
	var userid 		= '<%=userid%>';	
	var usertype 	= '<%=usertype%>';
	
	$(function(){
		//alert('lsit start');
     
		$.ajax({
			type : "post",
			url : path + '/traffic/mListTraffic.do',
			dataType : "json",
			cache : false,
			success:function(result) { 
				var htmltable = [];
				//alert('result.traffic count:'+result.traffic.length);
				for(var i in result.traffic) {  
		            //alert(i+":"+result.traffic[i].address+result.traffic[i].note+result.traffic[i].issuetime);
		            htmltable.push('<tr> <td width=30% align="right">'+result.traffic[i].address+'</td> <td width=50%>'+result.traffic[i].note+'</td> <td width=20%>'+result.traffic[i].issuetime+'</td> </tr>');								  
		        }	
		
				$("#tablemy").append( htmltable );

	        }, 				
			error : function(request, errinfo, errobject) {			
				//alert("errinfo："+errinfo);
			}
			
			
		});
		
		
		var oTable = document.getElementById('tablemy');//è·åtableå¯¹è±¡  
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
<div data-role="page" class="jqm-demos"  data-quicklinks="true">
  <div data-role="header" class="jqm-header" data-position="fixed" data-tap-toggle="false" data-theme="y" > 

    <h2>最新路况</h2>
    <a href="trafficadd.jsp?userid=<%=userid%>&usertype=<%=usertype%>" data-ajax="false" data-icon="bars" class="ui-btn-right" >上报路况</a>    
    
  </div>
  <!-- /header -->
  
  <div data-role="main" >
    <table  data-role="tablex" class="dataintable" cellpadding="0" cellspacing="0"  width=100% id="tablemy">

    </table>
    
  
  </div>
  <!-- /content -->
  <div data-role="footer" data-position="fixed">
    
    <!-- /底部 --> </div>
</div>
<!-- /page -->
</body>
</html>

