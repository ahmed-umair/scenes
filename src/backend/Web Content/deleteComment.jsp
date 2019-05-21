<%@page import="backend.Scenez_Connection"%>
<%@page import="backend.Scenez_Comments"%>
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
	int commentId = 0;
	int status = 0;		//Error Tracking
	int eventId = 0;
	String email = session.getAttribute("email").toString();
	Scenez_Connection s_con = new Scenez_Connection();
	
	if(request.getParameter("value")!= null){
		commentId = Integer.parseInt(request.getParameter("value").toString());
		System.out.println( "ERROR CHECKKING --> " + commentId);
	} else
		status = 2;
	
	if(status != 2){
		Scenez_Comments comm = new Scenez_Comments(s_con.getConnection());
		eventId = comm.getEventID(commentId);
		comm.deleteComment(commentId);
				
%>
</div>
</body>
<body onload="document.frm1.submit()">
<form name = "frm1" action = "viewEvent.jsp">
	<input name="value" value=<%=eventId%> type="hidden">
</form>
<% }  %>
</html>