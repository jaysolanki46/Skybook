<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - History Details</title>
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
			throw new Exception("User session timed out!");
		}
				
		Connection dbConn = DBConfig.connection(); ;
		Statement st = null;
		ResultSet rs = null;
		Statement stStatus = null;
		ResultSet rsStatus = null;
		st = dbConn.createStatement();
		stStatus = dbConn.createStatement();
		
		String log = request.getParameter("log");
		
		rs = st.executeQuery(
				"select l.id, l.log_date, l.log_time, l.is_voicemail, l.is_instructed, l.serial, l.description, l.new_issue, l.new_solution, l.status, l.technician, l.duration, " + 
				"ter.name as terminal, rel.name as current_release, d.name as dealer, " +
				"u.name as user, iss.name as issue, issmaster.name as category, fup.id as follow_up_id, fup.follow_up_date, fup.follow_up_time, fup.contact, fup.note from " +
				"logs as l " +
				"LEFT JOIN follow_ups fup ON fup.log = l.id " +
				"LEFT JOIN terminals as  ter ON l.terminal =  ter.id " +
				"LEFT JOIN releases as rel ON l.current_release =  rel.id " +
				"LEFT JOIN dealers as d ON l.dealer = d.id " +
				"LEFT JOIN issues as iss ON iss.id = l.issue " +
				"LEFT JOIN issue_master as issmaster ON issmaster.id = l.issue_master " +
				"LEFT JOIN users as u ON l.user = u.id WHERE l.id=" + log);
		System.out.println(log);
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<form id="book" action="<%=request.getContextPath()%>/book" method="post" class="disable">
	<% while(rs.next()) { %>
	<div class="card center_div">
	
		<div class="card-header"
			style="color: white; background-color: #0066cb; display: flex; justify-content: space-around;">
			<h5 style="color: white;">Call #<%=rs.getString("id") %> [<%=rs.getString("log_date") %>]</h5>
			<div style="margin-left: auto;">
				<span>Attendant: <%=rs.getString("user") %></span>
			</div>
			
			
			<input type="hidden" name="hiddenLogID" value=<%=rs.getString("id") %>>
			<input type="hidden" id="user" name="user" value='<%=userID%>' />
			<input type="hidden" id="userName" name="userName" value='<%=username%>'/>
			<input type="hidden" id="userEmail" name="userEmail" value='<%=userEmail%>'/>
			<input type="hidden" name="hiddenRedirectPage" value="HistoryDetails.jsp">
		</div>

		<div class="card-group">
		
			<div class="card-body" style="width:66%">
				<div class="card mb-3">
				
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Time</h5>
						<div style="display: flex;">
						
						<div class="input-group" >
							<label class="col-sm-1 col-form-label">Time:</label>  &nbsp;&nbsp;
							<label class="col-sm-2 col-form-label"><%=rs.getString("log_time") %></label>
						</div>
						
						<div class="input-group" style="margin-left: auto; width:10%;">
							 <input type="checkbox" class="form-check-input" name="isVoicemail" onclick="return false;"
							 <%
							 	if(rs.getString("is_voicemail") != null) 
							 		if(rs.getString("is_voicemail").equals("1")) 
										%> checked<%
							 
							 %>>
   							 <label class="form-check-label">Voice mail</label>
						</div>
						<div class="input-group" style="margin-left: auto; width:10%;">
							 <input type="checkbox" class="form-check-input" name="isInstructed" onclick="return false;" 
							 <%
							 	if(rs.getString("is_instructed") != null) 
							 		if(rs.getString("is_instructed").equals("1")) 
										%> checked<%
							 
							 %>>
   							 <label class="form-check-label">Outgoing</label>
						</div>
						</div>
					</div>
				</div>

				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Dealer</h5>
						<div class="form-group row">
						
							<label class="col-sm-1 col-form-label">Name:</label>
							<label class="col-sm-4 col-form-label"><%=rs.getString("technician") %> - <%=rs.getString("dealer") %></label>
							
						</div>
						
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Terminal</h5>
						<div class="form-group row">
						
							<label class="col-sm-1 col-form-label">Terminal:</label> 
							<label class="col-sm-2 col-form-label"><% if(rs.getString("terminal") != null) out.print(rs.getString("terminal")); else out.print("-"); %></label>
							
							<label class="col-sm-1 col-form-label">Serial:</label>
							<label class="col-sm-2 col-form-label"><%=rs.getString("serial") %></label>
							
							<label class="col-sm-1 col-form-label">Release:</label>
							<label class="col-sm-4 col-form-label"><% if(rs.getString("current_release") != null) out.print(rs.getString("current_release")); else out.print("-"); %></label>
							
							
						</div>
					</div>
				</div>
				
				<div class="card-group">
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Issue</h5>
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Issue:</label>
							<label class="col-sm-4 col-form-label"><%=rs.getString("issue") %></label>
						</div>
						
						<div class="form-group row">
						
							<label class="col-sm-2 col-form-label">Category:</label>
							<label class="col-sm-4 col-form-label"><%=rs.getString("category") %></label>
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Description:</label>
							<textarea class="col-sm-8 form-control" placeholder="" rows="3" name="description"><%=rs.getString("description") %></textarea>
						</div>
						
					</div>
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px">
						<h5 class="card-title">Description</h5>
						<div class="form-group row">
						
							<label class="col-sm-2 col-form-label">Issue:</label>
							<textarea class="col-sm-9 form-control" placeholder="New issue..." rows="4"  name="newIssue" id="newIssue"><%=rs.getString("new_issue") %></textarea>
						
						</div>
						
						<div class="form-group row">
							<label class="col-sm-2 col-form-label">Solution:</label>
							<textarea class="col-sm-9 form-control" placeholder="New solution..." rows="4" name="newSolution" id="newSolution"><%=rs.getString("new_solution") %></textarea>
						</div>
					</div>
				</div>
				
				</div>
				
				<div class="card mb-3">
					<div class="card-body" style="padding: 10px" id="buttonDiv">
						<a href="../View/Index.jsp"><input type="button" class="btn btn-danger float-right" style="margin-left:10px;" value="Cancel"></a>
						<input type="button" class="btn btn-primary float-right" value="Update" onclick="validate()">
						
					</div>
				</div>
				
			</div>

			<!--  side card -->
			<div class="card" style="width:25%">
				<div class="card-body" >
					
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Call Duration</h5>
						<div class="card-body row">
							<%
								String duration = rs.getString("duration");
								String hr = "00", mi = "00";
								if(duration != null) {
									hr =  String.format("%02d" , Integer.valueOf(duration.substring(0, duration.indexOf(":"))));
									mi =  String.format("%02d", Integer.valueOf(duration.substring(duration.indexOf(":") + 1)));	
								}
							%>
							<div class="form-group col-sm-6">
							    <label for="callDurationHR">Hours</label>
								<input type="number" id="callDurationHR" name="callDurationHR" min="0"  placeholder="Hr"
								 class="form-control col-sm-12" value=<%=hr %>>
							 </div>	
							 <div class="form-group col-sm-6">
							    <label for="callDurationMI">Minutes</label>
								<input type="number" id="callDurationMI" name="callDurationMI" min="0" max="59" placeholder="Mi" 
								class="form-control col-sm-12" value=<%=mi %>>
							 </div>							
						</div>
					</div>
					
					<div class="card bg-light mb-3" style="max-width: 26rem;">
						<h5 class="card-header" style="background-color: transparent;">Status</h5>
						<div class="row" style="margin-left: 0px;">
						
						<select class="custom-select col-sm-8 center_div" id="status" name="status" onchange="updateStatus()">
								<option value="0" selected>Select status...</option>
								<%	
								rsStatus = stStatus.executeQuery("SELECT * FROM status");
								
							    while(rsStatus.next())
							    {   
									%>
							    		<option value="<%=rsStatus.getString("id") %>" <%
							    		
							    		if(rs.getString("status").equals(rsStatus.getString("id"))) {
							    			%>selected<%
							    		}
							    		
							    		%>><%=rsStatus.getString("name") %></option>
							    	<%
							    }    
						    
							%>
						</select>
						
						<img alt="" width="22px" src="../IMAGES/task-complete.svg" id="statusImg" style="visibility:hidden;">
						</div>
						<div class="input-group center_div" style="margin-left: 12%;">
							 <input type="checkbox" class="form-check-input" name="isFollowUp" id="isFollowUp" <%
							 	
							 if(rs.getString("follow_up_id") != null) {
									%>checked="checked"<%								 
							 }
							 %>>
   							 <label class="form-check-label">Follow Up</label>
						</div>
					</div>
					
					<div class="card bg-light mb-3" style="max-width: 26rem; <% if(rs.getString("follow_up_id") == null) {  %> display:none; <%   } %>" id="followUp">
						<h5 class="card-header" style="background-color: transparent;">Follow Up (SBT - <%=rs.getString("follow_up_id") %>)</h5>
						<input type="hidden" name="hiddenFollowUpID" value=<%=rs.getString("follow_up_id") %>>
						<input type="date" id="followUpDate" name="followUpDate" max="31-12-3000" min="01-01-1000" class="form-control col-sm-10 center_div" value=<%=rs.getString("follow_up_date") %>>						
						<input type="time" id="followUpTime" name="followUpTime" min="00:00" max="23:59" class="form-control col-sm-10 center_div" value=<%=rs.getString("follow_up_time") %>>
						<input type="hidden" id="hiddenFollowUpTime" name="hiddenFollowUpTime"  value=<%=rs.getString("follow_up_time") %>>
						<input type="text" id="followUpContact" name="followUpContact" placeholder="Email/Phone" class="form-control col-sm-10 center_div" value=<% if(rs.getString("contact") != null) out.println(rs.getString("contact")); %>>
        				<textarea class="col-sm-10 form-control center_div" placeholder="Follow up notes..." rows="3" name="followUpNote"><% if(rs.getString("note") != null) out.println(rs.getString("note")); %></textarea>
						
					</div>
				</div>
				
			</div>
			
			
		</div>
	</div>
	<% } %>
	</form>
	<%@include  file="../footer.html" %>
		<%
			if (session.getAttribute("updateStatus") != null) {
				if (session.getAttribute("updateStatus").toString().equals("success")) {
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
						session.setAttribute("updateStatus", "killed");
				} else if (session.getAttribute("updateStatus").toString().equals("error")) {
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
						session.setAttribute("updateStatus", "killed");
				}
			}
		%>
		
</body>
<script type="text/javascript">
var myVar=setInterval(function () {myTimer()}, 1000);
var counter = 0;


function myTimer() {
	var now = new Date(),	 
    months = ['January', 'February', '...']; 
    time = now.getHours() + ':' + now.getMinutes() + ':' + now.getSeconds(), 

    date = [now.getDate(), 
            now.getMonth() + 1,
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
	  $('[data-toggle="popover"]').popover();
	  var status = parseInt(document.getElementById("status").value);
	  
	  if(status === 1) {
		  $(':input').attr('readonly','readonly');
		  $("#status").css("pointer-events","none");
		  $('#isFollowUp').prop('disabled',true);
		  document.getElementById("statusImg").style.visibility = "visible";
		  document.getElementById("buttonDiv").style.display = "none";;
	  }
	  
})
function updateStatus() {
  var x = parseInt(document.getElementById("status").value);
 
  if (x === 1) {
	  $(':input').attr('readonly','readonly');
	  $('#isFollowUp').prop('disabled',true);
	  document.getElementById("statusImg").style.visibility = "visible";
  } else {
	  $(':input').attr('readonly', false);  
	  $('#isFollowUp').prop('disabled',false);
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
	
	var status = document.getElementById("status").value;
	var isFollowUp = document.getElementById("isFollowUp").checked;
	var followUpDate = document.getElementById("followUpDate").value;
	var followUpTime = document.getElementById("followUpTime").value;
	var callDurationHR = document.getElementById("callDurationHR").value;
	var callDurationMI = document.getElementById("callDurationMI").value;
	
	if (status == 0) {
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
<% 
} catch (Exception e) {
	
	e.printStackTrace();
	%>
	<script>
		swal({
			title : "Your session timed out!",
			text : "",
			icon : "error",
			button : "Let me loginnn!",
		});
	</script>
	<%
} %>
</html>

