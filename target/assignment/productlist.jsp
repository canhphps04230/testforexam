<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="model.Product"%>
<%@page import="model.ProductDAO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div class="panel panel-default">
	<div class="panel-body">
		<c:forEach var="product"
			items='${requestScope.productList }'>
			<div class="col-xs-12 col-sm-6 col-md-3">
				<div class="product-frame">
					<a href="ProductController?action=View&id=${product.id}"><img src="img/product/thumbnail/${product.image }"
						class="img-responsive" width="180"></a>
					<div class="text-center text-primary">
						<strong>${product.name }</strong>
					</div>
					<div class="text-center product-price">
<%-- 						<fmt:formatNumber type="number" value="${product.price}" /> --%>
						${product.price}
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
