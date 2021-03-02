<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.util.Date" %>
<%@ page language="java" import="java.time.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Call Metrics</title>
<%@include  file="../header.html" %>

	<%
		final int RESOLVED = 1;
	
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
		
		Statement stUserOutstanding = null;
		ResultSet rsUserOutstanding = null;
		stUserOutstanding = dbConn.createStatement();
		
		
		String clause = ""; 
		String filteredMonth = request.getParameter("month");
		
		Date date = new Date();
		LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		int month = localDate.getMonthValue();
		Integer selectedMonth = month;
		
		if(filteredMonth != null && Integer.valueOf(filteredMonth) > 0) {
			clause = "WHERE MONTH(log_date) = " + filteredMonth;
			selectedMonth = Integer.valueOf(filteredMonth);
		} else if (filteredMonth != null && Integer.valueOf(filteredMonth) == 0) {
			//clause = "WHERE YEAR(log_date) = YEAR(CURRENT_DATE)";
			clause ="WHERE 1=1";
			selectedMonth = Integer.valueOf(filteredMonth);
		} else if (filteredMonth != null && Integer.valueOf(filteredMonth) == -1) {
			clause = "WHERE YEAR(log_date) = YEAR(CURRENT_DATE)";
			selectedMonth = Integer.valueOf(filteredMonth);
		} else {
			clause = "WHERE MONTH(log_date) = " + month;
		}
		
		
		// Total calls
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as totalCalls FROM logs " + clause );
		int totalCalls = 0;
		while(rs.next()) {
			totalCalls = rs.getInt("totalCalls");
		}
		
		// Outstanding calls
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as outstandingCalls FROM logs " + clause + " AND status != " + RESOLVED);
		int outstandingCalls = 0;
		while(rs.next()) {
			outstandingCalls = rs.getInt("outstandingCalls");
		}	
		
		// Outstanding calls
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as resolvedCalls FROM logs " + clause + " AND status = " + RESOLVED);
		int resolvedCalls = 0;
		while(rs.next()) {
			resolvedCalls = rs.getInt("resolvedCalls");
		}
		
		// Top 10 Issues
		rs = null;
		rs = st.executeQuery("select issues.name as issue, count(logs.id) as total from issues LEFT JOIN logs ON issues.id = logs.issue " + clause + " group by issue order by total DESC LIMIT 10");
		
		// Outstanding issue
		rsUserOutstanding = stUserOutstanding.executeQuery(
					"select l.id, l.log_date, l.log_time, l.technician, l.description, l.new_issue, l.new_solution, l.is_voicemail, l.is_instructed, "+
						"ter.name as terminal, l.serial as serialNumber, rel.name as current_release, "+
				        "d.name as dealer, "+
						"u.name as user, "+
				        "iss.name as issue, "+
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
                         " AND l.status != " + RESOLVED);
		
		System.out.println(selectedMonth);
		System.out.println(clause);
		
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div"  >
	
	 	<div class="card-header" style="color: white; background-color: #0066cb; display: flex; justify-content: space-around">
			<div style="width: 70%;">
				<h5 style="color: white;">Call Metrics</h5>
			</div>
			<div style="color: white; margin-left: auto; margin-right: 5px; width: 10%;">
				 <form action="../View/CallMetrics.jsp" method="post">
					 <select class="custom-select" name="month" onchange="this.form.submit();">
						<option value="0" <% if(selectedMonth == 0) {	%> selected <% } %>>All</option>
						<option value="-1" <% if(selectedMonth == -1) {	%> selected <% } %>>This Year</option>
						<option value="1" <% if(selectedMonth == 1) {	%> selected <% } %>>Jan</option>
						<option value="2" <% if(selectedMonth == 2) {	%> selected <% } %>>Feb</option>
						<option value="3" <% if(selectedMonth == 3) {	%> selected <% } %>>Mar</option>
						<option value="4" <% if(selectedMonth == 4) {	%> selected <% } %>>Apr</option>
						<option value="5" <% if(selectedMonth == 5) {	%> selected <% } %>>May</option>
						<option value="6" <% if(selectedMonth == 6) {	%> selected <% } %>>Jun</option>
						<option value="7" <% if(selectedMonth == 7) {	%> selected <% } %>>Jul</option>
						<option value="8" <% if(selectedMonth == 8) {	%> selected <% } %>>Aug</option>
						<option value="9" <% if(selectedMonth == 9) {	%> selected <% } %>>Sep</option>
						<option value="10" <% if(selectedMonth == 10) {	%> selected <% } %>>Oct</option>
						<option value="11" <% if(selectedMonth == 11) {	%> selected <% } %>>Nov</option>
						<option value="12" <% if(selectedMonth == 12) {	%> selected <% } %>>Dec</option>						
					</select>
				</form>
			</div>
		</div>
		
		<div class="card-group">
			<div class="card-body" style="width:66%; padding: 0px;">
				<!-- Begin -->
				 <!-- Main Content -->
            <div id="content"  style="margin-top: 10px;">

                <!-- Begin Page Content -->
                <div class="container-fluid">
	
                    	<!-- Content Row -->
	                    <div class="row">
	
								<div class="col-xl-4 col-md-7 mb-5">
								<div class="card mb-4 bg-warning border-0">
										<div class="card-body">
											<h5 class="text-white">Outstanding Calls</h5>
											<div class="mb-4">
												<span class="display-4 text-white"><%=outstandingCalls %></span> 
											</div>
										</div>
									</div>	
								</div>
								
								<div class="col-xl-4 col-md-7 mb-5">
								<div class="card mb-4 bg-green border-0">
										<div class="card-body">
											<h5 class="text-white">Resolved Calls</h5>
											<div class="mb-4">
												<span class="display-4 text-white"><%=resolvedCalls %></span> 
											</div>
										</div>
									</div>	
								</div>						
	
								<div class="col-xl-4 col-md-7 mb-5">
								<div class="card mb-4 bg-secondary border-0">
										<div class="card-body">
											<h5 class="text-white">Total Calls</h5>
											<div class="mb-4">
												<span class="display-4 text-white"><%=totalCalls %></span> 
											</div>
										</div>
									</div>	
								</div>	
								
	                    </div>
	                    
	                    <div class="row">
                                    <div class="col-xl-4 col-md-7 mb-5">
                                       
                                        <div class="card mb-4">
                                            <div class="card-header"><i class="fas fa-bug fa-1x"></i> Top Issues</div>
                                            <div class="card-body">
                                            
                                             <%  while(rs.next()) { %>
                                                <!-- Item -->
                                                <div class="d-flex align-items-center justify-content-between mb-4">
                                                    <div class="d-flex align-items-center flex-shrink-0 mr-3">
                                                        <div class="d-flex flex-column font-weight-bold">
                                                            <a class="text-dark line-height-normal mb-1" href="#!"><%=rs.getString("issue") %></a>
                                                            <div class="small text-muted line-height-normal">Number of issues: <%=rs.getString("total") %></div>
                                                        </div>
                                                    </div>
                                                </div>
                                             <% } %>   
                                                
                                     		</div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-8 mb-4">
                                       
                                        <div class="card mb-4">
                                            <div class="card-header"><i class="fas fa-bug fa-1x"></i> Outstanding Issues</div>
                                            <div class="card-body">
                                            
                                               <div class="table-wrap" style="margin: 1rem;">
                                               
                                               	<table class="table table-bordered" id="dataTable">
												  <thead>
												    <tr>
												      <th scope="col">#Call</th>
												      <th scope="col">Dealer</th>
												      <th scope="col">Issue</th>
												      <th scope="col">Description</th>
												      <th scope="col">New Issue</th>
												      <th scope="col">New Solution</th>
												      <th scope="col">More</th>
												    </tr>
												  </thead>
												  <tbody>
												   <%
					
															while (rsUserOutstanding.next()) {
																	
																%><tr><%
																%><td scope="row"><%=rsUserOutstanding.getString("id") %></td><%		
																%><td style="white-space: nowrap;"><%=rsUserOutstanding.getString("technician") + " <br/> <small>" + rsUserOutstanding.getString("dealer") + "</small>"%></td><%
																%><td style="white-space: nowrap;"><%=rsUserOutstanding.getString("issue") + " <br/> <small>" + rsUserOutstanding.getString("category") + "</small>" %></td><%
																%><td><small><%=rsUserOutstanding.getString("description") %></small></td><%
																%><td><small><%=rsUserOutstanding.getString("new_issue") %></small></td><%
																%><td><small><%=rsUserOutstanding.getString("new_solution") %></small></td><%
																%><td><center><a href=../View/HistoryDetails.jsp?log=<%=rsUserOutstanding.getString("id") %>><i class="fas fa-edit"></i></a></center></td><%
																%></tr><%
															}
													%>
												  </tbody>
                                               </table>
                                               
                                               </div>
                                                
                                     		</div>
                                        </div>
                                    </div>
                                    
                                    
                                    
	                    </div>

                    </div>
					</div>


                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->	
		
			</div>
		</div>
	</div>
	<footer id="sticky-footer" class="py-0 bg-dark text-white-50 fixed-bottom">
		    
		 <div style="color: white; background-color: #0066cb; display: flex; justify-content: space-around">
			<div>
				<img alt="" width="15px" src="../IMAGES/user.svg">
				<small style="color: white;"><%=username %></small>
				
				<small style="color: white;">></small>
				<small style="color: white;">Dashboard</small>
				<small style="color: white;">></small>
				<a href=""><small style="color: white;">Call Metrics</small></a>
				
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
            now.getMonth() + 1,
            now.getFullYear()].join('-');

	document.getElementById('clock').innerHTML = [date, time].join(' / ');
	
	setTimeout(myTimer, 1000);//This method will call for every second
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
