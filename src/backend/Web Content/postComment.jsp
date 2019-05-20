<%@page import="backend.Scenez_Connection"%>
<%@page import="backend.Scenez_NEWCOMMENT"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reply to Post</title>
</head>
<body>
<div class="container">
<%
	int postId = 0;
	int status = 0;		//Error Tracking
	String email = session.getAttribute("email").toString();
	String content = request.getParameter("reply");
	Scenez_Connection s_con = new Scenez_Connection();
	
	if(request.getParameter("reply")!= null){
		postId = Integer.parseInt(request.getParameter("postId").toString());
		System.out.println( "ERROR CHECKKING --> " + postId);
	} else
		status = 2;
	
	if(status != 2){
		Scenez_NEWCOMMENT newComm = new Scenez_NEWCOMMENT(s_con.getConnection());
		
		newComm.insertComment(content, email, postId);
		
%>
	
<body onload="document.frm1.submit()">
<form name = "frm1" action = "viewEvent.jsp">
	<input name="value" value=<%=newComm.getEventID(postId) %> type="hidden">
</form>
<%} %>
</body>

</div>


</body>
</html>