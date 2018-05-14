$(function() {
	ps = 1;
	query(ps);
	$("#grid1").datagrid({
		title : "路况列表",
		fitColumns : true,
		pagination : true,
		singleSelect : true,
		striped : true,
		showFooter : true,
		toolbar : [ {
			text : '发布路况',
			iconCls : 'icon-add',
			handler : function() {
				preAddTraffic();
			}
		}, {
			text : '删除',
			iconCls : 'icon-remove',
			handler : function() {
				delTraffic();
			}
		} ],
		loadMsg : "数据载入中...",
		columns : [ [
						{
							title : '<font style=" font-weight:bold">发布人</font>',
							align : 'center',
							field : 'userName',
							width : 50							
						},
						{
							title : '<font style=" font-weight:bold">发布人类型</font>',
							align : 'center',
							field : 'userType',
							width : 40,
							formatter : function(value, rec) {
								if(value==TRAFFIC_USERTYPE_1){
									return '司机';
								}
								if(value==TRAFFIC_USERTYPE_2){
									return '货主' ;	
								}
								if(value==TRAFFIC_USERTYPE_0){
									return '管理员' ;	
								}
								
							}
						},
						{
							title : '<font style=" font-weight:bold">地址</font>',
							align : 'center',
							field : 'address',
							width : 80
						},
						{
							title : '<font style=" font-weight:bold">路况描述</font>',
							align : 'center',
							field : 'note',
							width : 160,
							formatter : function(value, rec) {
								if(value.length>40){
									var valuesub =value.substring(0,40)+"......";
								}else{
									valuesub=value;
								}
								return '<span title="'+value+'">'+valuesub+'</span>' ;
						}
						},
						{
							title : '<font style=" font-weight:bold">发布时间</font>',
							align : 'center',
							field : 'issueTime',
							width : 60
						},
						{
							title : '<font style=" font-weight:bold">操作</font>',
							align : 'center',
							field : 'status',
							width : 100,
							formatter : function(value, rec) {
								if(value==TRAFFIC_STAUTS_1){
									return '<font color="red">审核中</font>&nbsp;|&nbsp;<a href="#" onclick="checkTraffic(&quot;'
									+ rec.trafficId
									+ '&quot;,&quot;'
									+ TRAFFIC_STAUTS_2
									+ '&quot;);">已发布</a>'
								}
								if(value==TRAFFIC_STAUTS_2){
									return '<font color="green">已发布</font>'
								}
								
						}
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

	/* 查询按钮点击事件 */
	$("#btnSearch").click(function() {
		query(1);

	});

	/* 重置按钮点击事件 */
	$("#btnReset").click(function() {
		$("#startTime").datebox("setValue", "");
		$("#endTime").datebox("setValue", "");
		document.getElementById("formCondition_query").reset();
	});

	// 新增车型弹出层
	$("#traffic").dialog({
		height : 280,
		width : 680,
		modal : true,
		resizable : false,
		closed : true
	});

	/* 提交按钮点击事件 */
	$("#btnSubmit").click(function() {
		addTraffic();
	});

	/* 关闭按钮点击事件 */
	$("#btnClose").click(function() {
		document.getElementById("formCondition").reset();
		$("#traffic").dialog("close");
	});

})

/* 查询商品列表 */
function query(pageNum) {

	var startTime = $("#startTime").datebox("getValue");
	var endTime = $("#endTime").datebox("getValue");

	if (startTime == '' || endTime == '') {
		queryTraffic(pageNum, startTime, endTime);
	} else {
		if (timeCompare(startTime, endTime) == 0) {
			$.messager.alert('提示', '前者日期应早于或等于后者日期!', 'info');
		} else {
			queryTraffic(pageNum, startTime, endTime);
		}
	}
}

function queryTraffic(pageNum, startTime, endTime) {
	$.ajax({
		type : "post",
		url : path + "/traffic/queryTraffic.do",
		dataType : "json",
		cache : false,
		data : {
			"pageNum" : pageNum,
			"startTime" : startTime,
			"endTime" : endTime
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

function preAddTraffic() {
	$("#traffic").dialog("setTitle", "发布路况");
	$("#traffic").dialog("open");
	document.getElementById("formCondition").reset();
	$("#province").val("");
	$("#city").val("");
	$("#area").val("");
	$("#note").val("");

}

function addTraffic() {
	
	var province=$("#province").val();
	var city = $("#city").val();
	var area = $("#area").val();
	var note = $("#note").val();
	//var address=province+city+area;
	var address=province+city;
	if(province=='' || province == null){
		$.messager.alert('提示', '请选择路况地址！', 'info');
	}else{
		if(note=='' || note == null){
			$.messager.alert('提示', '请填写路况描述！', 'info');
		}else{
			$.ajax({
				type : "post",
				url : path + '/traffic/addTraffic.do',
				dataType : "json",
				cache : false,
				data : {
					"address" : address,
					"note" : note
				},
				success : function(r) {
					backinfo(r);
				},
				error : function(request, errinfo, errobject) {
					$.messager.alert('提示', '保存失败！', 'info');
				}
			});
		}
	}
	
	
}

function delTraffic() {
	var traffic = $("#grid1").datagrid("getSelected");
	if (traffic == '' || traffic == null) {
		$.messager.alert("提示", "请选择路况信息！", "info");
	} else {
		var trafficId = traffic.trafficId;

		$.messager.confirm('确认', '确定删除该条路况信息吗？', function(r) {
			if (r) {
				$.ajax({
					type : "post",
					url : path + "/traffic/delTraffic.do",
					dataType : "json",
					data : {
						"trafficId" : trafficId
					},
					cache : false,
					success : function(r) {
						if (r.code) {
							query(ps);
							$.messager.show({
								title : "提示",
								msg : "路况信息删除成功!",
								timeout : 5000
							});
						}
					},
					error : function(request, errinfo, errobject) {
						$.messager.alert("系统错误", "路况信息删除失败！" + errobject,
								"error");
					}
				});
			} else {
				query(ps);
			}
		});
	}
}

function checkTraffic(trafficId,status){
	$.ajax({
		type : "post",
		url : path + "/traffic/checkTraffic.do",
		dataType : "json",
		data : {
			"trafficId" : trafficId,
			"status" : status
		},
		cache : false,
		success : function(r) {
			if (r.code) {
				query(ps);
				$.messager.show({
					title : "提示",
					msg : "路况信息审核成功!",
					timeout : 5000
				});
			}
		},
		error : function(request, errinfo, errobject) {
			$.messager.alert("系统错误", "路况信息审核失败！" + errobject,
					"error");
		}
	});
}

function backinfo(r) {
	if (r.code == CODE_CAUSE_SUCCESS) {
		document.getElementById("formCondition").reset();
		$("#traffic").dialog("close");
		query(ps);
		$.messager.show({
			title : "提示",
			msg : "路况发布成功!",
			timeout : 5000
		});

	}
	if (r.code == CODE_CAUSE_FAILURE) {
		$.messager.alert('提示', '路况发布失败!', 'info');
	}

}

// 判断查询条件中两个时间的先后顺序
function timeCompare(begindate, enddate) {
	if (new Date(Date.parse(begindate.replace("-", "/"))) > new Date(Date
			.parse(enddate.replace("-", "/")))) {
		return 0;
	}
}