<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Book</title>
<%@include  file="../header.html" %>
</head>
<body>
<%@include  file="../navbar.html" %>

	<div class="card center_div">
	
		<div class="card-header"
			style="display: flex; justify-content: space-around">
			<div>Customer call book</div>
			<div style="margin-left: auto;">
				<span id="clock"></span>
			</div>
		</div>

		<div class="card-group">
		
			<div class="card-body" style="width:70%">
				<div class="card mb-3">
					<div class="card-body" >
						<h5 class="card-title">Time</h5>
						<div style="display: flex; justify-content: space-around">
						<div class="input-group" style="width:30%">
							<label class="col-form-label">Time:</label> &nbsp;&nbsp;&nbsp; 
							<label class="col-form-label" id="time">00:00:00</label>
						</div>
						<div class="input-group" style="margin-left: auto; width:30%;">
							 <input type="checkbox" class="form-check-input">
   							 <label class="form-check-label">Voice mail</label>
						</div>
						<div class="input-group" style="margin-left: auto; width:30%;">
							 <input type="checkbox" class="form-check-input">
   							 <label class="form-check-label">Instructed</label>
						</div>
						</div>
					</div>
				</div>

				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">Dealer</h5>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-1 col-form-label">Name:</label>
							<input type="password" class="col-sm-2 form-control" id="inputPassword">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<label for="staticEmail" class="col-sm-1 col-form-label">Division:</label> 
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Choose...</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">Terminal</h5>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-1 col-form-label">Serial:</label>
							<input type="password" class="col-sm-2 form-control" id="inputPassword">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<label for="staticEmail" class="col-sm-1 col-form-label">Terminal:</label> 
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Choose...</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="card-group">
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">Issue</h5>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-2 col-form-label">Category:</label>
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Choose...</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Issue:</label>
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Choose...</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">Description</h5>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Issue:</label>
							<textarea class="col-sm-10 form-control" placeholder="New issue..." rows="3"></textarea>
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Solution:</label>
							<textarea class="col-sm-10 form-control" placeholder="New solution..." rows="3"></textarea>
						</div>
					</div>
				</div>
				</div>
				
			</div>

			<div class="card" style="width:20%">
				<div class="card-body" >
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<div class="card-header">Status</div>
						<select class="custom-select col-sm-8 center_div" id="inputGroupSelect02">
								<option selected>Choose...</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
					</div>
					
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<div class="card-header">Follow Up</div>
						
						
						
					</div>
				</div>
				
			</div>
			
			
		</div>
	</div>

	<%@include  file="../footer.html" %>
</body>

<script type="text/javascript">
var myVar=setInterval(function () {myTimer()}, 1000);
var counter = 0;
function myTimer() {
	var now = new Date(), 
    months = ['January', 'February', '...']; 
    time = now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds(), 

    date = [now.getDate(), 
            now.getMonth(),
            now.getFullYear()].join('-');

	document.getElementById('clock').innerHTML = [date, time].join(' / ');
	
	setTimeout(updateYourTime, 1000);//This method will call for every second
}
</script>
</html>

