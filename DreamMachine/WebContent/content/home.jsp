<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="assets/stylesheets/home.css">
<jsp:include page="app.jsp">
  <jsp:param value="" name=""/>
</jsp:include>
<title>Welcome to Dream Machine</title>
</head>
<body>
  <jsp:include page="top-bar.jsp">
    <jsp:param value="" name=""/>
  </jsp:include>
  <div id="home-div">
    <div id="welcome-div">Hello There!</div>
  </div>
</body>
</html>