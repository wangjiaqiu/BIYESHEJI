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
		}, {
			title : '<font style=" font-weight:bold">司机姓名</font>',
			align : 'center',
			field : 'driverName',
			width : 40
		}, {
			title : '<font style=" font-weight:bold">银行名称</font>',
			align : 'center',
			field : 'bankName',
			width : 70
		}, {
			title : '<font style=" font-weight:bold">银行账号</font>',
			align : 'center',
			field : 'bankCount',
			width : 70
		}, {
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
			width : 50
		}, {
			title : '<font style=" font-weight:bold">箱型</font>',
			align : 'center',
			field : 'boxTypeName',
			width : 50
		}, {
			title : '<font style=" font-weight:bold">箱属</font>',
			align : 'center',
			field : 'boxOwnerName',
			width : 50
		}, {
			title : '<font style=" font-weight:bold">车型</font>',
			align : 'center',
			field : 'autoTypeName',
			width : 50
		}, {
			title : '<font style=" font-weight:bold">抢单箱数</font>',
			align : 'center',
			field : 'grabBoxNum',
			width : 50
		}, {
			title : '<font style=" font-weight:bold">抢单金额</font>',
			align : 'center',
			field : 'grabPrice',
			width : 80
		}, {
			title : '<font style=" font-weight:bold">抢单时间</font>',
			align : 'center',
			field : 'grabTime',
			width : 80
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
			queryGrabManifest(ps, manifestId);
		}
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
						if (status == MANIFEST_STATUS_2) {
							manifestStatus = '<font color="red">已完成</font>';
						}
						if (status == MANIFEST_STATUS_2) {
							manifestStatus = '<font color="red">抢单结束</font>';
						}
						var boxNum = data.manifest.boxNum;
						var grabBoxSum = data.grabInfo.grabBoxSum;
						var syBoxSum = boxNum - grabBoxSum;
						
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
												+ boxNum
												+ '&nbsp;&nbsp;箱/<font color="red">'
												+ syBoxSum
												+ '</font>&nbsp;&nbsp;箱'
												+ '</td><td style="font-weight:bold;">价格：</td><td align="left">'
												+ data.manifest.price
												+ '&nbsp;&nbsp;'+ data.manifest.priceUnit
												+ '</td></tr>'
												+ '<tr><td style="font-weight:bold;">收货联系人：</td><td align="left">'
												+ data.manifest.contact
												+ '</td><td style="font-weight:bold;">收货人手机：</td><td align="left">'
												+ data.manifest.contactPhone
												+ '</td></tr>');
						$("#sendInfo")
								.html(
										'<tr><td style="font-weight:bold;" width="20%">发货地址：</td><td align="left" width="40%">'
												+ data.manifest.sendProvince
												+ data.manifest.sendCity
												+ data.manifest.sendArea
												+ sendDetailedAddress
												+ '</td>'
												+ '<td style="font-weight:bold;" width="20%">日期：</td><td align="left" width="20%">'
												+ data.manifest.sendDate
												+ '</td></tr>');
						$("#receiveInfo")
								.html(
										'<tr><td style="font-weight:bold;" width="20%">收货地址：</td><td align="left" width="40%">'
												+ data.manifest.receiveProvince
												+ data.manifest.receiveCity
												+ data.manifest.receiveArea
												+ receiveDetailedAddress
												+ '</td>'
												+ '<td style="font-weight:bold;" width="20%">日期：</td><td align="left" width="20%">'
												+ data.manifest.receiveDate
												+ '</td></tr>');
						$("#remarkInfo").html(
								'<tr><td style="font-weight:bold;">备注</td></tr>'
										+ '<tr><td align="left">'
										+ data.manifest.remark + '</td></tr>');
						$("#grabInfo")
								.html(
										'<tr><td style="font-weight:bold;">确认抢单数量合计：</td><td align="left">'
												+ data.grabInfo.grabNum
												+ '</td><td style="font-weight:bold;">确认抢单箱数</td><td align="left">'
												+ grabBoxSum
												+ '&nbsp;&nbsp;箱'
												+ '</td><td style="font-weight:bold;">确认抢单金额合计：</td><td align="left">'
												+ data.grabInfo.grabPriceNum
												+ '&nbsp;&nbsp;元'
												+ '</td></tr>');
					} else {
						$.messager.alert("系统错误", "查询失败", "error");
					}
				},
				error : function(request, errinfo, errobject) {

					$.messager.alert("系统错误", "查询失败123" + errobject, "error");
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
	$(div_name).dialog("setTitle", "司机详细信息");
	$(div_name).dialog("open");
	$(tab_name).empty();
	$(tab_name)
			.html(
					'<tr><td style="font-weight:bold;">姓名：</td><td>'
							+ driver.driverName
							+ '</td><td style="font-weight:bold;">手机号：</td><td align="left">'
							+ driver.phoneNo
							+ '</td></tr>'
							+ '<tr><td style="font-weight:bold;">车牌号：</td><td align="left">'
							+ driver.autoNo
							+ '</td><td style="font-weight:bold;">车型：</td><td>'
							+ driver.autoTypeName
							+ '</td></tr>'
							+ '<tr><td style="font-weight:bold;">载重：</td><td align="left">'
							+ driver.loadNum
							+ '</td><td style="font-weight:bold;">箱型：</td><td align="left">'
							+ driver.boxTypeName
							+ '</td></tr>'
							+ '<tr><td style="font-weight:bold;">箱属：</td><td>'
							+ driver.boxOwnerName
							+ '</td><td style="font-weight:bold;">身份证号：</td><td align="left">'
							+ driver.idcardNo
							+ '</td></tr>'
							+ '<tr><td style="font-weight:bold;">开户银行：</td><td align="left">'
							+ driver.bankName
							+ '</td><td style="font-weight:bold;">银行账号：</td><td align="left">'
							+ driver.bankCount
							+ '</td></tr>'
							+ '<tr><td style="font-weight:bold;">注册日期：</td><td align="left">'
							+ driver.registerdate
							+ '</td><td style="font-weight:bold;">当前状态：</td><td align="left">'
							+ status + '</font>' + '</td></tr>');
}
