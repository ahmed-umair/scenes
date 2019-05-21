<%@page import="backend.Scenez_GroupBean"%>
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
<%@page import="backend.Scenez_GroupBean"%>
<%@page import="backend.Scenez_EVENT"%>
<%@page import="backend.Scenez_EventTag"%>
<%@page import="java.util.ArrayList"%>
<%@page import="backend.Scenez_POST"%>
<%@page import="backend.Scenez_Comments"%>
<%@page import="backend.Scenez_CommentBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
	<title>Home | Scenez</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<!-- <link rel="stylesheet" type="text/css" href="mainfeed.css"> -->
	<link rel="stylesheet" type="text/css" href="common.css">
	<link rel="stylesheet" type="text/css" href="header.css">
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
// 	Scenez_POST post_data = new Scenez_POST(global_Connection.getConnection());
// 	Scenez_Comments comment_data = new Scenez_Comments(global_Connection.getConnection());
%>
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
					<a href="mainfeed.jsp"><i class="fa fa-home fa-2x fa-fw neeche_button my-auto float-left"></i></a>
				</div>


				<!-- SEARCH BAR -->
				<div class="col ">
					<form class="form-inline" action="search.jsp">
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
						<label class="name d-block"><strong>
								<div class="dropdown show">
									<a class="name dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
										data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										 <%=usr_data.getFirstNameAsString(session.getAttribute("email").toString()) + " "
											+ usr_data.getLastNameAsString(session.getAttribute("email").toString())%>
									</a>

									<div class="dropdown-menu" id="pic-dropdown" aria-labelledby="dropdownMenuLink">
										<a class="dropdown-item option" href="#">View Profile</a>
										<a class="dropdown-item option" href="#">Settings</a>
										<a class="dropdown-item option" href="#">Logout</a>
									</div>
								</div>
							</strong></label>
					</div>
				</div>
			</div>
		</div>
	</nav>


	<!-- *************** LEFT COLUMN *************** -->
	<div class="container d-flex justify-content-start border-right float-left col-sm-2 make-me-sticky">
		<div id="left-col" class="col-sm-12 ml-2 ">

			<!-------- GROUPS --------->
			<div id="groups" class="row d-flex mt-4 mb-4 border-bottom pb-4">
				<!-- GROUPS HEADING -->
				<div id="group-header" class="row justify-content-center">
					<h5 class="tbg col-sm-12"><strong>My Groups</strong></h5>
				</div>

				<div id="group-list" class="row mx-auto">
					<nav class="nav col-sm-12 mx-auto list-group">
					 <%
					 		ArrayList<Scenez_GroupBean> grpBean = new ArrayList<Scenez_GroupBean>();
					 		grpBean = grp_data.getGroupBean(session.getAttribute("email").toString());
					 		int size = grpBean.size();
					 		
							int x = 0;
							for (; x < size; x++  )
							{
								if (x > 4)
									break;
					 %>

						<div class="row d-block">
							<div class="col-sm-12">
								<a class="nav-link tbp d-inline-block" href="viewGroup.jsp?value=<%=grpBean.get(x).getGrp_id()%>"><i
										class="fas fa-users mr-2"></i><%= grpBean.get(x).getName() %></a>
							</div>
						</div>
					</nav>
						<% } %>
						<% if(x > 4){ %>
					
					<div class="row">
						<div class="col-sm-12">
							<a href="#" id="see-more" class="link"><strong>See more</strong></a>
						</div>
					</div>
					<% } %>
				</div>
				
				<!-- LIST OF GROUPS -->
				<div class="container">
					<div class="col-sm-12">
						<a href="createGroup.jsp" id="create-group-btn" class="btn btn-sm btn-outline-dark mt-3 col mx-auto my-btn">Create
							Group</a>
					</div>

				</div>

			</div>

			<!-------- POPULAR TAGS --------->
			<div id="pop-tags" class="row d-flex">
				<!-- HEADING -->
				<div class="row">
					<h5 class="tbg col"><strong>Popular Tags</strong></h5>
				</div>

				<div class="container px-0 d-block">
					<div class="col-sm-10">
					<%
							for (int i = 0; i < tag_data.getPopularTagsAsList().size(); i++)
							{
								if (i > 4)
									break;
							%>
						<a href="searchEvent.jsp?value=<%=tag_data.getPopularTagsAsList().get(i) %>" class="badge badge-tag d-inline"><%= tag_data.getPopularTagsAsList().get(i) %></a>
						<% } %>
					</div>

				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid col-sm-8 d-inline-block feed">

	</div>


	<!-- *************** RIGHT COLUMN *************** -->
	<div class="container d-flex justify-content-start border-left float-right col-sm-2 make-me-sticky">

		<div id="right-col" class="col-sm-12 px-0">

			<!-------- TRENDING EVENTS --------->
			<div id="trending-events" class="row d-flex col-sm-12 mt-3 mb-0 pb-0 px-3">
				<h5 class="tbg"><strong>Upcoming Events</strong></h5>
				<p id="sort-prompt" class="tbp col-sm-12 px-0 py-0 mb-3">Sorted by: date</p>

				<nav class="nav flex-column">
					<%
						ArrayList<Scenez_EventBean> eventsAttending = new ArrayList<Scenez_EventBean>();
						eventsAttending = event_Data.getEventNamesAsList(session.getAttribute("email").toString());
						int eventsSize = eventsAttending.size();
						for (int i = 0; i < eventsSize; i++) {
							if (i > 4)
								break;
					%>
					<!-- Event 1 -->
					<div class="mb-4 trending-event-instance">
						<a href="viewEvent.jsp?value=<%=eventsAttending.get(i).getId()%>">
							<h4 class="tbg trending-event-heading mb-0"><%=eventsAttending.get(i).getName()%></h4>
							<p class="tbg font-weight-bold mb-0" style="font-size: 0.8rem;">Event
								created by:</p> <span class="tbp" style="font-size: 0.8rem;"><%=usr_data.getFirstNameAsString(eventsAttending.get(i).getEmail()) + " "
						+ usr_data.getLastNameAsString(eventsAttending.get(i).getEmail())%></span>
						</a>
					</div>
					<%
						}
					%>
					<a href="#" id="see-more" class="mx-auto"><strong>See more</strong></a>
				</nav>
			</div>

			<!-------- CHAT --------->
			<div id="chat" class="col-sm-12 px-0">
				<div class="row d-flex justify-content-end align-items-center pt-1"
					style="border-top: 1px solid #707070;">
					<div class="col-sm-5 my-0">
						<h5 class="tbg"><strong>Chats</strong></h5>
					</div>
					<div class="col-sm-7 my-0 px-3 ">
						<a href="#" class="view-all-chats float-right">View all chats</a> <!-- view all chats -->
					</div>
				</div>
				<%
							ArrayList<Friend_Pair> users_friends = friends_data.getAllFriendsAsList(session.getAttribute("email").toString());
							for (int i = 0; i < users_friends.size(); i++)
							{
									
				%>
				<%	if (users_friends.get(i).getRequester().equals(session.getAttribute("email").toString())) { %>
				<!-- Friend 1 -->
				<a href="#" class="chat-link">
					<div class="row chat-box border-bottom py-2 d-flex justify-content-start align-items-center">
						<div class="col-sm-3">
							<img src="celebration.jpg" alt="" class="chat-pic">
						</div>
						<div class="col-sm-8">
							<h5 class="friend-name tbp mb-0"><%= usr_data.getFirstNameAsString(users_friends.get(i).getRequested()) + usr_data.getLastNameAsString(users_friends.get(i).getRequested())%></h5>
						</div>
					</div>
				</a>
			<% 		} else { %>
			<a href="#" class="chat-link">
					<div class="row chat-box py-2 d-flex justify-content-start align-items-center">
						<div class="col-sm-3">
							<img src="david.jpg" alt="" class="chat-pic">
						</div>
						<div class="col-sm-8">
							<h5 class="friend-name tbp mb-0"><%= usr_data.getFirstNameAsString( users_friends.get(i).getRequester()) + usr_data.getLastNameAsString(users_friends.get(i).getRequested())%></h5>
						</div>
					</div>
				</a>
								
									<% 		} 	%>
												
									<%  } %>

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