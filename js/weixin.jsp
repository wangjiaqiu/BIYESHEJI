<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="zh">
<%
	String path = request.getContextPath();

	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

%>
<%@page import="com.tpmgr.manage.utils.Constant"%>
<head>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>微运输</title>
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
<link rel="stylesheet"
	href="css/themes/default/jquery.mobile-1.3.2.min.css">
<link rel="stylesheet" href="css/my.css">
<script src="js/jquery.js"></script>
<script src="js/jquery.mobile-1.3.2.min.js"></script>

<%
	String rtn = "";
	int c;
	String openid = "";
	String code = request.getParameter("code");
	String menustate = request.getParameter("state");
	try {
		java.net.URL l_url = new java.net.URL(
				"https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx49b20541a9896c89&secret=22c7dada8a89f21501c98fcab1e6ba91&code="
						+ code + "&grant_type=authorization_code");
		java.net.HttpURLConnection l_connection = (java.net.HttpURLConnection) l_url
				.openConnection();
		l_connection.connect();
		java.io.InputStream l_urlStream = l_connection.getInputStream();
		JSONObject obj=new JSONObject();
		while (((c = l_urlStream.read()) != -1)) {
			int all = l_urlStream.available();
			byte[] b = new byte[all];
			l_urlStream.read(b);
			rtn += new String(b, "UTF-8");
			
		}
		rtn.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
		obj = JSONObject.fromObject("{" + rtn + "}");
		openid = obj.getString("openid");
		l_urlStream.close();
	} catch (Exception e) {
		e.printStackTrace();
	}

%>

<script>
	var openid1 = '<%=openid%>';
	//var openid1 = 'o2jGiuCV4zS0HKqWkmtf2ED_cU1I'; //iphone 5s
	//var openid1 = 'o2jGiuCV4zS0HKqWkmtf2ED_huozhu'; //test data huozhu
	//var openid1 = 'o2jGiuCV4zS0HKqWkmtf2ED_siji'; //test data siji

	var menustate = '<%=menustate%>';
	//var menustate = '20';
	$(function() {
		//alert('menustate weixin:'+menustate);
		$.ajax({
			type : "post",
			url : path + '/common/mQueryOpenid.do',
			dataType : "json",
			cache : false,
			data : {
				"openid" : openid1
			},
			success : function(data) {
				//查询成功，返回用户数据

				if (data.openidinfo.length){
					//微信用户已存在

					if( data.openidinfo[0].usertype == 'A' ||  data.openidinfo[0].usertype == 'P' ||  data.openidinfo[0].usertype == 'U'  ){
						//货主角色
						//alert("huo zhu p:"+data.openidinfo[0].ownerid);
						if(data.openidinfo[0].ownerstatus == 2){
							//进入了黑名单
							alert('请联系微运输中心！');
						}else{
							if(menustate == "11"){
								//我：个人中心
								window.location='mobile/owner/ownerinfo.jsp?ownerid='+ data.openidinfo[0].ownerid;							
							}else if(menustate == "12"){
								//我：我的货单
								window.location='mobile/owner/goodlistownermy.jsp?ownerid='+ data.openidinfo[0].ownerid;
							}else if(menustate == "20"){
								//交易平台
								window.location='mobile/owner/goodadd.jsp?ownerid='+ data.openidinfo[0].ownerid +'&usertype:'+ data.openidinfo[0].usertype;							
							}else if(menustate = "31"){
								//最新路况
								window.location='mobile/common/trafficlist.jsp?userid='+ data.openidinfo[0].ownerid +'&usertype=2';								
							}else if(menustate == "32"){
								//上报路况
								window.location='mobile/common/trafficadd.jsp?userid='+ data.openidinfo[0].ownerid +'&usertype=2';								
							}else{
								WeixinJSBridge.call('closeWindow');
							}
						}
						
					}else{
						//司机角色
						//alert("si ji");
						if(data.openidinfo[0].driverstatus == 2){
							//进入了黑名单
							alert('请联系微运输中心！');
						}else{					
						
							if(menustate == "11"){
								//我：个人中心
								window.location='mobile/driver/driverinfo.jsp?driverid='+ data.openidinfo[0].driverid;
							}else if(menustate == "12"){
								//我：我的货单
								window.location='mobile/driver/goodlistdrivermy.jsp?driverid='+ data.openidinfo[0].driverid;							
							}else if(menustate == "20"){
								//交易平台
								window.location='mobile/driver/goodlist-research.jsp?driverid='+ data.openidinfo[0].driverid;	
	
							}else if(menustate == "31"){
								//最新路况
								window.location='mobile/common/trafficlist.jsp?userid='+ data.openidinfo[0].driverid +'&usertype=1';									
							}else if(menustate == "32"){
								//上报路况
								window.location='mobile/common/trafficadd.jsp?userid='+ data.openidinfo[0].driverid +'&usertype=1';						
							}else{
								WeixinJSBridge.call('closeWindow');
	
							}
						}
					}					
				}else{
					//微信用户不存在，跳转至注册页面					
 					window.location= 'regport.jsp?openid='+openid1;
				}
				
			},
			error : function(request, errinfo, errobject) {
				//添加失败，继续添加
				//alert('获取失败！');

			}
		});
		
		
	
	});
	
</script>
</head>

<body>
	<br>
	<%
			//String code = request.getParameter("code");
			//String code1 = "022b0d911526206b215fa826ed5033b0";

			//response.sendRedirect("https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx49b20541a9896c89&secret=22c7dada8a89f21501c98fcab1e6ba91&code="+code1+"&grant_type=authorization_code");
		%>

</body>
</html>
