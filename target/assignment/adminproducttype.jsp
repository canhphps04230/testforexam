<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>Admin Product Type Manager - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.setAttribute("oldUrl", "adminproduct.jsp");
	%>
	<%@ include file="header.jsp"%>
	<%@ include file="adminlogin.jsp"%>
	<c:set var="itemsOnPage" value="<%=ProductTypeDAO.ITEMSONPAGE%>"></c:set>

	<c:if test="${ empty requestscope.pageNumber }">
		<c:set var="pageNumber" scope="request"
			value='<%=ProductTypeDAO.getPage("", ProductTypeDAO.ITEMSONPAGE)%>' />
	</c:if>
	<c:if test="${empty list && empty param.txtClause}">
		<c:set var="list" scope="request"
			value='<%=ProductTypeDAO.listByPage("", 1, ProductTypeDAO.ITEMSONPAGE)%>' />
		<c:set var="page" value="1" />
	</c:if>
	<%-- 	<c:out value="typeId: ${page }"></c:out> --%>

	<div class="container">
		<div class="row">
			<form action="ProductTypeController" method="get">
				<div class="panel panel-default text-primary">
					<div class="panel-heading medium-height">
						<div class="col-xs-12 col-sm-8">
							<div class="input-group col-sm-7">
								<input type="text" id="txtClause" name="txtClause"
									class="form-control" placeholder="Tìm kiếm loại sản phẩm"
									value="${param.txtClause }" /> <span class="input-group-btn">
									<button type="submit" class="btn btn-default" name="action"
										value="List">
										<img src="img/search_40.png" width="20" />
									</button>
								</span>
							</div>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button class="btn btn-primary" type="submit" name="action"
								value="New">Thêm Loại Sản Phẩm</button>
						</div>
						<div class="col-xs-6 col-sm-2">
							<button class="btn btn-warning" type="submit" name="action"
								value="Delete">Xóa Loại Sản Phẩm</button>
						</div>
						<!-- end table header content -->
					</div>
					<div class="panel-body">
						<table class="table table-hover col-xs-12">
							<thead>
								<tr>
									<th class="text-center"><input type="checkbox" class="large-checkbox"
										id="checkAll"></th>
									<th class="text-center">Number</th>
									<th class="text-center">ID</th>
									<th class="text-center">Name</th>
									<th class="text-center">Update</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="type" items="${list }" varStatus="loop">
									<tr>
										<td class="text-center"><input type="checkbox" class="large-checkbox"
											name="idCheck" value="${type.id }" /></td>
										<td class="text-center">${loop.count + (itemsOnPage*(page-1)) }</td>
										<td class="text-center">${type.id }</td>
										<td class="text-center">${type.name }</td>
										<td class="text-center"><a class="btn btn-success"
											href="ProductTypeController?action=Update&id=${type.id }&txtClause=${param.txtClause}&page=${page}">Update
										</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<!-- end table body content -->
					</div>
					<!-- end table body -->
					<div class="panel-footer medium-height">
						<div class="col-sx-6 col-sm-9"></div>
						<div class="col-xs-6 col-sm-3 text-right">
							<ul class="pagination nopadding">
								<li><a
									href="ProductTypeController?action=List&txtClause=${param.txtClause }&page=1">&laquo;</a></li>
								<c:forEach var="count" begin="1"
									end='${requestScope.pageNumber }' varStatus="loop">
									<li class="${count == page?'active':'' }"><a
										href="ProductTypeController?action=List&txtClause=${param.txtClause }&page=${count }">${count }</a></li>
								</c:forEach>
								<li><a
									href="ProductTypeController?action=List&txtClause=${param.txtClause }&page=${requestScope.pageNumber }">&raquo;</a></li>
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