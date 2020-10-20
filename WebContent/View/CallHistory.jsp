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
		Statement stUser = null;
		ResultSet rsUser = null;
		stUser = dbConn.createStatement();
		
		Statement st = null;
		ResultSet rs = null;
		st = dbConn.createStatement();
		 
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    String today = dateFormat.format(date);
	    
	    String filteredUser = request.getParameter("filterUser");
	    String filteredDate = request.getParameter("filterDate");
	    
	    
	    if(filteredUser == null) {
	    	filteredUser = userID;
	    }
	    
	    if(filteredDate == null) {
	    	filteredDate = today;
	    }
	    
	    String clause = ""; 
	    
	    if(filteredUser.equals("0")) {
	    	clause = "WHERE l.log_date = '" + filteredDate + "'";
	    } else {
	    	clause = "WHERE u.id = " + filteredUser + " and l.log_date = '" + filteredDate + "'";
	    }
	    
	    System.out.println(filteredUser);
	    System.out.println(filteredDate);
	    System.out.println(clause);
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div"  >
	
	 	<div class="card-header" style="color: white; background-color: #0066cb; ">
			<h5 style="color: white;">Call History</h5>
		</div>
		
		<div class="card-group">
			<div class="card-body" style="width:66%; padding: 0px; height: 43rem;">
				<!-- Begin -->
					<div class="card mb-3">
				
						<div class="card-body" style="padding: 10px;">
									
								 
								 <form class="form-inline" action="../View/CallHistory.jsp" method="post">
								 	 
								 	 <label class="col-sm-0 col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">User:</label> 
									 <select class="custom-select col-sm-2" name="filterUser">
										<option value="0">All</option>
										<%
											rsUser = stUser.executeQuery("SELECT * FROM users where is_support = 1");
					
										while (rsUser.next()) {
										%>
											<option value="<%=rsUser.getString("id")%>" <%
							    		
							    		if(rsUser.getString("id").equals(filteredUser)) {
							    			%>selected<%
							    		}
							    		
							    		%>><%=rsUser.getString("name")%></option>
										<%
											}
										%>
									</select>
									
									<label class="col-form-label" style="margin-left: 0.5rem;margin-right: 0.5rem;">Date:</label> 
									<input type="date" id="filterDate" name="filterDate" max="31-12-3000" min="01-01-1000" value=<%=filteredDate %>	class="form-control col-sm-2">	
									
									<button type="submit" class="btn btn-primary" style="margin-left: 0.5rem;" onclick="this.form.submit();">Search</button>
									<a href="../View/CallHistory.jsp"><button type="button" class="btn btn-primary" style="margin-left: 0.5rem;"><i class="fas fa-sync-alt"></i></button></a>
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
					      <th scope="col">Issue</th>
					      <th scope="col">Description</th>
					      <th scope="col">Status</th>
					      <th scope="col" colspan="2"></th>
					    </tr>
					  </thead>
					  <tbody>
					    
					    <%
					  		  rs = st.executeQuery(
								"select l.id, l.log_date, l.log_time, l.description, " +
									"dt.name as technician, " +
							        "d.name as dealer, " +
									"u.name as user, " +
							        "iss.name as issue, " +
							        "issmaster.name as category, " +
							        "st.name as status from " +
										"logs as l " +
		                                "INNER JOIN dealer_technicians as dt ON l.dealer_technician = dt.id " +
										"INNER JOIN dealers as d ON dt.dealer = d.id " +
										"INNER JOIN issues as iss ON iss.id = l.issue " +
										"INNER JOIN issue_master as issmaster ON issmaster.id = l.issue_master " +
										"INNER JOIN users as u ON l.user = u.id " +
		                                "INNER JOIN status as st ON l.status = st.id " + clause);
					
								while (rs.next()) {
										
									%><tr><%
										%><td scope="row"><%=rs.getString("id") %></td><%		
										%><td><%=rs.getString("log_date") + " - " + rs.getString("log_time")%></td><%	
										%><td><%=rs.getString("technician") + " - " + rs.getString("dealer") %></td><%
										%><td><%=rs.getString("category") + " - " + rs.getString("issue") %></td><%
										%><td><%=rs.getString("description") %></td><%
										%><td><%=rs.getString("status") %></td><%
										%><td><i class="fas fa-edit"></i></td><%
										%><td><i class="fas fa-trash-alt"></i></td><%		
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

</script>
</html>
