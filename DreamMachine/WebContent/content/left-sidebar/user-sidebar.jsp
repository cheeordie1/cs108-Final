
<html>
<head>
	<link rel="stylesheet" type="text/css" href="/DreamMachine/assets/stylesheets/user-sidebar.css">	
</head>
<head>
<body>


	<nav id="left" class="column">
    <%@ page import="assignment.User, java.util.List" %>
    
    
	
	
	<%
        HttpSession sess = request.getSession();
        if (sess.getAttribute("loggedIn").toString().equals("true")) {
      %>
      
   	<div class = "profile-picture">
		<img id="user-img" src="/DreamMachine/assets/images/mr-bean.jpeg" alt="user pic" class="img-circle">
	</div>	
      
	<h1 id = "user-welcome"><%=sess.getAttribute("username") %></h1>
	
	<div id="login-bar-container">
      <div id="logged-in-text">
        <div id="logout-options">
        <center>
	      <br>
	      <br>
          <a class = "btn btn-default" role = "button" id="account-link" class="login-link" href=<%= "/DreamMachine/user/" + sess.getAttribute("username") %> >Account</a>
		  <br>
		  <br>
          <a class = "btn btn-default" role = "button" id="logout-link" class="logout-link" href="/DreamMachine/logout">Logout</a>
          <br>
          <br>
          <a class = "btn btn-default" role = "button" id="messages-link" class="" href="">Messages</a>
		  <br>
		  <br>
		  <a class = "btn btn-default" role = "button" id="history-link" class="" href="">History</a>
          </center>
        </div>
      </div>
      <% } else { %>
      <div id="not-logged-in-text">
        <br>
        <br>
      	<a class = "btn btn-default" role = "button"  class="logout-link" href="/DreamMachine/login">login</a>
      	<br>
      	<br>
      	<a class = "btn btn-default" role = "button"  class="login-link" href="/DreamMachine/signup">signup</a>
      </div>
      <% } %>
	</div>
   
	</nav>

</body>