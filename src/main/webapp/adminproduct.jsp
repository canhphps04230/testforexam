<%@page import="model.ProductHibernateDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="model.Product"%>
<%@page import="model.ProductHibernateDAO"%>
<%@page import="model.ProductTypeDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/checkall.js"></script>
<title>Admin Product Manager - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setAttribute("oldUrl", "adminproduct.jsp");
	%>
	<%@ include file="header.jsp"%>
	<%@ include file="adminlogin.jsp"%>
	<c:set var="itemsOnPage" value="<%=ProductHibernateDAO.ITEMSONPAGE%>"></c:set>
	<c:if test="${ empty type }">
		<c:set var="type" scope="request" value=""></c:set>
	</c:if>
	<c:if test="${ empty pageNumber }">
		<c:set var="pageNumber" scope="request"
			value='<%=ProductHibernateDAO.getPage("", "", ProductHibernateDAO.ITEMSONPAGE)%>' />
	</c:if>
	<c:if
		test="${empty list && empty param.txtClause && empty param.txtType }">
		<c:set var="list"
			value='<%=ProductHibernateDAO.listByPage("", "", 1, ProductHibernateDAO.ITEMSONPAGE)%>' />
		<c:set var="page" value="1" />
	</c:if>

	<div class="container">
		<div class="row">
			<form action="ProductController" method="post">
				<div class="panel panel-default text-primary updown-padding">
					<div class="panel-heading medium-height">
						<div class="col-xs-6 col-sm-3">
							<select class="form-control" name="txtType" id="txtType">
								<c:forEach var="typeP" items="<%=ProductTypeDAO.getComboBox()%>">
									<option value="${typeP.id }"
										${typeP.id eq param.txtType?'selected':'' }>${typeP.name }</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-xs-6 col-sm-5">
							<div class="input-group col-xs-10">
								<input type="text" id="txtClause" name="txtClause"
									class="form-control col-xs-1" placeholder="Tìm kiếm sản phẩm"
									value="${param.txtClause }" /><span class="input-group-btn">
									<button type="submit" class="btn btn-default" name="action"
										value="List">
										<img src="img/search_40.png" width="20" />
									</button>
								</span>
							</div>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button class="btn btn-primary" type="submit" name="action"
								value="New">Thêm Sản Phẩm</button>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button class="btn btn-warning" type="submit" name="action"
								value="DeleteProduct">Xóa Sản Phẩm</button>
						</div>
						<!-- end table header content -->
					</div>
					<div class="panel-body">
						<table class="table table-hover col-xs-12">
							<thead>
								<tr>
									<th class="text-center"><input type="checkbox"
										id="checkAll" class="large-checkbox"></th>
									<th class="text-center">Number</th>
									<th class="text-center">ID</th>
									<th class="text-center">Name</th>
									<th class="text-center">Image</th>
									<th class="text-center">Price</th>
									<th class="text-center">Quantity</th>
									<th class="text-center">Update</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="product" items="${list }" varStatus="loop">
									<tr>
										<td class="text-center"><input type="checkbox"
											name="idCheck" class="large-checkbox" value="${product.id }" /></td>
										<td class="text-center">${loop.count + (itemsOnPage*(page-1)) }</td>
										<td class="text-center">${product.id }</td>
										<td>${product.name }</td>
										<td><img src="img/product/thumbnail/${product.image }"
											class="img-responsive" width="90" /></td>
										<td class="text-center product-price"><fmt:formatNumber
												type="number" value="${product.price}" /></td>
										<td class="text-center">${product.quantity }</td>
										<td class="text-center"><a class="btn btn-success"
											href="ProductController?action=Update&id=${product.id}&txtClause=${param.txtClause}&txtType=${param.txtType}&page=${page}">Update
										</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- end table body content -->
					</div>
					<!-- end table body -->
					<div class="panel-footer medium-height">
						<div class="col-sx-6 col-sm-9">
						</div>
						<div class="col-xs-6 col-sm-3 text-right">
							<ul class="pagination nopadding">
								<li><a
									href="ProductController?action=List&txtClause=${param.txtClause}&txtType=${param.txtType}&page=1">&laquo;</a></li>
								<c:forEach var="count" begin="1" end='${pageNumber }'
									varStatus="loop">
									<li class="${count == page?'active':'' }"><a
										href="ProductController?action=List&txtClause=${param.txtClause}&txtType=${param.txtType}&page=${count }">${count }</a></li>
								</c:forEach>
								<li><a
									href="ProductController?action=List&txtClause=${param.txtClause}&txtType=${param.txtType}&page=${pageNumber }">&raquo;</a></li>
							</ul>
						</div>
					</div>
					<!-- end table footer -->
				</div>
				<!-- end panel -->
			</form>
			<!-- end form -->
		</div>
	</div>
</body>
</html>