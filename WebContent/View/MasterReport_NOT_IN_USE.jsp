<%@page import="com.sun.org.apache.xpath.internal.operations.Bool"%>
<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Report</title>
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
		
		Statement stUser = null;
		ResultSet rsUser = null;
		stUser = dbConn.createStatement();
		
		Statement stTerminal = null;
		ResultSet rsTerminal = null;
		stTerminal = dbConn.createStatement();
		
		Statement stTechnician = null;
		ResultSet rsTechnician = null;
		stTechnician = dbConn.createStatement();
		
		Statement stRelease = null;
		ResultSet rsRelease = null;
		stRelease = dbConn.createStatement();
		
		Statement stDealer = null;
		ResultSet rsDealer = null;
		stDealer = dbConn.createStatement();
		
		Statement stIssueMaster = null;
		ResultSet rsIssueMaster = null;
		stIssueMaster = dbConn.createStatement();
		
		Statement stIssue = null;
		ResultSet rsIssue = null;
		stIssue = dbConn.createStatement();
		
		Statement stStatus = null;
		ResultSet rsStatus = null;
		stStatus = dbConn.createStatement();
		
		Statement st = null;
		ResultSet rs = null;
		st = dbConn.createStatement();
		 
		
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String user =  request.getParameter("user");
		String terminal =  request.getParameter("terminal");
		String release =  request.getParameter("release");
		String dealer =  request.getParameter("hiddenDealerID");
		String issueMaster =  request.getParameter("hiddenIssueMasterID");
		String issue =  request.getParameter("hiddenIssueID");
		String status =  request.getParameter("status");
		String[] voicemail = request.getParameterValues("isVoicemail");
		String[] instructed = request.getParameterValues("isInstructed");
		Boolean isVoicemail = false;
		Boolean isInstructed = false;
		
		if(voicemail != null)
			isVoicemail = true;
		
		if(instructed != null)
			isInstructed = true;
		
		System.out.println(startDate);
		System.out.println(endDate);
		System.out.println(user);
		System.out.println(terminal);
		System.out.println(release);
		System.out.println(dealer);
		System.out.println(issueMaster);
		System.out.println(issue);
		System.out.println(status);
		System.out.println(isVoicemail);
		System.out.println(isInstructed);
		
		String clause = "";
		

		if((startDate != null && startDate != "") &&
				(endDate != null && endDate != "") &&
				(!user.equals("0") && user != null) &&
				(!terminal.equals("0") && terminal != null) &&
				(!release.equals("0") && release != null) &&
				(!dealer.equals("0") && dealer != null) &&
				(!issueMaster.equals("0") && issueMaster != null) &&
				(!issue.equals("0") && issue != null) &&
				(!status.equals("0") && status != null) &&
				(isVoicemail != null) &&
				(isInstructed != null)) {
			
			clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate + "'" +
						" and l.user = " + user +
						" and l.terminal = " + terminal +
						" and l.current_release = " + release +
						" and l.dealer = " + dealer +
						" and l.issue_master = " + issueMaster +
						" and l.issue = " + issue +
						" and l.status = " + status +
						" and l.is_voicemail = " + isVoicemail +
						" and l.is_instructed = " + isInstructed;
		}
		
		
		System.out.print(clause);
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div">
	
	 	<div class="card-header" style="color: white; background-color: #0066cb; ">
			<h5 style="color: white;">Report</h5>
		</div>
		
		<div class="card-group">
			<div class="card-body" style="width:66%; padding: 0px; height: 43rem;">
				<!-- Begin -->
					<div class="card mb-3">
				
						<div class="card-body" style="padding: 10px;">
							<form action="../View/MasterReport.jsp" method="post">		
								 
								 <div class="form-inline" action="#" method="post">
								 	 
								 	<input type="date"  max="31-12-3000" min="01-01-1000" class="form-control col-sm-2" name="startDate">	
									&nbsp; To &nbsp;
									<input type="date"  max="31-12-3000" min="01-01-1000" class="form-control col-sm-2" name="endDate">
									&nbsp;
								 	<select class="form-control col-sm-2" name="user">
										<option value="0" selected>Select user...</option>
										<%
											rsUser = stUser.executeQuery("SELECT * FROM users where is_support = 1");
					
										while (rsUser.next()) {
										%>
											<option value="<%=rsUser.getString("id")%>"><%=rsUser.getString("name")%></option>
										<%
											}
										%>
									</select>
									&nbsp;
	                        		<select class="form-control col-sm-2 center_div" id="terminal" name="terminal">
										<option value="0" selected>Select terminal...</option>
											<%	
											rsTerminal = stTerminal.executeQuery("SELECT * FROM terminals");
											
										    while(rsTerminal.next())
										    {   
												%>
										    		<option value="<%=rsTerminal.getString("id") %>"><%=rsTerminal.getString("name") %></option>
										    	<%
										    }    
									    
											%>
									</select>
									&nbsp;
	                        		<select class="form-control col-sm-3 center_div" id="release" name="release">
										<option value="0" selected>Select software release...</option>
											<%	
											rsRelease = stRelease.executeQuery("SELECT * FROM releases");
											
										    while(rsRelease.next())
										    {   
												%>
										    		<option value="<%=rsRelease.getString("id") %>"><%=rsRelease.getString("name") %></option>
										    	<%
										    }    
									    
											%>
									</select>
								</div>
								
								<div class="form-inline" action="#" method="post">
								 	 
									<input class=" form-control col-sm-2" list="dealers" id="dealer" name="dealer" placeholder="Select dealer...">
									<datalist id="dealers">
										<%	
											 rsDealer = stTechnician.executeQuery("select * from dealers");
			
										    while(rsDealer.next())
										    {   
												%>
													<option data-dealer=<%=rsDealer.getString("id") %>><%=rsDealer.getString("name") %></option>
			
										    	<%
										    }    
										%>
									</datalist>
	                        		<input type="hidden" id="hiddenDealerID" name="hiddenDealerID" value="0"/>
	                        		&nbsp;&nbsp;&nbsp;
									<input class=" form-control col-sm-2" list="issuesMaster" id="issueMaster" name="issueMaster" placeholder="Select issue category...">
									<datalist id="issuesMaster">
										<%	
											 rsIssueMaster = stIssueMaster.executeQuery("select * from issue_master");
			
										    while(rsIssueMaster.next())
										    {   
												%>
													<option data-issue-master=<%=rsIssueMaster.getString("id") %>><%=rsIssueMaster.getString("name") %></option>
			
										    	<%
										    }    
										%>
									</datalist>
	                        		<input type="hidden" id="hiddenIssueMasterID" name="hiddenIssueMasterID" value="0"/>
	                        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input class=" form-control col-sm-2" list="issues" id="issue" name="issue" placeholder="Select issue...">
									<datalist id="issues">
										<%	
											 rsIssue = stIssue.executeQuery("select * from issues");
			
										    while(rsIssue.next())
										    {   
												%>
													<option data-issue=<%=rsIssue.getString("id") %>><%=rsIssue.getString("name") %></option>
			
										    	<%
										    }    
										%>
									</datalist>
	                        		<input type="hidden" id="hiddenIssueID" name="hiddenIssueID" value="0"/>
	                        		&nbsp;
	                        		<select class="custom-select col-sm-2 center_div" id="status" name="status">
										<option value="0" selected>Select status...</option>
											<%	
											rsStatus = stStatus.executeQuery("SELECT * FROM status");
											
										    while(rsStatus.next())
										    {   
												%>
										    		<option value="<%=rsStatus.getString("id") %>"><%=rsStatus.getString("name") %></option>
										    	<%
										    }    
									    
											%>
									</select>
									&nbsp;&nbsp;&nbsp;&nbsp;
	                        		<input type="checkbox" class="form-check-input" name="isVoicemail">
   							 		<label class="form-check-label">Voicemail</label>
   							 		&nbsp;&nbsp;&nbsp;
   							 		<input type="checkbox" class="form-check-input" name="isInstructed">
   							 		<label class="form-check-label">Outgoing</label>
									<button type="submit" class="btn btn-primary" style="margin-left: 0.5rem;" onclick="this.form.submit();">Search</button>
									<button type="button" class="btn btn-primary" style="margin-left: 0.5rem;"><i class="fas fa-download"></i>&nbsp;Export</button>
									<a href="../View/Report.jsp"><button type="button" class="btn btn-primary" style="margin-left: 0.5rem;"><i class="fas fa-sync-alt"></i></button></a>
								</div>
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
					      <th scope="col">Terminal</th>
					      <th scope="col">Issue</th>
					      <th scope="col">Description</th>
					      <th scope="col">New Issue</th>
					      <th scope="col">New Solution</th>
					      <th scope="col">Voicemail</th>
					      <th scope="col">Outgoing</th>
					      <th scope="col">Status</th>
					    </tr>
					  </thead>
					  <tbody>
					    
					    <%
					  		  rs = st.executeQuery(
								"select l.id, l.log_date, l.log_time, l.description, l.new_issue, l.new_solution, l.is_voicemail, l.is_instructed, "+
									"ter.name as terminal, l.serial as serialNumber, rel.name as current_release, "+
									"dt.name as technician, "+
							        "d.name as dealer, "+
									"u.name as user, "+
							        "iss.name as issue, "+
							        "issmaster.name as category, "+
							        "st.name as status from "+
										"logs as l "+
		                                "INNER JOIN dealer_technicians as dt ON l.dealer_technician = dt.id "+
										"INNER JOIN dealers as d ON dt.dealer = d.id "+
										"INNER JOIN issues as iss ON iss.id = l.issue "+
										"INNER JOIN issue_master as issmaster ON issmaster.id = l.issue_master "+
										"INNER JOIN users as u ON l.user = u.id "+
		                                "INNER JOIN status as st ON l.status = st.id "+
		                                "LEFT JOIN terminals as ter ON l.terminal = ter.id "+
                                        "LEFT JOIN releases as rel ON l.current_release = rel.id " +
                                        clause);
					
								while (rs.next()) {
										
									%><tr><%
										%><td scope="row"><%=rs.getString("id") %></td><%		
										%><td style="white-space: nowrap;"><%=rs.getString("log_date") + " <br/> <small>" + rs.getString("log_time") + "</small>"%></td><%	
										%><td style="white-space: nowrap;"><%=rs.getString("technician") + " <br/> <small>" + rs.getString("dealer") + "</small>"%></td><%
										%><td style="white-space: nowrap;"><%=rs.getString("terminal") + " - " + rs.getString("serialNumber") + " <br/> <small>" + rs.getString("current_release") + "</small>" %></td><%
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
									%></tr><%
								}
										
						%>
					  </tbody>
					  
					</table>
					</div>
				<!-- End -->
			</div>
		</div>
	</div>
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
$("#dealer").change(function() {
	var val = $('#dealer').val()
	var dealerID = $('#dealers option').filter(function() {
	        return this.value == val;
	    }).data('dealer');
	 
	 document.getElementById("hiddenDealerID").value  = dealerID;
	 
})
$("#issueMaster").change(function() {
	var val = $('#issueMaster').val()
	var issueMasterID = $('#issuesMaster option').filter(function() {
	        return this.value == val;
	    }).data('issue-master');
	 
	 document.getElementById("hiddenIssueMasterID").value  = issueMasterID;
	 
})
$("#issue").change(function() {
	var val = $('#issue').val()
	var issueID = $('#issues option').filter(function() {
	        return this.value == val;
	    }).data('issue');
	 
	 document.getElementById("hiddenIssueID").value  = issueID;
	 
})
</script>
</html>
