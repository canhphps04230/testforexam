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
<title>${title } - Shop Online</title>
</head>
<body>
	<%!ProductTypeDAO typeDAO = new ProductTypeDAO();%>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
	%>

	<%@ include file="header.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#${param.type}").addClass("active");
		})
	</script>

	<c:set var="productList" scope="request"
		value='<%=(new ProductDAO()).listByType(request.getParameter("type"))%>' />

	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
						<li><a href=""><%=typeDAO.getName(request.getParameter("type"))%>
					</a></li>
				</ul>
			</div>
		</div>

		<div class="row">
			<!-- begin content area -->
			<div class="col-sm-12 col-md-3">
				<!-- begin left area -->
				<div class="panel">
					<div class="panel-header"></div>
					<div class="panel-body">
						<c:out value='${param.type }' />
						<input type="range" min="${param.min }" max="${param.max }" />
					</div>
				</div>
			</div>
			<!-- end left aread -->
			<div class="col-sm-12 col-md-9">
				<!-- begin right area -->
				<div class=""><h3>${title }</h3></div>
				<jsp:include page="productlist.jsp" />
			</div>
			<!-- end right area -->
		</div>
		<!-- end content area -->
	</div>
</body>
</html>