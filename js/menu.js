// JavaScript Document
//================================================================================ 

// 弹出菜单

// 作者：邬博

// 描述: 弹出式菜单实现，配合menu.CSS样式实现

// 更新: 2008-06-18 

//================================================================================ 



//菜单样式常量

var m_styletop="29px";
var m_styleleft_hidden="-9000px";
var m_styleleft_show="1px";
var m_stylebgcolor_click="#99DDFF"; //菜单弹出时的背景颜色
var m_stylebgcolor_unclick="#EFFFFF"; //菜单隐藏式的背景颜色
var m_spanlaction=":"; //当前命令导航常量
var m_spanpointer=">";//当前命令导航箭头

//显示菜单
function showMenu(menuid,btnid)
{
	if (document.getElementById(menuid).style.left==m_styleleft_hidden)
	{
		initMenu();
		document.getElementById(menuid).style.left=m_styleleft_show;
		document.getElementById(menuid).style.top=m_styletop;
		document.getElementById(btnid).style.backgroundColor=m_stylebgcolor_click;
	}
	else 
	{
		document.getElementById(menuid).style.left=m_styleleft_hidden;
		document.getElementById(btnid).style.backgroundColor=m_stylebgcolor_unclick;
	}

}

//隐藏菜单

function hiddenMenu(menuid,btnid)
{
	document.getElementById(menuid).style.left=m_styleleft_hidden;
	document.getElementById(btnid).style.backgroundColor = m_stylebgcolor_unclick;
}

//初始化菜单按钮

function initMenu()
{
	document.getElementById("ul_1").style.left = m_styleleft_hidden;
	document.getElementById("ul_2").style.left = m_styleleft_hidden;
	document.getElementById("ul_3").style.left = m_styleleft_hidden;
	document.getElementById("ul_4").style.left = m_styleleft_hidden;
	document.getElementById("btn1").style.backgroundColor = m_stylebgcolor_unclick;
	document.getElementById("btn2").style.backgroundColor = m_stylebgcolor_unclick;
	document.getElementById("btn3").style.backgroundColor = m_stylebgcolor_unclick;
	document.getElementById("btn4").style.backgroundColor = m_stylebgcolor_unclick;
}



//当鼠标以上时清楚时间对象

function drop_mouseover()
{
    try
    {
        window.clearTimeout(timer);
    }

    catch(e)
    {
    }

}



//当鼠标移开后隐藏菜单

function drop_mouseout(menuid,btnid)
{
    var posSel = document.getElementById(menuid).style.left;
    if(posSel != m_styleleft_hidden)
    {
        timer = setTimeout("hiddenMenu('"+menuid+"','"+btnid+"')", 800);
    }
}