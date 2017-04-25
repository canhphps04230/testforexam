<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="model.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/autohidenavbar.js"></script>
<title>Admin Manager - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
	%>
	<%@ include file="header.jsp"%>
	<div class="container">
		<div class="row">
			<c:if test="${not empty sessionScope.msg}">
				<div class="alert alert-${sessionScope.css} alert-dismissible" role="alert">
					<button type="button" class="close" data-dismiss="alert"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
					<strong>${sessionScope.msg}</strong>
				</div>
				<c:set var="msg" scope="session" value="" />
				<c:set var="css" scope="session" value="" />
			</c:if>
		</div>
		<div class="row">
			<c:choose>
				<c:when
					test="${empty sessionScope.user || sessionScope.user.admin == false}">
					<div
						class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
						<h4 class="text-center">ĐĂNG NHẬP QUẢN TRỊ</h4>
						<form action="UserController" method="post">
							<div class="form-group">
								<label for="txtEmail">Tài khoản:</label> <input type="email"
									class="form-control" id="txtEmail" name="txtEmail">
							</div>
							<div class="form-group">
								<label for="txtPassword">Password:</label> <input type="password"
									class="form-control" id="txtPassword" name="txtPassword">
							</div>
							<button type="submit" class="btn btn-default" name="action"
								value="LoginAdmin">Login</button>
						</form>
					</div>
				</c:when>

				<c:otherwise>
					<div class="container">
						<div class="page-header text-center text-primary">
							<h1>QUẢN TRỊ SHOP ONLINE</h1>
						</div>
						<div class="row">
							<div class="btn-group btn-group-justified">
								<div class="btn-group">
									<a class="btn btn-primary btn-lg" href="adminuser.jsp">Quản Lý
										Người Dùng</a>
								</div>
								<div class="btn-group">
									<a class="btn btn-primary btn-lg" href="adminproducttype.jsp">Quản Lý
										Loại Sản Phẩm </a>
								</div>
								<div class="btn-group">
									<a class="btn btn-primary btn-lg" href="adminproduct.jsp">Quản Lý
										Sản Phẩm </a>
								</div>
								<div class="btn-group">
									<a class="btn btn-primary btn-lg" href="admincart.jsp">Quản Lý
										Giỏ Hàng</a>
								</div>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>