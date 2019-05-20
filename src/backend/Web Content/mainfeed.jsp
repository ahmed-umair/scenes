<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="backend.Scenez_Comments"%>
<%@page import="backend.Scenez_PostBean"%>
<%@page import="backend.Scenez_Connection"%>
<%@page import="backend.Friend_Pair"%>
<%@page import="backend.Scenez_IS_FRIENDS_WITH"%>
<%@page import="backend.Scenez_LOCATION"%>
<%@page import="java.util.Iterator"%>
<%@page import="backend.Scenez_EventBean"%>
<%@page import="backend.Scenes_USER"%>
<%@page import="backend.Scenez_grp_invite"%>
<%@page import="backend.Scenez_EVENT"%>
<%@page import="backend.Scenez_EventTag"%>
<%@page import="java.util.ArrayList"%>
<%@page import="backend.Scenez_POST"%>
<%@page import="backend.Scenez_Comments"%>
<%@page import="backend.Scenez_CommentBean"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>

<head>
	<title>Home | Scenez</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="mainfeed.css">
	<link rel="stylesheet" type="text/css" href="common.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
		integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
<%
	Scenez_Connection global_Connection = new Scenez_Connection();
	Scenes_USER usr_data = new Scenes_USER(global_Connection.getConnection());
	Scenez_grp_invite grp_data = new Scenez_grp_invite(global_Connection.getConnection());
	Scenez_EVENT event_Data = new Scenez_EVENT(global_Connection.getConnection());
	Scenez_LOCATION location_data = new Scenez_LOCATION(global_Connection.getConnection());
	Scenez_EventTag tag_data = new Scenez_EventTag(global_Connection.getConnection());
	Scenez_IS_FRIENDS_WITH friends_data = new Scenez_IS_FRIENDS_WITH(global_Connection.getConnection());
	Scenez_POST post_data = new Scenez_POST(global_Connection.getConnection());
	Scenez_Comments comment_data = new Scenez_Comments(global_Connection.getConnection());
%>
</head>

<body>

		<!-- *************** FEED *************** -->
		<div class="container-fluid col-lg-8 d-inline-block feed ">
			<div class="d-flex justify-content-between border-bottom align-items-center mt-4 mb-4 pb-4 ">
				<h2 style="color: #4E4E4E; font-weight: 700;">Your Feed</h1>
					<button class="btn btn-lg btn-outline-dark d-flex float-right my-btn">Create
						Event</button>
			</div>

			<!-- ALL POSTS -->
			<%
				ArrayList<Scenez_EventBean> allEvents = new ArrayList<Scenez_EventBean>();
				allEvents = event_Data.getAllEventBeansAsList();
				Iterator<Scenez_EventBean> it = allEvents.iterator();
				
				while (it.hasNext())
				{
					Scenez_EventBean currentEvent = it.next();
			%>

			<div class="container-fluid d-flex align-items-start post mt-5 pl-3 pb-5 border-bottom ">
				<img src="dancing.jpg" class="img-responsive d-inline-block mr-3 rounded border-dark" alt="Image">
				<div class="col-sm-8">
					<div class="d-flex justify-content-between align-items-center">
					<a href="viewEvent.jsp?value=<%=currentEvent.getId()%>" class="display-4 mb-1 ml-2 d-inline to-be-grey"><%= currentEvent.getName() %></a>
					</div>
					<p class="ml-2 pl-2 mb-2"><strong class="to-be-grey">Event created by: </strong><a href="#">
						<%= usr_data.getFirstNameAsString(currentEvent.getEmail()) + " " +  usr_data.getLastNameAsString(currentEvent.getEmail())%>
					</a></p>

					<div class="row pl-2 mt-4">
						<div class="column col-lg-5 border-right ml-0 pl-4">
							<!-- <p class="mb-0"><strong class="to-be-grey subheading">Details</strong></p> -->
							<div class="container pl-0">
								<p><strong class="to-be-grey">Location: </strong><span class="tbp"><%= location_data.getLocationSpecificsByID(currentEvent.getLocation_id()) %></span></p>
								<p><strong class="to-be-grey">Date: </strong><span class="tbp"><%= currentEvent.getEvent_date() %></span></p>
								<p><strong class="to-be-grey">Time: </strong><span class="tbp"><%= currentEvent.getStart_time() %></span></p>
							</div>
						</div>
						<div class="column col-lg-7">
							<div>
							<% if (currentEvent.getDescription().length() < 50) { %>
								<p class="tbp"><%= currentEvent.getDescription() %></p>
							<% } else { %>
								<p class="tbp"><%= currentEvent.getDescription().substring(0, Math.min(currentEvent.getDescription().length(), 180)) + ". . ." %></p>
							<% } %>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%
				}
			%>

		</div>       <!-- Feed div ends here -->

		
	<!-- FOOTER -->
	<footer class="footer container-fluid col-sm-12 justify-content-between mt-5"
		style="background-color: #303030;">

		<!-- LOGO -->
		<div class="row d-flex justify-content-betweens align-items-center">
			<div class="col-2 footer-logo d-block float-left ">
				<img src="logo.png">
			</div>

			<!-- INFO -->
			<div class="col links d-inline-block my-auto justify-content-around">
				<a href="#">HOME</a>
				<label for=""> | </label>
				<a href="#">ABOUT</a>
				<label for=""> | </label>
				<a href="#">SUPPORT</a>
				<label for=""> | </label>
				<a href="#">CONTACT</a>
			</div>

			<!-- NEWSLETTER -->
			<div class="float-right col-2">
				<p class="mb-1 " style="letter-spacing: 1px;">JOIN OUR NEWSLETTER</p>
				<form action="#" id="newsletter" class="row align-items-center">
					<input type="email" id="newsletter-input"
						class="col-sm-8 bg-dark rounded form-control-sm border-1 px-2 ml-auto">
					<button class="btn btn-sm btn-outline-light text-light bg-transparent ml-auto mr-auto"
						type="submit">JOIN</button>
				</form>
			</div>
		</div>

		<!-- CREDITS -->
		<div class="row mt-2">
			<div class="credits col d-block mb-0">
				<p class="mb-0">© Codeplay | All Right Reserved</p>
			</div>
		</div>

	</footer>

</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
	integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
	crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"
	integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1"
	crossorigin="anonymous"></script>

</html>