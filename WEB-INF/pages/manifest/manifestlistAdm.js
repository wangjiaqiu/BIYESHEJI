$(function() {
	ps = 1;
	query(ps);

	$.ajax({
		type : "post",
		url : path + "/common/queryBoxTypeCombobox.do",
		dataType : "json",
		cache : false,
		success : function(r) {
			if (r.code) {
				$("#boxTypeId").combobox("loadData", r.combo);
				$("#MOD_boxTypeId").combobox("loadData", r.combo);

			} else {
				$.messager.show({
					title : 'Error',
					msg : r.message
				});
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.show({
				title : 'Error',
				msg : errinfo
			});
		}
	});

	$.ajax({
		type : "post",
		url : path + "/common/queryBoxOwnerCombobox.do",
		dataType : "json",
		cache : false,
		success : function(r) {
			if (r.code) {
				$("#boxOwnerId").combobox("loadData", r.combo);
				$("#MOD_boxOwnerId").combobox("loadData", r.combo);
			} else {
				$.messager.show({
					title : 'Error',
					msg : r.message
				});
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.show({
				title : 'Error',
				msg : errinfo
			});
		}
	});

	$("#grid1")
			.datagrid(
					{
						title : "货单列表",
						fitColumns : true,
						pagination : true,
						singleSelect : true,
						striped : true,
						showFooter : true,
						toolbar : [ 
//						            {
//							text : '发布货单',
//							iconCls : 'icon-add',
//							handler : function() {
//								preAddManifest();
//							}
//						}, 
//						{
//							text : '修改货单',
//							iconCls : 'icon-edit',
//							handler : function() {
//								preModifyManifest();
//							}
//						}, 
						{
							text : '删除货单',
							iconCls : 'icon-remove',
							handler : function() {
								delManifest();
							}
						}, 
						{
							text : '货单详细',
							iconCls : 'icon-win',
							handler : function() {
								manifestInfo();
							}
						} ],
						loadMsg : "数据载入中...",
						columns : [ [

								{
									title : '<font style=" font-weight:bold">货单号</font>',
									align : 'center',
									field : 'manifestId',
									width : 50
								},
								{
									title : '<font style=" font-weight:bold">货名</font>',
									align : 'center',
									field : 'manifestName',
									width : 80
								},
								{
									title : '<font style=" font-weight:bold">货主</font>',
									align : 'center',
									field : 'ownerName',
									width : 80
								},
								{
									title : '<font style=" font-weight:bold">货重</font>',
									align : 'center',
									field : 'weight',
									width : 60
								},
								{
									title : '<font style=" font-weight:bold">箱型</font>',
									align : 'center',
									field : 'boxTypeName',
									width : 60
								},
								{
									title : '<font style=" font-weight:bold">箱属</font>',
									align : 'center',
									field : 'boxOwnerName',
									width : 60
								},
								{
									title : '<font style=" font-weight:bold">起始地</font>',
									align : 'center',
									field : 'sendAddress',
									width : 80,
									formatter : function(value, rec) {
										if(rec.sendDetailedAddress=='' || rec.sendDetailedAddress==null){
											return value;
										}else{
											return value+rec.sendDetailedAddress;
										}
										
									}
								},
								{
									title : '<font style=" font-weight:bold">送达地</font>',
									align : 'center',
									field : 'receiveAddress',
									width : 80,
									formatter : function(value, rec) {
										if(rec.receiveDetailedAddress=='' || rec.receiveDetailedAddress==null){
											return value;
										}else{
											return value+rec.receiveDetailedAddress;
										}
									}
								},
								{
									title : '<font style=" font-weight:bold">发布时间</font>',
									align : 'center',
									field : 'sendDate',
									width : 80
								},
								{
									title : '<font style=" font-weight:bold">状态</font>',
									align : 'center',
									field : 'manifestStatus',
									width : 80,
									formatter : function(value, rec) {
										if (value == MANIFEST_STATUS_1) {
											return '<font color="red">抢单中</font>';
										}
										if (value == MANIFEST_STATUS_2) {
											return '<font color="green">已完成</font>';
										}
										if (value == MANIFEST_STATUS_3) {
											return '<font color="green">抢单结束</font>';
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
		$("#query_manifestId").val("");
		$("#query_manifestName").val("");
		document.getElementById("formCondition_query").reset();
	});

	/* 更新状态按钮点击事件 */
	$("#btnModStatus").click(function() {
		modifyManifestStatus(ownerId_pub, ownerStatus_pub);
	});

	/* 关闭按钮点击事件 */
	$("#btnClose_info").click(function() {
		$("#div_manifestinfo").dialog("close");
	});

	// 司机弹出层
	$("#manifest").dialog({
		height : 440,
		width : 730,
		modal : true,
		resizable : false,
		closed : true
	});

	// 司机弹出层
	$("#MOD_manifest").dialog({
		height : 440,
		width : 730,
		modal : true,
		resizable : false,
		closed : true
	});

	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		addManifest();
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#manifest").dialog("close");
	});

	/* 提交按钮点击事件 */
	$("#btnMODSubmit").click(function() {
		modifyManifest();
	});

	/* 关闭按钮点击事件 */
	$("#btnMODClose").click(function() {
		document.getElementById("MOD_formCondition").reset();
		$("#MOD_manifest").dialog("close");
	});

})

/* 查询商品列表 */
function query(pageNum) {

	var manifestId = $("#query_manifestId").val();
	var manifestName = $("#query_manifestName").val();
	queryManifest(pageNum, manifestId, manifestName);

}

function queryManifest(pageNum, manifestId, manifestName) {
	$.ajax({
		type : "post",
		url : path + "/manifest/queryManifest.do",
		dataType : "json",
		cache : false,
		data : {
			"pageNum" : pageNum,
			"manifestId" : manifestId,
			"manifestName" : manifestName
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

function preAddManifest() {
	
	$.ajax({
		type : "post",
		url : path + "/manifest/judgeApp.do",
		dataType : "json",
		cache : false,
		data : {
			"appraiseType" : APPRAISETYPE_1
		},
		success : function(data) {
			/* 数据绑定 */
			if (data.code) {
				$("#manifest").dialog("setTitle", "发布货单");
				$("#manifest").dialog("open");
				document.getElementById("formCondition").reset();
				$("#manifestId").val("");
				$("#manifestName").val("");
				$("#weight").val("");
				$("#boxOwnerId").combobox("setValue", "");
				$("#boxTypeId").combobox("setValue", "");
				$("#boxNum").val("");
				$("#price").val("");
				$("#contact").val("");
				$("#contactPhone").val("");
				$("#sendProvince").val("");
				$("#sendCity").val("");
				$("#sendArea").val("");
				$("#sendDate").datebox("setValue", "");
				$("#receiveProvince").val("");
				$("#receiveCity").val("");
				$("#receiveArea").val("");
				$("#receiveDate").datebox("setValue", "");
				$("#remark").val("");
			} else {
				$.messager.alert("提示", "您还有未评价的司机，请完成评价后才可发布货单！", "info");
			}
		},
		error : function(request, errinfo, errobject) {

			$.messager.alert("系统错误", "查询失败" + errobject, "error");
		}
	});
	
	
}

function addManifest() {
	var i = $("#formCondition").serialize();
	var sendProvince = "&sendProvince=" + $("#sendProvince").val();
	var sendCity = "&sendCity=" + $("#sendCity").val();
	var sendArea = "&sendArea=" + $("#sendArea").val();
	var receiveProvince = "&receiveProvince=" + $("#receiveProvince").val();
	var receiveCity = "&receiveCity=" + $("#receiveCity").val();
	var receiveArea = "&receiveArea=" + $("#receiveArea").val();

	i = i + sendProvince + sendCity + sendArea + receiveProvince + receiveCity
			+ receiveArea;

	$.ajax({
		type : "post",
		url : path + '/manifest/addManifest.do',
		dataType : "json",
		processData : true,
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

function preModifyManifest() {
	var manifest = $("#grid1").datagrid("getSelected");
	if (manifest == '' || manifest == null) {
		$.messager.alert("提示", "请选择要修改的货单！", "info");
	} else {
		manifestStatus = manifest.manifestStatus;
		if (manifestStatus == MANIFEST_STATUS_4) {
			$("#MOD_manifest").dialog("setTitle", "修改货单");
			$("#MOD_manifest").dialog("open");
			document.getElementById("MOD_formCondition").reset();
			$("#MOD_manifestId").val(manifest.manifestId);
			$("#MOD_manifestName").val(manifest.manifestName);
			$("#MOD_weight").numberbox("setValue",manifest.weight);
			$("#MOD_boxOwnerId").combobox("setValue", manifest.boxOwnerId);
			$("#MOD_boxTypeId").combobox("setValue", manifest.boxTypeId);
			$("#MOD_boxNum").numberbox("setValue",manifest.boxNum);
			$("#MOD_price").numberbox("setValue",manifest.price);
			$("#MOD_contact").val(manifest.contact);
			$("#MOD_contactPhone").val(manifest.contactPhone);
			// $("#MOD_sendProvince").val(manifest.sendProvince);
			// $("#MOD_sendCity").val(manifest.sendCity);
			// $("#MOD_sendArea").val(manifest.sendArea);
			$("#MOD_sendDate").datebox("setValue", manifest.sendDate);
			// $("#MOD_receiveProvince").val(manifest.receiveProvince);
			// $("#MOD_receiveCity").val(manifest.receiveCity);
			// $("#MOD_receiveArea").val(manifest.receiveArea);
			$("#MOD_receiveDate").datebox("setValue", manifest.receiveDate);
			$("#MOD_remark").val(manifest.remark);
			addressInit('MOD_sendProvince', 'MOD_sendCity', 'MOD_sendArea',
					manifest.sendProvince, manifest.sendProvince,
					manifest.sendArea);
			addressInit('MOD_receiveProvince', 'MOD_receiveCity',
					'MOD_receiveArea', manifest.receiveProvince,
					manifest.receiveCity, manifest.receiveArea);

		} else {
			$.messager.alert("提示", "订单状态为【待发布】才允许修改！", "info");
		}
	}
}

function modifyManifest() {
	var i = $("#MOD_formCondition").serialize();
	var sendProvince = "&MOD_sendProvince=" + $("#MOD_sendProvince").val();
	var sendCity = "&MOD_sendCity=" + $("#MOD_sendCity").val();
	var sendArea = "&MOD_sendArea=" + $("#MOD_sendArea").val();
	var receiveProvince = "&MOD_receiveProvince="
			+ $("#MOD_receiveProvince").val();
	var receiveCity = "&MOD_receiveCity=" + $("#MOD_receiveCity").val();
	var receiveArea = "&MOD_receiveArea=" + $("#MOD_receiveArea").val();

	i = i + sendProvince + sendCity + sendArea + receiveProvince + receiveCity
			+ receiveArea;
	var tempStr = "";
	var str="";
	var arr = i.split("&");
	for ( var a = 0; a < arr.length; a++) {
		tempStr = arr[a].replace("MOD_", "");
		if (a == arr.length-1) {
			str += tempStr;
		} else {
			str += tempStr + "&";
		}
	}
	$.ajax({
		type : "post",
		url : path + '/manifest/modifyManifest.do',
		dataType : "json",
		cache : false,
		data : str,
		success : function(r) {
			backinfo(r);
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert('提示', '保存失败！', 'info');
		}
	});
}

function manifestInfo() {

	var manifest = $("#grid1").datagrid("getSelected");
	if (manifest == '' || manifest == null) {
		$.messager.alert("提示", "请选择一条货单记录！", "info");
	} else {
		manifestId= manifest.manifestId;
				window.parent.openSub("货单详情", path
				+ "/manifest/manifestInfo.do?manifestId=" + manifestId);
	}

}

function delManifest() {
	var manifest = $("#grid1").datagrid("getSelected");
	if (manifest == '' || manifest == null) {
		$.messager.alert("提示", "请选择要删除的货单！", "info");
	} else {
		manifestStatus = manifest.manifestStatus;
		var manifestId = manifest.manifestId;

		$.messager.confirm('确认', '确定删除该条货单信息吗？', function(r) {
			if (r) {
				$.ajax({
					type : "post",
					url : path + "/manifest/delManifest.do",
					dataType : "json",
					data : {
						"manifestId" : manifestId
					},
					cache : false,
					success : function(r) {
						if (r.code) {
							query(ps);
							$.messager.show({
								title : "提示",
								msg : "货单信息删除成功!",
								timeout : 5000
							});
						}
					},
					error : function(request, errinfo, errobject) {
						$.messager.alert("系统错误", "货单信息删除失败！" + errobject,
								"error");
					}
				});
			} else {
				query(ps);
			}
		});
	
	}
}

function modifyManifestStatus(manifestId, manifestStatus) {
	$.messager.confirm('确认', '确定更新该条货单状态吗？', function(r) {
		if (r) {
			$.ajax({
				type : "post",
				url : path + '/manifest/modifyManifestStatus.do',
				dataType : "json",
				cache : false,
				data : {
					"manifestId" : manifestId,
					"manifestStatus" : manifestStatus
				},
				success : function(r) {
					if (r.code == CODE_CAUSE_SUCCESS) {
						$("#div_unitownerinfo").dialog("close");
						query(ps);
						$.messager.show({
							title : "提示",
							msg : "货单状态更新成功!",
							timeout : 5000
						});

					}
					if (r.code == CODE_CAUSE_FAILURE) {
						$.messager.alert('提示', '货单状态更新失败!', 'info');
					}
				},
				error : function(request, errinfo, errobject) {
					$.messager.alert('提示', '更新失败！', 'info');
				}
			});
		} else {
			query(ps);
		}
	});

}

function backinfo(r) {
	if (r.code == CODE_CAUSE_SUCCESS) {
		document.getElementById("formCondition").reset();
		document.getElementById("MOD_formCondition").reset();
		$("#manifest").dialog("close");
		$("#MOD_manifest").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "货单信息保存成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '货单信息保存失败!', 'info');
	}

}