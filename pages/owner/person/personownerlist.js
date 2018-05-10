$(function() {
	ps = 1;
	query(ps);

	$("#grid1").datagrid({
		title : "个人货主列表",
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
//				preAddPersonOwner();
//			}
//		}, 
		{
			text : '修改',
			iconCls : 'icon-edit',
			handler : function() {
				preModifyPersonOwner();
			}
		}, {
			text : '删除',
			iconCls : 'icon-remove',
			handler : function() {
				delPersonOwner();
			}
		}, {
			text : '详细',
			iconCls : 'icon-win',
			handler : function() {
				personOwnerInfo();
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
			title : '<font style=" font-weight:bold">货主姓名</font>',
			align : 'center',
			field : 'ownerName',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">身份证号</font>',
			align : 'center',
			field : 'idcardNo',
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
		$("#query_personOwnerName").val("");
		document.getElementById("formCondition_query").reset();
	});

	

	// 司机弹出层
	$("#personowner").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	// 司机弹出层
	$("#MOD_personowner").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	// 详细弹出层
	$("#div_personownerinfo").dialog({
		height : 300,
		width : 550,
		modal : true,
		resizable : false,
		closed : true
	});

	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		addPersonOwner();
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#personowner").dialog("close");
	});

	/* 提交按钮点击事件 */
	$("#btnMODSubmit").click(function() {
		modifyPersonOwner();
	});

	/* 关闭按钮点击事件 */
	$("#btnMODClose").click(function() {
		document.getElementById("MOD_formCondition").reset();
		$("#MOD_personowner").dialog("close");
	});
	
	/* 更新状态按钮点击事件 */
	$("#btnStatus").click(function() {
		modifyPersonOwnerStatus(ownerId_pub, ownerStatus_pub);
	});

	/* 关闭按钮点击事件 */
	$("#btnClose_info").click(function() {
		$("#div_personownerinfo").dialog("close");
	});

})

/* 查询商品列表 */
function query(pageNum) {

	var personOwnerName = $("#query_personOwnerName").val();
	queryPersonOwner(pageNum, personOwnerName);

}

function queryPersonOwner(pageNum, personOwnerName) {
	$.ajax({
		type : "post",
		url : path + "/owner/queryOwner.do",
		dataType : "json",
		cache : false,
		data : {
			"pageNum" : pageNum,
			"userType" : ROLE_TYPE_P,
			"ownerName" : personOwnerName
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

function preAddPersonOwner() {
	$("#personowner").dialog("setTitle", "添加个人货主");
	$("#personowner").dialog("open");
	document.getElementById("formCondition").reset();
	$("#ownerId").val("");
	$("#userName").val("");
	$("#password").val("");
	$("#ownerName").val("");
	$("#idcardNo").val("");
	$("#bankName").val("");
	$("#bankCount").val("");
	$("#phoneNo").val("");
	$("#otherPhoneNo").val("");
}

function addPersonOwner() {
	var i = $("#formCondition").serialize();
	$.ajax({
		type : "post",
		url : path + '/owner/person/addPersonOwner.do',
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

function preModifyPersonOwner() {
	var personOwner = $("#grid1").datagrid("getSelected");
	if (personOwner == '' || personOwner == null) {
		$.messager.alert("提示", "请选择个人货主信息！", "info");
	} else {
		$("#MOD_personowner").dialog("setTitle", "修改个人货主");
		$("#MOD_personowner").dialog("open");
		document.getElementById("MOD_formCondition").reset();

		$("#MOD_ownerId").val(personOwner.ownerId);
		$("#MOD_userName").html(personOwner.userName);
		$("#MOD_ownerName").html(personOwner.ownerName);
		$("#MOD_idcardNo").html(personOwner.idcardNo);
		$("#MOD_bankName").val(personOwner.bankName);
		$("#MOD_bankCount").val(personOwner.bankCount);
		$("#MOD_phoneNo").val(personOwner.phoneNo);
		$("#MOD_otherPhoneNo").val(personOwner.otherPhoneNo);
	}
}

function modifyPersonOwner() {
	var ownerId = $("#MOD_ownerId").val();
	var bankName = $("#MOD_bankName").val();
	var bankCount = $("#MOD_bankCount").val();
	var otherPhoneNo = $("#MOD_otherPhoneNo").val();
	var phoneNo=$("#MOD_phoneNo").val();
	$.ajax({
		type : "post",
		url : path + '/owner/person/modifyPersonOwner.do',
		dataType : "json",
		cache : false,
		data : {
			"ownerId" : ownerId,
			"bankName" : bankName,
			"bankCount" : bankCount,
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

function personOwnerInfo() {

	var personOwner = $("#grid1").datagrid("getSelected");
	if (personOwner == '' || personOwner == null) {
		$.messager.alert("提示", "请选择个人货主信息！", "info");
	} else {
		$("#div_personownerinfo").dialog("setTitle", "个人货主详细信息");
		$("#div_personownerinfo").dialog("open");
		$("#personownerinfo").empty();
		ownerId_pub = personOwner.ownerId;
		ownerStatus_pub = personOwner.ownerStatus;
		var status = '';
		if (ownerStatus_pub == STATUS_OPEN) {
			status = '<font color="green">正常</font>';
		}
		if (ownerStatus_pub == STATUS_STOP) {
			status = '<font color="red">停用</font>';
		}
		var ownername='';
		if(personOwner.ownerName==null || personOwner.ownerName==''){
			ownername='-';
		}else{
			ownername=personOwner.ownerName;
		}		
		var idcardNo='';
		if(personOwner.idcardNo==null || personOwner.idcardNo==''){
			idcardNo='-';
		}else{
			idcardNo=personOwner.idcardNo;
		}
		var phoneNo='';
		if(personOwner.phoneNo==null || personOwner.phoneNo==''){
			phoneNo='-';
		}else{
			phoneNo=personOwner.phoneNo;
		}
		var otherPhoneNo='';
		if(personOwner.otherPhoneNo==null || personOwner.otherPhoneNo==''){
			otherPhoneNo='-';
		}else{
			otherPhoneNo=personOwner.otherPhoneNo;
		}
		var bankName='';
		if(personOwner.bankName==null || personOwner.bankName==''){
			bankName='-';
		}else{
			bankName=personOwner.bankName;
		}
		var bankCount='';
		if(personOwner.bankCount==null || personOwner.bankCount==''){
			bankCount='-';
		}else{
			bankCount=personOwner.bankCount;
		}
		var registerdate='';
		if(personOwner.registerdate==null || personOwner.registerdate==''){
			registerdate='-';
		}else{
			registerdate=personOwner.registerdate;
		}
		
		
		$("#personownerInfo")
				.html(
						'<tr><td style="font-weight:bold;">姓名：</td><td>'
								+ ownername
								+ '</td><td style="font-weight:bold;">身份证号：</td><td align="left">'
								+ idcardNo
								+ '</td></tr>'
								+ '<tr><td style="font-weight:bold;">手机号：</td><td align="left">'
								+ phoneNo
								+ '</td><td style="font-weight:bold;">其他手机：</td><td>'
								+ otherPhoneNo
								+ '</td></tr>'
								+ '<tr><td style="font-weight:bold;">开户银行：</td><td align="left">'
								+ bankName
								+ '</td><td style="font-weight:bold;">银行账号：</td><td align="left">'
								+ bankCount
								+ '</td></tr>'
								+ '<tr><td style="font-weight:bold;">注册日期：</td><td align="left">'
								+ registerdate
								+ '</td><td style="font-weight:bold;">当前状态：</td><td align="left">'
								+ '' + status + '</font>' + '</td></tr>');
	}

}

function delPersonOwner() {
	var personOwner = $("#grid1").datagrid("getSelected");
	if (personOwner == '' || personOwner == null) {
		$.messager.alert("提示", "请选择个人货主信息！", "info");
	} else {
		var ownerId = personOwner.ownerId;

		$.messager.confirm('确认', '确定删除该条个人货主信息吗？', function(r) {
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
								msg : "个人货主信息删除成功!",
								timeout : 5000
							});
						}
					},
					error : function(request, errinfo, errobject) {
						$.messager.alert("系统错误", "个人货主信息删除失败！" + errobject,
								"error");
					}
				});
			} else {
				query(ps);
			}
		});
	}
}

function modifyPersonOwnerStatus(ownerId, ownerStatus) {
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
				$("#div_personownerinfo").dialog("close");
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
		$("#personowner").dialog("close");
		document.getElementById("MOD_formCondition").reset();
		$("#MOD_personowner").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "个人货主信息保存成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '个人货主信息保存失败!', 'info');
	}

}