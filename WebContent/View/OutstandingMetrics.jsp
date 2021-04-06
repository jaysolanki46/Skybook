<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.time.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<html>
<% try { %>
<head>
<meta charset="ISO-8859-1">
<title>Skybook - Dashboard</title>
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
		
		// TOTAL CALLS
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as totalCalls FROM logs");
		int totalCalls = 0;
		while(rs.next()) {
			totalCalls = rs.getInt("totalCalls");
		}
				
		
		// CALLS (CURRENT MONTHLY)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as currentMonthCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE) AND MONTH(log_date) = MONTH(CURRENT_DATE)");
		int currentMonthCount = 0;
		while(rs.next()) {
			currentMonthCount = rs.getInt("currentMonthCount");
		}
		
		// OUTSTANDING ISSUES (CURRENT MONTHLY)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as outstandingIssuesCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE) AND MONTH(log_date) = MONTH(CURRENT_DATE) AND status != " + RESOLVED);
		int outstandingIssuesCount = 0;
		while(rs.next()) {
			outstandingIssuesCount = rs.getInt("outstandingIssuesCount");
		}
		
		// RESOLVED ISSUES (CURRENT MONTHLY)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as resolvedIssuesCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE) AND MONTH(log_date) = MONTH(CURRENT_DATE) AND status = " + RESOLVED);
		int resolvedIssuesCount = 0;
		while(rs.next()) {
			resolvedIssuesCount = rs.getInt("resolvedIssuesCount");
		}
		
		// CALLS (ANNUAL/2020)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as currentYearCount FROM logs WHERE YEAR(log_date) = YEAR(CURDATE())");
		int currentYearCount = 0;
		while(rs.next()) {
			currentYearCount = rs.getInt("currentYearCount");
		}
		
		// CALLS (LAST MONTHLY)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as lastMonthCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(log_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)");
		int lastMonthCount = 0;
		while(rs.next()) {
			lastMonthCount = rs.getInt("lastMonthCount");
		}		
		
		// OUTSTANDING ISSUES (LAST MONTHLY)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as lastMonthOutstandingCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(log_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AND status != " + RESOLVED);
		int lastMonthOutstandingCount = 0;
		while(rs.next()) {
			lastMonthOutstandingCount = rs.getInt("lastMonthOutstandingCount");
		}
		
		// RESOLVED ISSUES (LAST MONTHLY)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as lastMonthResolvedCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(log_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AND status = " + RESOLVED);
		int lastMonthResolvedCount = 0;
		while(rs.next()) {
			lastMonthResolvedCount = rs.getInt("lastMonthResolvedCount");
		}		
		
		// Support Calls Overview (2020)
		rs = null;
		rs = st.executeQuery("select date_format(log_date,'%M') as month ,count(*) as cnt from logs group by year(log_date),month(log_date) order by year(log_date),month(log_date)");
		String janMonthCalls = null;
		String febMonthCalls = null;
		String marMonthCalls = null;
		String aprMonthCalls = null;
		String mayMonthCalls = null;
		String junMonthCalls = null;
		String julMonthCalls = null;
		String augMonthCalls = null;
		String sepMonthCalls = null;
		String octMonthCalls = null;
		String novMonthCalls = null;
		String decMonthCalls = null;
		
		while(rs.next()) {
			String month = rs.getString("month");
			String count =   rs.getString("cnt");
			
			if(month.equals("January")) janMonthCalls =  count;
			if(month.equals("February")) febMonthCalls =  count;
			if(month.equals("March")) marMonthCalls =  count;
			if(month.equals("April")) aprMonthCalls =  count;
			if(month.equals("May")) mayMonthCalls =  count;
			if(month.equals("June")) junMonthCalls =  count;
			if(month.equals("July")) julMonthCalls =  count;
			if(month.equals("August")) augMonthCalls =  count;
			if(month.equals("September")) sepMonthCalls =  count;
			if(month.equals("October")) octMonthCalls =  count;
			if(month.equals("November")) novMonthCalls =  count;
			if(month.equals("December")) decMonthCalls = count;
		}
		
		// Attendees Overview (MONTHLY)
		rs = null;
		rs = st.executeQuery("select u.name as usr, count(l.id) as cnt from users as u LEFT JOIN logs as l ON u.id = l.user WHERE YEAR(log_date) = YEAR(CURRENT_DATE) AND MONTH(log_date) = MONTH(CURRENT_DATE) group by usr");
		int jayMonthCalls = 0;
		int ashenMonthCalls = 0;
		int kishanMonthCalls = 0;
		int henryMonthCalls = 0;
		int nileshMonthCalls = 0;
		
		while(rs.next()) {
			String usr = rs.getString("usr");
			int count =   rs.getInt("cnt");
				
			if(usr.equalsIgnoreCase("Jay")) jayMonthCalls =  count;
			if(usr.equalsIgnoreCase("Ashen")) ashenMonthCalls =  count;
			if(usr.equalsIgnoreCase("Kishan")) kishanMonthCalls =  count;
			if(usr.equalsIgnoreCase("Henry")) henryMonthCalls =  count;
			if(usr.equalsIgnoreCase("Nilesh")) nileshMonthCalls =  count;
		}
		
		// Support Calls Overview (2020)
		rs = null;
		rs = st.executeQuery("select dealer, date_format(log_date,'%M') as month ,count(*) as cnt from logs WHERE dealer = 67 group by year(log_date),month(log_date) order by year(log_date),month(log_date)");
		int janKiwiMonthCalls = 0;
		int febKiwiMonthCalls = 0;
		int marKiwiMonthCalls = 0;
		int aprKiwiMonthCalls = 0;
		int mayKiwiMonthCalls = 0;
		int junKiwiMonthCalls = 0;
		int julKiwiMonthCalls = 0;
		int augKiwiMonthCalls = 0;
		int sepKiwiMonthCalls = 0;
		int octKiwiMonthCalls = 0;
		int novKiwiMonthCalls = 0;
		int decKiwiMonthCalls = 0;
		
		while(rs.next()) {
			String month = rs.getString("month");
			int count =   rs.getInt("cnt");
			
			if(month.equals("January")) janKiwiMonthCalls =  count;
			if(month.equals("February")) febKiwiMonthCalls =  count;
			if(month.equals("March")) marKiwiMonthCalls =  count;
			if(month.equals("April")) aprKiwiMonthCalls =  count;
			if(month.equals("May")) mayKiwiMonthCalls =  count;
			if(month.equals("June")) junKiwiMonthCalls =  count;
			if(month.equals("July")) julKiwiMonthCalls =  count;
			if(month.equals("August")) augKiwiMonthCalls =  count;
			if(month.equals("September")) sepKiwiMonthCalls =  count;
			if(month.equals("October")) octKiwiMonthCalls =  count;
			if(month.equals("November")) novKiwiMonthCalls =  count;
			if(month.equals("December")) decKiwiMonthCalls = count;
		}
	%>

</head>
<body>
<%@include  file="../navbar.html" %>
	<div class="card center_div"  >
	
	 	<div class="card-header" style="color: white; background-color: #0066cb; ">
			<h5 style="color: white;">Dashboard</h5>
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

 						<!-- TOTAL CALLS -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Total Calls At Skyzer</div>
                                            <div class="h5 mb-0 font-weight-bold"><%=totalCalls %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-layer-group fa-2x" style="color: #1cc88a;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- CALLS (CURRENT MONTH/2020) -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                	Calls (<%=LocalDate.now().getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=currentMonthCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x" style="color: #0066cb;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                       

                        <!-- OUTSTANDING ISSUES (CURRENT MONTH/2020) -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Outstanding Issues (<%=LocalDate.now().getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><%=outstandingIssuesCount %></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-bug fa-2x" style="color: #36b9cc;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- RESOLVED ISSUES (CURRENT MONTH/2020) -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                Resolved Issues (<%=LocalDate.now().getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=resolvedIssuesCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clipboard-check fa-2x" style="color: #f6c23e;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

					<div class="row">
						<!-- CALLS (ANNUAL/2020) -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Calls (Annual/<%=Calendar.getInstance().get(Calendar.YEAR) %>)</div>
                                            <div class="h5 mb-0 font-weight-bold"><%=currentYearCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-layer-group fa-2x" style="color: #1cc88a;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
					
					
						<!-- CALLS (LAST MONTH/2020) -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                	Calls (<%=LocalDate.now().minusMonths(1).getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=lastMonthCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x" style="color: #0066cb;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                       

                        <!-- OUTSTANDING ISSUES (LAST MONTH/2020) -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Outstanding Issues (<%=LocalDate.now().minusMonths(1).getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)
                                            </div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800"><%=lastMonthOutstandingCount %></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-bug fa-2x" style="color: #36b9cc;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- RESOLVED ISSUES (LAST MONTH/2020) -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                Resolved Issues (<%=LocalDate.now().minusMonths(1).getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=lastMonthResolvedCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clipboard-check fa-2x" style="color: #f6c23e;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					</div>

                    <!-- Content Row -->

                    <div class="row">

                        <!-- Area Chart -->
                        <div class="col-xl-8 col-lg-7">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Support Calls Overview (<%=Calendar.getInstance().get(Calendar.YEAR) %>)</h6>
                                    <input type="hidden" id="janMonthCalls" value=<%=janMonthCalls %>>
                                    <input type="hidden" id="febMonthCalls" value=<%=febMonthCalls %>>
                                    <input type="hidden" id="marMonthCalls" value=<%=marMonthCalls %>>
                                    <input type="hidden" id="aprMonthCalls" value=<%=aprMonthCalls %>>
                                    <input type="hidden" id="mayMonthCalls" value=<%=mayMonthCalls %>>
                                    <input type="hidden" id="junMonthCalls" value=<%=junMonthCalls %>>
                                    <input type="hidden" id="julMonthCalls" value=<%=julMonthCalls %>>
                                    <input type="hidden" id="augMonthCalls" value=<%=augMonthCalls %>>
                                    <input type="hidden" id="sepMonthCalls" value=<%=sepMonthCalls %>>
                                    <input type="hidden" id="octMonthCalls" value=<%=octMonthCalls %>>
                                    <input type="hidden" id="novMonthCalls" value=<%=novMonthCalls %>>
                                    <input type="hidden" id="decMonthCalls" value=<%=decMonthCalls %>>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="supportCallOverviewChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Pie Chart -->
                        <div class="col-xl-4 col-lg-5">
                            <div class="card shadow mb-4">
                                <!-- Card Header - Dropdown -->
                                <div
                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">Attendees Overview (<%=LocalDate.now().getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="myPieChart"></canvas>
                                    </div>
                                    <div class="mt-4 text-center small">
                                        <span class="mr-2">
                                            <i class="fas fa-circle text-primary"></i> Jay
                                            <input type="hidden" id="jayMonthCalls" value=<%=jayMonthCalls %>>
                                        </span>
                                        <span class="mr-2">
                                            <i class="fas fa-circle text-success"></i> Ashen
                                            <input type="hidden" id="ashenMonthCalls" value=<%=ashenMonthCalls %>>
                                        </span>
                                        <span class="mr-2">
                                            <i class="fas fa-circle text-info"></i> Kishan
                                            <input type="hidden" id="kishanMonthCalls" value=<%=kishanMonthCalls %>>
                                        </span>
                                         <span class="mr-2">
                                            <i class="fas fa-circle text-warning"></i> Henry
                                            <input type="hidden" id="henryMonthCalls" value=<%=henryMonthCalls %>>
                                        </span>
                                         <span class="mr-2">
                                            <i class="fas fa-circle text-dark"></i> Nilesh
                                            <input type="hidden" id="nileshMonthCalls" value=<%=nileshMonthCalls %>>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Bar Chart -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">Kiwibank Calls Overview (<%=Calendar.getInstance().get(Calendar.YEAR) %>)</h6>
							 		<input type="hidden" id="janKiwiMonthCalls" value=<%=janKiwiMonthCalls %>>
                                    <input type="hidden" id="febKiwiMonthCalls" value=<%=febKiwiMonthCalls %>>
                                    <input type="hidden" id="marKiwiMonthCalls" value=<%=marKiwiMonthCalls %>>
                                    <input type="hidden" id="aprKiwiMonthCalls" value=<%=aprKiwiMonthCalls %>>
                                    <input type="hidden" id="mayKiwiMonthCalls" value=<%=mayKiwiMonthCalls %>>
                                    <input type="hidden" id="junKiwiMonthCalls" value=<%=junKiwiMonthCalls %>>
                                    <input type="hidden" id="julKiwiMonthCalls" value=<%=julKiwiMonthCalls %>>
                                    <input type="hidden" id="augKiwiMonthCalls" value=<%=augKiwiMonthCalls %>>
                                    <input type="hidden" id="sepKiwiMonthCalls" value=<%=sepKiwiMonthCalls %>>
                                    <input type="hidden" id="octKiwiMonthCalls" value=<%=octKiwiMonthCalls %>>
                                    <input type="hidden" id="novKiwiMonthCalls" value=<%=novKiwiMonthCalls %>>
                                    <input type="hidden" id="decKiwiMonthCalls" value=<%=decKiwiMonthCalls %>>
						</div>
						<div class="card-body">
							<div class="chart-bar">
								<canvas id="myBarChart"></canvas>
							</div>
						</div>
					</div>

					<!-- Content Row -->

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->	
		
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
