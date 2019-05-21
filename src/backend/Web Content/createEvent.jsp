<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="backend.Scenez_CATEGORY"%>
<%@page import="java.util.ArrayList"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>

<head>
<title>Create a Group | Scenez</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
	integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="common.css">
<link rel="stylesheet" type="text/css" href="createGroup.css">
<%
	Scenez_CATEGORY cat = new Scenez_CATEGORY();
	ArrayList<String> cat_list = cat.getCategories();
%>
</head>

<body>

	<div id="main-view-pane"
		class="container-fluid align-items-start col-sm-8 d-inline-block feed">
		<div id="event-title" class="row mb-2">
			<h4 style="color: #4E4E4E; font-weight: 400;"
				class="mx-auto display-4">Create your event</h4>
		</div>
		<hr class="end-of-post-hr mb-5">
		<form action="newEvent.jsp">
			<!-- Event info -->
			<div id="event-metadata" class="row align-items-start mx-auto">
				<!-- Image -->
				<div id="cover-img" class="col-sm-5">
					<!--                     <input type="file" name="image" id="image" style="display:none;"/> -->
					<img src="david.jpg"
						class="img-responsive col-sm-12 px-0 event-pic border-none">
					<div class="col-sm-12 mt-4">
						<div class="custom-file">
							<input type="file" class="custom-file-input"
								id="inputGroupFile01" aria-describedby="inputGroupFileAddon01">
							<label class="custom-file-label" for="inputGroupFile01">Choose
								cover image for this event</label>
						</div>
					</div>
				</div>

				<!-- DETAILS -->

				<div id="event-metadata-text" class="col">
					<div class="row">
						<div class="col">
							<h4 class="tbg font-weight-bold mb-4">Event Details</h4>

							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="event-name">
										<h6 class="tbg">Event Name*:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<input type="text" required class="form-control"
										name="event_name" id="event-name"
										placeholder="Enter a name for your event">
								</div>
							</div>
							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="location">
										<h6 class="tbg">Location*:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<input type="text" required class="form-control"
										name="location" id="location" placeholder="Enter a location">
								</div>
							</div>

							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="capacity">
										<h6 class="tbg">Capacity:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<input type="number" class="form-control" name="capacity"
										id="capacity"
										placeholder="Enter the max capacity for this event">
								</div>
							</div>

							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="privacy">
										<h6 class="tbg">Privacy:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<select class="form-control" name="privacy"
										id="exampleFormControlSelect1">
										<option>Public</option>
										<option>Invite</option>
										<option>Private</option>
									</select>
								</div>
							</div>

							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="date">
										<h6 class="tbg">Date*:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<input type="date" required class="form-control" name="date"
										id="location">
								</div>
							</div>

							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="time">
										<h6 class="tbg">Time*:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<input type="time" required class="form-control" name="time"
										id="location">
								</div>
							</div>

							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="duration">
										<h6 class="tbg">Approximate Duration*:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<input type="number" required class="form-control"
										name="duration" id="location">
								</div>
							</div>

							<div class="row align-items-center">
								<div class="col-sm-3 my-2">
									<label for="category">
										<h6 class="tbg">Category*:</h6>
									</label>
								</div>
								<div class="col-sm-9">
									<select class="form-control" name="category"
										id="exampleFormControlSelect1">
										<%
											for (int count = 0; count < cat_list.size(); count++) {
										%>
										<option><%=cat_list.get(count)%></option>
										<%
											}
										%>

									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row mx-auto align-items-center">
						<div class="form-group col px-0">
							<label for="tags">
								<h6 class="tbg">Tags*:</h6>
							</label>
							<textarea name="tags" required class="form-control" rows="3"
								placeholder="Enter a comma-separated list of tags here (200 characters max). . ."
								maxlength="200"></textarea>
						</div>
					</div>
				</div>

			</div>

			<div id="event-description" class="container-fluid">
				<div class="row align-items-center  ">
					<div class="col-sm-12">
						<div class="form-group">
							<label for="event-description">
								<h6 class="tbg">Enter a description for this event*</h6>
							</label>
							<textarea name="description" required id="event-description"
								class="form-control"
								placeholder="Please enter a description here..." rows="3"></textarea>
						</div>
					</div>
				</div>
				<div class="row my-2 justify-content-end mx-auto">
					<input type="submit" class="btn btn-outline-dark my-btn">Create
					Event
					</button>
				</div>
			</div>
		</form>
	</div>


	<!-- FOOTER -->


</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
	integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"
	integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"
	integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1"
	crossorigin="anonymous"></script>

</html>