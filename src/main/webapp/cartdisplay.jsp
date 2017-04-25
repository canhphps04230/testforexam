<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script>
$(document).ready(function(){
	
	function assignEvent(){
		$(document).on("submit", "form.cartmainform", function(e){
			var action = $(document.activeElement).val();
			e.preventDefault();
			var query = "&action=" + action;
//				*****
			$.ajax({
				type:"post",
				url:"CartController",
				data:$(this).serialize() + query,
				success:function(data){
					var num = $("#total", $(data));
					var msg = $("#msg", $(data));
					var sum = $("#sum", $(data));
					
					$("#itemNum").text(num.val());
					$("#cartarea").html(data);
					//data.detach();
					$("#msgContent").html(msg.val());
					$("#sumspan").html(sum.val());
					
					$("#topAlert").removeClass("hidden").show().fadeOut(3000);
				}
			});
		});
	};
	
	$(document).on("submit", "form.cartmainform", function(e){
		var action = $(document.activeElement).val();
		//if (action == "Update") e.preventDefault();
		e.preventDefault();
		var query = "&action=" + action;
//			*****
		$.ajax({
			type:"post",
			url:"CartController",
			data:$(this).serialize() + query,
			success:function(data){
				var num = $("#total", $(data));
				var msg = $("#msg", $(data));
				var sum = $("#sum", $(data));
				
				$("#itemNum").text(num.val());
				$("#cartarea").empty().append(data);
				//data.detach();
				$("#msgContent").html(msg.val());
				$("#sumspan").html(sum);
				
				$("#topAlert").removeClass("hidden").show().fadeOut(3000);
				assignEvent();
			}
		});
	});
	
	
});
</script>
<c:choose>
	<c:when test="${empty sessionScope.cartList}">
		<div class="jumbotron text-center"><h3>Bạn Không Có Sản Phẩm Nào Trong Giỏ Hàng</h3></div>
	</c:when>
	<c:otherwise>
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="text-center">No</th>
					<th class="text-center">Name</th>
					<th class="text-center">Price</th>
					<th class="text-center">Quantity</th>
					<th class="text-center">Update</th>
					<th class="text-center">Delete</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="sum" scope="request" value="0"/>
				<c:forEach var="item" items="${sessionScope.cartList}" varStatus="loop">
					<c:set var="sum" scope="request" value="${sum + item.quantity*item.product.price }" />
					<form action="CartController" method="get" class="cartmainform">
						<tr>
							<td class="vertical-align col-xs-1 text-center"><strong>${loop.count}</strong>
								<input type="hidden" name="id" value="${item.product.id}" />
							</td>
							<td class="vertical-align col-xs-3 text-center">
								<div class="row text-center">${item.product.name}</div>
								<div class="row text-center">
									<img class="img-responsive" alt="" src="img/product/thumbnail/${item.product.image}" />
								</div>
							</td>
							<td class="vertical-align col-xs-2">
								<div class="product-price text-center">
									<fmt:formatNumber type="number" value="${item.product.price}" />
								</div>
							</td>
							<td class="vertical-align col-xs-2 text-center">
								<div class="form-inline">
<!-- 												<button class="btn btn-default minus" type="button">-</button> -->
									<input id="quantityNum" class="form-control number" type="number"
										name="quantity" id="quantity" value="${item.quantity}" min="1"
										max="${item.product.quantity}" />
<!-- 												<button class="btn btn-default plus" type="button">+</button> -->
								</div>
							</td>
							<td class="vertical-align col-xs-1">
								<button class="btn btn-success" type="submit" name="action" value="Update" >Update</button>
							</td>
							<td class="vertical-align col-xs-1">
								<button class="btn btn-warning" type="submit" name="action" value="Delete" >Delete</button>
							</td>
						</tr>
					</form>
				</c:forEach>
			</tbody>
		</table>
		<div>
			<input type="hidden" id="total" value="${requestScope.cartTotal}" />
			<input type="hidden" id="sum" value='<fmt:formatNumber type="number" value="${requestScope.cartSum}" />' />
			<input type="hidden" id="msg" value="${requestScope.msg}" />
		</div>
	</c:otherwise>
</c:choose>