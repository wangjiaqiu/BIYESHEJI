$(function() {
	ps = 1;
	query(ps);
	$.ajax( {
		type : "post",
		url : path + "/common/queryAutoTypeCombobox.do",
		dataType : "json",
		cache : false,
		success : function(r) {
			if (r.code) {
				$("#autoTypeId").combobox("loadData", r.combo);
			} else {
				$.messager.show( {
					title : 'Error',
					msg : r.message
				});
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.show( {
				title : 'Error',
				msg : errinfo
			});
		}
	});
	
	$.ajax( {
		type : "post",
		url : path + "/common/queryBoxTypeCombobox.do",
		dataType : "json",
		cache : false,
		success : function(r) {
			if (r.code) {
				$("#boxTypeId").combobox("loadData", r.combo);
			} else {
				$.messager.show( {
					title : 'Error',
					msg : r.message
				});
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.show( {
				title : 'Error',
				msg : errinfo
			});
		}
	});
	
	$.ajax( {
		type : "post",
		url : path + "/common/queryBoxOwnerCombobox.do",
		dataType : "json",
		cache : false,
		success : function(r) {
			if (r.code) {
				$("#boxOwnerId").combobox("loadData", r.combo);
			} else {
				$.messager.show( {
					title : 'Error',
					msg : r.message
				});
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.show( {
				title : 'Error',
				msg : errinfo
			});
		}
	});
	
	
	$.ajax( {
		type : "post",
		url : path + "/common/queryDataCombobox.do",
		dataType : "json",
		cache : false,
		data : {
			"dataType" : 'driverStatus'	
		},
		success : function(r) {
			if (r.code) {
				$("#driverStatus").combobox("loadData", r.combo);
			} else {
				$.messager.show( {
					title : 'Error',
					msg : r.message
				});
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.show( {
				title : 'Error',
				msg : errinfo
			});
		}
	});
	
	$("#grid1").datagrid({
		title : "司机列表",
		fitColumns : true,
		pagination : true,
		singleSelect : true,
		striped : true,
		showFooter : true,
		toolbar : [
//		           {
//			text : '添加',
//			iconCls : 'icon-add',
//			handler : function() {
//				preAddDriver();
//			}
//		}, 
		{
			text : '修改',
			iconCls : 'icon-edit',
			handler : function() {
				preModifyDriver();
			}
		}, {
			text : '删除',
			iconCls : 'icon-remove',
			handler : function() {
				delDriver();
			}
		}, {
			text : '详细',
			iconCls : 'icon-win',
			handler : function() {
				driverInfo();
			}
		} ],
		loadMsg : "数据载入中...",
		columns : [ [

		{
			title : '<font style=" font-weight:bold">司机姓名</font>',
			align : 'center',
			field : 'driverName',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">车牌号</font>',
			align : 'center',
			field : 'autoNo',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">车型</font>',
			align : 'center',
			field : 'autoTypeName',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">载重</font>',
			align : 'center',
			field : 'loadNum',
			width : 80
		}, 
//		{
//			title : '<font style=" font-weight:bold">箱型</font>',
//			align : 'center',
//			field : 'boxTypeName',
//			width : 100
//		}, {
//			title : '<font style=" font-weight:bold">箱属</font>',
//			align : 'center',
//			field : 'boxOwnerName',
//			width : 100
//		}, 
		{
			title : '<font style=" font-weight:bold">状态</font>',
			align : 'center',
			field : 'driverStatus',
			width : 80,
			formatter : function(value, rec) {
				if (value == '1') {
					return '<font color="green">正常</font>';
				}
				if (value == '2') {
					return '<font color="red">停用</font>';
				}
			}
		} ] ],
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
			query(ps);
		}
	});

	/* 查询按钮点击事件 */
	$("#btnSearch").click(function() {
		query(1);

	});

	/* 重置按钮点击事件 */
	$("#btnReset").click(function() {
		$("#driverName").val("");
		$("#autoNo").val("");
		document.getElementById("formCondition_query").reset();
	});
	
	/* 更新状态按钮点击事件 */
	$("#btnModStatus").click(function() {
		modifyDriverStatus(driverId_pub,driverStatus_pub);
	});

	
	/* 关闭按钮点击事件 */
	$("#btnClose_info").click(function() {
		$("#div_driverinfo").dialog("close");
	});

	// 司机弹出层
	$("#driver").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});
	
	// 详细弹出层
	$("#div_driverinfo").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		
		var doType = $("#doType").val();
		if (doType== DOTYPE_ADD) {
			addDriver();
		}
		if (doType == DOTYPE_UPDATE) {
			modifyDriver();
		}
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#driver").dialog("close");
	});

})

/* 查询商品列表 */
function query(pageNum) {

	var driverName = $("#query_driverName").val();
	var autoNo = $("#query_autoNo").val();
	queryDriver(pageNum, driverName, autoNo);

}

function queryDriver(pageNum, driverName, autoNo) {
	$.ajax({
		type : "post",
		url : path + "/driver/queryDriver.do",
		dataType : "json",
		cache : false,
		data : {
			"pageNum" : pageNum,
			"driverName" : driverName,
			"autoNo" : autoNo
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

function preAddDriver() {
	$("#driver").dialog("setTitle", "添加司机");
	$("#driver").dialog("open");
	document.getElementById("formCondition").reset();
	$("#doType").val(DOTYPE_ADD);
	$("#driverId").val("");
	$("#driverName").val("");
	$("#idcardNo").val("");
	$("#autoNo").val("");
	$("#autoTypeId").combobox("setValue","");
	$("#loadNum").val("");
//	$("#boxTypeId").combobox("setValue","");
//	$("#boxOwnerId").combobox("setValue","");
	$("#bankName").val("");
	$("#bankCount").val("");
	$("#phoneNo").val("");
	$("#otherPhoneNo").val("");
	$("#driverStatus").combobox("setValue","");

}

function addDriver() {
	var i = $("#formCondition").serialize();
	$.ajax({
		type : "post",
		url : path + '/driver/addDriver.do',
		dataType : "json",
		cache : false,
		data : i,
		success : function(r) {
			backinfo(r);
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '保存失败！', 'info');
		}
	});
}

function preModifyDriver() {
	var driver = $("#grid1").datagrid("getSelected");
	if (driver == '' || driver == null) {
		$.messager.alert("提示", "请选择司机信息！", "info");
	} else {
		$("#driver").dialog("setTitle", "修改司机");
		$("#driver").dialog("open");
		document.getElementById("formCondition").reset();
		$("#doType").val(DOTYPE_UPDATE);
		$("#driverId").val(driver.driverId);
		$("#driverName").val(driver.driverName);
		$("#idcardNo").val(driver.idcardNo);
		$("#autoNo").val(driver.autoNo);
		$("#autoTypeId").combobox("setValue",driver.autoTypeId);
		$("#loadNum").numberbox("setValue",driver.loadNum);
//		$("#boxTypeId").combobox("setValue",driver.boxTypeId);
//		$("#boxOwnerId").combobox("setValue",driver.boxOwnerId);
		$("#bankName").val(driver.bankName);
		$("#bankCount").val(driver.bankCount);
		$("#phoneNo").val(driver.phoneNo);
		$("#otherPhoneNo").val(driver.otherPhoneNo);
		$("#driverStatus").combobox("setValue",driver.driverStatus);
	}
}

function modifyDriver() {
	var i = $("#formCondition").serialize();
	$.ajax({
		type : "post",
		url : path + '/driver/modifyDriver.do',
		dataType : "json",
		cache : false,
		data : i,
		success : function(r) {
			backinfo(r);
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '保存失败！', 'info');
		}
	});
}

function driverInfo(){

	var driver = $("#grid1").datagrid("getSelected");
	if (driver == '' || driver == null) {
		$.messager.alert("提示", "请选择司机信息！", "info");
	} else {
		$("#div_driverinfo").dialog("setTitle", "司机详细信息");
		$("#div_driverinfo").dialog("open");
		$("#driverInfo").empty();
		driverId_pub=driver.driverId;
		driverStatus_pub=driver.driverStatus;
		var status='';
		if(driver.driverStatus==STATUS_OPEN){
			status='<font color="green">正常</font>';
		}
		if(driver.driverStatus==STATUS_STOP){
			status='<font color="red">停用</font>';
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
		
		$("#driverInfo")
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

}

function delDriver() {
	var driver = $("#grid1").datagrid("getSelected");
	if (driver == '' || driver == null) {
		$.messager.alert("提示", "请选择司机信息！", "info");
	} else {
		var driverId = driver.driverId;

		$.messager.confirm('确认', '确定删除该条司机信息吗？', function(r) {
			if (r) {
				$.ajax({
					type : "post",
					url : path + "/driver/delDriver.do",
					dataType : "json",
					data : {
						"driverId" : driverId
					},
					cache : false,
					success : function(r) {
						if (r.code) {
							query(ps);
							$.messager.show({
								title : "提示",
								msg : "司机信息删除成功!",
								timeout : 5000
							});
						}
					},
					error : function(request, errinfo, errobject) {
						$.messager.alert("系统错误", "司机信息删除失败！" + errobject,
								"error");
					}
				});
			} else {
				query(ps);
			}
		});
	}
}

function modifyDriverStatus(driverId,driverStatus){
	$.ajax({
		type : "post",
		url : path + '/driver/modifyDriverStatus.do',
		dataType : "json",
		cache : false,
		data : {
			"driverId" : driverId,
			"driverStatus":driverStatus
		},
		success : function(r) {
			if (r.code == CODE_CAUSE_SUCCESS) {
				$("#div_driverinfo").dialog("close");
				query(ps);
				$.messager.show({
					title : "提示",
					msg : "更新状态成功!",
					timeout : 5000
				});

			}
			if (r.code == CODE_CAUSE_FAILURE) {
				$.messager.alert('提示', '更新状态失败!', 'info');
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '保存失败！', 'info');
		}
	});
}

function backinfo(r) {
	if (r.code == CODE_CAUSE_SUCCESS) {
		document.getElementById("formCondition").reset();
		$("#driver").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "司机信息保存成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '司机信息保存失败!', 'info');
	}

}