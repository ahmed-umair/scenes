<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="backend.Scenes_USER"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Confirm Login...</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
<div class="container">
<%
	boolean login = false;
	String email="", password="";
	int status = 0;  // 1 = login success, 2 = login fail, 3 = invalid data
	
	if (request.getParameter("username") != null)
	{
		email = request.getParameter("username");
	}
	else
	{
		status = 3;
	}
	
	if (request.getParameter("password") != null)
	{
		password = request.getParameter("password");
	}
	else
	{
		status = 3;
	}
	
	if (status != 3)    //server data is coming from login page and not some other page
	{
		Scenes_USER user_table = new Scenes_USER();
		ArrayList<String> user_emails = user_table.getEmailAsList();
		Iterator<String> it = user_emails.iterator();
		
		while (it.hasNext())
		{
			String current_email = it.next();
			if (current_email.equals(email) && user_table.getPasswordAsSingle(email).equals(password))
				login = true;
		}
		
		if (login)
		{
			session.setAttribute("userLoggedIn", true);
			session.setAttribute("email", email);
			session.setAttribute("invalidCredentials", false);
			session.setMaxInactiveInterval(60);
			
			response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
			response.setHeader("Pragma","no-cache");
			response.setDateHeader("Expires", 0);
			response.sendRedirect("mainfeed.jsp");
		}
		else
		{
			status = 2;
		}
		
	}
	
%>
<% if (status == 2) { %>
	<br>
	<div class="alert alert-danger">
  		<strong>Alert!</strong> Invalid Username or Password!
	</div>
	<button class="btn btn-default" onclick="location.href='index.jsp'">Retry</button>
	<%
		session.setAttribute("invalidCredentials", true);
		response.sendRedirect("landing.jsp");
	%>
<% } %>

<% if (status == 3) { %>
	<br>
	<div class="alert alert-danger">
  		<strong>Alert!</strong> Data that has reached the server in invalid
	</div>
	<button class="btn btn-default" onclick="location.href='landing.jsp'">Retry</button>
<% } %>
</div>
</body>
</html>