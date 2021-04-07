<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Status Report</title>
<%@include  file="../header.html" %>

	<%
		String userEmail = "";
		String username = "";
		String userID = "";
		Integer entries = 0;
		
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
		st = dbConn.createStatement();
		
		Statement stStatus = null;
		ResultSet rsStatus = null;
		stStatus = dbConn.createStatement();
		
		Statement stUser = null;
		ResultSet rsUser = null;
		stUser = dbConn.createStatement();
		
		Statement stExport = null;
		ResultSet rsExport = null;
		stExport = dbConn.createStatement();
		
		String clause = "";
		String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");
	    String user = request.getParameter("user");
	    String status = request.getParameter("status");
	    
	    System.out.println(user);
	    System.out.println(status);
	 
	    
	    if(startDate != null && endDate != null) {
		   	 if(startDate == "" || endDate == "") {
			    	%>
			    	<script type='text/javascript'>
			    	document.addEventListener("DOMContentLoaded", function(event) {		
			    			swal({
								title : "Invalid dates!",
								text : "",
								icon : "error",
								button : "Aww okiee!",
							});
			    	});
					</script>
			    	<%
			    } else {
			    	if(user != null && !user.equals("0")) {  
				    	clause = "WHERE log_date between '" + startDate + "' and '" + endDate + "' and l.user = " + user;
				    }
				    if(status != null && !status.equals("0")) {  
				    	clause = "WHERE log_date between '" + startDate + "' and '" + endDate + "' and l.status = " + status;
				    }
				    if(user != null && !user.equals("0") && status != null && !status.equals("0")) {  
				    	clause = "WHERE log_date between '" + startDate + "' and '" + endDate + "' and l.user = " + user + " and status = " + status;
				    }
				    if(startDate != "" && endDate != "" && (user == null || user.equals("0")) && (status == null || status.equals("0"))) {
				    	clause = "WHERE log_date between '" + startDate + "' and '" + endDate + "'";
				    }
			    }
		 }
	    
		System.out.println(clause);
	    
		 rs = st.executeQuery(
					"select l.id, l.log_date, l.log_time, l.technician, l.description, l.new_issue, l.new_solution, l.is_voicemail, l.is_instructed, "+
						"ter.name as terminal, l.serial as serialNumber, rel.name as current_release, "+
				        "d.name as dealer, "+
						"u.name as user, "+
				        "iss.name as issue, "+
				        "iss.solution as solution, "+
				        "issmaster.name as category, "+
				        "st.name as status from "+
							"logs as l "+
							"LEFT JOIN dealers as d ON l.dealer = d.id "+
							"LEFT JOIN issues as iss ON iss.id = l.issue "+
							"LEFT JOIN issue_master as issmaster ON issmaster.id = l.issue_master "+
							"LEFT JOIN users as u ON l.user = u.id "+
                         "LEFT JOIN status as st ON l.status = st.id "+
                         "LEFT JOIN terminals as ter ON l.terminal = ter.id "+
                         "LEFT JOIN releases as rel ON l.current_release = rel.id " +
                         clause + 
                		 " ORDER BY l.id DESC");
		 
		 rsExport = stExport.executeQuery(
				 "select l.id, l.log_date, l.log_time, l.technician, l.description, l.new_issue, l.new_solution, l.is_voicemail, l.is_instructed, "+
							"ter.name as terminal, l.serial as serialNumber, rel.name as current_release, "+
					        "d.name as dealer, "+
							"u.name as user, "+
					        "iss.name as issue, "+
					        "iss.solution as solution, "+
					        "issmaster.name as category, "+
					        "st.name as status from "+
								"logs as l "+
								"LEFT JOIN dealers as d ON l.dealer = d.id "+
								"LEFT JOIN issues as iss ON iss.id = l.issue "+
								"LEFT JOIN issue_master as issmaster ON issmaster.id = l.issue_master "+
								"LEFT JOIN users as u ON l.user = u.id "+
	                         "LEFT JOIN status as st ON l.status = st.id "+
	                         "LEFT JOIN terminals as ter ON l.terminal = ter.id "+
	                         "LEFT JOIN releases as rel ON l.current_release = rel.id " +
	                         clause + 
                 			" ORDER BY l.id DESC");
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div"  >
	
	 	<div class="card-header" style="color: white; background-color: #0066cb; ">
			<h5 style="color: white;">Status Report</h5>
		</div>
		
		<div class="card-group">
			<div class="card-body" style="width:66%; padding: 0px; height: 43rem;">
				<!-- Begin -->
					<div class="card mb-3">
				
						<div class="card-body" style="padding: 10px;">
									
								 
								 <form class="form-inline" action="../View/StatusReport.jsp" method="post">
								 	 
								 	 <label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Date:</label> 
									 <input type="date" id="startDate" name="startDate" max="31-12-3000" min="01-01-1000" value="<%=startDate %>" class="form-control col-sm-2">	
									 <label class="col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">To</label> 
									 <input type="date" id="endDate" name="endDate" max="31-12-3000" min="01-01-1000" value="<%=endDate %>" class="form-control col-sm-2">	
									
								 	 <label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">User:</label> 
										<select class="form-control col-sm-2" id="user" name="user">
											<option value="0" selected>All</option>
											<%
												rsUser = stUser.executeQuery("SELECT * FROM users where is_support = 1 and is_active = 1");
						
											while (rsUser.next()) {
											%>
												<option value="<%=rsUser.getString("id")%>" <%
							    		
										    		if(rsUser.getString("id").equals(user)) {
										    			%> selected <% 
										    		}
										    		%>><%=rsUser.getString("name")%></option>
											<%
												}
											%>
										</select>
										
									 <label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Status:</label> 	
										<select class="custom-select col-sm-2 center_div" id="status" name="status">
										<option value="0" selected>All</option>
											<%	
											rsStatus = stStatus.executeQuery("SELECT * FROM status");
											
										    while(rsStatus.next())
										    {   
												%>
										    		<option value="<%=rsStatus.getString("id") %>" <%
							    		
										    		if(rsStatus.getString("id").equals(status)) {
										    			%> selected <% 
										    		}
										    		%>><%=rsStatus.getString("name") %></option>
										    	<%
										    }    
									    
											%>
									</select>
									
									<button type="submit" title="Search" class="btn btn-primary" style="margin-left: 0.5rem;" onclick="this.form.submit();"><i class="fas fa-search"></i></button>
									<button type="button" title="Export as PDF"  class="btn btn-primary" style="margin-left: 0.5rem;" onclick="exportTableToPDF();"><i class="fas fa-file-pdf"></i></button>
									<a href="../View/StatusReport.jsp"><button type="button" title="Reset"  class="btn btn-primary" style="margin-left: 0.5rem;"><i class="fas fa-sync-alt"></i></button></a>
								</form>
								
							</div>
					</div>
					
					<!-- Table -->
					<div class="table-wrap" style="margin: 1rem;">
					<table class="table table-bordered" id="dataTable">
					  <thead>
					    <tr>
					      <th scope="col">#Call</th>
					      <th scope="col">Date/Time</th>
					      <th scope="col">Dealer</th>
					      <th scope="col">Terminal Details</th>
					      <th scope="col">Issue</th>
					      <th scope="col">Description</th>
					      <th scope="col">New Issue</th>
					      <th scope="col">New Solution</th>
					      <th scope="col">Voicemail</th>
					      <th scope="col">Outgoing</th>
					      <th scope="col">Status</th>
					      <th scope="col">Attendee</th>
					      <th scope="col">Update</th>
					    </tr>
					  </thead>
					  <tbody>
					    
					    <%
					
								while (rs.next()) {
										
									entries += 1;
									
									%><tr><%
									%><td scope="row"><%=rs.getString("id") %></td><%		
									%><td style="white-space: nowrap;"><%=rs.getString("log_date") + " <br/> <small>" + rs.getString("log_time") + "</small>"%></td><%	
									%><td style="white-space: nowrap;"><%=rs.getString("technician") + " <br/> <small>" + rs.getString("dealer") + "</small>"%></td><%
									%><td style="white-space: nowrap;"><%
									
									if(rs.getString("terminal") != null) {
										out.print(rs.getString("terminal") + " ");
									}
																		
									if(rs.getString("serialNumber") != null) {
										out.print(rs.getString("serialNumber"));
									}
									
									if(rs.getString("current_release") != null) {
										out.print(" <br/> <small>" + rs.getString("current_release") + "</small>");
									}
									%></td><%
									%><td style="white-space: nowrap;"><%=rs.getString("issue") + " <br/> <small>" + rs.getString("category") + "</small>" %></td><%
									%><td><small><%=rs.getString("description") %></small></td><%
									%><td><small><%=rs.getString("new_issue") %></small></td><%
									%><td><small><%=rs.getString("new_solution") %></small></td><%
									%><td><%
											if(rs.getString("is_voicemail").equals("1")) {
												%>
													<center><img alt="" width="22px" src="../IMAGES/yes.svg"></center>
												<% }
									%></td><%
									%><td><%
									if(rs.getString("is_instructed").equals("1")) {
										%>
											<center><img alt="" width="22px" src="../IMAGES/yes.svg"></center>
										<% }
									%></td><%									
									%><td><%=rs.getString("status") %></td><%
									%><td><%=rs.getString("user") %></td><%
									%><td><center><a href=../View/HistoryDetails.jsp?log=<%=rs.getString("id") %>><i class="fas fa-edit"></i></a></center></td><%
									%></tr><%
								}
						%>
					  </tbody>
					  
					</table>
					<!-- Hidden table for export -->
					<div id=tab style="display: none;">

						<table style="border-collapse: collapse; width: 100%;" border="0">
							<tbody>
								<tr>
									<td style="width: 50%;"><img
										src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg"
										alt="skyzer-logo" width="370" height="49" /></td>
									<td style="width: 50%;">
										<p style="text-align: right;">
											<strong>Skyzer Technologies<br /></strong>269 Mount Smart
											Road,<br />Onehunga, Auckland 1061<br />New Zealand
										</p>
										<p style="text-align: right;">
											Telephone:&nbsp;<a href="tel:+6492590322">+64 9 259 0322</a>
										</p>
									</td>
								</tr>
							</tbody>
						</table>
						<hr />
						<h2 style="text-align: center;">Support Status Report</h2>
						<p>Status: <span id="pdfStatus">All</span></p>
						<p>Period: <span id="pdfStartDate">##/##/####</span> - <span id="pdfEndDate">##/##/####</span></p>

						<table style="font-family: arial, sans-serif;  border-collapse: collapse;  width: 100%;">
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead>
						    <tr>
						      <th style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;">Date/Time</th>
						      <th style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;">Technician</th>
						      <th style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;">Terminal Details</th>
						      <th style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;">Issue</th>
						      <th style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;">Possible Solutions</th>
						      <th style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;">Status</th>
						    </tr>
						  </thead>
						  <tbody>
						    
						    <%
									while (rsExport.next()) {
										
										%><tr><%
										%><td style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;"><%=rsExport.getString("log_date") + " " + rsExport.getString("log_time")%></td><%	
										%><td style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;"><%=rsExport.getString("technician")%></td><%
										%><td style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;"><%
										if(rsExport.getString("terminal") != null) {
											out.print(rsExport.getString("terminal"));
										} else {
											out.print(" ");	
										}
																			
										if(rsExport.getString("serialNumber") != null) {
											out.print(rsExport.getString("serialNumber"));
										} else {
											out.print(" ");	
										}
										%></td><%
										
										%><td style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;"><%=rsExport.getString("issue")%></td><%
										%><td style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;"><%=rsExport.getString("solution")%></td><%
										%><td style="border: 1px solid #dddddd;  text-align: left;  padding: 8px;"><%=rsExport.getString("status")%></td><%
										%></tr><%
									}
							%>
						  </tbody>
						</table>
					</div>
					</div>
					<!-- End export -->
					</div>
				<!-- End -->
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
            now.getMonth() + 1,
            now.getFullYear()].join('-');

	document.getElementById('clock').innerHTML = [date, time].join(' / ');
	
	setTimeout(myTimer, 1000);//This method will call for every second
}

function downloadCSV(csv, filename) {
	
	var csvFile;
	var downloadLink;
	
	csvFile = new Blob([csv], {type: "text/csv"});
	
	downloadLink = document.createElement("a");
	downloadLink.download = filename;
	downloadLink.href = window.URL.createObjectURL(csvFile);
	downloadLink.style.display = "none";
	
	document.body.appendChild(downloadLink);
	
	downloadLink.click();
}

// PDF Report Strats
$(document).ready(function() {   
	document.getElementById("pdfStatus").innerHTML = $("#status option:selected").text();
	document.getElementById("pdfStartDate").innerHTML = $('#startDate').val();;
	document.getElementById("pdfEndDate").innerHTML = $('#endDate').val();
});

function exportTableToPDF() {
	
	var sTable = document.getElementById('tab').innerHTML;
	var win = window.open("file.pdf", "_blank");

    win.document.write('<html><head>');
    win.document.write('</head>');
    win.document.write('<body>');
    win.document.write(sTable);         // THE TABLE CONTENTS INSIDE THE BODY TAG.
    win.document.write('</body></html>');

    win.document.close(); 	// CLOSE THE CURRENT WINDOW.
    win.print();
    
    
}
//PDF Report Ends

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
