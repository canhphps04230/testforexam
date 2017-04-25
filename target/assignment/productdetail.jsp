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
<script type="text/javascript" src="plusminusnumber.js"></script>
<title>${product.name}- Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<c:set var="type" scope="request" value="${product.typeId}" />
	<%@ include file="header.jsp"%>
	<script type="text/javascript">
		$(document).ready(function(){
			var interval;
			var plusFunction = function(){
				var num =  $("#quantityNum").val();
				num++;
				if (num > ${product.quantity}) {
					$("#quantityNum").val(${product.quantity});
					return;
				}
				$("#quantityNum").val(num);
				//alert("123");
			};
			
			var minusFunction = function(){
				var num =  $("#quantityNum").val();
				num--;
				if (num < 1) {
					$("#quantityNum").val(1);
					return;
				}
				$("#quantityNum").val(num);
			};
			
			$("#plus").on({
				mousedown:function(){
					interval = window.setInterval(function(){
						plusFunction();
					}, 100);
				},
				mouseup:function(){
					//alert("123");
					window.clearInterval(interval);
				}
			});
			
			$("#minus").on({
				mousedown:function(){
					interval = window.setInterval(function(){
						minusFunction();
					}, 100);
				},
				mouseup:function(){
					//alert("123");
					window.clearInterval(interval);
				}
			});
			
			//send button value with form
			$("#addBtn").click(function(){
				var formData = $(this).closest('form').serializeArray();
				formData.push({name:$(this).attr("name"), value:$(this).val()});
			})
			
			//set form on submit not refresh page
			$("#cartform").submit(function(e){
				e.preventDefault();
				$.ajax({
					type:"post",
					url:"CartController",
					data:$(this).serialize()+"&action=Add",
					success:function(data){
						var num = $("#total", $(data));
						var msg = $("#msg", $(data));
						var css = $("#css", $(data));
						$("#itemNum").text(num.val());
						$("#cartContent").empty().append(data);
						$("#msgContent").html(msg.val());
						
						$("#topAlert").removeClass("hidden").fadeIn().fadeOut(3000);
					}
				});
			});
		});
	</script>
	<div class="container">
		<div class="col-xs-12" id="testClass">
		</div>
		<div class="row">
			<div class="col-sm-12">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
					<li><a
						href="PageController?action=Direct&type=${product.typeId}">
							<%=ProductTypeDAO.getNameById(request.getAttribute("type") + "")%></a>
					</li>
					<li>${product.name}</li>
				</ul>
			</div>
		</div>
		<div class="page-header text-danger text-center">
			<h1>
				<strong></strong>
				</h3>
		</div>
		<div class="row">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="col-xs-12 col-sm-6 col-md-4">
						<img class="img-responsive" alt=""
							src="img/product/${product.image}" />
					</div>
					<div class="col-xs-12 col-sm-6 col-md-6">
						<div class="detail-right-panel">
							<form action="CartController" method="get" id="cartform">
								<div class="row">
									<h1 class="text-warning">${product.name}</h1>
								</div>
								<div class="row 15">
									<span class="glyphicon glyphicon glyphicon-star"
										aria-hidden="true"></span> <span
										class="glyphicon glyphicon glyphicon-star" aria-hidden="true"></span>
									<span class="glyphicon glyphicon glyphicon-star"
										aria-hidden="true"></span> <span
										class="glyphicon glyphicon glyphicon-star" aria-hidden="true"></span>
									<span class="glyphicon glyphicon glyphicon-star-empty"
										aria-hidden="true"></span>
								</div>
								<div class="row top15">
									<p class="text-justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit,
										sed do eiusmod tempor incidt utore et dolore magna aliqua. Ut
										enim ad minim veniam, quis nostrud exercitation ullamco
										laboris nisi ut aliquip ex eao consequa uis aute irure dolor
										in reprehenderit ullamco laboris nisi ut aliquip</p>
								</div>
								<div class="row top15">
									<h4 class="product-price text-danger">
										<fmt:formatNumber type="number" value="${product.price}" />
									</h4>
								</div>
								<div class="row top15">
									<c:choose>
										<c:when test="${product.quantity > 0 }">
											<div>Tình trạng: <span class="text-success"><strong>còn hàng</strong></span></div>
											<div class="form-inline top15">
												Số lượng:
												<button id="minus" class="btn btn-default" type="button">-</button>
												<input id="quantityNum" class="form-control" type="number"
													name="quantity" id="quantity" value="1" min="1"
													max="${product.quantity}" />
												<button id="plus" class="btn btn-default" type="button">+</button>
											</div>
										</c:when>
										<c:otherwise>
											<div>Tình trạng: <span class="text-warning"><strong>hết hàng</strong></span></div>
											<div class="top15"></div>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="row top15">
									<div class="col-xs-6 col-xs-offset-0 col-sm-6 col-sm-offset-2">
										<input type="hidden" name="id" value="${product.id}" />
										<button class='btn btn-primary btn-block btn-lg ${product.quantity eq 0?"disabled":"" }' type="submit" id="addBtn"
											name="action" ${product.quantity eq 0?"disabled":"" } value="Add">THÊM VÀO GIỎ HÀNG</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<div class="col-xs-12 col-sm-12 col-md-2"></div>
				</div>
				<!-- end panel body -->
			</div>
			<!-- end panel -->
		</div>
	</div>
</body>
</html>