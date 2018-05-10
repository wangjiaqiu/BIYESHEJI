<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 让低版本IE支持max-width/min-width等属性，需modernizr.js。 -->
<script type="text/javascript">
	Modernizr.load({
		test: Modernizr.mq('only all'),
		nope: '<c:url value="/plugin/respond-master/respond.min.js" />'
	});
</script>