<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Failure | Meta SG</title>
</head>
<body>
	<%
	String msg = (String) request.getAttribute("msg");
	out.println(msg);
	%>
	<jsp:include page="adminlogin.html" />
</body>
</html>
