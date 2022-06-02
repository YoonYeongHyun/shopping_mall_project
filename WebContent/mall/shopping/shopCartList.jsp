<%@page import="java.text.DecimalFormat"%>
<%@page import="manager.product.ProductDAO"%>
<%@page import="manager.product.ProductDTO"%>
<%@page import="cart.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<style>
.container{width: 1200px; height:auto; overflow:hidden;  margin: 0 auto; padding: 50px 20px;}
#cart_box{float:left; width:900px; height: 1200px;}	
table {border-top: 1px solid black; border-collapse: collapse; width: 100%;}
#cart_table td, #cart_table th{padding: 20px 0; text-align: center; vertical-align: middle; border-bottom: 1px solid #ddd;}
#cart_table td{height: 100px}
#cart_num{width: 40px}
.amount_btn{width:70px; height:40px; border: 1px solid #aaa; margin-top:20px; background:white; font-weight: bold; cursor: pointer;  }
.amount_btn:hover{background: black; color:white;}
</style>
<%
request.setCharacterEncoding("UTF-8");
String memberId = (String)session.getAttribute("memberId");

if(memberId == null){
	out.print("<script>alert('로그인 하세요');location='../member/memberAll.jsp?code=1'</script>");
}
CartDAO cartDAO = CartDAO.getInstance();
List<CartDTO> cartlist = null;
cartlist = cartDAO.getCartList(memberId);
ProductDAO productDAO = ProductDAO.getInstance();

DecimalFormat formatter = new DecimalFormat("###,###");
%>
<script>
document.addEventListener("DOMContentLoaded", function(){
	
	
	let cart_num = document.querySelector('#cart_num')
	cart_num.addEventListener("keyup", function(e){
		if(e.target.value > 999){
			e.target.value = 999;
			alert("999개 이하로 주문하세요");
		}else if(e.target.value < 1){
			e.target.value = 1;
			alert("1개 이상 주문하세요")
		}
	});
	
	let cart_chk = document.getElementsByName("cart_chk");
	let chk_arr1 = [];
	let chk_arr2 = [];
	let chk_arr3 = [];
	let chk_arr1_str;
	let chk_arr2_str;
	let sum = 0;
	func01();
	cart_chk.forEach(element => element.addEventListener("change", function(e){
		func01()	
	}));

	function func01(){
		chk_arr1 = [];
		chk_arr2 = [];
		chk_arr3 = [];
		chk_arr1_str = ""
		chk_arr2_str = "";
		sum = 0;
		cart_chk.forEach(element => {
			if(element.checked){
				chk_arr1.push(element.nextElementSibling.value);
				chk_arr2.push(element.nextElementSibling.nextElementSibling.value);
				chk_arr3.push(element.nextElementSibling.nextElementSibling.nextElementSibling.value);
			}
		});
		for(let i in chk_arr1){
			sum += (chk_arr2[i] * chk_arr3[i]);
		}
		
		chk_arr1_str = chk_arr1.join();
		chk_arr2_str = chk_arr2.join();
		let arr_product_id = document.getElementById("arr_product_id");
		let arr_product_amount = document.getElementById("arr_product_amount");
		arr_product_id.value = chk_arr1_str;
		arr_product_amount.value = chk_arr2_str;
		document.getElementById("sum_price").innerHTML = sum;
		if(sum >= 40000){
			document.getElementById("delivery_Fee").innerHTML = 0;
		}else{
			document.getElementById("delivery_Fee").innerHTML = 2500;
		}
	}
});
$(document).ready(function(){
	$('.amount_btn').on("click", function(e){
		let id = '<%=memberId%>';
	    let product_id = $(event.target).prev().prev().val();
	    let product_amount = $(event.target).prev().prev().prev().val();
	    let code = '1';
	    $.ajax({
	        type:'post',
	        async:false,
	        url:'shopCartUpdate.jsp',
	        dataType:'text',
	        data:{id:id,product_id:product_id, product_amount:product_amount, code:code },
	        success:function(data, textStatus){
	        	alert("수량이 변경되었습니다.");
	        	location.reload();
	        },
	        error:function (data, textStatus) {
	            alert("오류가 발생하였습니다.")
	        }
	    })
	})
})
</script>
<div class="container">
	<h2>장바구니</h2>
	<table id="cart_table">
		<tr> 
			<th width="4%"></th>
			<th width="12%"></th>
			<th width="30%">상품명</th>
			<th width="11%">수량</th>
			<th width="14%">상품금액</th>
			<th width="14%">합계금액</th>
			<th width="15%">배송비</th> 
		</tr>
		<%
		boolean flag = true; 
		int delivery_fee = 0;
		for(CartDTO cart : cartlist){
			int list_size = cartlist.size();
			ProductDTO product = productDAO.getProduct(cart.getProduct_id());%>
		<tr>
			<td>
				<input type="checkbox" name="cart_chk" checked>
				<input type="hidden" name="chk_product_id" value="<%=product.getProduct_id() %>">
				<input type="hidden" name="chk_product_amount" value="<%=cart.getProduct_amount()%>">
				<input type="hidden" name="chk_product_price" value="<%=product.getProduct_sale_price()%>">
			</td>
			<td>
				<img src="/images_yhmall/<%=product.getProduct_image()%>" style="width:100px; float: left;" >
			</td>
			<td style="text-align: left;">
				<%=product.getProduct_name()%>
			</td>
			<td>
				<input type="number" id="cart_num" value="<%=cart.getProduct_amount()%>" min="1" max="999">
				<input type="hidden" id="cart_id" value="<%=cart.getProduct_id()%>">
				<br>
				<button class="amount_btn">수량변경</button>
			</td>
			<td><%=formatter.format(product.getProduct_sale_price())%>원</td>
			<td style="font-weight:bold;"><%=formatter.format(cart.getProduct_amount() * product.getProduct_sale_price())%>원</td>
			<%if(flag){%>
			<td rowspan="<%=list_size%>">
				<span>4만원이상무료</span><br>
				<span>
				<%if(cart.getProduct_amount() * product.getProduct_sale_price() >= 40000){ 
					delivery_fee = 0;%>
					0원
					
				<%}else{
					delivery_fee = 2500;%>
					2500원
				<%}
				flag = false;
				%>
				</span><br>
				<span>(택배-선결제)</span>
			</td>
			<%}%>
		</tr>
		<%}%>
	</table>
	<div id="order_info">
	<p>총 상품금액<span id="sum_price"></span>원  + 배송비 <span id="delivery_Fee"></span>원
	</div>
	<form action=""> 
		<div>
			<input type="text" id="arr_product_id" >
			<input type="text" id="arr_product_amount">
		</div> 
	</form>
</div>
</html>