$(function() {
	ps = 1;
	query(ps, manifestId);
	$("#grid1").datagrid({
		title : "抢单司机列表",
		fitColumns : true,
		pagination : true,
		singleSelect : true,
		striped : true,
		showFooter : true,
		toolbar : [ {
			text : '抢单处理',
			iconCls : 'icon-edit',
			handler : function() {
				grabManifest();
			}
		}, {
			text : '收货处理',
			iconCls : 'icon-edit',
			handler : function() {
				getManifest();
			}
		} , {
			text : '付款处理',
			iconCls : 'icon-edit',
			handler : function() {
				payManifest();
			}
		}],
		loadMsg : "数据载入中...",
		columns : [ [
 		{
			title : '<font style=" font-weight:bold">ID</font>',
			align : 'center',
			field : 'grabId',
			width : 0
		},
		{
			title : '<font style=" font-weight:bold">分单号</font>',
			align : 'center',
			field : 'grabNumber',
			width : 30
		},
		{
			title : '<font style=" font-weight:bold">司机姓名</font>',
			align : 'center',
			field : 'driverName',
			width : 40
		}, {
			title : '<font style=" font-weight:bold">银行名称</font>',
			align : 'center',
			field : 'bankName',
			width : 70
		},{
			title : '<font style=" font-weight:bold">银行账号</font>',
			align : 'center',
			field : 'bankCount',
			width : 70
		},{
			title : '<font style=" font-weight:bold">车号</font>',
			align : 'center',
			field : 'autoNo',
			width : 50
		}, {
			title : '<font style=" font-weight:bold">状态</font>',
			align : 'center',
			field : 'grabStatus',
			width : 50,
			formatter : function(value, rec) {
				if (value == GRABSTATUS_1) {
					return '<font color="red">待确认</font>';
				}
				if (value == GRABSTATUS_2) {
					return '<font color="blue">已确认</font>';
				}
				
				if (value == GRABSTATUS_3) {
					return '<font color="green">已收货</font>';
				}
			}
		}, {
			title : '<font style=" font-weight:bold">载重</font>',
			align : 'center',
			field : 'loadNum',
			width : 30
		}, {
			title : '<font style=" font-weight:bold">箱型</font>',
			align : 'center',
			field : 'boxTypeName',
			width : 30
		}, {
			title : '<font style=" font-weight:bold">箱属</font>',
			align : 'center',
			field : 'boxOwnerName',
			width : 30
		}, {
			title : '<font style=" font-weight:bold">车型</font>',
			align : 'center',
			field : 'autoTypeName',
			width : 50
		},{
			title : '<font style=" font-weight:bold">抢单箱数</font>',
			align : 'center',
			field : 'grabBoxNum',
			width : 60
		},{
			title : '<font style=" font-weight:bold">抢单金额</font>',
			align : 'center',
			field : 'grabPrice',
			width : 60
		}, {
			title : '<font style=" font-weight:bold">抢单时间</font>',
			align : 'center',
			field : 'grabTime',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">付款</font>',
			align : 'center',
			field : 'grabMoneyOwner',
			width : 50,
			formatter : function(value, rec) {
				if (value == grabMoneyOwner_0) {
					return '<font color="red">未付款</font>';
				}
				if (value == grabMoneyOwner_1) {
					return '<font color="blue">已付款</font>';
				}
			}
		},] ],
		onHeaderContextMenu : function(e, field) {
			e.preventDefault();
			$("#grid1Menu").menu("show", {
				left : e.pageX,
				top : e.pageY
			});
		}
	});

	$("#grid1").datagrid("getPager").pagination({
		pageSize : 10,
		onSelectPage : function(pageNumber, pageSize) {
			ps = pageNumber;
			queryGrabManifest(ps, manifestId);
		}
	});

	// 详细弹出层
	$("#div_driverinfo").dialog({
		height : 400,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	// 详细弹出层
	$("#get_driverinfo").dialog({
		height : 400,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});
	
	$("#pay_driverinfo").dialog({
		height : 400,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		confirmGrab();
	});
	
	
	$("#btnSubmitNO").click(function() {
		confirmGrabNO();
	});
	

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		$("#grabPrice").val("");
		document.getElementById("formCondition").reset();
		$("#div_driverinfo").dialog("close");
	});

	/* 提交按钮点击事件 */
//	$("#btnGetSubmit").click(function() {
//		confirmGet();
//	});

	/* 关闭按钮点击事件 */
	$("#btnGetClose").click(function() {		
		document.getElementById("formCondition_get").reset();
		$("#get_driverinfo").dialog("close");
	});

	/* 好评 */
	$("#btnGrade1Submit").click(function() {
		btnGrade1Submit();
	});

	/* 中评 */
	$("#btnGrade2Submit").click(function() {
		btnGrade2Submit();
	});

	/* 差评 */
	$("#btnGrade3Submit").click(function() {
		btnGrade3Submit();
	});

	$("#btnPaySubmit").click(function() {
		manifestPay();
	});
	
	/* 关闭按钮点击事件 */
	$("#btnPayClose").click(function() {
		$("#grabPrice").val("");
		document.getElementById("formCondition_pay").reset();
		$("#pay_driverinfo").dialog("close");
	});
})

function query(pageNum, manifestId) {
	queryManifestInfo(manifestId);
	queryGrabManifest(pageNum, manifestId);
}


/* 查询抢单司机列表 */
function queryGrabManifest(pageNum, manifestId) {
	$.ajax({
		type : "post",
		url : path + "/manifest/queryGrabManifest.do",
		dataType : "json",
		cache : false,
		data : {
			"pageNum" : pageNum,
			"manifestId" : manifestId
		},
		success : function(data) {
			/* 数据绑定 */
			if (data.code) {
				$("#grid1").datagrid("loadData", data.pager.data);
				$("#grid1").datagrid("getPager").pagination({
					showPageList : false,
					total : data.pager.rowsTotal,
					pageSize : data.pager.pageSize,
					pageNumber : data.pager.currentPage
				});
			} else {
				$.messager.alert("系统错误", "查询失败", "error");
			}
		},
		error : function(request, errinfo, errobject) {

			$.messager.alert("系统错误", "查询失败" + errobject, "error");
		}
	});
}

function queryManifestInfo(manifestId) {

	$
			.ajax({
				type : "post",
				url : path + "/manifest/queryManifestInfo.do",
				dataType : "json",
				cache : false,
				data : {
					"manifestId" : manifestId
				},
				success : function(data) {
					/* 数据绑定 */
					if (data.code) {
						$("#manifestInfo").empty();
						$("#sendInfo").empty();
						$("#receiveInfo").empty();
						$("#remarkInfo").empty();
						$("#grabInfo").empty();
						var manifestStatus = '';
						var sendDetailedAddress='';
						var receiveDetailedAddress='';
						var status = data.manifest.manifestStatus;
						if (status == MANIFEST_STATUS_1) {
							manifestStatus = '<font color="red">抢单中</font>';
						}
						if (status == MANIFEST_STATUS_3) {
							manifestStatus = '<font color="red">抢单结束</font>';
						}
						if (status == MANIFEST_STATUS_2) {
							manifestStatus = '<font color="red">已完成</font>';
						}
						var boxNum = data.manifest.boxNum;
						var grabBoxSum= data.grabInfo.grabBoxSum;
						var syBoxSum = boxNum - grabBoxSum;
						document.getElementById("formCondition").reset();
						$("#varsyBoxNum").val(syBoxSum);
						
						if(data.manifest.sendDetailedAddress=="" ||data.manifest.sendDetailedAddress==null){
							sendDetailedAddress='';
						}else{
							sendDetailedAddress=data.manifest.sendDetailedAddress
						}
						
						if(data.manifest.receiveDetailedAddress=="" ||data.manifest.receiveDetailedAddress==null){
							receiveDetailedAddress='';
						}else{
							receiveDetailedAddress=data.manifest.receiveDetailedAddress
						}
						
						
						$("#manifestInfo")
								.html(
										'<tr><td style="font-weight:bold;">货单号：</td><td align="left">'
												+ data.manifest.manifestId
												+ '</td><td style="font-weight:bold;">货单状态：</td><td align="left">'
												+ manifestStatus
												+ '</td></tr>'
												+ '<tr><td style="font-weight:bold;">货名：</td><td align="left">'
												+ data.manifest.manifestName
												+ '</td><td style="font-weight:bold;">货重：</td><td>'
												+ data.manifest.weight
												+ '&nbsp;&nbsp;吨/箱'
												+ '</td></tr>'
												+ '<tr><td style="font-weight:bold;">需求箱型：</td><td align="left">'
												+ data.manifest.boxTypeName
												+ '</td><td style="font-weight:bold;">箱属：</td><td align="left">'
												+ data.manifest.boxOwnerName
												+ '</td></tr>'
												+ '<tr><td style="font-weight:bold;">总箱数/剩余箱数：</td><td align="left">'
												+ boxNum+ '&nbsp;&nbsp;箱/<font color="red">'+ syBoxSum 	+ '</font>&nbsp;&nbsp;箱'
												+ '</td><td style="font-weight:bold;">价格：</td><td align="left">'
												+ data.manifest.price
												+ '&nbsp;&nbsp;'+data.manifest.priceUnit
												+ '</td></tr>'
												+ '<tr><td style="font-weight:bold;">收货联系人：</td><td align="left">'
												+ data.manifest.contact
												+ '</td><td style="font-weight:bold;">收货人手机：</td><td align="left">'
												+ data.manifest.contactPhone
												+ '</td></tr>');
						$("#sendInfo")
								.html('<tr><td style="font-weight:bold;" width="20%">发货地址：</td><td align="left" width="40%">'
												+ data.manifest.sendProvince+ data.manifest.sendCity+data.manifest.sendArea+sendDetailedAddress
												+ '</td>'											
												+ '<td style="font-weight:bold;" width="20%">日期：</td><td align="left" width="20%">'
												+ data.manifest.sendDate
												+ '</td></tr>');
						$("#receiveInfo")
								.html('<tr><td style="font-weight:bold;" width="20%">收货地址：</td><td align="left" width="40%">'
												+ data.manifest.receiveProvince+ data.manifest.receiveCity+ data.manifest.receiveArea+receiveDetailedAddress
												+ '</td>'
												+ '<td style="font-weight:bold;" width="20%">日期：</td><td align="left" width="20%">'
												+ data.manifest.receiveDate
												+ '</td></tr>');
						$("#remarkInfo").html(
								'<tr><td style="font-weight:bold;">备注</td></tr>'
										+ '<tr><td align="left">' + data.manifest.remark
										+ '</td></tr>');
						$("#grabInfo")
						.html(
								'<tr><td style="font-weight:bold;">确认抢单数量合计：</td><td align="left">'
										+ data.grabInfo.grabNum
										+ '</td><td style="font-weight:bold;">确认抢单箱数</td><td align="left">'
										+ grabBoxSum+'&nbsp;&nbsp;箱'
										+ '</td><td style="font-weight:bold;">确认抢单金额合计：</td><td align="left">'
										+ data.grabInfo.grabPriceNum
										+ '&nbsp;&nbsp;元'
										+ '</td></tr>');
					} else {
						$.messager.alert("系统错误", "查询失败", "error");
					}
				},
				error : function(request, errinfo, errobject) {

					$.messager.alert("系统错误", "查询失败" + errobject, "error");
				}
			});
}

function driverinfo(driver, div_name, tab_name) {
	var status = '';
	if (driver.driverStatus == STATUS_OPEN) {
		status = '<font color="green">正常</font>';
	}
	if (driver.driverStatus == STATUS_STOP) {
		status = '<font color="red">停用</font>';
	}
	var driverName='';
	if(driver.driverName==null || driver.driverName==''){
		driverName='-';
	}else{
		driverName=driver.driverName;
	}
	
	var phoneNo='';
	if(driver.phoneNo==null || driver.phoneNo==''){
		phoneNo='-';
	}else{
		phoneNo=driver.phoneNo;
	}
	
	var autoNo='';
	if(driver.autoNo==null || driver.autoNo==''){
		autoNo='-';
	}else{
		autoNo=driver.autoNo;
	}
	
	var autoTypeName='';
	if(driver.autoTypeName==null || driver.autoTypeName==''){
		autoTypeName='-';
	}else{
		autoTypeName=driver.autoTypeName;
	}
	
	var loadNum='';
	if(driver.loadNum==null || driver.loadNum==''){
		loadNum='-';
	}else{
		loadNum=driver.loadNum;
	}
			
	var idcardNo='';
	if(driver.idcardNo==null || driver.idcardNo==''){
		idcardNo='-';
	}else{
		idcardNo=driver.idcardNo;
	}
	
	var otherPhoneNo='';
	if(driver.otherPhoneNo==null || driver.otherPhoneNo==''){
		otherPhoneNo='-';
	}else{
		otherPhoneNo=driver.otherPhoneNo;
	}
	
	
	var bankName='';
	if(driver.bankName==null || driver.bankName==''){
		bankName='-';
	}else{
		bankName=driver.bankName;
	}
	
	var bankCount='';
	if(driver.bankCount==null || driver.bankCount==''){
		bankCount='-';
	}else{
		bankCount=driver.bankCount;
	}
	
	var registerdate='';
	if(driver.registerdate==null || driver.registerdate==''){
		registerdate='-';
	}else{
		registerdate=driver.registerdate;
	}
	$(div_name).dialog("setTitle", "司机详细信息");
	$(div_name).dialog("open");
	$(tab_name).empty();
	$(tab_name)
	.html('<tr><td style="font-weight:bold;">姓名：</td><td>'
		+ driverName
		+ '</td><td style="font-weight:bold;">手机号：</td><td align="left">'
		+ phoneNo
		+ '</td></tr>'
		+'<tr><td style="font-weight:bold;">车牌号：</td><td align="left">'
		+ autoNo
		+ '</td><td style="font-weight:bold;">车型：</td><td>'
		+ autoTypeName
		+ '</td></tr>'
		+'<tr><td style="font-weight:bold;">载重：</td><td align="left">'
		+ loadNum
		+ '</td><td style="font-weight:bold;">其他手机：</td><td align="left">'
		+ otherPhoneNo
		+ '</td></tr>'
		+'<tr><td style="font-weight:bold;">身份证号：</td><td align="left">'
		+ idcardNo
		+ '</td><td style="font-weight:bold;">注册日期：</td><td align="left">'
		+ registerdate
		+ '</td></tr>'
		+ '<tr><td style="font-weight:bold;">开户银行：</td><td align="left">'
		+ bankName
		+'</td><td style="font-weight:bold;">银行账号：</td><td align="left">'
		+ bankCount
		+ '</td></tr>'
		+ '<tr><td style="font-weight:bold;">当前状态：</td><td align="left">'
		+ ''+status+'</font>'
		+'</td><td style="font-weight:bold;"></td><td align="left">'
		+ '</td></tr>');
}

function grabManifest() {
	var driver = $("#grid1").datagrid("getSelected");

	if (driver == '' || driver == null) {
		$.messager.alert("提示", "请选择抢单司机信息！", "info");
	} else {
		var driverId = driver.driverId;
		var grabId = driver.grabId;
		var grabNumber = driver.grabNumber;
		var grabStatus = driver.grabStatus;
		var grabBoxNum = driver.grabBoxNum;
		var div_name = '#div_driverinfo';
		var tab_name = '#driverInfo';
		$("#grabId").val(grabId);
		$("#grabNumber").val(grabNumber);
		$("#driverId").val(driverId);
		$("#grabStatus").val(grabStatus);
		$("#grabBoxNum").html(grabBoxNum+'箱');	
		$("#vargrabBoxNum").val(grabBoxNum);
		$("#grabPrice").val("");
		
		

		if (grabStatus == GRABSTATUS_1) {

			driverinfo(driver, div_name, tab_name);
			$.ajax({
				type : "post",
				url : path + "/manifest/queryAppraise.do",
				dataType : "json",
				cache : false,
				data : {
					"driverId" : driverId,
					"appraiseType" : APPRAISETYPE_1
				},
				success : function(data) {
					/* 数据绑定 */
					if (data.code) {
						$("#grade1").empty();
						$("#grade2").empty();
						$("#grade3").empty();

						$("#grade1").html(
								'<h2><font color="#99CC00">好评：'
										+ data.appraise[0].gradecnt
										+ '</font></h2>');
						$("#grade2").html(
								'<h2><font color="#FFCC00">中评：'
										+ data.appraise[1].gradecnt
										+ '</font></h2>');
						$("#grade3").html(
								'<h2><font color="#FB0000">差评：'
										+ data.appraise[2].gradecnt
										+ '</font></h2>');
					}
				},
				error : function(request, errinfo, errobject) {

					$.messager.alert("系统错误", "查询失败" + errobject, "error");
				}
			});

		} else {
			$.messager.alert('提示', '状态：【待确认】状态，才可进行抢单处理!', 'info');
		}
	}
}

function confirmGrab() {
	
	var grabId = $("#grabId").val();
	var grabPrice = $("#grabPrice").val();
	var grabBoxNum = $("#vargrabBoxNum").val();
	var driverId=$("#vargrabBoxNum").val();
	if(grabPrice==null || grabPrice==""){
		grabPrice='0.00';
	}
	var grabBoxNum = $("#vargrabBoxNum").val();
	var syBoxNum = $("#varsyBoxNum").val();
	$.ajax({
		type : "post",
		url : path + '/manifest/confirmGrab.do',
		dataType : "json",
		cache : false,
		data : {
			"grabId" : grabId,
			"grabPrice" : grabPrice,
			"manifestId":manifestId,
			"grabBoxNum":grabBoxNum,
			"syBoxNum":syBoxNum,
			"driverId":driverId
		},
		success : function(r) {
			backinfo(r);
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '操作失败！', 'info');
		}
	});

}

function confirmGrabNO(){

	var grabId = $("#grabId").val();
	$.ajax({
		type : "post",
		url : path + '/manifest/confirmGrabNo.do',
		dataType : "json",
		cache : false,
		data : {
			"grabId" : grabId
		},
		success : function(r) {
			if (r.code == CODE_CAUSE_SUCCESS) {
				$("#grabPrice").val("");
				document.getElementById("formCondition").reset();
				$("#div_driverinfo").dialog("close");
				query(ps, manifestId);
				$.messager.show({
					title : "提示",
					msg : "拒绝抢单成功!",
					timeout : 5000
				});
			}
			if (r.code == CODE_CAUSE_FAILURE) {
				$.messager.alert('提示', '拒绝抢单失败!', 'info');
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '操作失败！', 'error');
		}
	});


}

function getManifest() {
	var driver = $("#grid1").datagrid("getSelected");

	if (driver == '' || driver == null) {
		$.messager.alert("提示", "请选择抢单司机信息！", "info");
	} else {
		var driverId = driver.driverId;
		var grabId = driver.grabId;
		var grabStatus = driver.grabStatus;
		var grabPrice = driver.grabPrice;
		var grabBoxNum = driver.grabBoxNum;
		
		var div_name = '#get_driverinfo';
		var tab_name = '#getDriverInfo';
		$("#get_grabId").val(grabId);
		$("#get_grabStatus").val(grabStatus);
		$("#get_grabBoxNum").html(grabBoxNum+'箱');		
		$("#get_grabPrice").html(grabPrice+'元');

		if (grabStatus == GRABSTATUS_2) {

			driverinfo(driver, div_name, tab_name);
//			$("#get").show();
//			$("#app").hide();
		} else {
			$.messager.alert('提示', '状态：【已确认】，才可进行收货处理!', 'info');
		}
	}
}

//function confirmGet() {
//	var grabId = $("#get_grabId").val();
//	$.ajax({
//		type : "post",
//		url : path + '/manifest/confirmGet.do',
//		dataType : "json",
//		cache : false,
//		data : {
//			"grabId" : grabId,
//			"grabStatus" : GRABSTATUS_3
//		},
//		success : function(r) {
//			if (r.code == CODE_CAUSE_SUCCESS) {
////				$("#get").hide();
////				$("#app").show();
//				$.messager.show({
//					title : "提示",
//					msg : "确认收货成功，请对司机进行评价!",
//					timeout : 3000
//				});
//			}
//			if (r.code == CODE_CAUSE_FAILURE) {
//				$.messager.alert('提示', '确认收货失败!', 'info');
//			}
//		},
//		error : function(request, errinfo, errobject) {
//			$.messager.alert('提示', '操作失败！', 'info');
//		}
//	});
//
//}

function btnGrade1Submit() {
	appSubmit(GRADE_1);
}

function btnGrade2Submit() {
	appSubmit(GRADE_2);
}

function btnGrade3Submit() {
	appSubmit(GRADE_3);
}
function appSubmit(grade) {

	var grabId = $("#get_grabId").val();
	$.ajax({
		type : "post",
		url : path + '/manifest/confirmApp.do',
		dataType : "json",
		cache : false,
		data : {
			"grabId" : grabId,
			"grade" : grade,
			"appraiseType" : APPRAISETYPE_1,
			"grabStatus" : GRABSTATUS_3
		},
		success : function(r) {
			if (r.code == CODE_CAUSE_SUCCESS) {
				document.getElementById("formCondition_get").reset();
				$("#get_driverinfo").dialog("close");
				query(ps, manifestId);
				$.messager.show({
					title : "提示",
					msg : "货主对司机的评价成功!",
					timeout : 5000
				});

			}
			if (r.code == CODE_CAUSE_FAILURE) {
				$.messager.alert('提示', '货主对司机的评价失败!', 'info');
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '操作失败！', 'info');
		}
	});
}

function payManifest(){
	var driver = $("#grid1").datagrid("getSelected");

	if (driver == '' || driver == null) {
		$.messager.alert("提示", "请选择抢单司机信息！", "info");
	} else {
		var grabId = driver.grabId;
		var grabStatus = driver.grabStatus;
		var grabMoneyOwner = driver.grabMoneyOwner;
		var grabPrice = driver.grabPrice;
		var grabBoxNum = driver.grabBoxNum;
		
		var div_name = '#pay_driverinfo';
		var tab_name = '#payDriverInfo';
		$("#pay_grabId").val(grabId);
		$("#pay_grabBoxNum").html(grabBoxNum+'箱');		
		$("#pay_grabPrice").html(grabPrice+'元');

		if (grabStatus != GRABSTATUS_1) {
			if(grabMoneyOwner == grabMoneyOwner_0){
				driverinfo(driver, div_name, tab_name);
			}else{
				$.messager.alert('提示', '已付款，无需再次付款!', 'info');
			}			
		} else {
			$.messager.alert('提示', '状态：非【待确认】，才可进行付款处理!', 'info');
		}
		
	}
}

function manifestPay() {
var grabId = $("#pay_grabId").val();
$.ajax({
	type : "post",
	url : path + '/manifest/manifestPay.do',
	dataType : "json",
	cache : false,
	data : {
		"grabId" : grabId,
		"grabMoneyOwner" : grabMoneyOwner_1
	},
	success : function(r) {
		if (r.code == CODE_CAUSE_SUCCESS) {
			document.getElementById("formCondition_pay").reset();
			$("#pay_driverinfo").dialog("close");
			query(ps, manifestId);
			$.messager.show({
				title : "提示",
				msg : "付款处理成功!",
				timeout : 3000
			});
		}
		if (r.code == CODE_CAUSE_FAILURE) {
			$.messager.alert('提示', '付款处理失败!', 'info');
		}
	},
	error : function(request, errinfo, errobject) {
		$.messager.alert('提示', '操作失败！', 'info');
	}
});

}

function backinfo(r) {
	if (r.code == 1) {
		$("#grabPrice").val("");
		document.getElementById("formCondition").reset();
		$("#div_driverinfo").dialog("close");
		query(ps, manifestId);
		$.messager.show({
			title : "提示",
			msg : "确认抢单成功!",
			timeout : 5000
		});

	}
	if (r.code == 2) {
		$.messager.alert('提示', '确认抢单失败，抢单箱数已经超过货单剩余箱数!', 'info');
	}
	
	if (r.code == 3) {
		$.messager.alert('提示', '超过5天内抢单数量！', 'info');
	}
	
	if (r.code == 0) {
		$.messager.alert('提示', '抢单失败！', 'info');
	}

}