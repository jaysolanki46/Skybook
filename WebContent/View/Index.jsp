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
			style="color: white; background-color: #0066cb; display: flex; justify-content: space-around">
			<h5 style="color: white;">Customer call book</h5>
			<div style="color: white; margin-left: auto;">
				<span id="clock"></span>
			</div>
		</div>

		<div class="card-group">
		
			<div class="card-body" style="width:66%">
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
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
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Dealer</h5>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-1 col-form-label">Name:</label>
							<input type="text" class="col-sm-2 form-control" id="inputPassword">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<label for="staticEmail" class="col-sm-1 col-form-label">Division:</label> 
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Select division...</option>
								<option value="1">1140 - Eftpos Specialist CHCH</option>
								<option value="2">9999 - Skyzer Technologies</option>
								<option value="3">1004 - Point of Sale</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Terminal</h5>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-1 col-form-label">Serial:</label>
							<input type="text" class="col-sm-2 form-control" id="inputPassword">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<label for="staticEmail" class="col-sm-1 col-form-label">Terminal:</label> 
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Select terminal...</option>
								<option value="1">ICT250</option>
								<option value="2">MOVE5000</option>
								<option value="3">DESK3200</option>
							</select>
						</div>
					</div>
				</div>
				
				<div class="card-group">
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Issue</h5>
						<div class="form-group row">
							<label for="staticEmail" class="col-sm-2 col-form-label">Category:</label>
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Select category...</option>
								<option value="1">TMS</option>
								<option value="2">NITRO</option>
								<option value="3">RKI</option>
							</select>
						</div>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Issue:</label>
							<select class="custom-select col-sm-4" id="inputGroupSelect02">
								<option selected>Select issue...</option>
								<option value="1">Latest software</option>
								<option value="2">Transmission error</option>
								<option value="3">Put prevent download</option>
							</select>
							&nbsp;&nbsp;&nbsp;<img alt="" width="22px" src="../IMAGES/answer.svg">
						</div>
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Description</h5>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Issue:</label>
							<textarea class="col-sm-9 form-control" placeholder="New issue..." rows="3"></textarea>
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Solution:</label>
							<textarea class="col-sm-9 form-control" placeholder="New solution..." rows="3"></textarea>
						</div>
					</div>
				</div>
				
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						
						<button type="button" class="btn btn-danger float-right" style="margin-left:10px;">Cancel</button>
						<button type="button" class="btn btn-skyzer float-right">Complete</button>
						
					</div>
				</div>
				
			</div>

			<!--  side card -->
			<div class="card" style="width:23%">
				<div class="card-body" >
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Status &nbsp;&nbsp;&nbsp;<img alt="" width="22px" src="../IMAGES/task-complete.svg"></h5>
						<select class="custom-select col-sm-10 center_div" id="inputGroupSelect02">
								<option selected>Select status...</option>
								<option value="1">Instructed</option>
								<option value="2">Awaiting</option>
								<option value="3">Resolved</option>
							</select>
					</div>
					
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Follow Up</h5>
						<input type="date" name="bday" max="3000-12-31" min="1000-01-01" class="form-control col-sm-10 center_div">						
						<input type="time" id="appt" name="appt" min="09:00" max="18:00" class="form-control col-sm-10 center_div">
        				<textarea class="col-sm-10 form-control center_div" placeholder="Follow up details..." rows="3"></textarea>
						<button type="button" class="btn btn-skyzer col-sm-10 center_div">Generate Ticket</button>
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

