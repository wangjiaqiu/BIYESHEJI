$(function() {
	ps = 1;
	query(ps);

	$("#grid1").datagrid({
		title : "单位货主列表",
		fitColumns : true,
		pagination : true,
		singleSelect : true,
		striped : true,
		showFooter : true,
		toolbar : [ 
//		            {
//			text : '添加',
//			iconCls : 'icon-add',
//			handler : function() {
//				preAddUnitOwner();
//			}
//		}, 
		{
			text : '修改',
			iconCls : 'icon-edit',
			handler : function() {
				preModifyUnitOwner();
			}
		}, {
			text : '删除',
			iconCls : 'icon-remove',
			handler : function() {
				delUnitOwner();
			}
		}, {
			text : '详细',
			iconCls : 'icon-win',
			handler : function() {
				unitOwnerInfo();
			}
		} ],
		loadMsg : "数据载入中...",
		columns : [ [
		{
			title : '<font style=" font-weight:bold">登录名</font>',
			align : 'center',
			field : 'userName',
			width : 80
		},
		{
			title : '<font style=" font-weight:bold">单位名称</font>',
			align : 'center',
			field : 'ownerName',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">营业执照号</font>',
			align : 'center',
			field : 'organizationNum',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">手机号</font>',
			align : 'center',
			field : 'phoneNo',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">注册时间</font>',
			align : 'center',
			field : 'registerDate',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">状态</font>',
			align : 'center',
			field : 'ownerStatus',
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
		$("#query_unitOwnerName").val("");
		document.getElementById("formCondition_query").reset();
	});

	// 弹出层
	$("#unitowner").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	// 弹出层
	$("#MOD_unitowner").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	// 详细弹出层
	$("#div_unitownerinfo").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		addUnitOwner();
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#unitowner").dialog("close");
	});

	/* 提交按钮点击事件 */
	$("#btnMODSubmit").click(function() {
		modifyUnitOwner();
	});

	/* 关闭按钮点击事件 */
	$("#btnMODClose").click(function() {
		document.getElementById("MOD_formCondition").reset();
		$("#MOD_unitowner").dialog("close");
	});
	
	/* 更新状态按钮点击事件 */
	$("#btnStatus").click(function() {
		modifyUnitOwnerStatus(ownerId_pub, ownerStatus_pub);
	});

	/* 关闭按钮点击事件 */
	$("#btnClose_info").click(function() {
		$("#div_unitownerinfo").dialog("close");
	});

})

/* 查询商品列表 */
function query(pageNum) {

	var unitOwnerName = $("#query_unitOwnerName").val();
	queryUnitOwner(pageNum, unitOwnerName);

}

function queryUnitOwner(pageNum, unitOwnerName) {
	$.ajax({
		type : "post",
		url : path + "/owner/queryOwner.do",
		dataType : "json",
		cache : false,
		data : {
			"pageNum" : pageNum,
			"userType" : ROLE_TYPE_U,
			"ownerName" : unitOwnerName
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

function preAddUnitOwner() {
	$("#unitowner").dialog("setTitle", "添加单位货主");
	$("#unitowner").dialog("open");
	document.getElementById("formCondition").reset();
	$("#ownerId").val("");
	$("#userName").val("");
	$("#password").val("");
	$("#ownerName").val("");
	$("#idcardNo").val("");
	$("#bankName").val("");
	$("#bankCount").val("");
	$("#phoneNo").val("");
	$("#unitContact").val("");
	$("#otherPhoneNo").val("");
}

function addUnitOwner() {
	var i = $("#formCondition").serialize();
	$.ajax({
		type : "post",
		url : path + '/owner/unit/addUnitOwner.do',
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

function preModifyUnitOwner() {
	var unitOwner = $("#grid1").datagrid("getSelected");
	if (unitOwner == '' || unitOwner == null) {
		$.messager.alert("提示", "请选择单位货主信息！", "info");
	} else {
		$("#MOD_unitowner").dialog("setTitle", "修改单位货主");
		$("#MOD_unitowner").dialog("open");
		document.getElementById("MOD_formCondition").reset();

		$("#MOD_ownerId").val(unitOwner.ownerId);
		$("#MOD_userName").html(unitOwner.userName);
		$("#MOD_ownerName").html(unitOwner.ownerName);
		$("#MOD_organizationNum").html(unitOwner.organizationNum);
		$("#MOD_bankName").val(unitOwner.bankName);
		$("#MOD_bankCount").val(unitOwner.bankCount);
		$("#MOD_phoneNo").val(unitOwner.phoneNo);
		$("#MOD_unitContact").val(unitOwner.unitContact);
		$("#MOD_otherPhoneNo").val(unitOwner.otherPhoneNo);
	}
}

function modifyUnitOwner() {
	var ownerId = $("#MOD_ownerId").val();
	var bankName = $("#MOD_bankName").val();
	var bankCount = $("#MOD_bankCount").val();
	var unitContact = $("#MOD_unitContact").val();
	var otherPhoneNo = $("#MOD_otherPhoneNo").val();
	var phoneNo=$("#MOD_phoneNo").val();
	$.ajax({
		type : "post",
		url : path + '/owner/unit/modifyUnitOwner.do',
		dataType : "json",
		cache : false,
		data : {
			"ownerId" : ownerId,
			"bankName" : bankName,
			"bankCount" : bankCount,
			"unitContact" : unitContact,
			"otherPhoneNo" : otherPhoneNo,
			"phoneNo":phoneNo
		},
		success : function(r) {
			backinfo(r);
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '保存失败！', 'info');
		}
	});
}

function unitOwnerInfo() {

	var unitOwner = $("#grid1").datagrid("getSelected");
	if (unitOwner == '' || unitOwner == null) {
		$.messager.alert("提示", "请选择单位货主信息！", "info");
	} else {
		$("#div_unitownerinfo").dialog("setTitle", "单位货主详细信息");
		$("#div_unitownerinfo").dialog("open");
		$("#unitownerinfo").empty();
		ownerId_pub = unitOwner.ownerId;
		ownerStatus_pub = unitOwner.ownerStatus;
		var status = '';
		var unitContact='';
		var otherPhoneNo='';
		var bankName='';
		var bankCount='';
		
		if (ownerStatus_pub == STATUS_OPEN) {
			status = '<font color="green">正常</font>';
		}
		if (ownerStatus_pub == STATUS_STOP) {
			status = '<font color="red">停用</font>';
		}
		if(unitOwner.unitContact==null || unitOwner.unitContact==""){
			unitContact='——';
		}else{
			unitContact=unitOwner.unitContact;
		}
		if(unitOwner.otherPhoneNo==null || unitOwner.otherPhoneNo==""){
			otherPhoneNo='——';
		}else{
			otherPhoneNo=unitOwner.otherPhoneNo;
		}
		if(unitOwner.bankName==null || unitOwner.bankName==""){
			bankName='——';
		}else{
			bankName=unitOwner.bankName;
		}
		if(unitOwner.bankCount==null || unitOwner.bankCount==""){
			unitContact='——';
		}else{
			bankCount=unitOwner.bankCount;
		}
		$("#unitownerInfo")
				.html(
						'<tr><td style="font-weight:bold;">单位名称：</td><td>'
								+ unitOwner.ownerName
								+ '</td><td style="font-weight:bold;">营业执照号：</td><td align="left">'
								+ unitOwner.organizationNum
								+ '</td></tr>'
								+ '<tr><td style="font-weight:bold;">联系人：</td><td align="left">'
								+ unitContact
								+ '</td><td style="font-weight:bold;">手机号：</td><td>'
								+ unitOwner.phoneNo
								+ '</td></tr>'
								+ '<tr><td style="font-weight:bold;">其他手机：</td><td align="left">'
								+ otherPhoneNo
								+ '</td><td></td><td>'
								+ '</td></tr>'
								+ '<tr><td style="font-weight:bold;">开户银行：</td><td align="left">'
								+ bankName
								+ '</td><td style="font-weight:bold;">银行账号：</td><td align="left">'
								+ bankCount
								+ '</td></tr>'
								+ '<tr><td style="font-weight:bold;">注册日期：</td><td align="left">'
								+ unitOwner.registerDate
								+ '</td><td style="font-weight:bold;">当前状态：</td><td align="left">'
								+ '' + status + '</font>' + '</td></tr>');
	}

}

function delUnitOwner() {
	var unitOwner = $("#grid1").datagrid("getSelected");
	if (unitOwner == '' || unitOwner == null) {
		$.messager.alert("提示", "请选择单位货主信息！", "info");
	} else {
		var ownerId = unitOwner.ownerId;

		$.messager.confirm('确认', '确定删除该条单位货主信息吗？', function(r) {
			if (r) {
				$.ajax({
					type : "post",
					url : path + "/owner/delOwner.do",
					dataType : "json",
					data : {
						"ownerId" : ownerId
					},
					cache : false,
					success : function(r) {
						if (r.code) {
							query(ps);
							$.messager.show({
								title : "提示",
								msg : "单位货主信息删除成功!",
								timeout : 5000
							});
						}
					},
					error : function(request, errinfo, errobject) {
						$.messager.alert("系统错误", "单位货主信息删除失败！" + errobject,
								"error");
					}
				});
			} else {
				query(ps);
			}
		});
	}
}

function modifyUnitOwnerStatus(ownerId, ownerStatus) {
	$.ajax({
		type : "post",
		url : path + '/owner/modifyOwnerStatus.do',
		dataType : "json",
		cache : false,
		data : {
			"ownerId" : ownerId,
			"ownerStatus" : ownerStatus
		},
		success : function(r) {
			if (r.code == CODE_CAUSE_SUCCESS) {
				$("#div_unitownerinfo").dialog("close");
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
		document.getElementById("MOD_formCondition").reset();
		$("#unitowner").dialog("close");
		$("#MOD_unitowner").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "单位货主信息保存成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '单位货主信息保存失败!', 'info');
	}

}