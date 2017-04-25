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
<script type="text/javascript" src="js/autohidenavbar.js"></script>
<title>Index</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<%@ include file="header.jsp"%>
	
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-6 col-sm-offset-3">
				<div id="mainCarousel" class="carousel slide col-xs-12"
					data-ride="carousel" data-pause="hover">
					<ol class="carousel-indicators">
						<li data-target="#mainCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#mainCarousel" data-slide-to="1"></li>
						<li data-target="#mainCarousel" data-slide-to="2"></li>
						<li data-target="#mainCarousel" data-slide-to="3"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="img/advertise/banner-khuyen-mai-chuot-jvj.jpg"
								width="651px" height="224ps" />
						</div>
						<div class="item">
							<img src="img/advertise/banner-khuyen-mai-chuot-jvj.jpg"
								width="651px" height="224ps" />
						</div>
						<div class="item">
							<img src="img/advertise/banner-khuyen-mai-chuot-jvj.jpg"
								width="651px" height="224ps" />
						</div>
						<div class="item">
							<img src="img/advertise/banner-khuyen-mai-chuot-jvj.jpg"
								width="651px" height="224ps" />
						</div>
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
			</div>
		</div>

		<div class="row">
			<!-- begin product slide show -->
			<div class="col-xs-12 col-sm-9 nopadding">
				<!-- begin left panel -->
				<div class="row">
					<div class="panel panel-default nopadding">
						<!-- begin hot product panel -->
						<div class="panel-heading">
							<strong>SẢN PHẨM HOT</strong>
						</div>
						<div class="panel-body nopadding fixed-height">
							<div class="carousel slide multi-item-carousel nopadding"
								id="theCarousel" data-pause="hover" data-ride="carousel">
								<div class="carousel-inner">
									<c:forEach items="<%=(new ProductDAO()).listHot()%>"
										var="product" varStatus="loop">
										<c:choose>
											<c:when test="${loop.index eq 0 }">
												<div class="item active">
													<div class="col-xs-3 product-frame">
														<a href="#1"><img
															src="img/product/thumbnail/${product.image }"
															class="img-responsive" width="180"></a>
														<div class="text-center text-primary">
															<strong>${product.name }</strong>
														</div>
														<div class="text-center text-warning product-price">
															<fmt:formatNumber type="number" value="${product.price}" />
														</div>
													</div>
												</div>
											</c:when>
											<c:otherwise>
												<div class="item">
													<div class="col-xs-3">
														<a href="#1"><img
															src="img/product/thumbnail/${product.image }"
															class="img-responsive" width="180"></a>
														<div class="text-center text-primary">
															<strong>${product.name }</strong>
														</div>
														<div class="text-center text-warning product-price">
															<fmt:formatNumber type="number" value="${product.price}" />
														</div>
													</div>
												</div>
											</c:otherwise>
										</c:choose>
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
					</div>
					<!-- end hot product panel -->
				</div>
				<div class="row">
					<jsp:include page="productslide.jsp">
						<jsp:param name="title" value="BOOK" />
						<jsp:param name="id" value="book" />
						<jsp:param value="PT00001" name="type" />
					</jsp:include>
				</div>
				<div class="row">
					<jsp:include page="productslide.jsp">
						<jsp:param name="title" value="ĐIỆN THOẠI" />
						<jsp:param name="id" value="phone" />
						<jsp:param value="PT00002" name="type" />
					</jsp:include>
				</div>
				<div class="row">
					<jsp:include page="productslide.jsp">
						<jsp:param name="title" value="COMPUTER" />
						<jsp:param name="id" value="computer" />
						<jsp:param name="type" value="PT00003" />
					</jsp:include>
				</div>
				<div class="row">
					<jsp:include page="productslide.jsp">
						<jsp:param name="title" value="MULTIMEDIA" />
						<jsp:param name="id" value="sport" />
						<jsp:param name="type" value="PT00004" />
					</jsp:include>
				</div>
				<div class="row">
					<jsp:include page="productslide.jsp">
						<jsp:param name="title" value="THỂ THAO" />
						<jsp:param name="id" value="accessories" />
						<jsp:param name="type" value="PT00005" />
					</jsp:include>
				</div>
			</div>
			<!-- end left panel -->
			<div class="col-xs-6 col-sm-4">
				<div class="row"></div>
			</div>
		</div>
		<!-- end content area -->

		<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin
			ut rutrum orci. Vivamus sem dui, tincidunt tempus massa sit amet,
			sollicitudin iaculis justo. Maecenas facilisis tristique justo sed
			iaculis. Maecenas porttitor mi sed bibendum maximus. Fusce aliquam
			erat a urna condimentum, ac aliquet elit lacinia. Aliquam luctus
			vehicula malesuada. Sed posuere vestibulum sapien in pulvinar. Fusce
			at sollicitudin sapien. Nulla nunc nisl, ultrices sed hendrerit id,
			pretium eu augue. Vivamus viverra tortor quis aliquam accumsan. Nulla
			tempor semper consequat. Integer posuere ex non vehicula mollis. Sed
			ultrices commodo ex, eu aliquet diam consequat non. Sed arcu lorem,
			ornare ut lacinia quis, vulputate sed leo. Donec sed iaculis tellus.</p>
		<p>Duis bibendum maximus nulla, a sollicitudin nisl ullamcorper
			ut. Pellentesque tempus posuere ex et aliquet. In a augue eget lorem
			ullamcorper gravida. In varius, leo vitae molestie dictum, dolor
			augue tincidunt mauris, nec pulvinar magna nisl in dui. Aenean
			consequat nisl et eros volutpat efficitur. Etiam tempor, nibh vel
			bibendum fringilla, ipsum magna blandit nunc, vitae blandit tellus
			neque a nibh. Mauris et pharetra elit. Fusce eleifend, libero vitae
			pretium feugiat, erat eros pharetra felis, in auctor ante sapien id
			elit. Etiam eu commodo metus, ut accumsan ligula. Donec lobortis leo
			nec quam sollicitudin ultricies. Donec nisi diam, vestibulum at
			ultrices vitae, scelerisque nec metus.</p>
		<p>Duis facilisis, sapien ut scelerisque sollicitudin, augue enim
			lacinia lectus, imperdiet dictum eros massa at turpis. Proin at
			lobortis odio, sed tincidunt erat. Sed pulvinar cursus molestie.
			Etiam eleifend neque dui, ac imperdiet nunc varius sed. Nullam
			blandit, dui accumsan venenatis pharetra, orci mauris feugiat libero,
			et faucibus risus eros non nisi. Cras ut metus laoreet, vulputate sem
			vitae, tincidunt lectus. Vivamus eu rhoncus nibh. Nunc orci leo,
			sodales sit amet varius eget, tempor quis tortor. Nunc condimentum
			dictum dapibus. Praesent at volutpat lectus, non convallis elit.
			Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas nec
			interdum tortor.</p>
		<p>Integer porttitor ornare lacus, vitae volutpat purus pulvinar
			ac. Ut vitae elit tristique, vehicula metus ac, condimentum sapien.
			Integer sit amet mauris laoreet, varius urna vel, aliquet arcu. Sed
			faucibus leo ut pretium sollicitudin. Nam sed lectus fringilla risus
			lacinia venenatis et ut orci. Sed auctor diam at lorem euismod
			dictum. Fusce ullamcorper varius suscipit.</p>
		<p>Suspendisse laoreet dui nunc, ut suscipit odio faucibus sed.
			Morbi varius tortor nec ligula placerat, id laoreet diam tristique.
			Praesent in laoreet augue, a pharetra dui. Nunc suscipit risus sit
			amet felis mattis, at mollis arcu dapibus. Aliquam ultrices eleifend
			nisi, ornare pharetra erat maximus nec. Nam erat nulla, venenatis ut
			massa eu, condimentum maximus mauris. Quisque consequat, urna ut
			sodales lobortis, lorem orci pretium purus, ac imperdiet nunc odio
			non eros. Vivamus malesuada dapibus nunc vel imperdiet. In mollis
			laoreet nisi sed sollicitudin. Vestibulum posuere arcu vel bibendum
			pulvinar. Pellentesque a diam in leo vehicula maximus. Proin viverra
			ex et tincidunt auctor.</p>
	</div>
</body>
</html>