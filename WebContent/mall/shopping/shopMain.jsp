<%@page import="java.text.DecimalFormat"%>
<%@page import="manager.product.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<style>

#container{width:1200px; margin:50px auto;}
.swiper-slide {text-align: center;  font-size: 18px; display: -webkit-box; display: -ms-flexbox; 
				display: -webkit-flex; display: flex; -webkit-box-pack: center; -ms-flex-pack: center; 
				-webkit-justify-content: center; justify-content: center; -webkit-box-align: center; 
				-ms-flex-align: center; -webkit-align-items: center; align-items: center;}
.swiper-slide img {display: block; height:500px; object-fit: cover;}
.swiper-wrapper a{width:100%; height: 500px; overflow: hidden;}
.swiper-pagination-bullet { width: 12px; height: 12px; background: transparent; border: 1px solid white; opacity: 1; }
.swiper-pagination-bullet-active { width: 40px; transition: width .5s; border-radius: 5px; background: white; border: 1px solid transparent; }

h2{text-align: center;}
.main_table{width:1200px; border-collapse: collapse; margin-bottom: 80px}
.main_table tr {height: 300px; width:1200px; border-bottom:1px solid #eee; }
.main_table td {text-align: center;}
.main_table td p {margin:0 auto;}

.product_img_box{position: relative; text-align: center; display:inline-block; width:202px}
#product_img{border: 1px solid #ccc;}
.medal{position: absolute; top:0px; left: 0px; border: none;}
.price{text-decoration: line-through;}
.sale_price{color: red}
.product__hidden_menu{position: absolute; top:120px; left:26.1px; visibility: hidden;}
.product__hidden_menu button{display:inline-block; width:50px; height:50px; border-radius: 100%;
		position: relative; border: 1px solid black; margin:0 10px; cursor: pointer;}
.product__hidden_menu #like_btn{background: url("../../icons/heart.png") no-repeat center white}
.product__hidden_menu #cart_btn{background: url("../../icons/basket.png") no-repeat center white}

.cart_disabled{display:none;}
.cart_enabled{ position: fixed; left: 50%; transform: translate(-50%, 0); top:20%; z-index:1000; text-align:center;
width:400px; height: 400px; border: 2px solid black; border-radius:20px; padding:30px; background: white; }
#qty_set button{background:white; border:1px solid #888; ;border-radius:30%;font-size:1.3em;}
#qty_set input[type="number"]{text-align:center; border:none;}
#qty_set input[type="number"]:focus{outline:none;}
input::-webkit-inner-spin-button { -webkit-appearance:none; margin:0; }
#cart_btns{display: inline-block; width: 100%; margin-top: 30px}
#cart_btns button{width:130px; height:50px; margin:10px; font-size:0.9em; border: 0.5px solid #888; cursor: pointer;}
#cart_btns button:hover {font-weight: bold; box-shadow: 1px 1px 5px 1px #888;}
#cart_cancel{background: white}
#cart_insert{background: #D2691E; color: white;}
</style>

<%
ProductDAO productDAO = ProductDAO.getInstance();
List<ProductDTO> mPList1 = productDAO.getSpecialProductsList("1", 1, 8);
List<ProductDTO> mPList2 = productDAO.getSpecialProductsList("2", 1, 8);

DecimalFormat formatter = new DecimalFormat("###,###");
String memberId = memberId = (String) session.getAttribute("memberId");
int result;
%> 

<div class="swiper mySwiper">
	<div class="swiper-wrapper">
        <div class="swiper-slide" style="background: rgb(250, 218, 207);">
        	<a href="@" ><img style="display: inline-block;"  src="../../images/main_slider04.png"></a>
        </div>
        <div class="swiper-slide" style="background: rgb(228, 230, 229);"> 
            <a href="@"><img style="display: inline-block;"  src="../../images/main_slider05.png"></a> 
        </div>
        <div class="swiper-slide" style="background: rgb(243, 243, 243);"> 
          	<a href="@"><img style="display: inline-block;"  src="../../images/main_slider06.png"></a> 
        </div>
        <div class="swiper-slide" style="background: rgb(133, 14, 3);"> 
         	<a href="@"><img style="display: inline-block;"  src="../../images/main_slider07.jpg"></a> 
        </div>
        <div class="swiper-slide" style=""> 
          	<a href="shoppingAll.jsp?code=4&product_id=172"><img style="display: inline-block;"  src="../../images/main_slider08.png"></a> 
        </div>
		</div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
</div>

<script>
var swiper = new Swiper(".mySwiper", {
	autoplay: {
   		delay: 5000, // 시간 설정
    },
    loop: true,
    cssMode: true,
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    pagination: {
      el: ".swiper-pagination",
      clickable: true, 
    },
    mousewheel: false,
    keyboard: true,
});
  
document.addEventListener("DOMContentLoaded", function(){
	let product_img_box = document.getElementsByName("product_img_box");
	
	product_img_box.forEach(element => element.addEventListener("mouseenter", function(e){
		let product_image = e.target.firstChild.nextSibling;
		product_image.style.opacity= "0.5";
		let hidden_box = e.target.lastChild.previousSibling;
		hidden_box.style.visibility="visible";
	}));
	product_img_box.forEach(element => element.addEventListener("mouseleave", function(e){
		let product_image = e.target.firstChild.nextSibling;
		product_image.style.opacity= "1";
		let hidden_box = e.target.lastChild.previousSibling;
		hidden_box.style.visibility="hidden";
	}));
	
	let cart_btn = document.getElementsByName("cart_btn");
	cart_btn.forEach(element => element.addEventListener("click", function(e){
		let cart__product_id = (e.target).nextElementSibling.value;
		let cart__product_name = (e.target).nextElementSibling.nextElementSibling.value;
		let cart__product_img = (e.target).nextElementSibling.nextElementSibling.nextElementSibling.value;
		let cart_1 = document.getElementById("cart_1");
		let cart_2 = document.getElementById("cart_2");
		let cart_product_name = document.getElementById("cart_product_name");
		let cart_product_img = document.getElementById("cart_product_img");
		
		cart_product_img.src="/images_yhmall/" + cart__product_img;
		cart_1.value = '<%=memberId%>';
		cart_2.value = cart__product_id;
		cart_product_name.innerHTML = cart__product_name;
		document.getElementById('cart_box').className = 'cart_enabled';
	}));
	
	let cart_3 = document.getElementById("cart_3");
	document.getElementById("btn_plus").addEventListener("click", function(){
		if(cart_3.value > 999){
			alert("최대 구매 수량을 초과 하였습니다. (999개)");
		}else{
			cart_3.value = Number(cart_3.value)+1;	
		}
	});
	document.getElementById("btn_minus").addEventListener("click", function(){
		if(cart_3.value < 2){	
			alert("최소 1개이상 구매하셔야합니다.");
		}else{
			cart_3.value = Number(cart_3.value)-1;
		}
	});
	
	document.getElementById("cart_3").addEventListener("keyup", function(){
		if(cart_3.value > 999){
			cart_3.value = 1;	
			alert("최대 구매 수량을 초과 하였습니다. (999개)");
		}else if(cart_3.value < 1){
			cart_3.value = 1;	
			alert("최소 1개이상 구매하셔야합니다.");
		}
	});
})
$(document).ready(function(){
	$('#cart_insert').on("click", function(e){
		let id = $('#cart_1').val();
	    let product_id = $('#cart_2').val();
	    let product_amount = $('#cart_3').val();
	    let result = "";
	    e.preventDefault()
	    <%if(memberId == null){%>
			alert("로그인 하세요");
			location="../member/memberAll.jsp?"
	    <%}else{ %>
	    $.ajax({
	        type:'post',
	        async:false,
	        url:'shopCartInsert.jsp',
	        dataType:'text',
	        data:{id:id,product_id:product_id, product_amount:product_amount},
	        success:function(data, textStatus) {
	        	$('#cart_box').attr('class','cart_disabled')
	        	alert("장바구니에 담겼습니다.");
	        },
	        error:function (data, textStatus) {
	            alert("오류가 발생하였습니다.")
	        }
	    })
	    <%}%>

	})
	
	$('#cart_cancel').on("click", function(e){
		$('#cart_box').attr('class','cart_disabled')
	})
   
});
</script>


<div id="container">
	<div class="cart_disabled" id="cart_box">
		<div>
			<img src="" id="cart_product_img" width="200px">
		</div>
		<p id="cart_product_name"> </p>
		<input type="hidden" id="cart_1">
		<input type="hidden" id="cart_2">
		<div id="qty_set">
			<button type="button" id="btn_plus">+</button>
			<input type="number" id="cart_3" value="1" max="999" min="1">
			<button type="button" id="btn_minus">-</button>
		</div>
		<div id="cart_btns">
			<button id="cart_cancel">취소</button>
			<button id="cart_insert">장바구니 담기</button>
		</div>
	</div>
	<h2>최고 인기상품</h2> 
	<table class="main_table">
		<tr>
			<% int cnt = 1;
			for(ProductDTO list1 : mPList1){ %>
			<td width="25%"> 
				<div class="product_img_box" name="product_img_box">
					<a href="shoppingAll.jsp?code=4&product_id=<%=list1.getProduct_id()%>">
						<%if(cnt==1){%>
						<img class="medal" src="../../icons/gold-medal.png" width="48px">
						<%}else if(cnt==2){%>
						<img class="medal" src="../../icons/silver-medal.png" width="48px">
						<%}else if(cnt==3){%>
						<img class="medal" src="../../icons/bronze-medal.png" width="48px">
						<%} %>
						<img  id="product_img" src="/images_yhmall/<%=list1.getProduct_image()%>" width="200px" height="200px"/> 
					</a>
					<div class="product__hidden_menu">
						<button type="button" name="like_btn" id="like_btn"></button>
						<button type="button" name="cart_btn" id="cart_btn"></button>
						<input type="hidden" value="<%=list1.getProduct_id()%>">
						<input type="hidden" value="<%=list1.getProduct_name()%>">
						<input type="hidden" value="<%=list1.getProduct_image()%>">
					</div>
				</div>
				<br>
				<p><a href="shoppingAll.jsp?code=4&product_id=<%=list1.getProduct_id()%>"><%=list1.getProduct_name()%></a></p>
				<% if(list1.getProduct_price() == list1.getProduct_sale_price()){%>
					<span class="sale_price" style="color:black;"><%=formatter.format(list1.getProduct_sale_price())%>원</span>
				<%}else{%>
					<span class="price" style="color:#aaa;"><%=formatter.format(list1.getProduct_price())%>원</span>&nbsp;
					<span class="sale_price"><%=formatter.format(list1.getProduct_sale_price())%>원</span>
				<%}
				if(cnt == 4){
					%></tr><tr><%
				}
				++cnt;
				%>
			</td>
			<%}%>
		</tr>
	</table>
	
	<h2>최고 할인상품</h2> 
	<table class="main_table">
		<tr>
			<% cnt = 1;
			for(ProductDTO list2 : mPList2){ %>
			<td width="25%"> 
				<div class="product_img_box" name="product_img_box">
					<a href="shoppingAll.jsp?code=4&product_id=<%=list2.getProduct_id()%>"><%if(cnt==1){%>
						<img class="medal" src="../../icons/gold-medal.png" width="48px">
						<%}else if(cnt==2){%>
						<img class="medal" src="../../icons/silver-medal.png" width="48px">
						<%}else if(cnt==3){%>
						<img class="medal" src="../../icons/bronze-medal.png" width="48px">
						<%} %>
						<img  id="product_img" src="/images_yhmall/<%=list2.getProduct_image()%>" width="200px" height="200px"/> 
					</a>
					<div class="product__hidden_menu">
						<button type="button" name="like_btn" id="like_btn"></button>
						<button type="button" name="cart_btn" id="cart_btn"></button>
						<input type="hidden" value="<%=list2.getProduct_id()%>">
						<input type="hidden" value="<%=list2.getProduct_name()%>">
						<input type="hidden" value="<%=list2.getProduct_image()%>">
					</div>
				</div>
				<p><a href="shoppingAll.jsp?code=4&product_id=<%=list2.getProduct_id()%>"><%=list2.getProduct_name()%></a></p>
				<% if(list2.getProduct_price() == list2.getProduct_sale_price()){%>
					<span class="sale_price" style="color:black;"><%=formatter.format(list2.getProduct_sale_price())%>원</span>
				<%}else{%>
					<span class="price" style="color:#aaa;"><%=formatter.format(list2.getProduct_price())%>원</span>&nbsp;
					<span class="sale_price"><%=formatter.format(list2.getProduct_sale_price())%>원</span>
				<%}
				if(cnt == 4){
					%></tr><tr><%
				}
				++cnt;
				%>
			</td>
			<%}%>
		</tr>
	</table>
	<hr>
</div>

</html>