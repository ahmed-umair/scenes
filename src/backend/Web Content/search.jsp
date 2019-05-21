<%@page import="backend.Scenez_USERBEAN"%>
<%@page import="backend.Scenez_SEARCH"%>
<%@page import="backend.Scenes_USER"%>
<%@page import="backend.Friend_Pair"%>
<%@page import="backend.Scenez_IS_FRIENDS_WITH"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="backend.Scenez_Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<<!DOCTYPE html>
<html>

<head>
	<title>Search Results | Scenez</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<!-- <link rel="stylesheet" type="text/css" href="mainfeed.css"> -->
	<link rel="stylesheet" type="text/css" href="common.css">
        <link rel="stylesheet" type="text/css" href="header.css">
        <link rel="stylesheet" type="text/css" href="members_common.css">
	<link rel="stylesheet" type="text/css" href="searchresults.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
		integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
</head>

<body>
	<%
		Scenez_Connection global_Connection = new Scenez_Connection();
		Scenes_USER usr_data = new Scenes_USER(global_Connection.getConnection());
		Scenez_IS_FRIENDS_WITH friends_data = new Scenez_IS_FRIENDS_WITH(global_Connection.getConnection());
		Scenez_SEARCH search_user = new Scenez_SEARCH(global_Connection.getConnection());
		
		// Event ID and corressponding bean
		String searchCriteria = request.getParameter("searchBar");
		System.out.println("ERROR CHECKING -->" + searchCriteria);

		
	%>
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
				<div class="col">
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
					<nav class="nav col-sm-12 mx-auto">
						<div class="row align-items-center">
							<a class="nav-link tbp" href="#"><i class="fas fa-users mr-2"></i>Orgy Central</a>
						</div>
						<div class="row">
							<a class="nav-link tbp" href="#"><i class="fas fa-users mr-2"></i>Assault on Aayan Nusrat's
								House</a>
						</div>
						<div class="row">
							<a class="nav-link tbp" href="#"><i class="fas fa-users mr-2"></i>Lez go partayy</a>
						</div>
						<div class="row">
							<a class="nav-link tbp" href="#"><i class="fas fa-users mr-2"></i>Getting collective FZ in
								EEE</a>
						</div>
					</nav>
					<div class="row">
						<div class="col-sm-12">
							<a href="#" id="see-more" class="link"><strong>See more</strong></a>
						</div>
					</div>
				</div>
				<!-- LIST OF GROUPS -->
				<div class="row">
					<div class="col-sm-12">
						<button id="create-group-btn" class="btn btn-sm btn-outline-dark mt-3 col mx-auto my-btn">Create
							Group</button>
					</div>

				</div>

			</div>

			<!-------- POPULAR TAGS --------->
			<div id="pop-tags" class="row d-flex">
				<!-- HEADING -->
				<div class="row">
					<h5 class="tbg col"><strong>Popular Tags</strong></h5>
				</div>

				<div class="row">
					<div class="col-sm-10">
						<a href="#" class="badge badge-tag d-inline">Primary</a>
						<a href="#" class="badge badge-tag d-inline">Secondary</a>
						<a href="#" class="badge badge-tag d-inline">Success</a>
						<a href="#" class="badge badge-tag d-inline">Danger</a>
						<a href="#" class="badge badge-tag d-inline">Warning</a>
						<a href="#" class="badge badge-tag d-inline">Info</a>
						<a href="#" class="badge badge-tag d-inline">Light</a>
						<a href="#" class="badge badge-tag d-inline">Dark</a>
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

					<!-- Event 1 -->
					<div class="mb-4 trending-event-instance">
						<a href="#">
							<h4 class="tbg trending-event-heading mb-0">John Smith's Concert</h4>
							<p class="tbg font-weight-bold mb-0" style="font-size: 0.8rem;">Event created by: </p>
							<span class="tbp" style="font-size: 0.8rem;">Ankara Concert Association</span>
						</a>
					</div>

					<!-- Event 2 -->
					<div class="mb-4">
						<a href="#">
							<h4 class="tbg trending-event-heading mb-0">Bilkent vs. NUST</h4>
							<p class="tbg font-weight-bold mb-0" style="font-size: 0.8rem;">Event created by: </p>
							<span class="tbp" style="font-size: 0.8rem;">Bilkent Football Club</span>
						</a>
					</div>

					<!-- Event 3 -->
					<div class="mb-4">
						<a href="#">
							<h4 class="tbg trending-event-heading mb-0">Women's March</h4>
							<p class="tbg font-weight-bold mb-0" style="font-size: 0.8rem;">Event created by: </p>
							<span class="tbp" style="font-size: 0.8rem;">Women Rights Association</span>
						</a>
					</div>

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

				<!-- Friend 1 -->
				<a href="#" class="chat-link">
					<div class="row chat-box border-bottom py-2 d-flex justify-content-start align-items-center">
						<div class="col-sm-3">
							<img src="celebration.jpg" alt="" class="chat-pic">
						</div>
						<div class="col-sm-8">
							<h5 class="friend-name tbp mb-0">Tamim Akhtar</h5>
						</div>
					</div>
				</a>

				<!-- Friend 2 -->
				<a href="#" class="chat-link">
					<div class="row chat-box py-2 d-flex justify-content-start align-items-center">
						<div class="col-sm-3">
							<img src="david.jpg" alt="" class="chat-pic">
						</div>
						<div class="col-sm-8">
							<h5 class="friend-name tbp mb-0">Hamza Ashfaq</h5>
						</div>
					</div>
				</a>

				<!-- Friend 3 -->
				<a href="#" class="chat-link">
					<div class="row chat-box py-2 d-flex justify-content-start align-items-center">
						<div class="col-sm-3">
							<img src="bandi.jpg" alt="" class="chat-pic">
						</div>
						<div class="col-sm-8">
							<h5 class="friend-name tbp mb-0">Rameez Hashmi</h5>
						</div>
					</div>
				</a>

				<!-- Friend 4 -->
				<a href="#" class="chat-link">
					<div class="row chat-box py-2 d-flex justify-content-start align-items-center">
						<div class="col-sm-3">
							<img src="dancing.jpg" alt="" class="chat-pic">
						</div>
						<div class="col-sm-8">
							<h5 class="friend-name tbp mb-0">Talha Zeeshan</h5>
						</div>
					</div>
				</a>

			</div>
		</div>
	</div>





        <!-- *************** FEED *************** -->
        
        <!-- HEADING -->
		<div class="container-fluid col-lg-8 d-inline-block feed pl-3">
			<div class="d-flex justify-content-start  align-items-center mt-4 mb-0 pb-0 pl-3 row">
                <h2 style="color: #4E4E4E; font-weight: 700;" class="mr-2">Showing search results for: </h2>
                <h2 id="search-query"><%=searchCriteria %></h2>
            </div>

            <hr>

            <!-- SORTING AREA -->
            <div class="d-flex justify-content-center sort-div">
                <div class="d-flex justify-content-between col-sm-12 align-items-center mt-2 mb-2 pb-0 row">
                    <div class="col">
                        <label for="" class="tbg mr-3" style="font-weight: 700;">Search Type</label>
                        <select name="search-type" id="" class="rounded">
                            <option value="events">Events</option>
                            <option value="groups">Groups</option>
                            <option value="users">Users</option>
                        </select>
                    </div>  
                    <div class="col">
                        <label for="" class="tbg mr-3" style="font-weight: 700;">Category</label>
                        <select name="category" id="" class="rounded">
                            <option value="porn">American Porn</option>
                            <option value="">Bolivian Porn</option>
                        </select>
                    </div>
                    <div class="col my-auto">
                        <label for="" class="tbg mr-3" style="font-weight: 700;">Sort By</label>
                        <select name="sort" id="" class="rounded p-auto">
                            <option value="asc-alphabetical">Asc: Alphabetical A-Z</option>
                            <option value="desc-alphabetical">Des: Alphabetical A-Z</option>
                            <option value="asc-date">Asc: Date</option>
                            <option value="desc-date">Des: Date</option>
                            
								</select>
								<button class="btn btn-sm reverse-btn float-right">Apply</button>
                    </div>
                </div>
                
            </div>
            <hr>
            
            <%
            	ArrayList<Scenez_USERBEAN> userBean = new ArrayList<Scenez_USERBEAN>();
            	userBean = search_user.searchUser(searchCriteria);
            	Iterator<Scenez_USERBEAN> iter = userBean.iterator();
            	
            	while(iter.hasNext()){
            		Scenez_USERBEAN currUserBean = iter.next();
            	
            %>

            <div class="container col-lg-12 d-inline-block px-0">

					<!-- USER 1 -->
                <a href="#" class="friend-row d-block p-2 border-bottom">
                    <div class="row d-flex align-items-center ">
                        <div class="col-sm-2 text-center">
                            <img src="david.jpg" alt="" class="img-thumbnail header-thumb">
                        </div>
                        <div class="col-sm-10">
                            <h5 class="display-4 page-friend-name tbp"><%=currUserBean.getFirst_name() + " " + currUserBean.getLast_name()%></h5>
                        </div>
                        <!-- Image and link to profile- backend -->
                    </div>
					 </a>
					 
					
					
        
        
        
        
				</div>
				<% } %>
			</div>
				
			

	<!-- FOOTER -->
	
	

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