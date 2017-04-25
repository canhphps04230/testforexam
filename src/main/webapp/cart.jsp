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
<title>Cart - Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<%@ include file="header.jsp"%>
	<script type="text/javascript">
		$(document).ready(function(){
			
			function assignEvent(){
				$(document).on("submit", "form.cartmainform", function(e){
					var action = $(document.activeElement).val();
					alert(action);
					e.preventDefault();
					var query = "&action=" + action;
//	 				*****
					$.ajax({
						type:"post",
						url:"CartController",
						data:$(this).serialize() + query,
						success:function(data){
							var num = $("#total", $(data)).val();
							var msg = $("#msg", $(data)).val();
							var sum = $("#sum", $(data)).val();
							
							$("#itemNum").text(num);
							$("#cartarea").html(data);
							//data.detach();
							$("#msgContent").html(msg);
							$("#sumspan").html(sum);
							
							$("#topAlert").removeClass("hidden").show().fadeOut(3000);
						}
					});
				});
			};
			
			$(document).on("submit", "form.cartmainform", function(e){
				var action = $(document.activeElement).val();
				var item;
				//if (action == "Update") e.preventDefault();
				e.preventDefault();
				var query = "&action=" + action;
				if (action == "Delete") item = $(document.activeElement).closest("tr");
				else item = null;
				//alert($(item).html());
// 				*****
				$.ajax({
					type:"post",
					url:"CartController",
					data:$(this).serialize() + query,
					success:function(data){
						var total = $("#total", $(data)).val();
						var msg = $("#msg", $(data));
						var sum = $("#sum", $(data)).val();
						
						$("#itemNum").text(total > 0 ? total : "");
						//$("#cartarea").empty().append(data);
						//data.detach();
						
						//alert(action);
						
						$("#msgContent").html(msg.val());
						$("#sumspan").html(total > 0?sum:"0");
						$("#cartContent").empty().append(data);
						if (action == "Delete") $(item).remove();
						$("#topAlert").removeClass("hidden").show().fadeOut(3000);
						
					}
				});
			});

		});
	</script>

	<div class="container">
		<div class="page-header text-center text-primary" id="test1"><h1><strong>GIỎ HÀNG</strong></h1></div>
		<div class="row">
			<div id="cartarea">
			<c:choose>
				<c:when test="${empty sessionScope.cartList}">
					<div class="jumbotron text-center"><h3>Bạn Không Có Sản Phẩm Nào Trong Giỏ Hàng</h3></div>
				</c:when>
				<c:otherwise>
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="text-center">No</th>
								<th class="text-center">Product</th>
								<th class="text-center">Price</th>
								<th class="text-center">Quantity</th>
								<th class="text-center">Update</th>
								<th class="text-center">Delete</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${sessionScope.cartList}" varStatus="loop">
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
												<a href="ProductController?action=View&id=${item.product.id}">
													<img class="img-responsive" alt="" src="img/product/thumbnail/${item.product.image}" />
												</a>
											</div>
										</td>
										<td class="vertical-align col-xs-2">
											<div class="product-price text-center">
												<fmt:formatNumber type="number" value="${item.product.price}" />
											</div>
										</td>
										<td class="vertical-align col-xs-2 text-center">
											<div class="form-inline">
<!-- 												<button class="btn btn-default minus" type="button">-</button> -->
												<input id="quantityNum" class="form-control number" type="number"
													name="quantity" id="quantity" value="${item.quantity}" min="1"
													max="${item.product.quantity}" />
<!-- 												<button class="btn btn-default plus" type="button">+</button> -->
											</div>
										</td>
										<td class="vertical-align col-xs-1 text-center">
											<button class="btn btn-success" type="submit" name="action" value="Update">Update</button>
										</td>
										<td class="vertical-align col-xs-1 text-center">
											<button class="btn btn-warning" type="submit" name="action" value="Delete">Delete</button>
										</td>
									</tr>
								</form>
							</c:forEach>
						</tbody>
					</table>
					<div class="col-xs-7"></div>
					<div class="col-xs-5 text-right">
						<h3 class="product-price">Tổng cộng: <span id="sumspan"><fmt:formatNumber type="number" value="${sessionScope.cartSum}" /></span></h3>
					</div>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		<div class="row top15">
			<div class="col-xs-6 col-sm-4">
				<a type="submit" class="btn btn-warning btn-block btn-lg" name="action" href="CartController?action=Order">THANH TOÁN GIỎ HÀNG</a>
			</div>
			<div class="col-xs-0 col-sm-4">
			</div>
			<div class="col-xs-6 col-sm-4">
				<a class="btn btn-primary btn-block btn-lg" name="action" href="index.jsp" >TIẾP TỤC MUA HÀNG</a>
			</div>
		</div>
	</div>
	<!-- end container -->

</body>
</html>