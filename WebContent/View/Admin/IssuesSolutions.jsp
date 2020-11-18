<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" import="java.sql.*" %>
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

    <title>Skybook - Issues / Solutions</title>

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
		Statement stIssueMaster = null;
		ResultSet rsIssueMaster = null;
		stIssueMaster = dbConn.createStatement();
		
		Statement st = null;
		ResultSet rs = null;
		st = dbConn.createStatement();
    
		rs = st.executeQuery("select issue_master.name as category, issues.* from issues INNER JOIN issue_master ON issues.issue_master = issue_master.id");
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
                        <h1 class="h3 mb-0 text-gray-800">Issues / Solutions</h1>
                    </div>


                    <!-- Content Row -->
                    <form id="issueSolution" action="<%=request.getContextPath()%>/issueSolution" method="post">
					 <div class="card shadow mb-4">
                                <!-- Card Header - Accordion -->
                                <a href="#collapseCardExample" class="d-block card-header py-3" data-toggle="collapse"
                                    role="button" aria-expanded="true" aria-controls="collapseCardExample">
                                    <h6 class="m-0 font-weight-bold text-primary">Add New Issue / Solution</h6>
                                </a>
                                <!-- Card Content - Collapse -->
                                <div class="collapse show" id="collapseCardExample">
                                    <div class="card-body">
                                     
                                     <div class="form-group row">
                                     <label class="col-sm-1 col-form-label">Category:<span style="color: red;">*</span></label>
                                     <input class="col-sm-4" list="masterList" id="issueMaster" name="issueMaster" placeholder="Select/Type Issue Category...">
										&nbsp;&nbsp;&nbsp;
										<datalist id="masterList">
										
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
									</div> 
                                     <div class="form-group row">
                                      	<label class="col-sm-1 col-form-label">Issue:<span style="color: red;">*</span></label>
									 	<input class="col-sm-4 form-control"  id="name" name="name" placeholder="Ex. No Communication between POS and Terminal">
									</div>
									<div class="form-group row">
									 <label class="col-sm-1 col-form-label">Solution:<span style="color: red;">*</span></label>
									 <textarea class="col-sm-4 form-control" placeholder="Solution..." rows="3" id="solution" name="solution"></textarea>
									 &nbsp;&nbsp;&nbsp;
									 <a href="https://wordtohtml.net" title="HTML Formatter" style="align-self:center;" target="_blank"><i class="fas fa-file-code"></i></a>
                                    </div>
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
                            <h6 class="m-0 font-weight-bold text-primary">Issues / Solutions</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Category</th>
                                            <th>Issue</th>
                                            <th>Solutions</th>
                                           <th></th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                           <th>#</th>
                                           <th>Category</th>
                                           <th>Issue</th>
                                           <th>Solutions</th>
                                           <th></th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                   		<% while (rs.next()) { %>
                                        <tr>
                                           	<td><%=rs.getString("id") %></td>
                                           	<td><%=rs.getString("category") %></td>
                                            <td><%=rs.getString("name") %></td>
                                            <td><%=rs.getString("solution") %></td>
                                             <!-- <td><center><a href=""><i class="fas fa-edit"/></a></center></td> -->
                                            <td><center><a href="<%=request.getContextPath()%>/issueSolution?id=<%=rs.getString("id") %>"><i class="fas fa-trash-alt"/></a></center></td>
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

$("#issueMaster").change(function() {
	
	var val = $('#issueMaster').val();
	
	var issueMasterID = $('#masterList option').filter(function() {
	        return this.value == val;
	    }).data('issue-master');
	 
	 document.getElementById("hiddenIssueMasterID").value  = issueMasterID;
})

function validate() {
	
	var category = document.getElementById("hiddenIssueMasterID").value;
	var name = document.getElementById("name").value;
	var solution = document.getElementById("solution").value;

	if(category == "undefined" || category == 0) {
		swal("Error!", "Invalid category", "error");
	} else if (name == "" || solution == "") {
		swal("Error!", "Invalid issue / solution", "error");
	} else {
		document.getElementById("issueSolution").submit();
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