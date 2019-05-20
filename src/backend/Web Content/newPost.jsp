<%@page import="backend.Scenez_Connection"%>
<%@page import="backend.Scenez_NEWCOMMENT"%>
<%@page import="backend.Scenez_POST"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<div class="container">

<%
	int eventId = 0;
	int status = 0;		//Error Tracking
	String email = session.getAttribute("email").toString();
	String title = request.getParameter("post-title");
	String content = request.getParameter("post-content");
	Scenez_Connection s_con = new Scenez_Connection();
	
	if(request.getParameter("post-content")!= null){
		eventId = Integer.parseInt(request.getParameter("eventId").toString());
		System.out.println( "ERROR CHECKKING --> " + eventId);
	} else
		status = 2;
	
	if(status != 2){
		Scenez_POST newPost = new Scenez_POST(s_con.getConnection());
		
		newPost.insertPost(email, title, content, eventId);
		
		
	
%>

<body onload="document.frm1.submit()">
<form name = "frm1" action = "viewEvent.jsp">
	<input name="value" value=<%=eventId%> type="hidden">
</form>
<%} %>
</body>
</div>

</body>
</html>