<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="db.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Completed Tickets</title>
<%@include  file="../header.html" %>

	<%
		String username = "";
		String userID = "";
		if(session.getAttribute("username") != null) {
			username = session.getAttribute("username").toString();
			userID = session.getAttribute("userID").toString();
		} else {
			response.sendRedirect("../View/login.jsp");
			throw new Exception("User session timed out!");
		}
		
		Connection dbConn = DBConfig.connection(); ;
		Statement st = null;
		ResultSet rs = null;
		st = dbConn.createStatement();
		
		Statement stUser = null;
		ResultSet rsUser = null;
		stUser = dbConn.createStatement();
		
		 String clause = ""; 
		 String filteredUser = request.getParameter("user");
		 
		 if(filteredUser == null) {
		    	filteredUser = userID;
		  }
		 
		 if(!filteredUser.equals("0")) {
			 clause = "and l.user = '" + filteredUser + "'";
		 }
		 
		 System.out.println(clause);
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div"  >
	
	 	<div class="card-header" style="color: white; background-color: #0066cb; display: flex; justify-content: space-around">
			<div style="width: 70%;">
				<h5 style="color: white;">Completed Tickets</h5>
			</div>
			<div style="color: white; margin-left: auto; margin-right: 5px; width: 10%;">
				 <form action="../View/CompletedTickets.jsp" method="post">
					 <select class="custom-select" name="user" onchange="this.form.submit();">
						<option value="0">All</option>
						<%
						rsUser = stUser.executeQuery("SELECT * FROM users where is_support = 1");
	
						while (rsUser.next()) {
						%>
							<option value="<%=rsUser.getString("id")%>" <%
							    		
							    		if(rsUser.getString("id").equals(filteredUser)) {
							    			%> selected <% 
							    		}
							    		%>
							> <%=rsUser.getString("name")%>  </option>
						<%
							}
						%>
					</select>
				</form>
			</div>
		</div>
		
		<div class="card-group" style="overflow-x: hidden; max-height: 700px;">
			<div class="card-body row">
				<!-- Begin -->
				
						<div class="row row-cols-4 row-cols-md-4">
						
						<%	
						rs = st.executeQuery("select fup.*,l.technician, d.name as dealer, u.name as user, u1.name as updated_by_user from " +
								"follow_ups fup INNER JOIN logs as l ON fup.log = l.id " +
								"INNER JOIN users as u1 ON fup.updated_by = u1.id " +
								"INNER JOIN dealers as d ON l.dealer = d.id " +
								"INNER JOIN users as u ON l.user = u.id " +
								"WHERE fup.is_completed = 1 " + clause +
								" ORDER BY fup.follow_up_date DESC, fup.follow_up_time ASC");		
																
							    while(rs.next())
							    {   
									%>
							    		 <!--  Ticket card -->
										  <div class="card-deck col mb-4" style="min-width:31rem;  max-width: 31rem;">
										    <div class="card" style="background-color: #f4f5f7;">
										      <div class="card-header bg-transparent" style="border-color: transparent; display: flex; justify-content: space-around">
										      <h5>SBT - <%=rs.getString("id") %> 
										      <%
										      if(rs.getString("is_completed") == null || rs.getString("is_completed").equals("0")) {
										    	  %><img alt="" width="70px" src="../IMAGES/awaiting.svg"></h5><%
										      } else {
										    	  %><img alt="" width="70px" src="../IMAGES/completed.svg"></h5><%
										      }
										      %>
										      
												<div style="margin-left: auto;">
													<span><%=rs.getString("follow_up_date") %> - <%=rs.getString("follow_up_time") %></span>
												</div>
										      </div>
										      <div class="card-body">
										        <h5 class="card-title"><%=rs.getString("technician") %> - <%=rs.getString("dealer") %></h5>
										        
										        <%	
										        	if(rs.getString("contact") != null) {
										        		%><p class="card-text"><%=rs.getString("contact") %></p><%
										        	}
										        
											        if(rs.getString("note") != null) {
										        		%><p class="card-text"><%=rs.getString("note") %></p><%
										        	}
										        
										        %>
										        
										      </div>
										      <div class="bg-transparent" style="border-color: transparent; ">
										      <div class="card-header bg-transparent" style="display: flex; justify-content: space-around">
										      <p><img alt="" width="13px" src="../IMAGES/created-by.svg"> <%=rs.getString("user") %> <br/>  <img alt="" width="12px" src="../IMAGES/updated-by.svg">  <%=rs.getString("updated_by_user") %> (<%=rs.getString("updated_on") %>)</p>
												<div style="margin-left: auto;">
													<a href=../View/TicketDetails.jsp?log=<%=rs.getString("log") %>><img alt="" width="20px" src="../IMAGES/info.svg"></a>
												</div>
										      </div>
										     
										     </div>
										    </div>
										  </div>
										  <!--  Ticket card end -->
							    	<%
							    }    
						    
							    rs.close();
						%>
						</div>
			</div>
		</div>
	</div>
	<footer id="sticky-footer" class="py-0 bg-dark text-white-50 fixed-bottom">
		    
		 <div style="color: white; background-color: #0066cb; display: flex; justify-content: space-around">
			<div>
				<img alt="" width="15px" src="../IMAGES/user.svg">
				<small style="color: white;"><%=username %></small>
				
				<small style="color: white;">></small>
				<a href=""><small style="color: white;">Completed Tickets</small></a>
				
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
            now.getMonth(),
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

