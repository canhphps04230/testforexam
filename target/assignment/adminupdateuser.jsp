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
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<title>Admin {requestScope.action} - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setAttribute("oldUrl", "adminuser.jsp");
	%>
	<%@ include file="header.jsp"%>
	<%@ include file="adminlogin.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#birthday").datepicker();
		})
	</script>

	<c:set var="css" value='${requestScope.action == "New User"?"primary":"success"}' />
	<c:set var="title" value='${requestScope.action == "New User"?"Thêm Người Dùng":"Cập Nhật Tài Khoản"}' />
	
	<div class="container">

		<div class='page-header text-center text-${css} text-uppercase'>
			<h1><strong>${title}</strong></h1>
		</div>

		<div class="row">
			<div class="col-xs-12 col-xs-offset-0 col-sm-5 col-sm-offset-3">
				<form class="form-horizontal" action="UserController" method="post">
					<input type="hidden" name="txtClause" value="${param.txtClause }" />
					<input type="hidden" name="page" value="${param.page }" />
					<input type="hidden" name="id" value="${requestScope.user.id}" />
					<div class="form-group">
						<label class="control-label col-sm-2" for="uid">ID:</label>
						<div class="col-sm-10">
							<c:choose>
								<c:when test="${requestScope.isNew eq 'true' }">
									<input type="text" class="form-control" name="uid" id="uid"
										value="${requestScope.user.id }" />
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" name="uid" id="uid"
										value="${requestScope.user.id }" disabled="disabled" />
								</c:otherwise>
							</c:choose>
	
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="email">Email:</label>
						<div class="col-sm-10">
							<input type="email" class="form-control" name="email" id="email"
								value="${requestScope.user.email }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="password">Password:</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" name="password"
								id="password" value="${requestScope.user.password }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="name">Name:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="name" id="name"
								value="${requestScope.user.name }" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="gender">Gender:</label>
						<div class="col-sm-10">
							<label class="radio-inline"><input type="radio"
								name="gender" value="true"
								${requestScope.user.gender == true?'checked':''} />Nam</label> <label
								class="radio-inline"><input type="radio" name="gender"
								value="false" ${requestScope.user.gender == false?'checked':''} />Nữ</label>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="birthday">Birthday:</label>
						<div class="col-sm-10">
							<input type="text" data-date-format="dd/mm/yyyy" id="birthdayUser"
								name="birthday" class="form-control"
								value='<fmt:formatDate pattern="dd/MM/yyyy" value="${requestScope.user.birthday }" />' />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="admin">Role:</label>
						<div class="col-sm-10">
							<label class="radio-inline"><input type="radio"
								name="admin" value="true"
								${requestScope.user.admin == true?'checked':'' } />Admin</label> <label
								class="radio-inline"><input type="radio" name="admin"
								value="false" ${requestScope.user.admin == false?'checked':'' } />User</label>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class='btn btn-${css}' 
									name="action" value="${requestScope.action}">${title}</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>