<%@page import="model.ProductTypeDAO"%>
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
<title>Admin ${action} - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setAttribute("oldUrl", "adminproduct.jsp");
	%>
	<%@ include file="header.jsp"%>
	<%@ include file="adminlogin.jsp"%>

	<c:set var="css" value='${requestScope.action == "New Product"?"primary":"success"}' />
	<c:set var="title" value='${requestScope.action == "New Product"?"Thêm Sản Phẩm":"Cập Nhật Sản Phẩm"}' />
	
	<div class="container">

		<div class='page-header text-center text-${css} text-uppercase'>
			<h1><strong>${title}</strong></h1>
		</div>
		<div class="row">
			<div class="col-xs-12 col-xs-offset-0 col-sm-5 col-sm-offset-3">
				<form class="form-horizontal" action="ProductController" enctype="multipart/form-data">
					<input type="hidden" name="txtClause" value="${param.txtClause}">
					<input type="hidden" name="txtType" value="${param.txtType}">
					<input type="hidden" name="page" value="${param.page}"> <input
						type="hidden" name="id" value="${requestScope.product.id}">
					<div class="form-group">
						<label class="control-label col-sm-2" for="pid">ID:</label>
						<div class="col-sm-10">
							<c:choose>
								<c:when test="${requestScope.isNew eq 'true' }">
									<input type="text" class="form-control" name="pid" id="pid"
										value="${requestScope.product.id }">
								</c:when>
								<c:otherwise>
									<input type="text" class="form-control" name="pid" id="pid"
										value="${requestScope.product.id }" disabled="disabled">
								</c:otherwise>
							</c:choose>
	
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="name">Name:</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="name" id="name"
								value="${requestScope.product.name }">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="price">Price:</label>
						<div class="col-sm-10">
							<input type="number" class="form-control currency" name="price"
								id="price" value="${requestScope.product.currency }">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="quantity">Quantity:</label>
						<div class="col-sm-10">
							<input type="number" class="form-control" name="quantity"
								id="quantity" value="${requestScope.product.quantity }">
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="image">Image:</label>
						<div class="col-sm-10">
							<input type="file" class="form-control form-control-file" name="image" id="image"
								value="${requestScope.product.image }">
						</div>
					</div>
					<div class="form-group row">
						<label class="control-label col-sm-2" for="type">Type:</label>
						<div class="col-sm-4">
							<select class="form-control" name="type" id="type">
								<c:forEach var="typeP" items="<%=ProductTypeDAO.getComboBox()%>">
									<option value="${typeP.id }"
										${typeP.id eq requestScope.product.typeId?'selected':'' }>${typeP.name }</option>
								</c:forEach>
							</select>
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