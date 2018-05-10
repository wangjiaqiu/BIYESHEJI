$(function() {
	ps = 1;
	query(ps);
	$("#grid1")
			.datagrid(
					{
						title :  "基础数据-车型列表",
						fitColumns : true,
						pagination : true,
						singleSelect : true,
						striped : true,
						showFooter : true,
						toolbar : [ {
							text : '添加',
							iconCls : 'icon-add',
							handler : function() {
								preAddAutoType();
							}
						}],
						loadMsg : "数据载入中...",
						columns : [ [
								{
									title : '<font style=" font-weight:bold">车型编号</font>',
									align : 'center',
									field : 'autoTypeId',
									width : 100
								},
								{
									title : '<font style=" font-weight:bold">车型名称</font>',
									align : 'center',
									field : 'autoTypeName',
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

	// 新增车型弹出层
	$("#autotype").dialog({
		height : 170,
		width : 270,
		modal : true,
		resizable : false,
		closed : true
	});

	
	
	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		addAutoType();
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#autotype").dialog("close");
	});

})

/* 查询商品列表 */
function query(pageNum) {
	$.ajax({
		type : "post",
		url : path + "/basicdata/queryAutoTypeList.do",
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

function preAddAutoType() {
	$("#autotype").dialog("setTitle", "添加车型");
	$("#autotype").dialog("open");
	document.getElementById("formCondition").reset();
	$("#autoTypeName").val("");
	
}



function addAutoType() {
	var i = $("#formCondition").serialize();	
	$.ajax({
		type : "post",
		url : path + '/basicdata/addAutoType.do',
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
		$("#autotype").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "车型保存成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '车型保存失败!', 'info');
	}
	
}