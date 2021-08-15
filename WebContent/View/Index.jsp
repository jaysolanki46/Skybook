<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
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
		String userEmail = "";
		String username = "";
		String userID = "";
		if(session.getAttribute("userName") != null) {
			userEmail = session.getAttribute("userEmail").toString();
			username = session.getAttribute("userName").toString();
			userID = session.getAttribute("userID").toString();
		} else {
			response.sendRedirect("../View/login.jsp");
		}
				
		Connection dbConn = DBConfig.connection(); ;
		Statement st = null;
		ResultSet rs = null;
		st = dbConn.createStatement();

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
   							 <label class="form-check-label">Outgoing</label>
						</div>
						</div>
					</div>
				</div>

				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Dealer</h5>
						<div class="form-group row">
						
							<label class="col-sm-1 col-form-label">Name:<span style="color: red;">*</span></label>
							<input class="col-sm-1"  id="technician" name="technician" placeholder="Technician..." onfocusout="freezeLogTime()">
							<input class="col-sm-3" list="dealers" id="dealer" name="dealer" placeholder="Dealer...">
							&nbsp;&nbsp;&nbsp;
							<datalist id="dealers">
							
							<%	
								 rs = st.executeQuery("select * from dealers");

							    while(rs.next())
							    {   
									%>
										<option data-dealer=<%=rs.getString("id") %>><%=rs.getString("name") %></option>

							    	<%
							    }    
						    
							%>
							</datalist> 
							<input type="hidden" id="user" name="user" value='<%=userID%>'/>
							<input type="hidden" id="userName" name="userName" value='<%=username%>'/>
							<input type="hidden" id="userEmail" name="userEmail" value='<%=userEmail%>'/>
	                        <input type="hidden" id="hiddenDealerID" name="hiddenDealerID" value="0"/>
							
						</div>
						
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Terminal</h5>
						<div class="form-group row">
						
							<label class="col-sm-1 col-form-label">Terminal:</label> 
							<select class="custom-select col-sm-2" name="terminal">
								<option value ="0" selected>Select terminal type...</option>
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
							
							<label class="col-sm-1 col-form-label">Serial No:</label>
							<input type="text" class="col-sm-2 form-control" name="serial" placeholder="Ex. 3542874">
							
							<label class="col-sm-1 col-form-label">Release:</label> 
							<select class="custom-select col-sm-4" name="release">
								<option value ="0" selected>Select release...</option>
								<%	
								rs = st.executeQuery("SELECT * FROM releases");
								
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
							
							<a href="" id="solutionpopup" class="popover-toggle" title="Solution" onclick="return false;"><button type="button" class="btn btn-primary"><i class="fa fa-bars"></i></button></a>
							<div id="solutiondiv" style="display: none">
					           
					           <!-- solutions from javascript -->
					        </div>	
					        
						</div>
						
						<div class="form-group row">
						
							<label class="col-sm-2 col-form-label">Category:</label>
							<div class="form-group col-sm-8" style="padding: 0px;">
								<input id="category" class="form-control" type="text" readonly>
								<small class="form-text text-muted">Note: Category will come up automatically...</small>
								<input type="hidden" id="hiddenIssueMasterID" name="hiddenIssueMasterID"/>
							</div>
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Description:</label>
							<textarea class="col-sm-8 form-control" placeholder="Description..." rows="3" name="description"></textarea>
						</div>
						
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Unknown Issue</h5>
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
						<input type="button" class="btn btn-primary float-right" value="Complete" onclick="validate()">
						
					</div>
				</div>
				
			</div>

			<!--  side card -->
			<div class="card" style="width:25%">
				<div class="card-body" >
				
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Call Duration</h5>
						<div class="card-body row">
							<div class="form-group col-sm-6">
							    <label for="callDurationHR">Hours</label>
								<input type="number" id="callDurationHR" name="callDurationHR" min="0"  placeholder="Hr"
								 class="form-control col-sm-12" value=00>
							 </div>	
							 <div class="form-group col-sm-6">
							    <label for="callDurationMI">Minutes</label>
								<input type="number" id="callDurationMI" name="callDurationMI" min="0" max="59" placeholder="Mi" 
								class="form-control col-sm-12" value=00>
							 </div>		
						</div>
					</div>
				
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
						<div class="input-group center_div" style="margin-left: 12%;" id="isFollowUpCheckbox">
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
		
</body>
<script type="text/javascript">
var counter = 0;

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
 
  if (x === 1) {
	  document.getElementById("isFollowUp").checked = false;
	  document.getElementById("followUp").style.display = "none";
	  document.getElementById("isFollowUpCheckbox").style.visibility = "hidden";
	  document.getElementById("statusImg").style.visibility = "visible";
  } else {
	  document.getElementById("isFollowUpCheckbox").style.visibility = "visible";
	  document.getElementById("statusImg").style.visibility = "hidden";
  }
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
	 
	 
	 document.getElementById("solutiondiv").innerHTML = solution;
	 $('#solutionpopup').popover({
	      html : true, 
	      content: function() {
	        return $('#solutiondiv').html();
	      } 
	  });  
	 
	 
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
	
	var val = $('#dealer').val();
	var dealerID = $('#dealers option').filter(function() {
	        return this.value == val;
	    }).data('dealer');
	 
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
	
	var dealer = document.getElementById("hiddenDealerID").value;
	var category = document.getElementById("hiddenIssueMasterID").value;
	var isUnknownCategory = document.getElementById("category").value;
	var newIssue = document.getElementById("newIssue").value;
	var newSolution = document.getElementById("newSolution").value;
	var status = document.getElementById("status").value;
	var isFollowUp = document.getElementById("isFollowUp").checked;
	var followUpDate = document.getElementById("followUpDate").value;
	var followUpTime = document.getElementById("followUpTime").value;
	var callDurationHR = document.getElementById("callDurationHR").value;
	var callDurationMI = document.getElementById("callDurationMI").value;
	
	if(dealer == 0) {
		swal("Error!", "Invalid dealer", "error");
	} else if (category  === "" || category == "undefined") {
		swal("Error!", "Invalid issue", "error");
	} else if ((isUnknownCategory == "Unknown") &&  (newIssue === "" || newSolution === "")) {
		swal("Error!", "Required attention on new issue!", "error");
	} else if(status == 0) {
		swal("Error!", "Invalid status!", "error");
	} else if (isFollowUp && (followUpDate === "" || followUpTime === "")) {
		swal("Error!", "Invalid follow up details!", "error");
	} else if (callDurationMI  === "" || callDurationHR === "" || callDurationHR < 0 || callDurationMI > 59) {
		swal("Error!", "Invalid call duration!", "error");
	} else {
		document.getElementById("book").submit();
	}
}
</script>
</html>

