<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if
	test="${empty sessionScope.user || sessionScope.user.admin == false}">
	<c:set var="msg" scope="session"
			value="Vui lòng đăng nhập tài khoản quản trị để tiếp tục!" />
	<c:set var="css" scope="session" value="warning" />
	<c:redirect url="admin.jsp">
	</c:redirect>
</c:if>
<div class="container">
	<div class="row">
		<c:if test="${not empty msg}">
			<div class="alert alert-${css} alert-dismissible" role="alert">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<strong>${msg}</strong>
			</div>
		</c:if>
	</div>
	<!-- end msg alert	 -->
	<div class="page-header text-center text-primary">
		<h1>QUẢN TRỊ SHOP ONLINE</h1>
	</div>

	<div class="row">
		<div class="btn-group btn-group-justified">
			<div class="btn-group">
				<a class="btn btn-primary btn-lg" href="adminuser.jsp">Quản Lý Người
					Dùng</a>
			</div>
			<div class="btn-group">
				<a class="btn btn-primary btn-lg" href="adminproducttype.jsp">Quản Lý Loại
					Sản Phẩm </a>
			</div>
			<div class="btn-group">
				<a class="btn btn-primary btn-lg" href="adminproduct.jsp">Quản Lý Sản
					Phẩm </a>
			</div>
			<div class="btn-group">
				<a class="btn btn-primary btn-lg" href="admincart.jsp">Quản Lý Giỏ Hàng</a>
			</div>
		</div>
	</div>
</div>