$(function() {
	ps = 1;
	query(ps);
	$("#grid1")
			.datagrid(
					{
						title :  "基础数据-箱属列表",
						fitColumns : true,
						pagination : true,
						singleSelect : true,
						striped : true,
						showFooter : true,
						toolbar : [ 
						            {
										text : '添加',
										iconCls : 'icon-add',
										handler : function() {
											preAddBoxOwner();
										}						
									}, {
										text : '删除',
										iconCls : 'icon-remove',
										handler : function() {
											delBoxOwner();
										}
									}
									],
						loadMsg : "数据载入中...",
						columns : [ [
								{
									title : '<font style=" font-weight:bold">箱属编号</font>',
									align : 'center',
									field : 'boxOwnerId',
									width : 100
								},
								{
									title : '<font style=" font-weight:bold">箱属名称</font>',
									align : 'center',
									field : 'boxOwnerName',
									width : 100
								}] ],
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

	// 新增箱型弹出层
	$("#boxowner").dialog({
		height : 170,
		width : 270,
		modal : true,
		resizable : false,
		closed : true
	});

	
	
	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		addBoxOwner();
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#boxowner").dialog("close");
	});

})

/* 查询箱型列表 */
function query(pageNum) {
	$.ajax({
		type : "post",
		url : path + "/basicdata/queryBoxOwnerList.do",
		dataType : "json",
		cache : false,
		data : {
			"pageNum" : pageNum
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
				$.messager.alert("提示", "查询失败", "info");
			}
		},
		error : function(request, errinfo, errobject) {

			$.messager.alert("系统错误", "查询失败" + errobject, "error");
		}
	});
}

function preAddBoxOwner() {
	$("#boxowner").dialog("setTitle", "添加箱属");
	$("#boxowner").dialog("open");
	document.getElementById("formCondition").reset();
	$("#boxOwnerName").val("");
	
}



function addBoxOwner() {
	var i = $("#formCondition").serialize();	
	$.ajax({
		type : "post",
		url : path + '/basicdata/addBoxOwner.do',
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

function delBoxOwner() {
	var driver = $("#grid1").datagrid("getSelected");
	if (driver == '' || driver == null) {
		$.messager.alert("提示", "请选择箱属信息！", "info");
	} else {
		var driverId = driver.boxOwnerId;

		$.messager.confirm('确认', '确定删除该条择箱信息吗？', function(r) {
			if (r) {
				$.ajax({
					type : "post",
					url : path + "/basicdata/delBoxOwner.do",
					dataType : "json",
					data : {
						"boxOwnerId" : driverId
					},
					cache : false,
					success : function(r) {
						if (r.code) {
							query(ps);
							$.messager.show({
								title : "提示",
								msg : "择箱信息删除成功!",
								timeout : 5000
							});
						}
					},
					error : function(request, errinfo, errobject) {
						$.messager.alert("系统错误", "择箱信息删除失败！" + errobject,
								"error");
					}
				});
			} else {
				query(ps);
			}
		});
	}
}

function backinfo(r) {
	if (r.code == CODE_CAUSE_SUCCESS) {
		document.getElementById("formCondition").reset();
		$("#boxowner").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "箱属保存成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '箱属保存失败!', 'info');
	}
	
}