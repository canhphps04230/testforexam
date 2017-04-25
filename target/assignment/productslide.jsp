<%@page import="model.ProductHibernateDAO"%>
<%@page import="model.AdvertiseDAO" isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="model.ProductDAO"%>
<%@page import="model.Product"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<c:set var="ad"
	value='<%=AdvertiseDAO.getNewByProduct(request.getParameter("id"))%>' />
<div class="col-xs-12 col-sm-9 no-leftright-padding">
	<div class="panel panel-default no-border">
		<div class="panel-heading text-uppercase nopadding">
			<h2>${param.name }</h2>
		</div>
		<div class="panel-body">
			<div class="carousel slide multi-item-carousel main-carousel"
				id="Carousel${param.id }" data-pause="hover" data-ride="carousel">
				<div class="carousel-inner">
					<c:forEach
						items='<%=ProductHibernateDAO.list("", request.getParameter("id"), 7)%>'
						var="product" varStatus="loop">
						<div class='item ${loop.index eq 0?"active":"" }'>
							<div class="col-sm-3 product-frame">
								<a href="ProductController?action=View&id=${product.id}"><img
									src="img/product/thumbnail/${product.image }"
									class="img-responsive"></a>
								<div class="product-info">
									<div class="text-center text-primary">
										<strong>${product.name }</strong>
									</div>
									<div class="product-price">
<%-- 										<fmt:formatNumber type="number" value="${product.price}" /> --%>
										${product.price}
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<a class="left carousel-control" href="#Carousel${param.id }"
					data-slide="prev"><img class="new-arrow" src="img/prev.png"
					widht="30" /></a> <a class="right carousel-control"
					href="#Carousel${param.id }" data-slide="next"><img
					class="new-arrow" src="img/next.png" /></a>
			</div>
		</div>
	</div>
</div>
<%-- <c:if test="${param.position % 2 == 1 }"> --%>
<div class="col-xs-6 col-sm-3 small-padding">
	<a href="#"><img class="img-responsive" alt=""
		src="img/advertise/${ad.image }" /></a>
</div>
<%-- </c:if> --%>