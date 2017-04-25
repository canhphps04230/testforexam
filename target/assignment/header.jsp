<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="css/datepicker.css" />
<script type="text/javascript" src="js/autohidenavbar.js"></script>
<script type="text/javascript" src="js/validator.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<%
// 	User userTest = new User("US123", "admin@gmail.com", "12345", "admin",
// 			new SimpleDateFormat("dd/MM/yyyy").parse("2/2/2002"), true, true);
	//session.setAttribute("user", userTest);
	//User user = (User) request.getSession().getAttribute("user");
%>
<nav
	class="navbar navbar-dark bg-primary navbar-default navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="index.jsp">LOGOWEBSITE</a>
		</div>
		<ul class="nav navbar-nav navbar-right col-xs-12 col-sm-3">
			<!-- begin login and cart button -->
				<div class="alert alert-info alert-dismissible alert-fixed hidden" role="alert" id="topAlert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button><strong class="alert-heading">Thông báo</strong>
					<p id="msgContent">${msg}</p>
				</div>
				<c:if test="${not empty sessionScope.homeMsg}">
					<div class="alert alert-${sessionScope.css} alert-dismissible alert-fixed" role="alert">
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button><strong class="alert-heading">Thông báo</strong>
					<p id="msgContent">${sessionScope.homeMsg}</p>
				</div>
					<c:set var="homeMsg" scope="session" value="" />
					<c:set var="css" scope="session" value="" />
				</c:if>
			<li class="navbar-nav navbar-right col-xs-6 col-sm-6">
				<c:choose>
					<c:when test="${not empty sessionScope.user}">
						<button class="btn btn-primary navbar-btn btn-block" type="button"
							data-toggle="dropdown">
							${user.getName()} <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Details</a></li>
							<li><a href="#">Edit</a></li>
							<c:if test="${sessionScope.user.admin == true}">
								<li class=""><a href="admin.jsp">Admin Manager</a></li>
							</c:if>
							<li role="separator" class="divider"></li>
							<li><a href="UserController?action=Logout">Log Out</a></li>
						</ul>
					</c:when>
					<c:otherwise>
						<button class="btn btn-primary navbar-btn btn-block" type="button"
							data-toggle="modal" data-target="#loginModal">ACCOUNT</button>
					</c:otherwise>
				</c:choose></li>
			<!-- end login button -->
			<li class="navbar-right col-xs-6 col-sm-6"><button
					class="btn btn-primary navbar-btn btn-block" type="button"
					data-toggle="dropdown">
					CART <span id="itemNum" class="badge">${sessionScope.cartTotal>0 ? sessionScope.cartTotal : ''}</span>
					<span class="caret"></span>
				</button>
				<div class="dropdown-menu 1dropdown-menu-expanded dropdown-menu-margin" role="menu">
					<div id="cartContent">
						<jsp:include page="cartmanager.jsp"></jsp:include>
					</div>
				</div>
			</li>
			<!-- end cart button -->
		</ul>

		<div class="col-xs-12 col-sm-7">
			<form class="navbar-form navbar-right" role="search"
				action="PageController">
				<div class="input-group">
					<input type="hidden" id="txtType" name="txtType" value="" />
					<input type="text" id="txtSearch" name="txtSearch"
						class="form-control" placeholder="Tìm kiếm sản phẩm"> <span
						class="input-group-btn">
						<button type="submit" class="btn btn-default" name="action" value="Search">
							<img src="img/search_40.png" width="20" />
						</button>
					</span>

				</div>
			</form>
		</div>
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#mainNav" aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<div class="row" id="menuRow">
			<div class="col-lg-10 col-md-10 col-md-offset-1">
				<div class="collapse navbar-collapse" id="mainNav">
					<ul id="navlist" class="nav nav-pills nav-justified">
						<li id="PT00001"><a
							href="PageController?action=Direct&type=PT00001">BOOKS</a></li>
						<li id="PT00002"><a
							href="PageController?action=Direct&type=PT00002">ĐIỆN THOẠI</a></li>
						<li id="PT00003"><a
							href="PageController?action=Direct&type=PT00003">COMPUTER</a></li>
						<li id="PT00004"><a
							href="PageController?action=Direct&type=PT00004">MULTIMEDIA</a></li>
						<li id="PT00005"><a
							href="PageController?action=Direct&type=PT00005">THỂ THAO</a></li>
						<li id="PT00006"><a
							href="PageController?action=Direct&type=PT00006">PHỤ KIỆN</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</nav>
<div class="modal fade" id="loginModal" role="dialog" ><!--tabindex="-1"> -->
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- login modal content -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h3 class="text-center text-success"><strong>ACCOUNT</strong></h3>
			</div>
			<div class="modal-body">
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item">
						<a class="btn btn-primary active" data-toggle="tab" href="#login" role="tab">Login</a>
					</li>
					<li>
						<a class="btn btn-success" data-toggle="tab" href="#register" role="tab">Register</a>
					</li>
				</ul>
				<!-- nav tabs -->
				<div class="tab-content">
					<div class="tab-pane active" id="login" role="tabpanel">
						<form role="form" data-toggle="validator" action="UserController" method="post">
						<!-- begin login form -->
							<div class="form-group">
								<label for="txtEmail"><span
									class="glyphicon glyphicon-user"></span> Email</label> <input
									type="email" class="form-control" id="txtEmail" name="txtEmail"
									 data-error="Vui lòng nhập đúng địa chỉ email" placeholder="Email" required autofocus />
									 <div class="help-block with-errors"></div>
							</div>
							<div class="form-group">
								<label for="txtPassword"><span
									class="glyphicon glyphicon-eye-open"></span> Mật Khẩu</label> <input
									type="password" class="form-control" id="txtPassword" name="txtPassword"
									data-error="Vui lòng nhập mật khẩu" placeholder="Password" required />
									<div class="help-block with-errors"></div>
							</div>
							<button type="submit" class="btn btn-success btn-block"
								name="action" value="Login">
								<span class="glyphicon glyphicon-off"></span> Login</button>
						</form>
					</div>
					<!-- end login pane -->
					<div class="tab-pane" id="register" role="tabpanel">
						<div class="col-sm-offset-1">
							<form class="form-horizontal" role="form" data-toggle="validator" action="UserController" method="post">
							
								<div class="form-group">
									<label for="name1" class="col-sm-4 control-label">Email:</label>
									<div class="col-sm-7">
										<input type="email" class="form-control" name="email" id="email"
											data-error="Vui lòng nhập đúng địa chỉ email" required />
										<div class="help-block with-errors"></div>
									</div>
								</div>
							
								<div class="form-group">
									<label for="password" class="col-sm-4 control-label">Mật khẩu:</label>
									<div class="col-sm-6">
										<input type="password" class="form-control" name="password"
											id="password" data-minlength="8"
											data-error="Mật khẩu tối thiểu 8 ký tự" placeholder="Mật khẩu"
											required />
										<div class="help-block with-errors"></div>
									</div>
								</div>
							
								<div class="form-group">
									<label for="password2" class="col-sm-4 control-label">Nhập lại mật khẩu:</label>
									<div class="col-sm-6">
										<input type="password" class="form-control" name="password2"
											id="password2" data-match="#password"
											data-required-error="Vui lòng nhập mật khẩu xác nhận"
											data-match-error="Mật khẩu phải trùng khớp"
											placeholder="Nhập lại mật khẩu" required />
										<div class="help-block with-errors"></div>
									</div>
								</div>
								
								<div class="form-group">
									<label for="name" class="col-sm-4 control-label">Tên:</label>
									<div class="col-sm-7">
										<input type="text" class="form-control" name="name" id="name"
											data-error="Vui lòng nhập tên" required />
										<div class="help-block with-errors"></div>
									</div>
								</div>
							
								<div class="form-group">
									<label for="gender" class="col-sm-4 control-label">Giới tính:</label>
									<div class="col-sm-4">
										<label class="radio-inline">
										<input type="radio"	name="gender" value="true" checked="checked" />Nam</label>
										<label class="radio-inline">
										<input type="radio" name="gender" value="false" />Nữ</label>
									</div>
								</div>
							
								<div class="form-group">
									<label for="birthday" class="col-sm-4 control-label">Ngày sinh:</label>
									<div class="col-sm-6">
										<input type="text" data-date-format="dd/mm/yyyy" id="birthday" class="form-control"
											name="birthday" data-error="Vui lòng chọn ngày sinh" required />
										<div class="help-block with-errors"></div>
									</div>
								</div>
	
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-6">
										<button type="submit" class="btn btn-primary btn-block" name="action"
											value="Register">Đăng Ký</button>
									</div>
								</div>
							</form>
						</div>
						<script type="text/javascript">
							$(document).ready(function() {
								$("#birthday").datepicker();
								$("#birthdayUser").datepicker();
								
								$(".alert .close").on("click", function(e){
									e.stopPropagation();
									e.preventDefault();
									$(this).parent().hide();
								});
								
								//$("#topAlert").hide();
							})
						</script>
					</div>
					<!-- end register pane -->
				</div>
				<!-- end tab panes -->
			</div>
		</div>
	</div>
</div>