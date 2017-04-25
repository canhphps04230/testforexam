<%@page import="model.ProductHibernateDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="panel panel-primary">
	<div class="panel-heading">
		<input type="hidden" id="total" value="${requestScope.cartTotal}" />
		<input type="hidden" id="msg" value="${requestScope.msg}" />
		<input type="hidden" id="sum" value='<fmt:formatNumber type="number" value="${requestScope.cartSum}" />' />
	</div>
	<div class="panel-body dropdown-menu-expanded">
		<div class="table-responsive nopadding">
			<table class="table table-hover col-xs-12 nopadding">
				<c:choose>
					<c:when test="${empty sessionScope.cartList}">
						<h4 class="text-info text-center">Bạn chưa đặt mua sản phẩm</h4>
					</c:when>
					<c:otherwise>
						<tbody>
							<c:forEach var="item" items="${sessionScope.cartList}"
								varStatus="loop">
								<tr>
									<td class="col-xs-7">
										<div class="row text-center text-primary">
											<h5><a href="ProductController?action=View&id=${item.product.id}">${item.product.name}</a></h5>
										</div>
										<div class="row">
											<div class="col-xs-4 col-xs-offset-4">
												<a href="ProductController?action=View&id=${item.product.id}">
													<img class="img-responsive" alt=""
													src="img/product/thumbnail/${item.product.image}" />
												</a>
											</div>
										</div>
									</td>
									<td class="vertical-align col-xs-4">
										<div class="product-price text-danger">
											${item.quantity} x
											<fmt:formatNumber type="number" value="${item.product.price}" />
										</div>
									</td>
		
									<td></td>
								</tr>
							</c:forEach>
						</tbody>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</div>
	<div class="panel-footer">
		<div class="row">
			<div class="col-sm-6">
				<a class="btn btn-danger btn-block" href="cart.jsp">VÀO GIỎ HÀNG</a>
			</div>
			<div class="col-sm-6">
				<a class="btn btn-default btn-block" href="#">TIẾP TỤC MUA HÀNG</a>
			</div>
		</div>
	</div>
</div>
