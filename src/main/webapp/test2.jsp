<%@page import="model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#add1").click(function(){
				var id = $(this).val();
				$.ajax({
					type:"post",
					url:"CartController",
					data:"action=Add&id="+id+"&quantity=1",
					success:function(data){
						$("#receiver").empty().append(data);
					}
				});
			});
			
			$("#add2").click(function(){
				var id = $(this).val();
				$.ajax({
					type:"get",
					url:"CartController",
					data:"action=Add&id="+id+"&quantity=1",
					success:function(data){
						$("#receiver").empty().append(data);
					}
				});
			});
			
			$("#update1").click(function(){
				var id = $(this).val();
				$.ajax({
					type:"post",
					url:"CartController",
					data:"action=Update&id="+id+"&quantity=10",
					success:function(data){
						$("#receiver").empty().append(data);
					}
				});
			});
			
			$("#update2").click(function(){
				var id = $(this).val();
				$.ajax({
					type:"post",
					url:"CartController",
					data:"action=Update&id="+id+"&quantity=10",
					success:function(data){
						$("#receiver").empty().append(data);
					}
				});
			});
			
			$("#delete1").click(function(){
				var id = $(this).val();
				$.ajax({
					type:"post",
					url:"CartController",
					data:"action=Delete&id="+id,
					success:function(data){
						$("#receiver").empty().append(data);
					}
				});
			});
			
			$("#delete2").click(function(){
				var id = $(this).val();
				$.ajax({
					type:"post",
					url:"CartController",
					data:"action=Delete&id="+id,
					success:function(data){
						$("#receiver").empty().append(data);
					}
				});
			});
		})
	</script>
	<button id="add1" value="PS00001">Add PS00001</button>
	<button id="add2" value="PS00002">Add PS00002</button>
	<button id="update1" value="PS00001">Update PS00001</button>
	<button id="update2" value="PS00002">Update PS00001</button>
	<button id="delete1" value="PS00001">Delete PS00001</button>
	<button id="delete2" value="PS00002">Delete PS00002</button>
	<div id="receiver"></div>
	<p>${session.cartTotal}</p>
</body>
</html>