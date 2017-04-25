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
<title>Admin ${requestScope.action } - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setAttribute("oldUrl", "adminuser.jsp");
	%>
	<%@ include file="header.jsp"%>
	<%@ include file="adminlogin.jsp"%>
	<c:set var="css" value='${requestScope.action == "New Product Type"?"primary":"success"}' />
	<c:set var="title" value='${requestScope.action == "New Product Type"?"Thêm Loại Sản Phẩm":"Cập Nhật Loại Sản Phẩm"}' />
	
	<div class="container">

		<div class='page-header text-center text-${css} text-uppercase'>
			<h1><strong>${title}</strong></h1>
		</div>
		<div class="row">
			<div class="col-xs-12 col-xs-offset-0 col-sm-6 col-sm-offset-3">
				<form class="form-horizontal" action="ProductTypeController"
					method="post">
					<input type="hidden" name="txtClause" value="${param.txtClause }" />
					<input type="hidden" name="page" value="${param.page }" />
					<input type="hidden" name="id"
						value="${requestScope.productType.id}">
					<div class="form-group">
						<label class="control-label col-sm-2" for="uid">ID:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="uid" id="uid"
								value="${requestScope.productType.id }"
								${requestScope.isNew == false?"disabled":""} />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="name">Name:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="name" id="name"
								value="${requestScope.productType.name }" />
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