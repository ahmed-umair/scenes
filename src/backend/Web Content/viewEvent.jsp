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
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css">
    <link rel="stylesheet" type="text/css" href="common.css">
    <link rel="stylesheet" type="text/css" href="view_event.css">
    <title>View Event | Scenez</title>
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
                    <h5 class="to-be-grey"><strong>My Groups</strong></h5>
                </div>
                <nav class="nav flex-column">
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

    <div id="main-view-pane" class="container-fluid align-items-start col-sm-8 d-inline-block feed">
        <div id="event-title" class="row ">
            <h2 style="color: #4E4E4E; font-weight: 700;" class="mx-auto"><%= event_Data.getEventNameAsSingle(eventId) %></h2>
        </div>
        <div id="event-metadata" class="row  mx-auto align-items-center">
            <div id="cover-img" class="col">
                <img src="image.jpg" class="img-responsive col-sm-12">
            </div>

            <div id="event-metadata-text" class="col ">
                <div class="row ">
                    <div class="col">
                        <h6>Details:</h6>
                        <ul class="list-unstyled">
                            <li>Location: <%= location_data.getLocationSpecificsByID(eventBean.getLocation_id()) %></li>
                            <li>Date: <%= eventBean.getEvent_date() %></li>
                            <li>Time: <%= eventBean.getStart_time() %></li>
                        </ul>
                    </div>
                </div>
                <div class="row py-1">
                    <div class="col-sm-12">
                        <h6 class="d-inline">You are: Going</h6>
                        <h6 class="d-inline">Mark as: </h6>
                        <button class="btn btn-sm btn-outline-dark" type="button">Going</button>
                    </div>
                </div>
                <div class="row mx-auto align-items-center">
                    <h6>Tags</h6>
                    <p>
                    	<%
                    		ArrayList<String> tagList = event_Data.getEventTagsAsList(eventId);
                    		Iterator<String> it = tagList.iterator();
                    		
                    		while(it.hasNext()){
                    			String currTag = it.next();
                    	%>
                    			<%= "#" + currTag + " " %>
                    	<%
                    		}
                    	%>
                    </p>
                </div>
            </div>

        </div>
        <div id="event-description" class="row justify-content-center mx-auto">
            <div class="col-sm-10">
                <h6>Description</h6>
                <p>
                	<%= eventBean.getDescription() %>
                </p>
            </div>

        </div>


        <!--AREA FOR ALL POSTS RELATED TO THIS EVENT-->
        <div id="post-display" class="row justify-content-center">
            <div class="row">
                <div class="col">
                    <h4>Posts on this event</h4>
                </div>

            </div>
            <%
            	ArrayList<Scenez_PostBean> eventPostLists = new ArrayList<Scenez_PostBean>();
            	eventPostLists = post_data.getPostsofEventAsList(eventId);
            	Iterator<Scenez_PostBean> iter = eventPostLists.iterator();
            	while(iter.hasNext()) {
            		if(eventPostLists.isEmpty())
            			break;
            		Scenez_PostBean currentPost= iter.next();
            %>
            <div class="col-sm-10">
                <!--POST-->
                <div id="post-n" class="card">
                    <div class="card-header">
                      <%= post_data.getFirstName(currentPost.getId()) + " " + post_data.getLastName(currentPost.getId()) %>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><%= currentPost.getTitle() %></h5>
                        <p class="card-text"><%= currentPost.getContent() %></p>
                    </div>
                    <div class="card-footer">
                        <span>Post Metadata</span>
                        <span class="col-sm-6 votes">
                            <div class="btn-group" role="group" aria-label="Button group">
                                <button class="btn btn-sm btn-outline-dark vote-btn" type="button">Upvote</button>
                                <button class="btn btn-sm btn-outline-dark vote-btn" type="button">Downvote</button>
                            </div>
                        </span>
                    </div>
                </div>
                <!--COMMENTS AREA FOR THE ABOVE POST-->
                <div class="row justify-content-end">
                    <div class="col-sm-10">
                        <!--INDIVIDUAL COMMENT-->
                        <div class="card my-2">
                        <%
	                        ArrayList<Scenez_CommentBean> commentList= new ArrayList<Scenez_CommentBean>();
	                        commentList = comment_data.getCommentsOfPostAsList(currentPost.getId());
	                    	Iterator<Scenez_CommentBean> iterate = commentList.iterator();
	                    	
	                    	while(iterate.hasNext()) {
	                    		if(commentList.isEmpty())
	                    			break;
	                    		Scenez_CommentBean currCommentBean = iterate.next();	
	                    	
                        %>
                            <div class="card-header">
                                <span>
                                 <%= comment_data.getFirstName(currCommentBean.getId()) + " " + comment_data.getLastName(currCommentBean.getId()) + " " %>replied:</span>
                                <span class="col-sm-6 votes">
                                    <div class="btn-group" role="group" aria-label="Button group">
                                        <button class="btn btn-sm btn-outline-dark vote-btn"
                                            type="button">Upvote</button>
                                        <button class="btn btn-sm btn-outline-dark vote-btn"
                                            type="button">Downvote</button>
                                    </div>
                                </span>
                            </div>
                            <div class="card-body">
                                <p class="card-text"><%=currCommentBean.getContent() %></p>
                            </div>
                            <% } %>
                        </div>
                    <div class="form-group col-sm-10 d-block">
                        <div class="row my-2">
                            <h6>Reply to Post</h6>
                        </div>
                        <div class="row my-2">
                            <label for="my-input">Comment</label>
                            <form class="form" action="postComment.jsp">
                            <textarea id="my-input" name=<%currentPost.getId(); %> class="form-control" rows="3"></textarea>
                            </form>
                        </div>
                        <div class="row my-2 justify-content-end">
                            <button type="submit" class="btn btn-outline-dark my-btn">Post Comment</button>
                        </div>
                    </div>
                    <% } %>
                </div>
                <div id="post-add" class="row justify-content-center">
                    <div class="form-group col-sm-12 d-block">
                        <div class="row my-2">
                            <h4>Add new post</h4>
                        </div>
                        <div class="row my-2">
                            <label for="">Post Title</label>
                            <input id="" name="post-title" class="form-control" type="text">
                        </div>
                        <div class="row my-2">
                            <label for="my-input">Post Content</label>
                            <textarea id="my-input" name="post-content" class="form-control" rows="3"></textarea>
                        </div>
                        <div class="row my-2 justify-content-end">
                            <button type="submit" class="btn btn-outline-dark my-btn">Make New Post</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- *************** RIGHT COLUMN *************** -->
    <div class="container d-flex justify-content-start border-left float-right col-lg-2 make-me-sticky">
        <div id="right-col" class="col-lg-12 mr-2 ">
            <div id="trending-events" class="row d-flex col-lg-12 mt-4 mb-4 border-bottom pb-4">
                <h5 class="to-be-grey"><strong>My Events</strong></h5>
                <nav class="nav flex-column">
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
                <h5 class="to-be-grey"><strong>Chats Here</strong></h5>
                <nav class="nav flex-column">
						<%
							ArrayList<Friend_Pair> users_friends = friends_data.getAllFriendsAsList(session.getAttribute("email").toString());
							for (int i = 0; i < users_friends.size(); i++)
							{
									
						%>
						<% 		if (users_friends.get(i).getRequester().equals(session.getAttribute("email").toString())) { %>
									<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> <%= usr_data.getFirstNameAsString(users_friends.get(i).getRequested()) + usr_data.getLastNameAsString(users_friends.get(i).getRequested())%></a>
						<% 		} else {%>
									<a class="nav-link row tbp" href="#"><i class="fas fa-users"></i> <%= usr_data.getFirstNameAsString( users_friends.get(i).getRequester()) + usr_data.getLastNameAsString(users_friends.get(i).getRequested())%></a>
						<% 		} 	%>
									
						<%  } %>
                </nav>
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