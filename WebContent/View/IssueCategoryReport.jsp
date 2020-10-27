<%@page import="java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="db.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Issue Category Report</title>
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
		
		Statement stIssueMaster = null;
		ResultSet rsIssueMaster = null;
		stIssueMaster = dbConn.createStatement();
		
		Statement stIssue = null;
		ResultSet rsIssue = null;
		stIssue = dbConn.createStatement();
		
		Statement stRelease = null;
		ResultSet rsRelease = null;
		stRelease = dbConn.createStatement();
		
		Statement stTerminal = null;
		ResultSet rsTerminal = null;
		stTerminal = dbConn.createStatement();
		
		String clause = "";
	    String startDate = request.getParameter("startDate");
	    String endDate = request.getParameter("endDate");
	    String issueMaster =  request.getParameter("hiddenIssueMasterID");
	    String issueMasterString =  request.getParameter("issueMaster");
		String issue =  request.getParameter("hiddenIssueID");
		String issueString =  request.getParameter("issue");
		String release =  request.getParameter("release");
		String terminal =  request.getParameter("terminal");
	    
	   	if(issueMaster != null) {
	   		if(issueMaster.equals("0") || issueMaster.equals("undefined") || startDate == "" || endDate == "") {
		   		%>
		    	<script type='text/javascript'>
		    	document.addEventListener("DOMContentLoaded", function(event) {		
		    			swal({
							title : "Invalid dates/category!",
							text : "",
							icon : "error",
							button : "Aww okiee!",
						});
		    	});
				</script>
		    	<%
		   	} else if ((issue.equals("0") || issue.equals("undefined")) && release.equals("0") && terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + issueMaster;
		   	} else if ((!issue.equals("0") && !issue.equals("undefined")) && release.equals("0") && terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + issueMaster + " and l.issue = " + issue;
		   	} else if ((!issue.equals("0") && !issue.equals("undefined")) && !release.equals("0") && terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + 
		   					issueMaster + " and l.issue = " + issue + " and l.current_release = " + release;
		   	} else if ((!issue.equals("0") && !issue.equals("undefined")) && !release.equals("0") && !terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + 
	   					issueMaster + " and l.issue = " + issue + " and l.current_release = " + release + " and l.terminal = " + terminal;
	   		} else if ((issue.equals("0") || issue.equals("undefined")) && !release.equals("0") && !terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + 
	   					issueMaster + " and l.current_release = " + release + " and l.terminal = " + terminal;
	   		} else if ((issue.equals("0") || issue.equals("undefined")) && release.equals("0") && !terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + 
	   					issueMaster + " and l.terminal = " + terminal;
	   		} else if ((issue.equals("0") || issue.equals("undefined")) && !release.equals("0") && terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + 
	   					issueMaster + " and l.current_release = " + release;
	   		} else if ((!issue.equals("0") || !issue.equals("undefined")) && release.equals("0") && !terminal.equals("0")) {
		   		clause = "WHERE l.log_date between '" + startDate + "' and '" + endDate  + "' and l.issue_master = " + 
	   					issueMaster + " and l.issue = " + issue + " and l.terminal = " + terminal;
	   		}
	   	}
		
	   	 System.out.println("--");
		 System.out.println(startDate);
		 System.out.println(endDate);
		 System.out.println(issueMaster);
		 System.out.println(issueMasterString);
		 System.out.println(issue);
		 System.out.println(issueString);
		 System.out.println(release);
		 System.out.println(terminal);
		 System.out.println(clause);
		 
	    
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div"  >
	
	 	<div class="card-header" style="color: white; background-color: #0066cb; ">
			<h5 style="color: white;">Issue Category Report</h5>
		</div>
		
		<div class="card-group">
			<div class="card-body" style="width:66%; padding: 0px; height: 43rem;">
				<!-- Begin -->
					<div class="card mb-3">
				
						<div class="card-body" style="padding: 10px;">
									
								 
								 <form class="form-inline" action="../View/IssueCategoryReport.jsp" method="post">
								 	 
								 	 <label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Date:</label> 
									 <input type="date" id="startDate" name="startDate" max="31-12-3000" min="01-01-1000" value="<%=startDate %>" class="form-control col-sm-1.5">	
									 
									 <label class="col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">To</label> 
									 <input type="date" id="endDate" name="endDate" max="31-12-3000" min="01-01-1000" value="<%=endDate %>" class="form-control col-sm-1.5">	
									
									<input class=" form-control col-sm-1.5" list="issuesMaster" id="issueMaster" name="issueMaster" style="margin-left: 0.5rem" placeholder="Select issue category..." value="<% if(issueMasterString != null) out.print(issueMasterString); %>">
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
									<input type="hidden" id="hiddenIssueMasterID" name="hiddenIssueMasterID" value="<% int issueMasterDefault = 0; if(issueMaster != null) out.print(issueMaster); else out.print(issueMasterDefault); %>"/>
									
									<input class="form-control col-sm-2" list="issues" id="issue" name="issue" style="margin-left: 0.5rem" placeholder="Select issue..." value="<% if(issueString != null) out.print(issueString); %>">
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
									<input type="hidden" id="hiddenIssueID" name="hiddenIssueID" value="<% int issueDefault = 0; if(issue != null) out.print(issue); else out.print(issueDefault); %>"/>
									
									<select class="form-control col-sm-1.5" name="release" style="margin-left: 0.5rem">
									<option value ="0" selected>Select release...</option>
									<%	
									rsRelease = stRelease.executeQuery("SELECT * FROM releases");
									
								    while(rsRelease.next())
								    {   
										%>
								    		<option value="<%=rsRelease.getString("id") %>"
								    		<%
							    		
										    if(rsRelease.getString("id").equals(release)) {
										    %> selected <% 
										    }
										    %>
								    		><%=rsRelease.getString("name") %></option>
								    	<%
								    }    
							    
									%>
									</select>
									
									<select class="form-control col-sm-1.5" name="terminal" style="margin-left: 0.5rem">
									<option value ="0" selected>Select terminal type...</option>
									<%	
									rsTerminal  = stTerminal .executeQuery("SELECT * FROM terminals");
									
								    while(rsTerminal .next())
								    {   
										%>
								    		<option value="<%=rsTerminal.getString("id") %>"
								    		<%
							    		
										    if(rsTerminal.getString("id").equals(terminal)) {
										    %> selected <% 
										    }
										    %>
										    ><%=rsTerminal .getString("name") %></option>
								    	<%
								    }    
							    
									%>
									</select>
									
									<button type="submit" class="btn btn-primary" style="margin-left: 0.5rem;" onclick="this.form.submit();">Search</button>
									<a href="../View/IssueCategoryReport.jsp"><button type="button" class="btn btn-primary" style="margin-left: 0.5rem;"><i class="fas fa-sync-alt"></i></button></a>
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
					      <th scope="col">Update</th>
					    </tr>
					  </thead>
					  <tbody>
					    
					    <%
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
                                        clause);
					
								while (rs.next()) {
										
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
									%><td><center><a href=../View/HistoryDetails.jsp?log=<%=rs.getString("id") %>><i class="fas fa-edit"></i></a></center></td><%
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