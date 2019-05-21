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
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
<head>
<title>EVENT KA NAAM | Scenez</title>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<!-- <link rel="stylesheet" type="text/css" href="mainfeed.css"> -->
<link rel="stylesheet" type="text/css" href="common.css">
<link rel="stylesheet" type="text/css" href="header.css">
<link rel="stylesheet" type="text/css" href="view_event.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
	integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
	crossorigin="anonymous">
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


	<!-- **************************************************************************************************** -->
	<!-- **************************************************************************************************** -->
	<!-- **************************************************************************************************** -->



	<div id="main-view-pane"
		class="container-fluid align-items-start col-sm-8 d-inline-block feed">
		<div id="event-title" class="row mb-2">
			<h4 style="color: #4E4E4E; font-weight: 600;"
				class="mx-auto display-4"><%=eventBean.getName()%></h4>
		</div>
		<hr class="end-of-post-hr mb-5">
		<div id="event-metadata" class="row  mx-auto align-items-start mt-2">
			<div id="cover-img" class="col-sm-5">
				<img src="celebration.jpg"
					class="img-responsive col-sm-12 px-0 event-pic">
			</div>

			<div id="event-metadata-text" class="col mt-4">
				<div class="row d-flex justify-content-between">
					<!-- <div class="col"> -->
					<div class="row col-sm-12 mb-2">
						<h5 class="tbg">Details:</h5>
					</div>
					<div class="col border-right mr-auto">
						<ul class="list-unstyled tbp">
							<li><strong class="tbg">Location:</strong> <%=location_data.getLocationSpecificsByID(eventBean.getLocation_id())%></li>
							<li><strong class="tbg">Date:</strong> <%=eventBean.getEvent_date()%></li>
							<li><strong class="tbg">Time:</strong> <%=eventBean.getStart_time()%></li>
						</ul>
					</div>
					<div class="col border-right ml-auto mr-auto">
						<ul class="list-unstyled tbp">
							<li><strong class="tbg">Capacity:</strong><%=eventBean.getCapacity()%></li>
							<li><strong class="tbg">Category:</strong> <%=eventBean.getCat_name()%>
							</li>
						</ul>
					</div>

					<!-- BUTTON -->
					<div
						class="col text-right pr-5 mr-5 d-flex align-items-center justify-content-center">
						<!-- DISABLED BUTTON -->
						<button class="btn-md btn reverse-btn disabled"
							data-toggle="tooltip" data-placement="top"
							title="You can give feedback after the event has taken place.">
							Give Feedback</button>

						<!-- NORMAL BUTTON -->
						<!-- <button class="btn-md btn reverse-btn">
                                Give Feedback
                            </button>												 -->
					</div>
				</div>
				<hr class="end-of-post-hr">
				<div class="row py-1">
					<div class="col-sm-12 d-flex justify-content-around my-2">
						<div class="col pl-0">
							<h5 class="d-inline tbg">
								You are: <span class="tbp font-weight-light">Going</span>
							</h5>
						</div>
						<div class="col d-flex align-items-center justify-content-start">
							<h5 class="d-inline mr-3 tbg">Mark as:</h5>
							<button class="btn btn-sm btn-outline-dark my-btn" type="button">Not
								Going</button>
						</div>
					</div>
				</div>
				<hr class="end-of-post-hr">
				<div class="row mx-auto align-items-center my-2">
					<h5 class="tbg">Tags</h5>
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
				<hr class="end-of-post-hr">
			</div>

		</div>
		<div id="event-description" class="row justify-content-center mx-auto">
			<div class="col-sm-10 mt-3">
				<h4 class="tbg">Description</h4>
				<p class="tbp"><%=eventBean.getDescription()%>.
				</p>
			</div>
		</div>

		<hr>

		<!--AREA FOR ALL POSTS RELATED TO THIS EVENT-->
		<div class="container">
			<div id="post-display" class="row justify-content-center">
				<div
					class="row mb-3 d-flex justify-content-around align-items-center">
					<div class="col-sm-12">
						<div class="row d-flex justify-content-around align-items-center">
							<h3 class="tbg mr-5">Posts on this event</h3>
							<a href="#add-new-post "><button class="btn my-btn ml-5">Add
									new post</button></a>
						</div>
					</div>

				</div>
				<div class="col-sm-10">
					<%
						ArrayList<Scenez_PostBean> eventPostLists = new ArrayList<Scenez_PostBean>();
						eventPostLists = post_data.getPostsofEventAsList(eventId);
						Iterator<Scenez_PostBean> iter = eventPostLists.iterator();
						while (iter.hasNext()) {
							if (eventPostLists.isEmpty())
								break;
							Scenez_PostBean currentPost = iter.next();
					%>
					<!--POST-->
					<div id="post-n" class="card">
						<!-- POST HEADER -->
						<div class="card-header">
							<div
								class="row d-flex justify-content-between align-items-center">
								<!-- PICTURE AND NAME -->
								<div class="col">
									<div
										class="row d-flex justify-content-start align-items-center">
										<a href="#"><img src="david.jpg" alt=""
											class="img-thumbnail post-thumb "></a> <a href="#"
											class="tbp"><h4 class="ml-3 tbp mb-0"><%=post_data.getFirstName(currentPost.getId()) + " " + post_data.getLastName(currentPost.getId())%></h4></a>
									</div>
								</div>
								<!-- DELETE BUTTON -->
								<div class="col">
									<button class="btn btn-danger btn-sm float-right"
										onclick='location.href="deletePost.jsp?value=<%=currentPost.getId()%>"'>Delete</button>
								</div>
							</div>
							<!-- END OF POST HEADER-->
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
											<button
												onclick='location.href="upvotePost.jsp?value=<%=currentPost.getId()%>"'
												class="btn btn-sm btn-outline-dark vote-btn" type="button">
												<span class="badge badge-pill my-badge mr-2"><%=post_data.getUpVoteCountForPost(currentPost.getId())%></span><i
													class="fas fa-long-arrow-alt-up"></i>
											</button>
											<button
												onclick='"downVotePost.jsp?value=<%=currentPost.getId()%>"'
												class="btn btn-sm btn-outline-dark vote-btn" type="button">
												<i class="fas fa-long-arrow-alt-down"></i><span
													class="badge badge-pill my-badge ml-2"><%=post_data.getDownVoteCountForPost(currentPost.getId())%></span>
											</button>
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
											<a href="#"><img src="dancing.jpg" alt=""
												class="img-thumbnail post-thumb "></a> <span class="tbg"><a
												href="#" class="tbp"><strong><%=comment_data.getFirstName(currCommentBean.getId()) + " "
							+ comment_data.getLastName(currCommentBean.getId()) + " "%></strong></a>
												replied:</span> <span class="col-sm-6 votes">
												<div class="btn-group" role="group"
													aria-label="Button group">
													<button
														onclick='location.href="upvote.jsp?value=<%=currCommentBean.getId()%>"'
														class="btn btn-sm btn-outline-dark vote-btn" type="button">
														<span class="badge badge-pill my-badge mr-2"><%=comment_data.getUpVoteCountForComment(currCommentBean.getId())%></span><i
															class="fas fa-long-arrow-alt-up"></i>
													</button>
													<button
														onclick='location.href="downVote.jsp?value=<%=currCommentBean.getId()%>"'
														class="btn btn-sm btn-outline-dark vote-btn" type="button">
														<i class="fas fa-long-arrow-alt-down"></i><span
															class="badge badge-pill my-badge ml-2"><%=comment_data.getDownVoteCountForComment(currCommentBean.getId())%></span>
													</button>
												</div>
											</span>
										</div>
										<div class="col d-flex align-items-center justify-content-end">
											<button
												onclick='location.href="deleteComment.jsp?value=<%=currCommentBean.getId()%>"'
												class="btn btn-danger btn-sm float-right">Delete</button>
										</div>
									</div>
									<div class="row d-flex justify-content-end pr-3">
										<span style="font-size: 0.6rem;"><%=currCommentBean.getTimestamp()%></span>
									</div>
								</div>
								<div class="card-body">
									<p class="card-text"><%=currCommentBean.getContent()%></p>
								</div>
							</div>
							<%
								}
							%>

							<!-- ADD COMMENT -->
							<form class="form" action="postComment.jsp">
								<div class="form-group col-sm-10 d-block mt-3 px-4">
									<div class="row my-2">
										<h5 class="tbg">Add new comment</h5>
									</div>
									<div class="row my-2">
										<label for="my-input">Post Content</label>
										<textarea id="my-input" name="post-content"
											class="form-control tbp" rows="3"></textarea>
									</div>
									<input type="hidden" name="postId"
										value=<%=currentPost.getId()%> />
									<div class="row my-2 justify-content-end">
										<button type="submit" class="btn btn-outline-dark my-btn">Post
											Comment</button>
									</div>
								</div>
							</form>

						</div>
						</div>
						<%
							}
						%>

					
				</div>
			</div>
			<div id="post-add" class="row justify-content-center">
				<form class="form" action="newPost.jsp">
					<div class="form-group col d-block">
						<div class="row my-2">
							<a href="" name="add-new-post"></a>
							<h4 class="tbg">Add new post</h4>
						</div>
						<div class="row my-2">
							<label for="">Post Title</label> <input id="" name="post-title"
								class="form-control" type="text">
						</div>
						<div class="row my-2">
							<label for="my-input">Post Content</label>
							<textarea id="my-input" name="post-content" class="form-control"
								rows="3"></textarea>
						</div>
						<input type="hidden" name="eventId" value=<%=eventBean.getId()%>>
						<div class="row my-2 justify-content-end">
							<button type="submit" class="btn btn-outline-dark my-btn">Make
								New Post</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<!-- FOOTER -->
		<footer
			class="footer container-fluid col-sm-12 justify-content-between mt-5 fixed"
			style="background-color: #303030;">

			<!-- LOGO -->
			<div class="row d-flex justify-content-betweens align-items-center">
				<div class="col-2 footer-logo d-block float-left ">
					<img src="logo.png">
				</div>

				<!-- INFO -->
				<div class="col links d-inline-block my-auto justify-content-around">
					<a href="#">HOME</a> <label for=""> | </label> <a href="#">ABOUT</a>
					<label for=""> | </label> <a href="#">SUPPORT</a> <label for="">
						| </label> <a href="#">CONTACT</a>
				</div>

				<!-- NEWSLETTER -->
				<div class="float-right col-2">
					<p class="mb-1 " style="letter-spacing: 1px;">JOIN OUR
						NEWSLETTER</p>
					<form action="#" id="newsletter" class="row align-items-center">
						<input type="email" id="newsletter-input"
							class="col-sm-8 bg-dark rounded form-control-sm border-1 px-2 ml-auto">
						<button
							class="btn btn-sm btn-outline-light text-light bg-transparent ml-auto mr-auto"
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

		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.slim.min.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
		<script
			src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
		<script>
			$(function() {
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
</body>

</html>