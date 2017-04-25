<%@page import="model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="model.ProductType"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/datepicker.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/validator.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="js/autohidenavbar.js"></script>
<title>Register - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
	%>
	<%@ include file="header.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#birthday").datepicker();
		})
	</script>

	<div class="container">
		<div class="page-header text-center text-primary">
			<h1><strong>ĐĂNG KÝ TÀI KHOẢN</strong></h1>
		</div>
		<div class="row">
			<div class="col-xs-12 col-xs-offset-0 col-sm-10 col-sm-offset-2">
				<form class="form-horizontal" role="form" data-toggle="validator" action="UserController" method="post">
				
			<div class="form-group">
				<label for="name1" class="col-sm-2 control-label">Email:</label>
				<div class="col-sm-4">
					<input type="email" class="form-control" name="email" id="email"
						data-error="Vui lòng nhập đúng địa chỉ email" required />
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group">
				<label for="password" class="col-sm-2 control-label">Mật khẩu:</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" name="password"
						id="password" data-minlength="8"
						data-error="Mật khẩu tối thiểu 8 ký tự" placeholder="Mật khẩu"
						required />
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group">
				<label for="password2" class="col-sm-2 control-label">Nhập lại mật khẩu:</label>
				<div class="col-sm-3">
					<input type="password" class="form-control" name="password2"
						id="password2" data-match="#password"
						data-required-error="Vui lòng nhập mật khẩu xác nhận"
						data-match-error="Mật khẩu phải trùng khớp"
						placeholder="Nhập lại mật khẩu" required />
					<div class="help-block with-errors"></div>
				</div>
			</div>
			
			<div class="form-group">
				<label for="name" class="col-sm-2 control-label">Tên:</label>
				<div class="col-sm-4">
					<input type="email" class="form-control" name="name" id="name"
						data-error="Vui lòng nhập tên" required />
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group">
				<label for="gender" class="col-sm-2 control-label">Giới tính:</label>
				<div class="col-sm-2">
					<label class="radio-inline">
					<input type="radio"	name="gender" value="true" checked="checked" />Nam</label>
					<label class="radio-inline">
					<input type="radio" name="gender" value="false" />Nữ</label>
				</div>
			</div>

			<div class="form-group">
				<label for="birthday" class="col-sm-2 control-label">Ngày sinh:</label>
				<div class="col-sm-3">
					<input type="text" data-date-format="dd/mm/yyyy" id="birthday" class="form-control"
						name="birthday" data-error="Vui lòng chọn ngày sinh" required />
					<div class="help-block with-errors"></div>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<div class="checkbox">
						<label> <input type="checkbox" class="inputstl">Ghi nhớ</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-primary" name="action"
						value="Register">Đăng Ký</button>
				</div>
			</div>
		</form>
			</div>
		</div>
	</div>
</body>
</html>