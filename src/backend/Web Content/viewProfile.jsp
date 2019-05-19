<%@page import="java.sql.Connection"%>
<%@page import="backend.Inviter_Invitee_Info"%>
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
<%
	Connection global_connection = (Connection) session.getAttribute("DBConnection");
	Scenes_USER usr_data = new Scenes_USER(global_connection);
	Scenez_grp_invite grp_data = new Scenez_grp_invite(global_connection);
	Scenez_EVENT event_Data = new Scenez_EVENT(global_connection);
	Scenez_LOCATION location_data = new Scenez_LOCATION(global_connection);
	Scenez_EventTag tag_data = new Scenez_EventTag(global_connection);
	Scenez_IS_FRIENDS_WITH friends_data = new Scenez_IS_FRIENDS_WITH(global_connection);
%>

<head>
	<title><%= usr_data.getFirstNameAsString(session.getAttribute("email").toString()) + " " +  usr_data.getLastNameAsString(session.getAttribute("email").toString())%> | Scenez</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="userProfile.css">
	<link rel="stylesheet" type="text/css" href="common.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
		integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
</head>

<body>
	<nav class="navbar navbar-light d-flex sticky-top" style="background-color: #2A0055;">
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
					<a href="#"><i class="far fa-bell fa-2x fa-fw neeche_button ml-auto float-right"></i></a>
				</div>




				<!-- PROFILE PICTURE -->
				<div class="text-center col-sm-2">
					<div class=" float-right">
						<a href="logout.jsp"><img src="bandi.jpg" class="profile_picture"></a>
						<label class="name d-block"><strong><%= usr_data.getFirstNameAsString(session.getAttribute("email").toString()) + " " +  usr_data.getLastNameAsString(session.getAttribute("email").toString()) %></strong></label>
					</div>
				</div>
			</div>
		</div>
	</nav>


		<!-- *************** LEFT COLUMN *************** -->
		<div class="container d-flex justify-content-start border-right float-left col-lg-2 make-me-sticky">
			<div id="left-col" class="col-lg-12 ml-2 ">
				<div id="groups" class="row d-flex col-lg-12 mt-4 mb-4 border-bottom pb-4">
					<!-- <div> -->
						<h5 class="tbg "><strong>My Groups</strong></h5>	
					<!-- </div> -->
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
					<button id="create-group-btn"class="btn btn-sm btn-outline-dark mt-3 ml-auto float-right my-btn">Create Group</button>
					
				</div>
				<div id="pop-tags" class="row d-flex col-lg-12">
					<h5 class="tbg"><strong>Popular Tags</strong></h5>
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
		<div class="container-fluid col-lg-8 d-inline-block feed mt-5">

			<!-- USER PROFILE HEADER -->
			<div class="col-sm-12 mt-0 d-flex justify-content-around">
				<div class="col-sm-3 d-inline">
					<img src="bandi.jpg" id="user-profile-picture" class="d-inline-block">
				</div>
				<div class="col-sm-7 ml-5">
					<div class="row mt-3 d-flex align-items-center">
						<h4 class="display-4"><%= usr_data.getFirstNameAsString(session.getAttribute("email").toString()) + " " +  usr_data.getLastNameAsString(session.getAttribute("email").toString()) %></h4>
						<button class="btn btn-sm reverse-btn ml-4 w-25">Edit Profile</button>
					</div>
					<div class="row mt-3 d-flex align-items-center">
						<div class="d-flex justify-content-around">
							<div class="col text-center">
								<a href="viewFriends.jsp">
									<h4 class="tbp font-weight-bold"><%= friends_data.getFriendsCountByEmail(session.getAttribute("email").toString()) %></h4>
									<label for="" class="tbp font-weight-light">friends</label>
								</a>
							</div>
							<div class="col text-center">
							<a href="#" class="tbp font-weight-bold">
								<h4 class="tbp font-weight-bold"><%= event_Data.getEventAttendedCount(session.getAttribute("email").toString()) %></h4>
								<label for="" class="tbp font-weight-light">events attended</label>
							</a>
							</div>
							<div class="col text-center">
								<a href="#" class="tbp font-weight-bold">
									<h4 class="tbp font-weight-bold"><%= event_Data.getEventHostedCount(session.getAttribute("email").toString()) %></h4>
									<label for="" class="tbp font-weight-light">events hosted</label>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div> <!-- END OF USER PROFILE HEADER-->

			<hr class="mt-5 mb-3">

			<div class="container">
				<h1 class="tbg font-weight-bold mb-5">Past Activity</h1>
				<ul>
				<%
					ArrayList<Inviter_Invitee_Info> attended_events = new ArrayList<>();
					attended_events = event_Data.getAttendedEventsAsList(session.getAttribute("email").toString());
					for (int i = 0; i < attended_events.size(); i++)
					{
						String hostEmail = event_Data.getHostEmailByID( attended_events.get(i).getEvent_id());
				%>		
					<li class="tbp "><h4 id="event-status"><%= usr_data.getFirstNameAsString(session.getAttribute("email").toString()) %> attended <a href="#" class=""><%= usr_data.getFirstNameAsString(hostEmail) + " " + usr_data.getLastNameAsString(hostEmail) %></a>'s <strong class="font-weight-bold">Dance Party</strong> </h4></li>
					<div class="container-fluid d-flex align-items-start post mt-5 pl-3 pb-5 border-bottom ">
							<img src="dancing.jpg" class="img-responsive d-inline-block mr-3 rounded border-dark" alt="Image">
							<div class="col-sm-8">
								<div class="d-flex justify-content-between align-items-center">
									<a href="#" class="display-4 mb-1 ml-2 d-inline tbg">Dance Party</a>                            
								</div>
								<p class="ml-2 pl-2 mb-2"><strong class="tbg">Event created by: </strong><a href="#"> <%= usr_data.getFirstNameAsString(hostEmail) + " " + usr_data.getLastNameAsString(hostEmail) %></a></p>
			
								<div class="row pl-2 mt-4">
									<div class="column col-lg-5 border-right ml-0 pl-4">
										<!-- <p class="mb-0"><strong class="tbg subheading">Details</strong></p> -->
										<div class="container pl-0">
										<%
											Scenez_EventBean current_event = event_Data.getSingleEventBean(attended_events.get(i).getEvent_id());
										%>
											<p><strong class="tbg">Location: </strong><span class="tbp"><%= location_data.getLocationSpecificsByID(current_event.getLocation_id()) %></span></p>
											<p><strong class="tbg">Date: </strong><span class="tbp"><%= current_event.getEvent_date() %></span></p>
											<p><strong class="tbg">Time: </strong><span class="tbp"><%= current_event.getStart_time() %></span></p>
										</div>
									</div>
									<div class="column col-lg-7">
										<div>
											<% if (current_event.getDescription().length() < 50) { %>
								<p class="tbp"><%= current_event.getDescription() %></p>
							<% } else { %>
								<p class="tbp"><%= current_event.getDescription().substring(0, Math.min(current_event.getDescription().length(), 180)) + ". . ." %></p>
							<% } %>
										</div>
									</div>
								</div>
							</div>
						</div>
						<% } %>
				</ul>
				
			</div>

		</div>






		<!-- *************** RIGHT COLUMN *************** -->
		<div class="container d-flex justify-content-start border-left float-right col-lg-2 make-me-sticky">
			<div id="right-col" class="col-lg-12 mr-2 ">
				<div id="trending-events" class="row d-flex col-lg-12 mt-4 mb-4 border-bottom pb-4">
					<h5 class="tbg"><strong>My Events</strong></h5>
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
					</nav>
				</div>
				<div id="chat" class="row d-flex col-lg-12">
					<h5 class="tbg"><strong>Chats Here</strong></h5>
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