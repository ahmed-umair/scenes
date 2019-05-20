<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>

<head>
	<title>Create a Group | Scenez</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
		integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">	
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"
		integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="common.css">
    <link rel="stylesheet" type="text/css" href="createGroup.css">
</head>

<body>

		<!-- *************** FORM *************** -->
		<div class="container col-sm-8 mt-0 d-inline-block">
                <div class=" mt-4 mb-4 pb-0 ">
                    <h2 style="color: #4E4E4E; font-weight: 700;">Create your own group</h1>
                </div>
                <hr>
            <div class="container col-sm-9 ">
                <form action="newGroup.jsp">
                    <div class="row mt-4">
                        <div class="col">
                            <label for="grp_name" class="mr-4 tbg col"><h4>Group Name: </h4></label>
                        </div>
                        <div class="col-sm-8">
                            <input type="text" name="grp_name" required maxlength="75" class="w-100 mb-3 col">
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col">
                            <label for="" class="mr-4 tbg col"><h4>Description: </h4></label>
                        </div>
                        <div class="col-sm-8">
                            <textarea name="grp_desc" required id="" class="col" cols="50" rows="5" style="vertical-align: top;" maxlength="3000"></textarea>
                        </div>
                    </div>
                    <div class="container col-sm-4 mt-5 d-flex justify-content-start">
                        <input type="submit" value="Create" class="btn btn-lg d-flex d-inline mr-5 btn-outline-dark text-white my-btn"/>
                        <button class="btn btn-lg btn-outline-dark text-white d-flex ml-5 my-btn">Cancel</button>
                    </div>
                </form>
            </div>
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