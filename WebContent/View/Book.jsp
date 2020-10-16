<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="db.DBConfig" %>
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
		String username = "";
		String userID = "";
		if(session.getAttribute("username") != null) {
			username = session.getAttribute("username").toString();
			userID = session.getAttribute("userID").toString();
		} else {
			response.sendRedirect("../View/login.jsp");
		}
				
		Connection dbConn = DBConfig.connection(); ;
		Statement st = null;
		ResultSet rs = null;
		st = dbConn.createStatement();
		rs = st.executeQuery("select dt.id as dtID, dt.dealer as dID, dt.name as technician, d.name as dealer" +
								" from dealer_technicians as dt INNER JOIN dealers as d ON dt.dealer = d.id");

		

	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<form id="book" action="<%=request.getContextPath()%>/book" method="post">
	<div class="card center_div">
	
		<div class="card-header"
			style="color: white; background-color: #0066cb;">
			<h5 style="color: white;">Customer call book</h5>
		</div>

		<div class="card-group">
		
			<div class="card-body" style="width:66%">
				<div class="card mb-3">
				
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Time</h5>
						<div style="display: flex;">
						
						<div class="input-group" >
							<label class="col-sm-1 col-form-label">Time:</label>  &nbsp;&nbsp;
							<input id="time" name="time" class="" type="text" style="width: 41.5%" value="00:00:00" readonly>
						</div>
						
						<div class="input-group" style="margin-left: auto; width:10%;">
							 <input type="checkbox" class="form-check-input" name="isVoicemail">
   							 <label class="form-check-label">Voice mail</label>
						</div>
						<div class="input-group" style="margin-left: auto; width:10%;">
							 <input type="checkbox" class="form-check-input" name="isInstructed">
   							 <label class="form-check-label">Instructed/Outgoing</label>
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
								 rs = st.executeQuery("select dt.id as dtID, dt.dealer as dID, dt.name as technician, d.name as dealer from dealer_technicians as dt INNER JOIN dealers as d ON dt.dealer = d.id");

							    while(rs.next())
							    {   
									%>
										<option data-dealer=<%=rs.getString("dID") %> data-dealer-technician=<%=rs.getString("dtID") %> value='<%=rs.getString("technician") %>'><%=rs.getString("dealer") %></option>

							    	<%
							    }    
						    
							%>
						
							</datalist>
							
							<input type="hidden" id="user" name="user" value='<%=userID%>' />
							<input type="hidden" id="hiddenDealerTechnicianID" name="hiddenDealerTechnicianID"/>
	                        <input type="hidden" id="hiddenDealerID" name="hiddenDealerID"/>
							
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
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							
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
							<input class="col-sm-8" list="issues" id="issue" name="issue">
							<datalist id="issues">
							<%	
								rs = st.executeQuery("SELECT i.id as issueID, im.id as issueMasterID, i.name as issue, im.name as category, i.solution as solution FROM skybook.issues i INNER JOIN issue_master im ON i.issue_master = im.id");
								
							    while(rs.next())
							    {   
									%>
							    		<option data-issue-id=<%=rs.getString("issueID") %> data-issue-master-id=<%=rs.getString("issueMasterID") %> data-solution='<%=rs.getString("solution") %>' data-value=<%=rs.getString("category") %>><%=rs.getString("issue") %></option>
							    	<%
							    }    
						    
							%>
							</datalist>
							<input type="hidden" id="hiddenIssueID" name="hiddenIssueID"/>
							&nbsp;&nbsp;&nbsp;
							
							<button id="solution" class="btn-skyzer-icon-background" type="button" data-toggle="popover" title="Solution" data-content="----"><i class="fa fa-bars"></i></button>
								
						</div>
						
						<div class="form-group row">
						
							<label class="col-sm-2 col-form-label">Category:</label>
							<div class="form-group ">
								<input id="category" class="form-control" type="text" style="width: 207%" readonly>
								<small class="form-text text-muted">Note: Category will come up automatically...</small>
								<input type="hidden" id="hiddenIssueMasterID" name="hiddenIssueMasterID"/>
							</div>
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Description:</label>
							<textarea class="col-sm-8 form-control" placeholder="" rows="3" name="description"></textarea>
						</div>
						
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Description</h5>
						<div class="form-group row">
						
							<label class="col-sm-2 col-form-label">Issue:</label>
							<textarea class="col-sm-9 form-control" placeholder="New issue..." rows="4"  name="newIssue" id="newIssue"></textarea>
						
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Solution:</label>
							<textarea class="col-sm-9 form-control" placeholder="New solution..." rows="4" name="newSolution" id="newSolution"></textarea>
						</div>
					</div>
				</div>
				
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						
						<input type="reset" class="btn btn-danger float-right" style="margin-left:10px;" value="Cancel">
						<input type="button" class="btn btn-skyzer float-right" value="Complete" onclick="validate()">
						
					</div>
				</div>
				
			</div>

			<!--  side card -->
			<div class="card" style="width:25%">
				<div class="card-body" >
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Status</h5>
						<div class="row" style="margin-left: 0px;">
						
						<select class="custom-select col-sm-8 center_div" id="status" name="status" onchange="updateStatus()">
								<option value="0" selected>Select status...</option>
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
						<div class="input-group center_div" style="margin-left: 12%;">
							 <input type="checkbox" class="form-check-input" name="isFollowUp" id="isFollowUp">
   							 <label class="form-check-label">Follow Up</label>
						</div>
					</div>
					
					<div class="card bg-light mb-3" style="max-width: 26rem; display: none;" id="followUp">
						<h5 class="card-header" style="background-color: transparent;">Follow Up</h5>
						<input type="date" id="followUpDate" name="followUpDate" max="31-12-3000" min="01-01-1000" class="form-control col-sm-10 center_div">						
						<input type="time" id="followUpTime" name="followUpTime" min="00:00" max="23:59" class="form-control col-sm-10 center_div">
						<input type="text" id="followUpContact" name="followUpContact" placeholder="Email/Phone" class="form-control col-sm-10 center_div">
        				<textarea class="col-sm-10 form-control center_div" placeholder="Follow up notes..." rows="3" name="followUpNote"></textarea>
						
					</div>
				</div>
				
			</div>
			
			
		</div>
	</div>
	</form>
	<%@include  file="../footer.html" %>
		<%
			if (session.getAttribute("insertStatus") != null) {
				if (session.getAttribute("insertStatus").toString().equals("success")) {
					%>
					<script>
						swal({
							title : "Good job!",
							text : "",
							icon : "success",
							button : "Aww yiss!",
						});
					</script>
					<%
						session.setAttribute("insertStatus", "killed");
				} else if (session.getAttribute("insertStatus").toString().equals("error")) {
					%>
					<script>
						swal({
							title : "Something went wrong!",
							text : "",
							icon : "error",
							button : "Aww okiee!",
						});
					</script>
					<%
						session.setAttribute("insertStatus", "killed");
				}
			}
		%>
		
		 <footer id="sticky-footer" class="py-0 bg-dark text-white-50 fixed-bottom">
		    
		   <div style="color: white; background-color: #0066cb; display: flex; justify-content: space-around">
			<div>
				<img alt="" width="15px" src="../IMAGES/user.svg">
				<small style="color: white;"><%=username %></small>
			</div>
			<div style="color: white; margin-left: auto; margin-right: 5px;">
				
				<small >
					<img alt="" width="15px" src="../IMAGES/clock.svg">
					<span id="clock"></span>
				</small>
			</div>
			
		</div>
	  </footer>
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
    x.value = time;
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
$("#issue").change(function() {
	 
	var val = $('#issue').val()
     var category = $('#issues option').filter(function() {
         return this.value == val;
     }).data('value');
	 
	 document.getElementById("category").value  = category;
	 
	 var solution = $('#issues option').filter(function() {
         return this.value == val;
     }).data('solution');
	 
	 $('#solution').attr("data-content",  solution);
	 
	 var issueID = $('#issues option').filter(function() {
         return this.value == val;
     }).data('issue-id');
	 
	 var issueMasterID = $('#issues option').filter(function() {
         return this.value == val;
     }).data('issue-master-id');
	 
	 document.getElementById("hiddenIssueID").value  = issueID;
	 document.getElementById("hiddenIssueMasterID").value  = issueMasterID;
	 
})
$("#dealer").change(function() {
	var val = $('#dealer').val()
    var dealerTechnicianID = $('#dealers option').filter(function() {
        return this.value == val;
    }).data('dealer-technician');
	
	 var dealerID = $('#dealers option').filter(function() {
	        return this.value == val;
	    }).data('dealer');
	 
	 document.getElementById("hiddenDealerTechnicianID").value  = dealerTechnicianID;
	 document.getElementById("hiddenDealerID").value  = dealerID;
	 
})
$("#isFollowUp").change(function() {
	
	var isFollowUp = $('#isFollowUp')[0].checked;
   	var followUpDiv = document.getElementById("followUp");
	
   	if(isFollowUp) {
   		followUpDiv.style.display = "block";
	} else {
		followUpDiv.style.display = "none";
	}
	 
})
function validate() {
	
	var dealerTechnicianID = document.getElementById("hiddenDealerTechnicianID").value;
	var category = document.getElementById("hiddenIssueMasterID").value;
	var newIssue = document.getElementById("newIssue").value;
	var newSolution = document.getElementById("newSolution").value;
	var status = document.getElementById("status").value;
	var isFollowUp = document.getElementById("isFollowUp").checked;
	var followUpDate = document.getElementById("followUpDate").value;
	var followUpTime = document.getElementById("followUpTime").value;
	
	if(dealerTechnicianID == "undefined") {
		swal("Error!", "Invalid dealer name!", "error");
	} else if (dealerTechnicianID === "" || category  === "" || status == 0) {
		swal("Error!", "Please fill all details!", "error");
	} else {
		if(category == "undefined" &&  (newIssue === "" || newSolution === "")) {
			swal("Error!", "Attention to new issue!", "error");
		} else if (isFollowUp && (followUpDate === "" || followUpTime === "")) {
			swal("Error!", "Invalid follow up details!", "error");
		} else {
		
			document.getElementById("book").submit();
		}
	}
	
}
</script>
</html>

