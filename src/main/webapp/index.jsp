<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="model.AdvertiseDAO"%>
<%@page import="model.ProductTypeDAO"%>
<%@page import="model.Product"%>
<%@page import="model.ProductDAO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/slider.js"></script>
<title>Shop Online</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<%@ include file="header.jsp"%>
	<c:set var="mainAdList"
		value='<%=AdvertiseDAO.listNewByType("AT00001", 4)%>' />
	<div class="container">
		<div class="row">
			<!-- begin left products -->
			<!-- end left products -->
			<div class="col-xs-12 col-sm-8 small-padding">
				<div id="mainCarousel" class="carousel slide col-xs-12 nopadding"
					data-ride="carousel" data-pause="hover">
					<!-- begin main slide -->
					<ol class="carousel-indicators">
						<c:forEach var="ad" items="${mainAdList}" varStatus="loop">
							<li data-target="#mainCarousel" data-slide-to="${loop.index}"
								class='${loop.index eq 0?"active":"" }'></li>
						</c:forEach>
					</ol>
					<div class="carousel-inner" role="listbox">
						<c:forEach var="ad" items="${mainAdList}" varStatus="loop">
							<div class='item ${loop.index eq 0?"active":""}'>
								<a href="#"><img class="img-responsive"
									src="img/advertise/${ad.image}" /></a>
							</div>
						</c:forEach>
					</div>
					<a class="left carousel-control" href="#mainCarousel" role="button"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#mainCarousel"
						role="button" data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
				<!-- end main slide -->
			</div>

			<div class="col-xs-12 col-sm-4">
				<c:forEach var="ad"
					items='<%=AdvertiseDAO.listNewByType("AT00003", 2)%>'>
					<div class="row">
						<a href="#"><img
							class="img-responsive col-xs-6 col-sm-12 no-leftright-padding"
							src="img/advertise/${ad.image}" /></a>
					</div>
				</c:forEach>
			</div>
		</div>
		<!-- end first row -->
		<!-- 		<div class="row"> -->
		<!-- begin 2nd row -->
		<!-- 			<div class="col-xs-4 small-padding"> -->
		<!-- 				<a href=""><img class="img-responsive" alt="" -->
		<!-- 					src="img/advertise/iphone6plus_393x158_1.jpg" /></a> -->
		<!-- 			</div> -->
		<!-- 			<div class="col-xs-4 small-padding"> -->
		<!-- 				<a href=""><img class="img-responsive" alt="" -->
		<!-- 					src="img/advertise/XPERIA-XZ-393x158_1.png" /></a> -->
		<!-- 			</div> -->
		<!-- 			<div class="col-xs-4 small-padding"> -->
		<!-- 				<a href=""><img class="img-responsive" alt="" -->
		<!-- 					src="img/advertise/226462_kbalo.jpg" /></a> -->
		<!-- 			</div> -->
		<!-- 		</div> -->
		<!-- 		<div class="row"> -->
		<!-- 			<div class="col-xs-4 small-padding"> -->
		<!-- 				<a href=""><img class="img-responsive" alt="" -->
		<!-- 					src="img/advertise/BTS-293x158.png" /></a> -->
		<!-- 			</div> -->
		<!-- 			<div class="col-xs-4 small-padding"> -->
		<!-- 				<a href=""><img class="img-responsive" alt="" -->
		<!-- 					src="img/advertise/mkm1475566323.png" /></a> -->
		<!-- 			</div> -->
		<!-- 			<div class="col-xs-4 small-padding"> -->
		<!-- 				<a href=""><img class="img-responsive" alt="" -->
		<!-- 					src="img/advertise/636113076734018724_H1-800x300.jpg" /></a> -->
		<!-- 			</div> -->
		<!-- 		</div> -->
		<!-- 	</div> -->
		<!-- end 2nd row -->
	</div>
	<!-- end first container -->

	<div class="container">
		<!-- begin show products container -->
		<div class="row">
			<!-- begin product slide show -->
			<div class="col-xs-12 no-leftright-padding">
				<!-- begin left panel -->
				<div class="panel panel-default no-border">
					<!-- begin hot product panel -->
					<div class="panel-heading nopadding">
						<h2>SẢN PHẨM HOT</h2>
					</div>
					<div class="panel-body">
						<div class="carousel slide multi-item-carousel" id="theCarousel"
							data-pause="hover" data-ride="carousel" data-interval="false">
							<div class="carousel-inner">
								<c:forEach items="<%=(new ProductDAO()).listHot()%>"
									var="product" varStatus="loop">
									<div class='item ${loop.index eq 0?"active":""}'>
										<div class="col-xs-3 product-frame">
											<a href="ProductController?action=View&id=${product.id}"><img
												src="img/product/thumbnail/${product.image}"
												class="img-responsive"></a>
											<div class="product-info">
												<div class="text-center text-primary">
													<strong>${product.name}</strong>
												</div>
												<div class="product-price">
<%-- 													<fmt:formatNumber type="number" value="${product.price}" /> --%>
													${product.price}
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<a class="left carousel-control" href="#theCarousel"
								data-slide="prev"><i
								class="glyphicon glyphicon-chevron-left"></i></a> <a
								class="right carousel-control" href="#theCarousel"
								data-slide="next"><i
								class="glyphicon glyphicon-chevron-right"></i></a>
						</div>
					</div>
					<!-- end hot product panel -->

				</div>
			</div>
			<!-- 			<div class="col-xs-6 col-sm-3 no-leftright-padding"> -->
			<!-- 				<a href="#"><img class="img-responsive" alt="" -->
			<!-- 					src="img/advertise/27359_original.jpg" /></a> -->
			<!-- 			</div> -->
		</div>
		<c:forEach var="pt" items="<%=(new ProductTypeDAO()).list()%>"
			varStatus="loop">
			<div class="row small-padding">
				<jsp:include page="productslide.jsp">
					<jsp:param name="name" value="${pt.name }" />
					<jsp:param name="id" value="${pt.id }" />
					<jsp:param name="position" value="${loop.index }" />
				</jsp:include>
			</div>
		</c:forEach>
	</div>
	<!-- end product show container -->

</body>
</html>