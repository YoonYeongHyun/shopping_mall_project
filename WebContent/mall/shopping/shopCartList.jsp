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

#delete_btns{width: 100%; height: 100px; text-align: right;}
#delete_btn{width: 150px; height: 50px; border: 1px solid #ccc; background: white; font-size: 1.2em; cursor: pointer; margin: 20px}
#delete_btn:hover{border: 1px solid black; font-weight: bold; }

#order_info{width: 1140px; height: 80px; background: #f5f0c5; padding: 30px; text-align: center; font-size: 1.2em; 
			border-top:1px solid #966147; }
#final_price1, #final_price2, #final_price3{font-size: 1.5em; font-weight: bold;}

#order_btns{width:1160px; height:112px; padding:20px; text-align: right;}
#order_btns form{display: inline-block; width: 210px}
#order_btns input[type="submit"]{width:200px; height:70px; padding: 10px; font-size: 1.2em; border: 1.5px solid #ccc; border-radius:20px; cursor: pointer;}
#se_purchase_btn{background: black; color:white;}
#all_purchase_btn{background: white; color:black;}
				   
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
int cart_cnt = cartDAO.getCartCount(memberId);

%>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let cart_cnt = <%=cart_cnt%>;
	if(cart_cnt != 0){

		let cart_num = document.querySelectorAll('#cart_num')
		
		
		cart_num.forEach(element => element.addEventListener("keyup", function(e){
			let cart_qty = e.target.previousSibling.previousSibling;
			amount_func(e);
			if(e.target.value > parseInt(cart_qty.value)){
				alert('선택량이 재고량 보다 많습니다.');
				e.target.value = parseInt(cart_qty.value);
			}
		}));
		
		cart_num.forEach(element => element.addEventListener("change", function(e){
			let cart_qty = e.target.previousSibling.previousSibling;
			amount_func(e);
			if(e.target.value > parseInt(cart_qty.value)){
				alert('선택량이 재고량 보다 많습니다.');
				e.target.value = parseInt(cart_qty.value);
			}
		}));
		
		function amount_func(e){
			if(e.target.value > 999){
				e.target.value = 999;
				alert("999개 이하로 주문하세요");
			}else if(e.target.value < 1){
				e.target.value = 1;
				alert("1개 이상 주문하세요")
			}
		}
		
		let flag = true;
		let cart_chk = document.getElementsByName("cart_chk");
		let cart_chk_all = document.getElementById("cart_chk_all");
		let chk_arr1 = [];
		let chk_arr2 = [];
		let chk_arr3 = [];
		let chk_arr1_str;
		let chk_arr2_str;
		let sum = 0;
		
		func01();
		
		cart_chk_all.addEventListener("click", function(){
			if(cart_chk_all.checked){
				cart_chk.forEach(element => {
					element.checked = true;
				});
			}else{
				cart_chk.forEach(element => {
					element.checked = false;
				});
			}
			func01();
		});
		
	
		cart_chk.forEach(element => element.addEventListener("change", function(e){
			let chk_cnt = cart_chk.length;
			let chk_checked_cnt = 0;
			for(let chk of cart_chk){
				if(chk.checked) chk_checked_cnt++;
			}
			if(chk_cnt == chk_checked_cnt) cart_chk_all.checked = true;
			else cart_chk_all.checked = false;
			
			func01()
			
		}));
	
		function func01(){
			let selected_cnt = 0;
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
					selected_cnt++;
				}
				
			});
			for(let i in chk_arr1){
				sum += (chk_arr2[i] * chk_arr3[i]);
			}
			chk_arr1_str = chk_arr1.join();
			chk_arr2_str = chk_arr2.join();
			let product_id_se = document.getElementById("product_id_se");
			let purchase_amount_se = document.getElementById("purchase_amount_se");
			product_id_se.value = chk_arr1_str;
			purchase_amount_se.value = chk_arr2_str;
			if(flag==true){
				let product_id_all = document.getElementById("product_id_all");
				let purchase_amount_all = document.getElementById("purchase_amount_all");
				product_id_all.value = chk_arr1_str;
				purchase_amount_all.value = chk_arr2_str;
				flag = false;
			}
			document.getElementById("final_price1").innerHTML = sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			if(sum >= 40000){
				document.getElementsByClassName('delivery_Fee')[0].innerHTML = 0;
				document.getElementsByClassName('delivery_Fee')[1].innerHTML = 0;
				document.getElementById("final_price3").innerHTML = sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}else{
				document.getElementsByClassName('delivery_Fee')[0].innerHTML = '2,500';
				document.getElementsByClassName('delivery_Fee')[1].innerHTML = '2,500';
				document.getElementById("final_price3").innerHTML = (sum+2500).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
			document.getElementById('selected_cnt').innerText= selected_cnt;
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
	
	$('#delete_btn').on("click", function(e){
		let id = '<%=memberId%>';
	    let product_ids = $('#product_id_se').val();
	    let code = '2';
	    $.ajax({
	        type:'post',
	        async:false,
	        url:'shopCartUpdate.jsp',
	        dataType:'text',
	        data:{id:id, product_ids:product_ids, code:code },
	        success:function(data, textStatus){
	        	alert("삭제 하였습니다.");
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
			<th width="4%"><input type="checkbox" id="cart_chk_all" checked></th>
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
		if(cart_cnt == 0){%>
		<tr><td colspan="7">장바구니가 비었습니다.</td></tr>
		<%}else{
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
					<input type="hidden" id="cart_qty" value="<%=product.getProduct_qty()%>">
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
					<span class="delivery_Fee"></span>원<br>
					<span>(택배-선결제)</span>
					<% 
					flag = false;
					%>
				</td>
				<%}%>
			<%}%>
		</tr>
		<%}%>
	</table>
	<%if(cart_cnt != 0){%>
	<div id="delete_btns">
		<button id=delete_btn>선택 상품 삭제</button>
	</div>
	<%}%>
	<div id="order_info">
		<p>
			총 <span id="selected_cnt"><%=cart_cnt%></span>개의 상품금액&nbsp;<span id="final_price1"></span>&nbsp;원,&ensp;&ensp; &ensp;
			<img src="../../icons/plus.png" width="24px">&ensp;&ensp;&ensp;
			배송비&nbsp;<span id="final_price2" class="delivery_Fee"></span>&nbsp;원&ensp;&ensp;&ensp;
			<img src="../../icons/equal.png" width="24px">&ensp;&ensp;&ensp;
			<span id="final_price3"></span>&nbsp;원
		</p>
	</div>
	<%if(cart_cnt != 0){%>
	<div id="order_btns">
		<form action="shoppingAll.jsp?code=5" method="post" name="order_form_selected"> 
			<input type="hidden" id="product_id_se" name="product_id">
			<input type="hidden" id="purchase_amount_se" name="purchase_amount">
			<input type="submit" id="se_purchase_btn" value="선택 상품 주문"></button>
		</form>
		<form action="shoppingAll.jsp?code=5" method="post" name="order_form_all"> 
			<input type="hidden" id="product_id_all" name="product_id">
			<input type="hidden" id="purchase_amount_all" name="purchase_amount">
			<input type="submit" id="all_purchase_btn" value="전체 상품 주문"></button>
		</form>
	</div>
	<%}%>
</div>
</html>