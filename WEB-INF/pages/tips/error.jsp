<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html lang="zh">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
<title>系统错误</title>
</head>
<body>
	<fmt:setLocale value="zh_CN"/>
	<fmt:setBundle basename="applicationMessage" var="applicationBundle"/>
	<fmt:message key="${errorCode }" bundle="${applicationBundle}" />
</body>
</html>