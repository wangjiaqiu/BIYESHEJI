<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">
	.olList { list-style-type: none; margin: 0, 0, 0, 0px; padding: 0; }
	.li-normal { margin: 3px; padding: 1px; text-align: center; border:0 none; }
	.li-hover {
	    background: url("<c:url value="/images/style/item.png"/>") repeat-x scroll 0 0 #E3EBFF;
	    border: 1px solid #9A9A9A;
	    padding: 0;
	}
	.li-selected {
	    background: url("<c:url value="/images/style/pressed.png"/>") repeat-x scroll 0 0 #DBDDE2;
	    border: 1px solid #9A9A9A;
	    padding: 0;
	}
</style>
<script type="text/javascript">
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
    createNavi();
});

var tabsList = new Array();
tabsList.push("view/jsp/valuation/valuationindex.jsp");

function setTabHeaderWidth(width) {
    $('#tabPanel .tabs-header .tabs-wrap ul li').css("width", width);
    $('#tabPanel .tabs-header .tabs-wrap ul li a.tabs-inner').css("width", width);
}

function createNavi() {
	$("#naviTree li").mouseenter(function() {
		if (!$(this).hasClass("li-hover"))
			$(this).addClass("li-hover");
	});
	$("#naviTree li").mouseleave(function() {
		if ($(this).hasClass("li-hover"))
			$(this).removeClass("li-hover");
	});
	$("#naviTree li").click(function() {
		$("#naviTree li").removeClass("li-selected");
		$(this).addClass("li-selected");
		openSub($(this).children("span").html(), $(this).children("span").attr("targetUrl"));
	});
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

<ol id="naviTree" class="olList">
	<c:forEach items="${sessionScope.menu }" var="item">
		<li class="li-normal">
			<c:if test="${!empty item.icon }">
				<img src="<c:url value="${item.icon }" />"  height="42" width="42"/><br/>
			</c:if>
			<span targetUrl="<c:url value="${item.url }" />">${item.menuName }</span>
		</li>
	</c:forEach>
</ol>