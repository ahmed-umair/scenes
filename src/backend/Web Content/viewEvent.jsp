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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
	<title>Event_Page | Scenez</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<!-- <link rel="stylesheet" type="text/css" href="mainfeed.css"> -->
	<link rel="stylesheet" type="text/css" href="common.css">
    <link rel="stylesheet" type="text/css" href="header.css">
    <link rel="stylesheet" type="text/css" href="view_event.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
		integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
</head>

<body>
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

	// Event ID and corressponding bean
	int eventId = Integer.parseInt(request.getParameter("value"));

	Scenez_EventBean eventBean = event_Data.getSingleEventBean(eventId);
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
						<%
							int x = 0;
							int size = grp_data.getGroupNamesAsLinkedList(session.getAttribute("email").toString()).size();
							for (; x < size; x++) {
								if (x > 4)
									break;
						%>
						<div class="row align-items-center">
							<a class="nav-link tbp" href="#"><i class="fas fa-users mr-2"></i><%=grp_data.getGroupNamesAsLinkedList(session.getAttribute("email").toString()).get(x)%></a>
						</div>
						<%
							}
						%>
						<%
							if (x > 4) {
						%>
						<div class="row">
							<div class="col-sm-12">
							<a href="#" id="see-more" class="link"><strong>See more</strong></a>
							</div>
						</div>
						<%
							}
						%>	
					</nav>
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
				
				<%
					for (int i = 0; i < tag_data.getPopularTagsAsList().size(); i++) {
						if (i > 4)
							break;
				%>
					<div class="row">
						<div class="col-sm-10">
							<a href="#" class="badge badge-tag d-inline"><%=tag_data.getPopularTagsAsList().get(i)%></a>
						</div>
					</div>
				<%
					}
				%>

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
				<h5 class="tbg"><strong>My Events</strong></h5>
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
							<a href="#">
								<h4 class="tbg trending-event-heading mb-0"><%=eventsAttending.get(i).getName()%></h4>
								<p class="tbg font-weight-bold mb-0" style="font-size: 0.8rem;">Event created by: </p>
								<span class="tbp" style="font-size: 0.8rem;"><%=usr_data.getFirstNameAsString(eventsAttending.get(i).getEmail()) + " " + usr_data.getLastNameAsString(eventsAttending.get(i).getEmail())  %></span>
							</a>
						</div>
						<% } %>
						<div class="row">
							<div class="col-sm-12">
							<a href="#" id="see-more" class="link"><strong>See more</strong></a>
							</div>
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

    
    <div id="main-view-pane" class="container-fluid align-items-start col-sm-8 d-inline-block feed">
        <div id="event-title" class="row mb-2">
            <h4 style="color: #4E4E4E; font-weight: 600;" class="mx-auto display-4"><%=eventBean.getName()%></h4>
        </div>
        <hr class="end-of-post-hr mb-5">
        <div id="event-metadata" class="row  mx-auto align-items-center mt-2">
            <div id="cover-img" class="col">
                <img src="image.jpg" class="img-responsive col-sm-12">
            </div>

            <div id="event-metadata-text" class="col ">
                <div class="row ">
                    <div class="col">
                        <h5 class="tbg">Details:</h5>
                        <ul class="list-unstyled tbp">
                            <li>Location: <%=location_data.getLocationSpecificsByID(eventBean.getLocation_id())%></li>
                            <li>Date: <%=eventBean.getEvent_date()%></li>
                            <li>Time: <%=eventBean.getStart_time()%></li>
                        </ul>
                    </div>
                </div>
                <div class="row py-1">
                    <div class="col-sm-12 d-flex justify-content-around mb-3">
                        <div class="col pl-0">
                            <h5 class="d-inline tbg">You are: <span class="tbp font-weight-light">Going</span></h5>
                        </div>
                        <div class="col d-flex align-items-center justify-content-start">
                            <h5 class="d-inline mr-3 tbg">Mark as: </h5>
                            <button class="btn btn-sm btn-outline-dark my-btn" type="button">Not Going</button>
                        </div>
                    </div>
                </div>
                <div class="row mx-auto align-items-center">
                    <h6>Tags</h6>
                    <p class="tbp">
                    	<%
							ArrayList<String> tagList = event_Data.getEventTagsAsList(eventId);
							Iterator<String> it = tagList.iterator();

							while (it.hasNext()) {
								String currTag = it.next();
						%>
						<%="#" + currTag + " "%>
						<%
							}
						%>
                    </p>
                </div>
            </div>

        </div>
        <div id="event-description" class="row justify-content-center mx-auto">
            <div class="col-sm-10 mt-3">
                <h4 class="tbg">Description</h4>
                <p class="tbp"><%=eventBean.getDescription() %></p>
            </div>
        </div>

        <hr>

        <!--AREA FOR ALL POSTS RELATED TO THIS EVENT-->
        <div class="container">
            <div id="post-display" class="row justify-content-center">
                <div class="row mb-3">
                    <div class="col">
                        <h3 class="tbg"> Posts on this event</h3>
                    </div>

                </div>
                <%
					ArrayList<Scenez_PostBean> eventPostLists = new ArrayList<Scenez_PostBean>();
					eventPostLists = post_data.getPostsofEventAsList(eventId);
					Iterator<Scenez_PostBean> iter = eventPostLists.iterator();
					while (iter.hasNext()) {
						if (eventPostLists.isEmpty())
							break;
						Scenez_PostBean currentPost = iter.next();
				%>
                <div class="col-sm-10">
                    <!--POST-->
                    <div id="post-n" class="card">
                        <!-- POST HEADER -->
                        <div class="card-header">
                            <div class="row d-flex justify-content-between align-items-center">
                                <!-- PICTURE AND NAME -->
                                <div class="col">
                                    <div class="row d-flex justify-content-start align-items-center">
                                        <a href="#" ><img src="david.jpg" alt="" class="img-thumbnail post-thumb "></a>
                                        <a href="#" class="tbp"><h4 class="ml-3 tbp mb-0"><%=post_data.getFirstName(currentPost.getId()) + " " + post_data.getLastName(currentPost.getId())%></h4></a> 
                                    </div>
                                </div>
                                <!-- DELETE BUTTON -->
                                <div class="col">
                                    <button class="btn btn-danger btn-sm float-right">Delete</button>
                                </div>
                            </div> <!-- END OF POST HEADER-->
                        </div>

                        <!-- CARD BODY -->
                        <div class="card-body">
                            <h4 class="card-title tbg"><%=currentPost.getTitle()%></h4>
                            <p class="card-text"><%=currentPost.getContent()%></p>
                        </div>

                        <!-- CARD FOOTER -->
                        <div class="card-footer">
                            <div class="row d-flex justify-content-between">
                                <div class="col">
                                    <span class="tbg font-weight-bold">2 hours ago</span>
                                </div>
                                <div class="col d-flex justify-content-end">
                                    <span class="col-sm-6 votes pr-0">
                                        <div class="btn-group" role="group" aria-label="Button group">
                                            <!-- <span><i class="fas fa-caret-up"></i> 21</span> -->
                                            <a href="upvotePost.jsp?value=<%=currentPost.getId()%>" class="btn btn-sm btn-outline-dark vote-btn" type="button"><span class="badge badge-pill my-badge mr-2">21</span>Upvote</a>
                                            <a href="downVotePost.jsp?value=<%=currentPost.getId()%>" class="btn btn-sm btn-outline-dark vote-btn" type="button">Downvote<span class="badge badge-pill my-badge ml-2">7</span></a>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--COMMENTS AREA FOR THE ABOVE POST-->
                    <div class="row justify-content-end">
                        <div class="col-sm-10">
                        <%
							ArrayList<Scenez_CommentBean> commentList = new ArrayList<Scenez_CommentBean>();
							commentList = comment_data.getCommentsOfPostAsList(currentPost.getId());
							Iterator<Scenez_CommentBean> iterate = commentList.iterator();

							while (iterate.hasNext()) {
								if (commentList.isEmpty())
									break;
							Scenez_CommentBean currCommentBean = iterate.next();
						%>
                            <!--INDIVIDUAL COMMENT-->
                            <div class="card my-2">
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-sm-9">
                                            <a href="#" ><img src="dancing.jpg" alt="" class="img-thumbnail post-thumb "></a>
                                            <span class="tbg"><a href="#" class="tbp"><strong><%=comment_data.getFirstName(currCommentBean.getId()) + " "
														+ comment_data.getLastName(currCommentBean.getId()) + " "%></strong></a> replied:</span>                                                                            
                                            <span class="col-sm-6 votes">
                                                <div class="btn-group" role="group" aria-label="Button group">
                                                        <a  href="upvote.jsp?value=<%=currCommentBean.getId()%>" class="btn btn-sm btn-outline-dark vote-btn" type="button"><span class="badge badge-pill my-badge mr-2">21</span>Upvote</a>
                                                        <a href="downVote.jsp?value=<%=currCommentBean.getId()%>" class="btn btn-sm btn-outline-dark vote-btn" type="button">Downvote<span class="badge badge-pill my-badge ml-2">7</span></a>
                                                </div>
                                            </span>
                                        </div>
                                        <div class="col">
                                            <button class="btn btn-danger btn-sm float-right">Delete</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <p class="card-text"><%=currCommentBean.getContent()%></p>
                                </div>
                                <%
									}
								%>
                            </div>
                        </div>
                         <!--NEW INDIVIDUAL COMMENT-->
                        <form class="form" action="postComment.jsp">
	                        <div class="form-group col-sm-10 d-block">
	                            <div class="row my-2">
	                                <h6>Add new comment</h6>
	                            </div>
	                            <div class="row my-2">
	                                <label for="my-input">Post Content</label>
	                                <textarea id="my-input" name="reply" class="form-control" rows="3"></textarea>
	                                <input type="hidden" name="postId" value=<%=currentPost.getId()%>>
	                            </div>
	                            <div class="row my-2 justify-content-end">
	                                <button type="submit" class="btn btn-outline-dark my-btn">Post Comment</button>
	                            </div>
	                        </div>
	                     </form>
	                     <%
							}
						 %>
                    </div>
                    <div id="post-add" class="row justify-content-center">
                        <div class="form-group col-sm-12 d-block">
                            <div class="row my-2">
                                <h4>Add new post</h4>
                            </div>
                            <form class="form" action="newPost.jsp">
	                            <div class="row my-2">
	                                <label for="">Post Title</label>
	                                <input id="" name="post-title" class="form-control" type="text">
	                                <input type="hidden" name="eventId" value=<%=eventBean.getId()%>>
	                            </div>
	                            <div class="row my-2">
	                                <label for="my-input">Post Content</label>
	                                <textarea id="my-input" name="post-content" class="form-control" rows="3"></textarea>
	                            </div>
	                            <div class="row my-2 justify-content-end">
	                                <button type="submit" class="btn btn-outline-dark my-btn">Make New Post</button>
	                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- FOOTER -->
    <footer class="footer container-fluid col-sm-12 justify-content-between mt-5 fixed"
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>

</html>