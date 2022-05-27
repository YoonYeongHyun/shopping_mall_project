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
.product__hidden_menu span{display:inline-block; width:50px; height:50px; background: white; border-radius: 100%;
							position: relative; border: 1px solid black; margin:0 10px; }
.product__hidden_menu span img{border:none; position: absolute; top:9px; left:9px;}
</style>

<%
ProductDAO productDAO = ProductDAO.getInstance();
List<ProductDTO> mPList1 = productDAO.getSpecialProductsList("1", 1, 8);
List<ProductDTO> mPList2 = productDAO.getSpecialProductsList("2", 1, 8);
DecimalFormat formatter = new DecimalFormat("###,###");

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
})
</script>


<div id="container">
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
						<input type="hidden" value="<%=list1.getProduct_id()%>">
						<span><a><img src="../../icons/heart.png"></a></span>
						<span><a><img src="../../icons/basket.png"></a></span>
					</div>
				</div>
				<br>
				<p><a href="shoppingAll.jsp?code=4&product_id=<%=list1.getProduct_id()%>"><%=list1.getProduct_name()%></a></p>
				<% if(list1.getProduct_price() == list1.getProduct_sale_price()){%>
					<span class="sale_price" style="color:black;"><%=formatter.format(list1.getProduct_sale_price())%></span>
				<%}else{%>
					<span class="price" style="color:#aaa;"><%=formatter.format(list1.getProduct_price())%></span>&nbsp;
					<span class="sale_price"><%=formatter.format(list1.getProduct_sale_price())%></span>
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
						<input type="hidden" value="<%=list2.getProduct_id()%>">
						<span><a><img src="../../icons/heart.png"></a></span>
						<span><a><img src="../../icons/basket.png"></a></span>
					</div>
				</div>
				<p><a href="shoppingAll.jsp?code=4&product_id=<%=list2.getProduct_id()%>"><%=list2.getProduct_name()%></a></p>
				<% if(list2.getProduct_price() == list2.getProduct_sale_price()){%>
					<span class="sale_price" style="color:black;"><%=formatter.format(list2.getProduct_sale_price())%></span>
				<%}else{%>
					<span class="price" style="color:#aaa;"><%=formatter.format(list2.getProduct_price())%></span>&nbsp;
					<span class="sale_price"><%=formatter.format(list2.getProduct_sale_price())%></span>
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