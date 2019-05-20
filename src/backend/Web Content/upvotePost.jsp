<%@page import="backend.Scenez_NEWCOMMENT"%>
<%@page import="backend.Scenez_Connection"%>
<%@page import="backend.Scenez_VOTE" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	int postID = 0;
	int status = 0;	//Error Tracking
	String email = session.getAttribute("email").toString();
	Scenez_Connection s_con = new Scenez_Connection();
	
	if(request.getParameter("value") != null){
		postID = Integer.parseInt(request.getParameter("value"));
	}
	else
		status = 2;	
	
	if(status != 2){
		Scenez_VOTE votePost = new Scenez_VOTE(s_con.getConnection());
		
		votePost.upVotePost(postID, email);
		
		Scenez_NEWCOMMENT scom = new Scenez_NEWCOMMENT(s_con.getConnection());
%>
</body>
<body onload="document.frm1.submit()">
<form name = "frm1" action = "viewEvent.jsp">
	<input name="value" value=<%=scom.getEventID(postID)%> type="hidden">
</form>
<% } %>
</html>