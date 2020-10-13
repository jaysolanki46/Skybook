<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
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
				
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		String DB_URL = "jdbc:mysql://localhost:3306/skybook?useSSL=false";
		
		String USER = "root";
		String pass = "Sisterbro46@";
		Connection dbConn = null;
		Statement st = null;
		ResultSet rs = null;
		Class.forName(JDBC_DRIVER);
		dbConn = DriverManager.getConnection(DB_URL, USER, pass);
		st = dbConn.createStatement();

	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div"  >
	
		<div class="card-header"
			style="color: white; background-color: #0066cb; display: flex; justify-content: space-around">
			<h5 style="color: white;">Tickets</h5>
			<div style="color: white; margin-left: auto;">
				<b><span><%=username %></span></b> /
				<span id="clock"></span>
			</div>
		</div>

		<div class="card-group" style="max-height: 750px; overflow-y: auto;">
			<div class="card-body row">
				<!-- Begin -->
				
					<div class="row row-cols-1 row-cols-md-2">
						  
						  <div class="col mb-4">
						    <div class="card">
						      <div class="card-header bg-transparent border-success" style="background-color: #0066cb; display: flex; justify-content: space-around">
						      <h5>T#01111</h5>
								<div style="margin-left: auto;">
									<span> 14/05/2020 - 22:30</span>
								</div>
						      </div>
						      <div class="card-body">
						        <h5 class="card-title">Richard (1204 Eftpos Specialist CHCH)</h5>
						        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
						      </div>
						      <div class="card-footer bg-transparent border-success"><b>Created by: <%=username %></b></div>
						    </div>
						  </div>
						  
						  <div class="col mb-4">
						    <div class="card">
						      <div class="card-header bg-transparent border-success" style="background-color: #0066cb; display: flex; justify-content: space-around">
						      <h5>T#01111</h5>
								<div style="margin-left: auto;">
									<span> 14/05/2020 - 22:30</span>
								</div>
						      </div>
						      <div class="card-body">
						        <h5 class="card-title">Card title</h5>
						        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
						      </div>
						      <div class="card-footer bg-transparent border-success"><b>Created by: <%=username %></b></div>
						    </div>
						  </div>
						  
						  
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
            now.getMonth(),
            now.getFullYear()].join('-');

	document.getElementById('clock').innerHTML = [date, time].join(' / ');
	
	setTimeout(myTimer, 1000);//This method will call for every second
}

</script>
</html>

