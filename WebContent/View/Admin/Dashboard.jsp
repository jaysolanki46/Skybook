<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="java.util.*" %>
<%@ page language="java" import="java.time.*" %>
<%@ page language="java" import="config.DBConfig" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<html lang="en">
<% try { %>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Skybook - Dashboard</title>

    <%@include  file="ADMIN-WEB-INF/header.html" %>
    <%
    	final int RESOLVED = 1;
    
		String adminUserID = "";
		String adminUserName = "";
		String adminUserEmail = "";
		if(session.getAttribute("adminUserName") != null) {
			adminUserID = session.getAttribute("adminUserID").toString();
			adminUserName = session.getAttribute("adminUserName").toString();
			adminUserEmail = session.getAttribute("adminUserEmail").toString();
		} else {
			response.sendRedirect("../login.jsp");
			throw new Exception("User session timed out!");
		}
		
		Connection dbConn = DBConfig.connection(); ;
		Statement st = null;
		ResultSet rs = null;
		st = dbConn.createStatement();
		
		// CALLS (ANNUAL/2020)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as currentYearCount FROM logs WHERE YEAR(log_date) = YEAR(CURDATE())");
		int currentYearCount = 0;
		while(rs.next()) {
			currentYearCount = rs.getInt("currentYearCount");
		}
		
		// CALLS (MONTHLY)
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as lastMonthCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(log_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)");
		int lastMonthCount = 0;
		while(rs.next()) {
			lastMonthCount = rs.getInt("lastMonthCount");
		}
		
		// OUTSTANDING ISSUES
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as outstandingIssuesCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(log_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AND status != " + RESOLVED);
		int outstandingIssuesCount = 0;
		while(rs.next()) {
			outstandingIssuesCount = rs.getInt("outstandingIssuesCount");
		}
		
		// RESOLVED ISSUES
		rs = null;
		rs = st.executeQuery("SELECT COUNT(*) as resolvedIssuesCount FROM logs WHERE YEAR(log_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(log_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AND status = " + RESOLVED);
		int resolvedIssuesCount = 0;
		while(rs.next()) {
			resolvedIssuesCount = rs.getInt("resolvedIssuesCount");
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
		rs = st.executeQuery("select u.name as usr, count(l.id) as cnt from users as u LEFT JOIN logs as l ON u.id = l.user WHERE YEAR(log_date) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(log_date) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) group by usr");
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

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

      	<%@include  file="ADMIN-WEB-INF/sidebar.html" %>
      
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

               	<!-- Top Bar -->
                <%@include  file="ADMIN-WEB-INF/topbar.html" %>
				<!-- Top Bar End-->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                    </div>

                    <!-- Content Row -->
                    <div class="row">

 						<!-- Earnings (Monthly) Card Example -->
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
                     </div>
                     
                     <div class="row">   
                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                	Total Calls (<%=LocalDate.now().minusMonths(1).getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=lastMonthCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x" style="color: #0066cb;"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Outstanding Issues (<%=LocalDate.now().minusMonths(1).getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)
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

                        <!-- Pending Requests Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                Resolved Issues (<%=LocalDate.now().minusMonths(1).getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</div>
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
                                    <h6 class="m-0 font-weight-bold text-primary">Attendees Overview (<%=LocalDate.now().minusMonths(1).getMonth() + "/" + Calendar.getInstance().get(Calendar.YEAR) %>)</h6>
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
							<h6 class="m-0 font-weight-bold text-primary">Kiwibank Calls Chart</h6>
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
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">�</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>

   <%@include  file="ADMIN-WEB-INF/footer.html" %>

</body>
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