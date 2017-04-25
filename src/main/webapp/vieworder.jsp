<%@page import="model.UserDAO"%>
<%@page import="model.CartDAO"%>
<%@page import="model.AdvertiseDAO"%>
<%@page import="model.ProductTypeDAO"%>
<%@page import="model.Product"%>
<%@page import="model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/slider.js"></script>
<title>View Order - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<%@ include file="header.jsp"%>
	<script type="text/javascript">
		$(document).ready(function(){

		});
	</script>
	<c:if test="${empty requestScope.orderId}">
		<c:set var="orderId" scope="request" value="${param.id}" />
	</c:if>
	<c:set var="cart" value='<%=CartDAO.getCartDetail(request.getAttribute("orderId")+"")%>' />
	<div class="container">
		<div class="page-header text-center text-primary" id="test1"><h1><strong>THÔNG TIN HÓA ĐƠN</strong></h1></div>
		<div class="panel panel-default">
  			<div class="panel-heading medium-height">
				<div class="col-xs-12 col-sm-4"><h4>Mã hóa đơn: <strong>${cart.id}</strong></h4></div>
				<div class="col-xs-12 col-sm-4"><h4>Tên khách hàng: <strong>${cart.user.name}</strong></h4></div>
				<div class="col-xs-12 col-sm-4"><h4>Ngày thanh toán: <strong><fmt:formatDate type="both" pattern="dd/MM/yyyy hh:mm a" value="${cart.dateAdd}" /></strong></h4></div>
			</div>
  			<div class="panel-body">
  				<div class="row">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="text-center">No</th>
								<th class="text-center">Product</th>
								<th class="text-center">Price</th>
								<th class="text-center">Quantity</th>
								<th class="text-center">Total</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="total" value="0" />
							<c:forEach var="item" items="${cart.cartItems}" varStatus="loop">
								<c:set var="total" value="${total + item.price * item.quantity}" />
								<form action="CartController" method="get" id="cartmainform" class="cartmainform">
									<tr>
										<td class="vertical-align col-xs-1 text-center"><strong>${loop.count}</strong>
											<input type="hidden" name="id" value="${item.product.id}" />
										</td>
										<td class="vertical-align col-xs-3 text-center">
											<div class="row text-center"><a href="ProductController?action=View&id=${item.product.id}">
												${item.product.name}</a>
											</div>
											<div class="row text-center">
												<div class="col-xs-12 col-xs-offset-0 col-sm-4 col-sm-offset-4">
													<a href="ProductController?action=View&id=${item.product.id}">
														<img class="img-responsive" alt="" src="img/product/thumbnail/${item.product.image}" />
													</a>
												</div>
											</div>
										</td>
										<td class="vertical-align col-xs-2">
											<div class="product-price text-center">
												<fmt:formatNumber type="number" value="${item.price}" />
											</div>
										</td>
										<td class="vertical-align col-xs-2 text-center">
											<div class="form-inline">
												<c:out value='${item.quantity}' />
											</div>
										</td>
										<td class="vertical-align col-xs-2 text-center">
											<div class="product-price"><fmt:formatNumber type="number" value="${item.quantity * item.price}" /></div>
										</td>
									</tr>
								</form>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-xs-6 col-sm-4">
						<a class="btn btn-success btn-block btn-lg" name="action" href="index.jsp" >TIẾP TỤC MUA HÀNG</a>
					</div>
					<div class="col-xs-0 col-sm-4">
					</div>
					<div class="col-xs-6 col-sm-4 text-right">
						<h3 class="product-price">Tổng cộng: <span id="sumspan"><fmt:formatNumber type="number" value="${total}" /></span></h3>
					</div>
				</div>
  			</div>
		</div>
		
	</div>
	<!-- end container -->

</body>
</html>