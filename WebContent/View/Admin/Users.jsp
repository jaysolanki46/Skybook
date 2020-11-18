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

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Skybook - Users</title>

    <%@include  file="ADMIN-WEB-INF/header.html" %>
    <%
    
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
    
		rs = st.executeQuery("Select * from users");
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
                        <h1 class="h3 mb-0 text-gray-800">Users</h1>
                    </div>


                    <!-- Content Row -->
                     <form id="user" action="<%=request.getContextPath()%>/user" method="post">
					 <div class="card shadow mb-4">
                                <!-- Card Header - Accordion -->
                                <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
                                    role="button" aria-expanded="true" aria-controls="collapseCardExample">
                                    <h6 class="m-0 font-weight-bold text-primary">Add New Users</h6>
                                </a>
                                <!-- Card Content - Collapse -->
                                <div class="collapse show" id="collapseCardExample">
                                    <div class="card-body">
	                                    <div class="form-group row">
										 <label class="col-sm-1 col-form-label">Name:<span style="color: red;">*</span></label>
										 <input class="col-sm-3" class="form-control"  id="name" name="name" placeholder="Ex. TOM">
	                                    </div>
	                                    <div class="form-group row">
										 <label class="col-sm-1 col-form-label">Email:<span style="color: red;">*</span></label>
										 <input class="col-sm-3" class="form-control"  id="email" name="email" placeholder="Ex. xyz@mail.co.nz">
	                                    </div>
	                                    <div class="form-group row">
										 <label class="col-sm-1 col-form-label">Password:<span style="color: red;">*</span></label>
										 <input type="password" class="col-sm-3" class="form-control"  id="pass" name="pass" placeholder="***">
	                                    </div>
	                                    <div class="form-check form-check-inline" style="margin-left: 8rem;">
										  <input class="form-check-input" type="checkbox" id="isAdmin"  name="isAdmin" value="1"/>
										  <label class="form-check-label"">Admin</label>
										</div>
										<div class="form-check form-check-inline">
										  <input class="form-check-input" type="checkbox" id="isSupport" name="isSupport" value="1" checked="checked"/>
										  <label class="form-check-label">Support</label>
										</div><br/><br/>
	                                     <div class="form-group row">
	                                      	<label class="col-sm-1 col-form-label"></label>
	                                      	<input type="button" class="btn btn-primary" value="Add" onclick="validate()">&nbsp;&nbsp;&nbsp;&nbsp;
                                      		<button type="reset" class="btn btn-danger">Cancel</button>
	                                      </div>
                                    </div>
                                </div>
                       </div>
                       </form>
					
					 <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">Users</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Name</th>
                                            <th>Admin</th>
                                            <th>Support</th>
                                           	<th>Edit</th>
                                           	<th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                           <th>#</th>
                                            <th>Name</th>
                                            <th>Admin</th>
                                            <th>Support</th>
                                           	<th>Edit</th>
                                           	<th>Delete</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    	<% while (rs.next()) { %>
                                        <tr>
                                            <td><%=rs.getString("id") %></td>
                                            <td><%=rs.getString("name") %></td>
                                            <td><center><% if(rs.getString("is_admin").equals("1")) %> <i class="far fa-check-square"></i></center></td>
                                            <td><center><% if(rs.getString("is_support").equals("1")) %> <i class="far fa-check-square"></i></center></td>
                                            <td><center><a title="Edit" href=""><i class="fas fa-edit"></i></a></center></td>
                                            <td><center><a title="Delete" href=""><i class="fas fa-trash-alt"></i></a></center></td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
					

                 
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

   <%@include  file="ADMIN-WEB-INF/footer.html" %>
   <%
			if (session.getAttribute("status") != null) {
				if (session.getAttribute("status").toString().equals("success")) {
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
						session.setAttribute("status", "killed");
				} else if (session.getAttribute("status").toString().equals("error")) {
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
						session.setAttribute("status", "killed");
				}
			}
		%>
</body>
<script>
$(function () {
	  $('[data-toggle="popover"]').popover()
})

function validate() {
	
	var pattern = /^[a-zA-Z0-9\-_]+(\.[a-zA-Z0-9\-_]+)*@[a-z0-9]+(\-[a-z0-9]+)*(\.[a-z0-9]+(\-[a-z0-9]+)*)*\.[a-z]{2,4}$/;
	var name = document.getElementById("name").value;
	var email = document.getElementById("email").value;
	var pass = document.getElementById("pass").value;
	var isAdmin = document.getElementById("isAdmin").checked;
	var isSupport = document.getElementById("isSupport").checked;

	if(name == "") {
		swal("Error!", "Invalid user name", "error");
	} else if (email == "" || !pattern.test(email)) {
		swal("Error!", "Invalid user email", "error");
	} else if (pass == "") {
		swal("Error!", "Invalid user password", "error");
	} else if (isAdmin == false && isSupport == false) {
		swal("Error!", "Either user should be support or admin", "error");
	} else {
		document.getElementById("user").submit();
	}
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