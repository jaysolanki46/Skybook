<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Book</title>
<%@include  file="../header.html" %>

	<%
		String username;
		if(session.getAttribute("username") != null) {
			username = session.getAttribute("username").toString();
		} else {
			response.sendRedirect("../View/login.jsp");
		}
				
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL = "jdbc:mysql://localhost:3306/skybook?useSSL=false";
		
		String USER = "root";
		String pass = "Sisterbro46@";
		Connection dbConn = null;
		Statement st = null;
		ResultSet rs = null;
		Class.forName(JDBC_DRIVER);
		dbConn = DriverManager.getConnection(DB_URL, USER, pass);
		st = dbConn.createStatement();

	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<form action="<%=request.getContextPath()%>/book" method="post">
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
							 <input type="checkbox" class="form-check-input" name="isVoicemail">
   							 <label class="form-check-label">Voice mail</label>
						</div>
						<div class="input-group" style="margin-left: auto; width:30%;">
							 <input type="checkbox" class="form-check-input" name="isInstructed">
   							 <label class="form-check-label">Instructed</label>
						</div>
						</div>
					</div>
				</div>

				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Dealer</h5>
						<div class="form-group row">
						
							<label class="col-sm-1 col-form-label">Name:</label>
							<input class="col-sm-4" list="dealers" id="dealer" name="dealer" onfocusout="freezeLogTime()">
							<datalist id="dealers">
							
							<%	
								rs = st.executeQuery("SELECT * FROM dealers");
								
							    while(rs.next())
							    {   
									%>
							    		<option value=<%=rs.getString("name") %>><%=rs.getString("name") %></option>
							    	<%
							    }    
						    
							%>
						
							</datalist>
							
							 <div class="input-group" style="margin-left: auto; width:47%;">
							 <input type="checkbox" class="form-check-input" name="isNew">
   							 <label class="form-check-label">Add New</label>
						</div>
						</div>
						
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Terminal</h5>
						<div class="form-group row">
						
							<label class="col-sm-1 col-form-label">Serial:</label>
							<input type="text" class="col-sm-4 form-control" name="serial">
							
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;
							
							<label class="col-sm-1 col-form-label">Terminal:</label> 
							<select class="custom-select col-sm-4" name="terminal">
								<option selected>Select terminal...</option>
								<%	
								rs = st.executeQuery("SELECT * FROM terminals");
								
							    while(rs.next())
							    {   
									%>
							    		<option value="<%=rs.getString("id") %>"><%=rs.getString("name") %></option>
							    	<%
							    }    
						    
							%>
							</select>
							
						</div>
					</div>
				</div>
				
				<div class="card-group">
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Issue</h5>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Issue:</label>
							<input class="col-sm-8" list="issues" id="issue" name="issue" onfocusout="">
							<datalist id="issues">
							<%	
								rs = st.executeQuery("SELECT * FROM issues");
								
							    while(rs.next())
							    {   
									%>
							    		<option data-value="<%=rs.getString("name") %>"><%=rs.getString("name") %></option>
							    	<%
							    }    
						    
							%>
							</datalist>
							
							&nbsp;&nbsp;&nbsp;
							
							<button class="btn-skyzer-icon-background" type="button" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?"><i class="fa fa-bars"></i></button>
								
						</div>
						
						<div class="form-group row">
						
							<label class="col-sm-2 col-form-label">Category:</label>
							<div class="form-group">
							<input class="form-control" type="text" style="width: 459px" readonly>
							<small class="form-text text-muted">Note: Category will come up automatically...</small>
							</div>
						</div>
						
						
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Description</h5>
						<div class="form-group row">
						
							<label class="col-sm-2 col-form-label">Issue:</label>
							<textarea class="col-sm-9 form-control" placeholder="New issue..." rows="3" name="newIssue"></textarea>
						
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Solution:</label>
							<textarea class="col-sm-9 form-control" placeholder="New solution..." rows="3" name="newSolution"></textarea>
						</div>
					</div>
				</div>
				
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						
						<input type="reset" class="btn btn-danger float-right" style="margin-left:10px;" value="Cancel">
						<input type="submit" class="btn btn-skyzer float-right" value="Complete">
						
					</div>
				</div>
				
			</div>

			<!--  side card -->
			<div class="card" style="width:23%">
				<div class="card-body" >
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Status</h5>
						<div class="row" style="margin-left: 0px;">
						
						<select class="custom-select col-sm-8 center_div" id="status" name="status" onchange="updateStatus()">
								<option selected>Select status...</option>
								<%	
								rs = st.executeQuery("SELECT * FROM status");
								
							    while(rs.next())
							    {   
									%>
							    		<option value="<%=rs.getString("id") %>"><%=rs.getString("name") %></option>
							    	<%
							    }    
						    
							%>
						</select>
						
						<img alt="" width="22px" src="../IMAGES/task-complete.svg" id="statusImg" style="visibility:hidden;">
						</div>
					</div>
					
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Follow Up</h5>
						
						<label class="col-sm-10 col-form-label" style="font-weight: bold" name="logID">LOGID-####</label>
						<input type="date" name="followUpDate" max="31-12-3000" min="01-01-1000" class="form-control col-sm-10 center_div">						
						<input type="time" name="followUpTime" name="appt" min="09:00" max="18:00" class="form-control col-sm-10 center_div">
        				<textarea class="col-sm-10 form-control center_div" placeholder="Follow up notes..." rows="3" name="followUpNote"></textarea>
						<button name="generateTicket" type="button" class="btn btn-skyzer col-sm-10 center_div" onclick="ticket()">Generate Ticket</button>
					</div>
				</div>
				
			</div>
			
			
		</div>
	</div>
	</form>
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
	
	setTimeout(myTimer, 1000);//This method will call for every second
}
function freezeLogTime() {
    
	var now = new Date();	
	time = now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds();
	
	var x = document.getElementById("time");
    x.innerHTML = time;
}
$(function () {
	  $('[data-toggle="popover"]').popover()
	})
function updateStatus() {
  var x = parseInt(document.getElementById("status").value);
 
  if (x === 2)
	  document.getElementById("statusImg").style.visibility = "visible";
  else
	  document.getElementById("statusImg").style.visibility = "hidden";
}
function ticket() {
	
	swal({
		  title: "Ticket created!",
		  text: "",
		  icon: "success",
		  button: "Aww yiss!",
		});
}
</script>
</html>

