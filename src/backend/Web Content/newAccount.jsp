<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "java.text.SimpleDateFormat, java.util.Date" %>
<%@page import="backend.Scenes_USER"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Account|Scenez</title>
</head>
<body>
<div class="container">
<%
	String fname="", lname="", email="", password="", gender="", date="";
	int status = 0;  // 1 = creation success, 2 = invalid parameter, 3 = Query Execution Failure, 4 = email already exists
	
	if(request.getParameter("fname") != null){
		fname = request.getParameter("fname");
		System.out.print(fname + "\n");
	} else {
		status = 2;
	}
	
	if(request.getParameter("lname") != null){
		lname = request.getParameter("lname");
		System.out.print(lname + "\n");
	} else {
		status = 2;
	}

	if(request.getParameter("email") != null){
		email = request.getParameter("email");
		System.out.print(email + "\n");
	} else {
		status = 2;
	}
	
	if(request.getParameter("password") != null){
		password = request.getParameter("password");
		System.out.print(password + "\n");
	} else {
		status = 2;
	}
	
	if(request.getParameter("gender") != null){
		gender = request.getParameter("gender");
		System.out.print(gender+ "\n");
	} else {
		status = 2;
	}
	
	if(request.getParameter("bday") != null){
		date = request.getParameter("bday");
		System.out.print(date + "\n");
	} else {
		status = 2;
	}
	
	if(status !=2){
		
		Scenes_USER user_table = new Scenes_USER();
		
		// Check if email already exists
		if(user_table.checkUniqueEmail(email) == true){		
			if(user_table.addUser(fname, lname, email, password, date, gender,-1)){
				response.sendRedirect("landing.jsp");
			}
			else
				status = 3;
		} else
			status = 4;
	}	
%>

<% if (status == 2) { %>
	<br>
	<div class="alert alert-danger">
  		<strong>Alert!</strong> Invalid Parameters Entered
	</div>
	<button class="btn btn-default" onclick="location.href='index.jsp'">Retry</button>
	<%
		response.sendRedirect("landing.jsp");
	%>
<% } %>

<% if (status == 3) { %>
	<br>
	<div class="alert alert-danger">
  		<strong>Alert!</strong> Data that has reached the server in invalid
	</div>
	<button class="btn btn-default" onclick="location.href='newAccount.jsp'">Retry</button>
<% } %>

<% if (status == 4) { %>
<div class="alert alert-warning alert-dismissible fade show" role="alert">
      <button type="button" class="close" onclick="location.href='newAccount.jsp'" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
      <strong>Account with entered Email already exists</strong> 
</div>
 <% } %>

</div>
</body>
</html>