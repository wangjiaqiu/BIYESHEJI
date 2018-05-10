<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
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
		
		//根据id获取用户信息
		var ownerid = '<%=ownerid%>';
		//var ownerid = '5';
		//alert('huo zhu my ownerid:'+ownerid);
		
		$.ajax({
			type : "post",
			url : path + "/manifest/mQueryManifestOwnerList.do",
			dataType : "json",
			cache : false,
			data : {
				"ownerid" : ownerid
			},
			success:function(result) { 
				//alert('result.manifestidinfo count:'+result.manifestidinfo.length);
								
				var htmlmanifestalllist = [];
				var manifestid;
				var manifeststatus;
				
				for(var i in result.manifestidinfo) {  
					manifestid = result.manifestidinfo[i].manifestid;
					if(result.manifestidinfo[i].manifeststatus == 1){
						manifeststatus = "抢单中";
					}else if(result.manifestidinfo[i].manifeststatus == 2){
						manifeststatus = "已完成";
					}else{
						manifeststatus = "抢单结束";
					}

					htmlmanifestalllist.push(
							'<li><a href="goodlistownermyinfo.jsp?manifestid='+ manifestid +'&ownerid='+ownerid+'" data-ajax="false">'+manifestid +'<span style="padding-left: 20px">'+ result.manifestidinfo[i].manifestname +'</span>'+' <span class="ui-li-count">'+manifeststatus+'</span></a></li>\n'
		            		);
				}
	           // alert('htmlmanifestalllist:'+htmlmanifestalllist);
	            $("#my-listview").append( htmlmanifestalllist ).listview('refresh');	

				
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
			<a href="goodadd.jsp?ownerid=<%=ownerid%>" data-ajax="false" data-icon="plus"
				class="ui-btn-right">发货</a>
			<h2>我的货单</h2>
		</div>
		<!-- /header -->

		<div data-role="main" data-theme="b">
			<ul data-role="listview" data-theme="c" id="my-listview">

			</ul>


		</div>
		<!-- /content -->
	</div>
	<!-- /page -->
</body>
</html>
