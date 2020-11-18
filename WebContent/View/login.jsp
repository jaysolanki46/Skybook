<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Skybook - Login</title>

<%@include  file="../header.html" %>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<%
	session.invalidate();
%>
</head>
<body style="background: #0066cb; margin-top:10rem;">
	<div class="container register">
                <div class="row">
                    <div class="col-md-3 register-left">
<!--                         <img src="http://10.63.192.184:8080/Skybook/IMAGES/pos-terminal.svg" alt=""/> -->
						<img src="http://10.63.192.13:8080/Skybook/IMAGES/pos-terminal.svg" alt=""/>
                        <h3>SKYBOOK</h3>
                        <p>MANAGES SKYZER SUPPORT CALLS</p>
                    </div>
                    <div class="col-md-9 register-right">
                        <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="support-tab" data-toggle="tab" href="#support" role="tab" aria-controls="support" aria-selected="true">Support</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="admin-tab" data-toggle="tab" href="#admin" role="tab" aria-controls="admin" aria-selected="false">Admin</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="support" role="tabpanel" aria-labelledby="support-tab">
                                <img alt="" loading="lazy" style="margin-top: 5rem; margin-left: 5rem;"  data-src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg" class="vc_single_image-img attachment-full lazyloaded" src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg">
                                 <form action="<%=request.getContextPath()%>/login" method="post">
                                <div class="row register-form">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="Username *" value=""  name="username"/>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control" placeholder="Password *" value="" name="password"/>
                                        </div>
                                         <input type="submit" class="btnRegister"  value="Login"/>
                                    </div>
                                </div>
                                </form>
                            </div>
                            <div class="tab-pane fade show" id="admin" role="tabpanel" aria-labelledby="admin-tab">
                                 <img alt="" loading="lazy" style="margin-top: 5rem; margin-left: 5rem;"  data-src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg" class="vc_single_image-img attachment-full lazyloaded" src="https://www.skyzer.co.nz/wp-content/uploads/2019/08/Skyzer-Technologies-Logo.svg">
                                 <form action="<%=request.getContextPath()%>/admin" method="post">
                                 <div class="row register-form">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <input type="text" class="form-control" placeholder="Username *" value="" name="username"/>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control" placeholder="Password *" value="" name="password"/>
                                        </div>
                                          <!--  While maintanance <input type="submit" class="btnRegister" data-toggle="modal" data-target="#myModal" value="Secure Login" /> -->
                                          <input type="submit" class="btnRegister" value="Secure Login" />
                                    </div>
                                </div>
                                </form>
                                
                                <!-- Modal -->
							  <div class="modal fade" id="myModal" role="dialog">
							    <div class="modal-dialog modal-lg">
							      <div class="modal-content">
							        <div class="modal-header">
							        	<h4 class="modal-title">503 - Under Maintenance</h4>
							          <button type="button" class="close" data-dismiss="modal">&times;</button>
							        </div>
							        <div class="modal-body">
							          <img src="../IMAGES/maintenance.svg" alt=""/>
							        </div>
							      </div>
							    </div>
							  </div>
							  
                            </div>
                        </div>
                    </div>
                </div>

            </div>
	<%@include  file="../footer.html" %>
</form>
</body>
</html>