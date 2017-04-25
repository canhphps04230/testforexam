<%@page import="model.Product"%>
<%@page import="model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
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
			<div class="col-sm-12">
				<a href="index.jsp">Trang chủ</a> <span
					class="glyphicon glyphicon-menu-right"></span> <span>Phone</span>
			</div>
		</div>

		<div class="row">
			<!-- begin content area -->
			<div class="col-sm-12 col-md-3">
				<!-- begin left area -->
				<div class="panel">
					<div class="panel-header"></div>
					<div class="panel-body"></div>
				</div>
			</div>
			<!-- end left aread -->
			<div class="col-sm-12 col-md-9">
				<!-- begin right area -->
				<div>PHONE</div>
				<jsp:include page="productlist.jsp">
					<jsp:param name="type" value="PT00002" />
				</jsp:include>
			</div>
			<!-- end right area -->
		</div>
		<!-- end content area -->
	</div>
</body>
</html>