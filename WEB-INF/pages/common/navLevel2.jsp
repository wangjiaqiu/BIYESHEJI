<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
var menudata = ${sessionScope.menu };
var path = '<c:url value="/" />';
$(function () {
    $('#tabPanel').tabs({
        width: $("#tabPanel").parent().width(),
        height: $("#tabPanel").parent().height(),
        onClose: function (title,b,c) {
        	tabsList = new Array();
        	$.each($('#tabPanel').tabs("tabs"), function() {
				tabsList.push(this.children().attr("src"));
        	});
        }
    });
    //setTabHeaderWidth(100);

    $('body').layout('panel', 'center').panel({
        onResize: function (width, height) {
            $('#tabPanel').css("width", width - 2);
            $('#tabPanel .tabs-panels').css("width", width - 4);
            $('#tabPanel .tabs-panels .panel').css("width", width - 4);
            $('#tabPanel .tabs-panels .panel .panel-body').css("width", width - 4);
            $('#tabPanel .tabs-header').css("width", width - 4);
            $('#tabPanel .tabs-header .tabs-wrap').css("width", width - 4);
        }
    });

    $("#naviTree").tree({
        onClick: function (node) {
            $(this).tree('toggle', node.target);
        },
        onSelect: function (node) {
            if ($('#naviTree').tree('getChildren', node.target).length == 0) {
            	openSub(node.text, path + node.attributes.targetUrl);
            }
        }
    });
    
    $("#naviTree").tree("loadData", menudata);
});

var tabsList = new Array();
tabsList.push("view/jsp/valuation/valuationindex.jsp");

function setTabHeaderWidth(width) {
    $('#tabPanel .tabs-header .tabs-wrap ul li').css("width", width);
    $('#tabPanel .tabs-header .tabs-wrap ul li a.tabs-inner').css("width", width);
}

function openSub(text, targetUrl) {
	if (targetUrl == "") {
		$.messager.alert("提示", "您没有该页面的访问权限！", "info");
		return false;
	}
	
	var existsIdx = -1;
	if (tabsList != null) {
		$.each(tabsList, function(i) {
			if (this == targetUrl) {
				existsIdx = i;
				return false;
			}
		});
	}
	
    if (existsIdx > -1) {
        $('#tabPanel').tabs('select', existsIdx)
    } else {
        $('#tabPanel').tabs('add', {
            title: text,
            //cache: "false",
            //href: node.id,
            content: '<iframe scrolling="auto" frameborder="0"  src="' + targetUrl + '" style="width:100%;height:99%;"></iframe>',
            closable: "true"
        });
        //setTabHeaderWidth(100);
        if (tabsList == null)
        	tabsList = new Array();
        	
        $('#tabPanel').tabs('getTabIndex', $('#tabPanel').tabs('getSelected'))
        tabsList.push(targetUrl);
    }
}

/* 关闭当前Tab页 */
function closeCurrentSub() {
	$('#tabPanel').tabs('close', $('#tabPanel').tabs('getTabIndex', $('#tabPanel').tabs('getSelected')));
}
</script>

<ol id="naviTree">
</ol>