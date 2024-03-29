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
<title>Skybook - General Report</title>
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
		
		Statement stExport = null;
		ResultSet rsExport = null;
		stExport = dbConn.createStatement();
		
		String clause = "";
	    String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");
	    
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
			    	clause = "WHERE log_date between '" + startDate + "' and '" + endDate + "'";
			    }
		   }
		
		 System.out.println(clause);
	    
		 rs = st.executeQuery(
					"select l.id, l.log_date, l.log_time, l.technician, l.description, l.new_issue, l.new_solution, l.is_voicemail, l.is_instructed, "+
						"ter.name as terminal, l.serial as serialNumber, rel.name as current_release, "+
				        "d.name as dealer, "+
						"u.name as user, "+
				        "iss.name as issue, "+
				        "issmaster.name as category, "+
				        "st.name as status from "+
							"logs as l "+
							"INNER JOIN dealers as d ON l.dealer = d.id "+
							"INNER JOIN issues as iss ON iss.id = l.issue "+
							"INNER JOIN issue_master as issmaster ON issmaster.id = l.issue_master "+
							"INNER JOIN users as u ON l.user = u.id "+
                         "INNER JOIN status as st ON l.status = st.id "+
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
					        "issmaster.name as category, "+
					        "st.name as status from "+
								"logs as l "+
								"INNER JOIN dealers as d ON l.dealer = d.id "+
								"INNER JOIN issues as iss ON iss.id = l.issue "+
								"INNER JOIN issue_master as issmaster ON issmaster.id = l.issue_master "+
								"INNER JOIN users as u ON l.user = u.id "+
	                         "INNER JOIN status as st ON l.status = st.id "+
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
			<h5 style="color: white;">General Report</h5>
		</div>
		
		<div class="card-group">
			<div class="card-body" style="width:66%; padding: 0px; height: 43rem;">
				<!-- Begin -->
					<div class="card mb-3">
				
						<div class="card-body" style="padding: 10px;">
									
								 
								 <form class="form-inline" action="../View/GeneralReport.jsp" method="post">
								 	 
								 	 <label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Date:</label> 
									 <input type="date" id="startDate" name="startDate" max="31-12-3000" min="01-01-1000" value="<%=startDate %>" class="form-control col-sm-2">	
									 <label class="col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">To</label> 
									 <input type="date" id="endDate" name="endDate" max="31-12-3000" min="01-01-1000" value="<%=endDate %>" class="form-control col-sm-2">	
									
									<button type="submit" title="Search"  class="btn btn-primary" style="margin-left: 0.5rem;" onclick="this.form.submit();"><i class="fas fa-search"></i></button>
									<button type="button" title="Export" class="btn btn-primary" style="margin-left: 0.5rem;" onclick="exportTableToCSV('General Report.csv');"><i class="fas fa-file-download"></i></button>
									<a href="../View/GeneralReport.jsp"><button type="button" title="Reset" class="btn btn-primary" style="margin-left: 0.5rem;"><i class="fas fa-sync-alt"></i></button></a>
								</form>
								
							</div>
					</div>
					
					<!-- Table -->
					<div class="table-wrap">
					<table class="table table-bordered">
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
					<table class="table table-bordered" id="exportTable" style="display: none;">
					  <thead>
					    <tr>
					      <th scope="col">#Call</th>
					      <th scope="col">Date/Time</th>
					      <th scope="col">Technician</th>
					      <th scope="col">Dealer</th>
					      <th scope="col">Terminal Details</th>
					      <th scope="col">Current Release</th>
					      <th scope="col">Issue Category</th>
					      <th scope="col">Issue</th>
					      <th scope="col">Description</th>
					      <th scope="col">New Issue</th>
					      <th scope="col">New Solution</th>
					      <th scope="col">Voicemail</th>
					      <th scope="col">Outgoing</th>
					       <th scope="col">Status</th>
					      <th scope="col">Attendee</th>
					    </tr>
					  </thead>
					  <tbody>
					    
					    <%
								while (rsExport.next()) {
									
									%><tr><%
									%><td><%=rsExport.getString("id") %></td><%		
									%><td><%='\"'+rsExport.getString("log_date") + " " + rsExport.getString("log_time") + '\"'%></td><%	
									%><td><%='\"'+rsExport.getString("technician")+'\"'%></td><%
									%><td><%='\"'+rsExport.getString("dealer")+'\"'%></td><%
									%><td><%
									if(rsExport.getString("terminal") != null) {
										out.print('\"' + rsExport.getString("terminal") + " ");
									} else {
										out.print('\"' + " ");	
									}
																		
									if(rsExport.getString("serialNumber") != null) {
										out.print(rsExport.getString("serialNumber") + '\"');
									} else {
										out.print(" " + '\"');	
									}
									%></td><%
									%><td><%
									
									if(rsExport.getString("current_release") != null) {
										out.print('\"' + rsExport.getString("current_release") + '\"');
									} else {
										out.print('\"' + " " + '\"');	
									}
									%></td><%
									%><td><%='\"'+rsExport.getString("category") + '\"'%></td><%
									%><td><%='\"'+rsExport.getString("issue") + '\"'%></td><%
									%><td><%='\"'+rsExport.getString("description") + '\"'%></td><%
									%><td><%='\"'+rsExport.getString("new_issue") + '\"'%></td><%
									%><td><%='\"'+rsExport.getString("new_solution") + '\"'%></td><%
									%><td><%
											if(rsExport.getString("is_voicemail").equals("1")) {
												out.print('\"' + "Yes" + '\"');
											} else {
												out.print('\"' + "-" + '\"');	
											}
									%></td><%
									%><td><%
											if(rsExport.getString("is_instructed").equals("1")) {
												out.print('\"' + "Yes" + '\"');
											} else {
												out.print('\"' + "-" + '\"');	
											}
									%></td><%									
									%><td><%='\"'+rsExport.getString("status") + '\"'%></td><%
									%><td><%='\"'+rsExport.getString("user") + '\"'%></td><%	
									%></tr><%
								}
						%>
					  </tbody>
					  
					</table>
					<!-- End export -->
					</div>
				<!-- End -->
			</div>
		</div>
	</div>
	<%@include  file="../footer.html" %>
</body>

<script type="text/javascript">
var counter = 0;


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

function exportTableToCSV(filename) {
	
	var csv = [];
	var rows = document.getElementById('exportTable').getElementsByTagName('tr');
	
	for(var i = 0; i < rows.length; i++) {
		var row = [];
		var cols = rows[i].querySelectorAll("td, th");
		
		for(var j = 0; j < cols.length; j++) {
			row.push(cols[j].innerText);
		}
		
		csv.push(row.join(","));
	}
	
	downloadCSV(csv.join("\n"), filename);
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
