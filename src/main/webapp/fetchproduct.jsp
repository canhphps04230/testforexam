<%@page import="model.ProductHibernateDAO"%>
<%@page import="model.UserDAO"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:set var="pageNumber"
	value='<%=ProductHibernateDAO.getPage(request.getParameter("txtSearch"), request.getParameter("txtType"),
					ProductHibernateDAO.ITEMSONPAGE)%>' />
<c:set var="total"
	value='<%=ProductHibernateDAO.getTotal(request.getParameter("txtSearch"), request.getParameter("txtType"))%>' />
<c:if test="${param.page <= pageNumber}">
	<div class="row col-sm-12">
		<input type="hidden" id="pageNumber" value="${pageNumber}" /> <input
			type="hidden" id="total" value="${total}" />
	</div>
	<div class="clearfix visible-md-block"></div>
	<div class="clearfix visible-md-block"></div>
	<div class="clearfix visible-md-block"></div>

	<c:forEach var="product"
		items='<%=ProductHibernateDAO.listByPage(request.getParameter("txtSearch"),
							request.getParameter("txtType"), Integer.parseInt(request.getParameter("page")), 12)%>'>
		<div class="col-xs-12 col-sm-6 col-md-3">
			<div class="product-frame">
				<a href="ProductController?action=View&id=${product.id}"><img src="img/product/thumbnail/${product.image }"
					class="img-responsive" height="180"></a>
				<div class="product-info">
					<div class="text-center text-primary">
						<strong>${product.name }</strong>
					</div>
					<div class="product-price">
						<fmt:formatNumber type="number" value="${product.price}" />
					</div>
				</div>
			</div>
		</div>
		</div>
	</c:forEach>
</c:if>
