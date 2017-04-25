<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="model.ProductDAO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
<c:if test="${not empty msg}">
	<div class="alert alert-${css} alert-dismissible" role="alert">
		<button type="button" class="close" data-dismiss="alert"
			aria-label="Close">
			<span aria-hidden="true">×</span>
		</button>
		<strong>${msg}</strong>
	</div>
</c:if>

<div class="row">
	<form action="ProductController" method="post">
		<div class="col-xs-12 col-sm-4"></div>
		<div class="col-xs-12 col-sm-4">
			<button class="btn btn-primary" type="submit" name="action"
				value="NewProduct">Thêm Sản Phẩm</button>
		</div>
		<div class="col-xs-12 col-sm-4">
			<button class="btn btn-warning" type="submit" name="action"
				value="DeleteProduct">Xóa Sản Phẩm</button>
		</div>
		<table class="table table-hover col-xs-12">
			<thead>
				<tr>
					<th class="text-center">Check</th>
					<th class="text-center">ID</th>
					<th class="text-center">Name</th>
					<th class="text-center">Image</th>
					<th class="text-center">Price</th>
					<th class="text-center">Quantity</th>
					<th class="text-center">Update</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="product"
					items='<%=(new ProductDAO()).listByType(request.getParameter("type"))%>'>
					<tr>
						<td class="text-center"><input type="checkbox" name="idCheck"
							value="${product.id }"></td>
						<td class="text-center">${product.id }</td>
						<td>${product.name }</td>
						<td><img src="img/product/thumbnail/${product.image }"
							class="img-responsive" width="90" /></td>
						<td class="text-center product-price"><fmt:formatNumber
								type="number" value="${product.price}" /></td>
						<td class="text-center">${product.quantity }</td>
						<td class="text-center"><a class="btn btn-success"
							href="ProductController?action=UpdateProduct&id=${product.id }">Update
						</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</div>
