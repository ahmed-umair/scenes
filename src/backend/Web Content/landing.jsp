<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Welcome to Scenez</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="landing.css">
	
</head>
<body>
	<nav class="navbar navbar-light bg-transparent">
	  <a class="navbar-brand" href="#"><img src="logo.png"></a>
	  <form class="form" action="loginConfirmation.jsp">
	  	<div>
	  		<%
				if (request.getSession().getAttribute("invalidCredentials") != null)
				{
					//System.out.println(request.getSession().getAttribute("invalidCredentials"));
					if ( (boolean) request.getSession().getAttribute("invalidCredentials") )
					{
						out.println("<p style='color:red;'>*Invalid username or password</p>");
					}
				}
			%>
	  		<!-- <span class="normalText" style="font-size: 28px;">Login</span> -->
	  		<span class="normalText" id="signupSuggestion" style="font-size: 1em;">Don't have an account? <br> Join Scenez today. <a href="/signup"><span class="link">Sign up.</span></a></span>
	  	</div>
	    <input class="form-control mr-sm-2" type="email" name="username" placeholder="username..." aria-label="Search">
	    <input class="form-control mr-sm-2" type="password" name="password" placeholder="password..." aria-label="Search">

	    <a href="#" class="link" style="float: left; font-size: 13px; padding-left: 5px; padding-top: 5px;">Forgot your password?</a>
	    <button class="btn btn-outline-light" type="submit">Login</button>
	  </form>
	</nav>

	<div class="container"></div>
		<div class="row"></div>
			<div class="col-lg-12"></div>
				<div id="content">
					<h1 id="heading" >SCENEZ</h1>
					<h3 id="tagline">Scenez kuch aese hain...</h3>				
				</div>
</body>
</html>