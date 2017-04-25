<%@page import="model.ProductHibernateDAO"%>
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
<title>Tìm Kiếm Sản Phẩm - Shop Online</title>
</head>
<body>
	<%!ProductTypeDAO typeDAO = new ProductTypeDAO();%>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
	%>

	<%@ include file="header.jsp"%>

	<c:set var="itemsOnPage" value="<%=ProductHibernateDAO.ITEMSONPAGE%>" />
	<script type="text/javascript">
		$(document)
			.ready(function() {
				var page = 1;
				load_content(page);

				$("#loadMore").click(function(e) {
					page++;
					load_content(page);
				});

				function load_content(page) {
					$.ajax({
						type : "post",
						url : "ProductController",
						data : "action=Fetch&txtSearch=${param.txtSearch}&txtType=${param.txtType}&page="
								+ page,
						success : function(data) {
							var total = $("#total", $(data)).val();
							if (total > 0) {
								$("#totalSpan").text(total + " kết quả!");
								$("#loadMore").text("Còn " + (total - page * ${itemsOnPage}) + " sản phẩm");
							}
							else {
								$("#totalSpan").text(" không có sản phẩm phù hợp!");
								$("#loadMore").hide();
							}
							if ($("#pageNumber", $(data)).val() <= page || total == 0) {
								$("#loadMore").text('No More').prop("disabled", true);
							}else{
								
							}
							
							$("#searchResult").append(data);
							$("html, body").animate({scrollTop:$("#loadMore").offset().top}, 1200);
						}
					});
				}
			});
	</script>

	<c:set var="itemsonpage" value="<%=ProductHibernateDAO.ITEMSONPAGE%>" />
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul class="breadcrumb">
					<li><a href="index.jsp">Home</a></li>
					<li>Tìm Kiếm Sản Phẩm</li>
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
						<c:out value='${param.id }' />
						<input type="range" min="${param.min }" max="${param.max }" />
					</div>
				</div>
			</div>
			<!-- end left aread -->
			<div class="col-sm-12 col-md-9">
				<!-- begin right area -->
				<div class="panel-heading">
					<div class="text-success">Kết quả tìm kiếm:<strong><span id="totalSpan"></span></strong></div>
				</div>
				<div class="panel-body" id="searchResult"></div>
				<div class="panel-footer medium-height">
					<div class="col-xs-12 col-xs-offset-12 col-sm-6 col-sm-offset-3 text-center">
						<button class="btn btn-success btn-lg btn-block" id="loadMore">Load More</button>
					</div>
				</div>
			</div>
		</div>
		<!-- end right area -->
	</div>
	<!-- end content area -->
	</div>
</body>
</html>