<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();
	String openid =request.getParameter("openid"); 
	String ownerid =request.getParameter("ownerid"); 
%>

<%@page import="com.tpmgr.manage.utils.Constant"%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>微运输</title>
<c:import url="/common/css/base-css.jsp"></c:import>
<c:import url="/common/jquery.jsp"></c:import>
<c:import url="/common/jquery-easyui.jsp"></c:import>
<c:import url="/common/html5shiv.jsp"></c:import>
<c:import url="/common/default.jsp"></c:import>
<script type="text/javascript">
		var path = '<%=path%>';
		var ps = '';
		var driverId_pub='';
		var driverStatus_pub = '';
		var CODE_CAUSE_SUCCESS = '<%=Constant.CODE_CAUSE_SUCCESS%>';
		var CODE_CAUSE_FAILURE = '<%=Constant.CODE_CAUSE_FAILURE%>';
		var DOTYPE_ADD ='<%=Constant.DOTYPE_ADD%>';
		var DOTYPE_UPDATE ='<%=Constant.DOTYPE_UPDATE%>';
		var STATUS_OPEN='<%=Constant.STATUS_OPEN%>';
		var STATUS_STOP='<%=Constant.STATUS_STOP%>';
</script>
<link rel="stylesheet" href="../../css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="../../css/my.css">
<script src="../../js/jquery.js"></script>
<script src="../../js/jquery.mobile-1.3.2.min.js"></script>
<script type="text/javascript" src="../../js/jsAddress.js"></script>
<!-- 系统中两个jsAddress.js，一个是面向 mobile，一个是PC-->
<script type="text/javascript">
	$(function(){	
		$("#ownerId").val('<%=ownerid%>');
		
		//$("#ownerId").val('9');
		
		var oTable = document.getElementById('tablemy');//获取table对象  
		var rows = oTable.rows;
		for ( var i = 0; i < rows.length; i++) {
			if (i % 2 == 0) {
				rows[i].style.backgroundColor = "#FFFFFF";
				rows[i].style.color = "#000000";
			} else {
				rows[i].style.backgroundColor = "#f6f6f6";
				rows[i].style.color = "#000000";
			}
		}
		
		$.ajax( {
			type : "post",
			url : path + "/common/queryBoxTypeCombobox.do",
			dataType : "json",
			cache : false,
			success:function(result) { 
				var htmlselect = [];
				for(var i in result.combo) {  
		            htmlselect.push('<option value="'+result.combo[i].boxtypeid+'">'+result.combo[i].boxtypename+'</option>\n');
		        }
				
				$("#boxTypeId").selectedIndex = 0;
				$("#boxTypeId").append( htmlselect ).selectmenu('refresh');
				
	        }, 				
			error : function(request, errinfo, errobject) {			
				//alert("errinfo："+errinfo);
			}
		});
		
		$.ajax( {
			type : "post",
			url : path + "/common/queryBoxOwnerCombobox.do",
			dataType : "json",
			cache : false,
			success:function(result) { 
				var htmlselect = [];
				for(var i in result.combo) {  
		            //alert(i+":"+result.combo[i].autotypename);
		            htmlselect.push('<option value="'+result.combo[i].boxownerid+'">'+result.combo[i].boxownername+'</option>\n');
		        }
				//alert('htmlselect:'+htmlselect);
				
				//$("#boxOwnerId").selectedIndex = 0;
				$("#boxOwnerId").append( htmlselect ).selectmenu('refresh');
				
	        }, 				
			error : function(request, errinfo, errobject) {			
				//alert("errinfo："+errinfo);
			}
		});
		
	})
	
	$(document).ready(function() {
		$("#submit").click(function() {
			
			//手机号码
			if(!document.getElementById || !document.createTextNode) 
				return false;
			
			var tempValue = "";
			tempValue = document.getElementById("manifestName").value;
			if( !tempValue || tempValue==null ){
				alert('货名不能为空！');
				return false;
			}
			
			tempValue = document.getElementById("weight").value;
			if( !tempValue || tempValue==null ){
				alert('货重不能为空！');
				return false;
			}
			
			tempValue = document.getElementById("boxNum").value;
			if( !tempValue || tempValue==null ){
				alert('箱数不能为空！');
				return false;
			}
			
			tempValue = document.getElementById("contact").value;
			if( !tempValue || tempValue==null ){
				alert('收货联系人不能为空！');
				return false;
			}
			
			var utel=document.getElementById("contactPhone");
			var str=utel.value;
			var regPartton=/1[3-8]+\d{9}/;
			if(!str || str==null){
				alert('手机号码不能为空！');
				utel.focus();
				return false;
			}else if( str.length > 11){
				alert('手机号码格式不正确！');
				utel.focus();
				return false;
			}else if(!regPartton.test(str)){
				alert('手机号码格式不正确！');
				utel.focus();
				return false;
			}
			
			tempValue = document.getElementById("sendDate").value;
			if( !tempValue || tempValue==null ){
				alert('发货日期不能为空！');
				return false;
			}
			
			tempValue = document.getElementById("receiveDate").value;
			if( !tempValue || tempValue==null ){
				alert('收货日期不能为空！');
				return false;
			}
			
			

			//alert($("#callAjaxForm").serialize());
			var formData = $("#callAjaxForm").serialize();

			$.ajax({
				type : "POST",
				url : path + "/manifest/mAddManifest.do",
				cache : false,
				data : formData,
				success : function(data) {
					//发货成功，点击提示框，返回微信
					//WeixinJSBridge.call('closeWindow');

					if (data.code == CODE_CAUSE_SUCCESS) {
						//alert('发货成功，返回我的货单！');
						//传递openid和ownerid参数
						window.location='goodlistownermy.jsp?ownerid='+'<%=ownerid%>';
					} else {
						alert('发货失败！');
					}
				},
				error : function(request, errinfo, errobject) {
					//发货失败，继续发货
					alert('发货失败！');

				}
			});
			

			return false;
		});
	});
</script>
</head>

<body>
<div data-role="page" data-theme="b">
  <div data-role="header" data-position="fixed" data-tap-toggle="false"  data-theme="y"> 
    <h2>发布货单信息</h2>
    <a href="goodlistownermy.jsp?ownerid=<%=ownerid%>" data-ajax="false"  data-role="button" data-icon="bars"  class="ui-btn-right">我的货单</a>

  </div>
  <!-- /header -->
  
  <div role="main" data-theme="b">  
	
    <form id="callAjaxForm" data-ajax="false">	
		<input type="hidden" id="ownerId" name="ownerId" />
      <table class="dataintable" cellpadding="0" cellspacing="0" width=100% id="tablemy">

        <tr>
          <td width=27% align="right">货名：</td>
          <td width=65%><input type="text" name="manifestName" id="manifestName" value=""></td>
          <td width=8%><font color=#FF0000 size=6>*</font></td>
        </tr>
        <tr>
          <td align="right">货重：</td>
          <td><input type="number" name="weight" pattern="[0-9]*" id="weight" value=""></td>
          <td>吨/箱<font color=#FF0000 size=6>*</font></td>
        </tr>
        <tr>
          <td align="right">价格：</td>
          <td>
	          <table width=100%>
		          <tr width=100%>
			          <td width=70%>
			          <input type="number" name="price" pattern="[0-9]*" id="price" value="">
			          </td >		
			          <td width=30%>
			          		<select name="priceUnit" id="priceUnit" data-theme="x">
							  <option value="无">无</option>
							  <option value="元/吨">元/吨</option>
							  <option value="元/箱">元/箱</option>
							  <option value="元/车">元/车</option>
							</select>
			          </td>
		          </tr>
	          </table>
          
          </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">箱型：</td>
          <td>
              <select name="boxTypeId" id="boxTypeId" data-theme="x">
              </select>
            </td>
          <td><font color=#FF0000 size=6>*</font></td>
        </tr>
        <tr>
          <td align="right">箱属：</td>
          <td>
              <select name="boxOwnerId" id="boxOwnerId" data-theme="x">
              </select>
            </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">箱数：</td>
          <td><input type="number" name="boxNum" id="boxNum" pattern="[0-9]*" value=""></td>
          <td>箱<font color=#FF0000 size=6>*</font></td>
        </tr>
        <tr>
          <td align="right">收货联系人：</td>
          <td><input type="text" name="contact" id="contact" value=""></td>
          <td><font color=#FF0000 size=6>*</font></td>
        </tr>
        <tr>
          <td align="right">收货人手机：</td>
          <td><input type="number" name="contactPhone" id="contactPhone" pattern="[0-9]*" value=""></td>
          <td><font color=#FF0000 size=6>*</font></td>
        </tr>
        <tr bgcolor="#FFff00">
          <th colspan="3" style="background-color: #00bec8; "><label >发货地址及日期</label></th>
        </tr>
        <tr>
          <td align="right">省：</td>
          <td>
              <select id="sendProvince" name="sendProvince" data-theme="x"></select>               
            </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">市：</td>
          <td>              
              <select id="sendCity" name="sendCity" data-theme="x"></select>              
            </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">区/县：</td>
          <td>              
              <select id="sendArea" name="sendArea" data-theme="x"></select>              
            </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">地址：</td>
          <td><input type="text" name="sendDetailedAddress" id="sendDetailedAddress" value=""></td>
          <td></td>
        </tr>
        <tr>
          <td align="right">日期：</td>
          <td><input type="date" data-clear-btn="false" name="sendDate" id="sendDate" value=""></td>
          <td><font color=#FF0000 size=6>*</font></td>
        </tr>
        <tr bgcolor="#FFff00">
          <th colspan="3" style="background-color: #00bec8; "><label>送达地及日期</label></th>
        </tr>
        <tr>
          <td align="right">省：</td>
          <td>
              <select id="receiveProvince" name="receiveProvince" data-theme="x"></select>               
            </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">市：</td>
          <td>
              
              <select id="receiveCity" name="receiveCity" data-theme="x"></select>              
            </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">区/县：</td>
          <td>
              
              <select id="receiveArea" name="receiveArea" data-theme="x"></select>              
            </td>
          <td></td>
        </tr>
        <tr>
          <td align="right">地址：</td>
          <td><input type="text" name="receiveDetailedAddress" id="receiveDetailedAddress" value=""></td>
          <td></td>
        </tr>
        <tr>
          <td align="right">日期：</td>
          <td><input type="date" data-clear-btn="false" name="receiveDate" id="receiveDate" value=""></td>
          <td><font color=#FF0000 size=6>*</font></td>
        </tr>
        
        <tr bgcolor="#FFff00">
          <th colspan="3"><label>备注说明</label></th>
        </tr>
        
        <tr>
          <th colspan="3"><textarea name="remark" id="remark"></textarea></th>
        </tr>
     
        <tr >
          <th colspan="3"><input type="submit" name="submit" id="submit" value="提交发布" data-theme="x"  style="width: 100%;" /></th>
        </tr>
      </table>
    </form>
    <script type="text/javascript">
		//alert("init");
        addressInit('sendProvince', 'sendCity', 'sendArea', '辽宁', '营口市', '鲅鱼圈区');
		addressInit('receiveProvince', 'receiveCity', 'receiveArea',  '辽宁', '营口市', '鲅鱼圈区');
        //addressInit('Select1', 'Select2', 'Select3');
    </script>

    
  </div>
  
  
  <!-- /content -->
  <div  data-role="footer" data-position="fixed" data-tap-toggle="false"  > </div>
  <!-- /底部 --></div>
</div>
<!-- /page -->
</body>
</html>
