$(function() {
	ps = 1;
	query(ps);
	$("#grid1")
			.datagrid(
					{
						title :  "基础数据-箱型列表",
						fitColumns : true,
						pagination : true,
						singleSelect : true,
						striped : true,
						showFooter : true,
						toolbar : [ {
							text : '添加',
							iconCls : 'icon-add',
							handler : function() {
								preAddBoxType();
							}
						}],
						loadMsg : "数据载入中...",
						columns : [ [
								{
									title : '<font style=" font-weight:bold">箱型编号</font>',
									align : 'center',
									field : 'boxTypeId',
									width : 100
								},
								{
									title : '<font style=" font-weight:bold">箱型名称</font>',
									align : 'center',
									field : 'boxTypeName',
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
	$("#boxtype").dialog({
		height : 170,
		width : 270,
		modal : true,
		resizable : false,
		closed : true
	});

	
	
	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		addBoxType();
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#boxtype").dialog("close");
	});

})

/* 查询箱型列表 */
function query(pageNum) {
	$.ajax({
		type : "post",
		url : path + "/basicdata/queryBoxTypeList.do",
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

function preAddBoxType() {
	$("#boxtype").dialog("setTitle", "添加箱型");
	$("#boxtype").dialog("open");
	document.getElementById("formCondition").reset();
	$("#boxTypeName").val("");
	
}



function addBoxType() {
	var i = $("#formCondition").serialize();	
	$.ajax({
		type : "post",
		url : path + '/basicdata/addBoxType.do',
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



function backinfo(r) {
	if (r.code == CODE_CAUSE_SUCCESS) {
		document.getElementById("formCondition").reset();
		$("#boxtype").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "箱型保存成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '箱型保存失败!', 'info');
	}
	
}