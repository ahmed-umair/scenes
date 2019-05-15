<%@page import="java.sql.Connection"%>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
	<title>Home | Scenez</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="mainfeed.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
		integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
</head>

<body>
<%
	Connection global_connection = (Connection) session.getAttribute("DBConnection");
	Scenes_USER usr_data = new Scenes_USER(global_connection);
	Scenez_grp_invite grp_data = new Scenez_grp_invite(global_connection);
	Scenez_EVENT event_Data = new Scenez_EVENT(global_connection);
	Scenez_LOCATION location_data = new Scenez_LOCATION(global_connection);
	Scenez_EventTag tag_data = new Scenez_EventTag(global_connection);
	Scenez_IS_FRIENDS_WITH friends_data = new Scenez_IS_FRIENDS_WITH(global_connection);
%>
	<nav class="navbar navbar-light d-flex sticky-top border" style="background-color: #2A0055;">
		<div class="container col-sm-12 d-flex justify-content-between">
			<div class="row col-sm-12 align-items-center">
				<!--LOGO-->
				<div class="col-sm-2 float-left ">
					<a class="navbar-brand" href="#"><img src="logo.png" class="logo ml-auto"></a>
				</div>

				<!--HOME BUTTON-->
				<div class="col-sm-1 ">
					<a href="#"><i class="fa fa-home fa-2x fa-fw neeche_button my-auto float-left"></i></a>
				</div>
				<!-- SEARCH BAR -->
				<div class="col ">
					<form class="form-inline">
						<input type="text" name="searchBar" placeholder="Search bar..." class="col search_bar ml-auto">
						<button type="submit" class="search_bar col-sm-1 d-inline" id="search_button">
							<i class="fa fa-search "></i>
						</button>
					</form>
				</div>
				<!--NOTIFICATIONS BUTTON-->
				<div class="col-sm-1">
					<a href="logout.jsp"><i class="far fa-bell fa-2x fa-fw neeche_button ml-auto float-right"></i></a>
				</div>




				<!-- PROFILE PICTURE -->
				<div class="text-center col-sm-2">
					<div class=" float-right">
						<a href="viewProfile.jsp"><img src="bandi.jpg" class="profile_picture"></a>
						<label class="name d-block"><strong><%= usr_data.getFirstNameAsString(session.getAttribute("email").toString()) + " " +  usr_data.getLastNameAsString(session.getAttribute("email").toString()) %></strong></label>
					</div>
				</div>
			</div>
		</div>

		<!-- NEECHE WAALI CHEEZEIN -->
		<!-- <div id="icon_bar" class="container col-sm-6 d-flex justify-content-between px-4">
			<a href="#"><i class="fa fa-home fa-2x fa-fw neeche_button mr-auto float-left"></i></a>
            <a href="#"><i class="far fa-bell fa-2x fa-fw neeche_button ml-auto"></i></a>
		</div> -->
	</nav>


		<!-- *************** LEFT COLUMN *************** -->
		<div class="container d-flex justify-content-start border-right float-left col-lg-2 make-me-sticky">
			<div id="left-col" class="col-lg-12 ml-2 ">
				<div id="groups" class="row d-flex col-lg-12 mt-4 mb-4 border-bottom pb-4">
					<div class="d-flex justify-content-between">
						<h5 class="to-be-grey"><strong>Groups</strong></h5>	
					</div>
					<nav class="nav flex-column">
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Active</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Disabled</a> -->							
							<%
							int x = 0;
							for (; x < grp_data.getGroupNamesAsLinkedList(session.getAttribute("email").toString()).size(); x++  )
							{
								if (x > 4)
									break;
							%>
							<a class="nav-link disabled row" href="#"><i class="fas fa-users"></i> <%= grp_data.getGroupNamesAsLinkedList(session.getAttribute("email").toString()).get(x) %></a>
							<% } %>
						<% if(x > 4){ %>
						<a href="#" id="see-more" class="mt-2"><strong>See more</strong></a>
						<% } %>
					</nav>
					<button id="create-group-btn"
							class="btn btn-sm btn-outline-dark text-white mt-3 ml-auto float-right my-btn">Create Group</button>
				</div>
				<div id="pop-tags" class="row d-flex col-lg-12">
					<h5 class="to-be-grey"><strong>Popular Tags</strong></h5>
					<nav class="nav flex-column">
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-hashtag"></i> Active</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-hashtag"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-hashtag"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-hashtag"></i> Disabled</a> -->
							<%
							for (int i = 0; i < tag_data.getPopularTagsAsList().size(); i++)
							{
								if (i > 4)
									break;
							%>
							<a class="nav-link disabled row" href="#"><i class="fas fa-hashtag"></i> <%= tag_data.getPopularTagsAsList().get(i) %></a>
							<% } %>
					</nav>
				</div>
			</div>
		</div>





		<!-- *************** FEED *************** -->
		<div class="container-fluid col-lg-8 d-inline-block feed ">
			<div class="d-flex justify-content-between border-bottom align-items-center mt-4 mb-4 pb-4 ">
				<h2 style="color: #4E4E4E; font-weight: 700;">Your Feed</h1>
					<button class="btn btn-lg btn-outline-dark text-white d-flex float-right my-btn">Create
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
					<a href="#" class="display-4 mb-1 ml-2 d-inline to-be-grey"><%= currentEvent.getName() %></a>
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






		<!-- *************** RIGHT COLUMN *************** -->
		<div class="container d-flex justify-content-start border-left float-right col-lg-2 make-me-sticky">
			<div id="right-col" class="col-lg-12 mr-2 ">
				<div id="trending-events" class="row d-flex col-lg-12 mt-4 mb-4 border-bottom pb-4">
					<h5 class="to-be-grey"><strong>My Events</strong></h5>
					<nav class="nav flex-column">
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Active</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Disabled</a> -->
						<%
						 for (int i = 0; i < event_Data.getEventNamesAsList(session.getAttribute("email").toString()).size(); i++  )
							{
								if (i > 4)
									break;
						%>
						 	<a class="nav-link disabled row" href="#"><i class="fas fa-users"></i> <%= event_Data.getEventNamesAsList(session.getAttribute("email").toString()).get(i) %></a>
						<%  } %>
							<a href="#" id="see-more" class="mt-2"><strong>See more</strong></a>
					</nav>
				</div>
				<div id="chat" class="row d-flex col-lg-12">
					<h5 class="to-be-grey"><strong>Chats</strong></h5>
					<nav class="nav flex-column">
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Active</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Link</a> -->
<!-- 						<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> Disabled</a> -->
							<%
								ArrayList<Friend_Pair> users_friends = friends_data.getAllFriendsAsList(session.getAttribute("email").toString());
								for (int i = 0; i < users_friends.size(); i++)
								{
									
							%>
								<% if (users_friends.get(i).getRequester().equals(session.getAttribute("email").toString())) { %>
									<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> <%= usr_data.getFirstNameAsString(users_friends.get(i).getRequested()) + usr_data.getLastNameAsString(users_friends.get(i).getRequested())%></a>
								<% } else {%>
									<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> <%= usr_data.getFirstNameAsString( users_friends.get(i).getRequester()) + usr_data.getLastNameAsString(users_friends.get(i).getRequested())%></a>
								<% } %>
									
							<%  } %>
					</nav>
				</div>
			</div>
		</div>


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