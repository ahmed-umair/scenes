<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="backend.Scenez_GRP"%>
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
</head>

<body>
	<div class="container">
		<%
			String grp_name = "", grp_desc = "", email = "";
			int status = 0; // 1 = creation success, 2 = invalid parameter, 3 = Query Execution Failure, 4 = group already exists

			if (request.getParameter("grp_name") != null) {
				grp_name = request.getParameter("grp_name");
				System.out.print(grp_name + "\n");
			} else {
				status = 2;
			}

			if (request.getParameter("grp_desc") != null) {
				grp_desc = request.getParameter("grp_desc");
				System.out.print(grp_desc + "\n");
			} else {
				status = 2;
			}

			if (status != 2) {

				Scenez_GRP grp_table = new Scenez_GRP();
				email = (String) session.getAttribute("email");
				// Check if email already exists
				if (grp_table.checkUniqueGrpName(grp_name, email) == true) {
					if (grp_table.addNewGroup(grp_name, grp_desc, email)) {
						response.sendRedirect("createGroup.jsp");
					} else
						status = 3;
				} else
					status = 4;
			}
		%>

		<%
			if (status == 2) {
		%>
		<br>
		<div class="alert alert-danger">
			<strong>Alert!</strong> Invalid Parameters Entered
		</div>
		<button class="btn btn-default" onclick="location.href='index.jsp'">Retry</button>
		<%
			response.sendRedirect("createGroup.jsp");
		%>
		<%
			}
		%>

		<%
			if (status == 3) {
		%>
		<br>
		<div class="alert alert-danger">
			<strong>Alert!</strong> Data that has reached the server in invalid
		</div>
		<button class="btn btn-default"
			onclick="location.href='newGroup.jsp'">Retry</button>
		<%
			}
		%>

		<%
			if (status == 4) {
		%>
		<div class="alert alert-warning alert-dismissible fade show"
			role="alert">
			<button type="button" class="close"
				onclick="location.href='newGroup.jsp'" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<strong>A group you created already has the same name</strong>
		</div>
		<%
			}
		%>
	
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