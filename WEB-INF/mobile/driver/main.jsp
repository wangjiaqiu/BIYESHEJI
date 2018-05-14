<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
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
	<link rel="stylesheet"  href="../../css/themes/default/jquery.mobile-1.3.2.min.css">
	<link rel="stylesheet" href="../../_assets/css/jqm-demos.css">
	<link rel="shortcut icon" href="../favicon.ico">
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
	<script src="../../js/jquery.js"></script>
	<script src="../../_assets/js/index.js"></script>
	<script src="../../js/jquery.mobile-1.3.2.min.js"></script>
</head>
<body>
<div data-role="page" class="jqm-demos jqm-demos-index">

	<div data-role="header" class="jqm-header">
        <h1 class="jqm-logo"><a href="../"><img src="../_assets/img/jquery-logo.png" alt="jQuery Mobile Framework"></a></h1>
		<a href="#" class="jqm-navmenu-link" data-icon="bars" data-iconpos="notext">Navigation</a>
		<a href="#" class="jqm-search-link" data-icon="search" data-iconpos="notext">Search</a>
<div class="jqm-search">
    <ul class="jqm-list">
<li data-section="Widgets" data-filtertext="accordions collapsible sets content formatting grouped inset mini"><a href="widgets/accordions/">Accordion</a></li>

<li data-section="Widgets" data-filtertext="ajax navigation navigate event method"><a href="widgets/navigation/" data-ajax="false">AJAX Navigation</a></li>

<li data-section="Widgets" data-filtertext="autocomplete filter reveal listviews remote listviewbeforefilter placeholder"><a href="widgets/autocomplete/" data-ajax="false">Autocomplete</a></li>

<li data-section="Widgets" data-filtertext="buttons inputs forms inline theme grouped icons mini disabled"><a href="widgets/buttons/" data-ajax="false">Buttons</a></li>

<li data-section="Widgets" data-filtertext="checkboxes checkboxradio inputs forms mini disabled"><a href="widgets/checkbox/">Checkboxes</a></li>

<li data-section="Widgets" data-filtertext="collapsibles content formatting"><a href="widgets/collapsibles/" data-ajax="false">Collapsibles</a></li>

<li data-section="Widgets" data-filtertext="controlgroups selects checkboxradio buttons horizontal vertical"><a href="widgets/controlgroups/">Controlgroup</a></li>

<li data-section="Widgets" data-filtertext="dialogs modal popups"><a href="widgets/dialog/">Dialogs</a></li>

<li data-section="Widgets" data-filtertext="fixed toolbars headers footers sections fullscreen"><a href="widgets/fixed-toolbars/">Fixed toolbars</a></li>



    </ul>
    
    
</div>

	</div><!-- /header -->
	
		<div data-role="content" class="jqm-content">
		
			</div><!-- /content -->

	<div data-role="footer" class="jqm-footer">
		<p class="jqm-version"></p>
		<p>Copyright 2013 The jQuery Foundation</p>
	</div><!-- /footer -->
	
	</div><!-- /page -->
</body>
</html>