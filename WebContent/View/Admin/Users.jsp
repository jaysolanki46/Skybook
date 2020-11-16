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

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Skybook - Users</title>

    <%@include  file="header.html" %>
    <%
    
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

      	<%@include  file="sidebar.html" %>
      
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <a class="navbar-brand" href="#">
					    <img alt="" loading="lazy" height="49.373333" width="370.16" data-src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg" class="vc_single_image-img attachment-full lazyloaded" src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg">
					  </a>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">


                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">Skyzer Admin</span>
                                <img class="img-profile rounded-circle"
                                    src="../img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Users</h1>
                    </div>


                    <!-- Content Row -->
                     <form action="<%=request.getContextPath()%>/user" method="post">
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
	                                      	<button type="submit" class="btn btn-primary">Add</button>&nbsp;&nbsp;&nbsp;&nbsp;
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

   <%@include  file="footer.html" %>
</body>
<script>
$(function () {
	  $('[data-toggle="popover"]').popover()
	})
</script>
</html>