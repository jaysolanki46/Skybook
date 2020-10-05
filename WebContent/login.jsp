<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Skybook - Login</title>
<%@include  file="header.html" %>
</head>
<body>
	<center><img src="IMAGES\logo.png" alt="Italian Trulli" style="width:300px;height:200px;"></center>
	<div class="login-form">
		<form action="/examples/actions/confirmation.php" method="post">
			<h1 class="text-center">Sky Book</h1>
			<h3 class="text-center">Manages Skyzer Support Calls</h3>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Username"
					required="required">
			</div>
			<div class="form-group">
				<input type="password" class="form-control" placeholder="Password"
					required="required">
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary btn-block">Log
					in</button>
			</div>
		</form>
	</div>
	<%@include  file="footer.html" %>
</body>
</html>