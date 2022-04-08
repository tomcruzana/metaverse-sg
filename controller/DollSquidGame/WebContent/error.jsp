<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error | Meta SG</title>
</head>
<body>

	<%@include file="adminlogin.html"%>

	<%
	out.println("<h3>There was an error!</h3> <h4>We've sent you back to the login page.</h4><br>");
	%>
	<%=exception%>
	<br>


</body>
</html>