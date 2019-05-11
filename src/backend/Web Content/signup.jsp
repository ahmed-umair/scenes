<!DOCTYPE html>
<html>
<head>
	<title>Sign up | Scenez</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="signup.css">
	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />

	
</head>
<body>
	<nav class="navbar navbar-light" style="background-color: #2A0055;">
	  <a class="navbar-brand" href="#"><img src="logo.png"></a>
	  <form class="form">
	  	<div>
	  		<!-- <span class="normalText" style="font-size: 28px;">Login</span> -->
	  		<span class="normalText" id="signupSuggestion" style="font-size: 1em;">Don't have an account? <br> Join Scenez today. <a href="/signup"><span class="link">Sign up.</span></a></span>
	  	</div>
	    <input class="form-control mr-sm-2" type="search" placeholder="username..." aria-label="Search">
	    <input class="form-control mr-sm-2" type="search" placeholder="password..." aria-label="Search">

	    <a href="#" class="link" style="float: left; font-size: 13px; padding-left: 5px; padding-top: 5px;">Forgot your password?</a>
	    <button class="btn btn-outline-light btn-login" type="submit">Login</button>
	  </form>
	</nav>

	<!-- ------------------------------------------------------------------------------------------ -->

	<div class="container col-lg-6 justify-content-center ml-auto">
		<h2 style="color: #707070; margin-bottom: 30px;">Get started with a free account</h2>
		<form action="newAccount.jsp">
			<div class="row">
				<div class="column col-sm-6 border-right">
					<div>
						<label>First Name</label>
						<br>
						<input type="text" name="fname" class="form-input form-control col-sm-9 py-0 mb-2">
					</div>
					<div>
						<label>Last Name</label>
						<br>
						<input type="text" name="lname" class="form-input form-control col-sm-9 py-0 mb-2">
					</div>
					<div>
						<label>Email</label>
						<br>
						<input type="text" name="email" class="form-input form-control col-sm-9 py-0 mb-2">
					</div>
					<div>
						<label>Password</label>
						<br>
						<input type="password" name="password" class="form-input form-control col-sm-9 py-0 mb-2">
					</div>								
				</div>
				<div class="column ml-auto ">
					<div class="col-sm-12 pl-0">
						<label>Gender</label>
						<br>
						<div class="btn-group dropright ml-0">
                            <select name="gender" id="gender" class="btn btn-secondary col-sm-12 form-control bg-white text-dark py-0 mb-2">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
							<!-- <button type="button" class="btn btn-secondary dropdown-toggle col-sm-12" data-toggle="dropdown"></button>		
  							<ul class="dropdown-menu">
							    <li><a class="dropdown-item" href="#">Male</a></li>
							    <li><a class="dropdown-item" href="#">Female</a></li>							    
                            </ul>					 -->
                            <!-- <input type="text" class="form-input form-control col-sm-9"> -->
						</div>
					</div>
					<div>
						<label>Date of Birth</label>
						<br>
						<input type="date" name="bday" class="form-input form-control col-sm-12 py-0 mb-2">
					</div>
					<div>
						<label>Profile Picture</label>
						<br>
						<i class="fa fa-camera"></i>
					</div>
				</div>
			</div>
			<br>
			<div class="container col-sm-3 float-center " >
				<input type="submit" name="submit-form" class="submit-buttons col-sm-10">
				<button class="submit-buttons col-sm-10" >Cancel</button>
			</div>
		</form>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

</body>
</html>
