<%@page import="manager.product.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- 제이쿼리 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
 
<!-- Slick 불러오기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
</head>
<style>
	#container{width:1200px; margin:0 auto;}
	#slider-div div{height: 500px}
	#slider-div ul{justify-content: center; display: flex;}
	
	table{width:1200px; border-collapse: collapse;}
	tr {height: 300px; width:1200px;}
	td {text-align: center;}
	td p {margin:0 auto;}
	td img{border: 1px solid #eee;}
	.price{text-decoration: line-through;}
	.sale_price{color: red}
	
</style>
<script>
$(function(){
	$('#slider-div').slick({
    	slide: 'div',        //슬라이드 되어야 할 태그 ex) div, li 
     	infinite : true,     //무한 반복 옵션     
       	slidesToShow : 1,        // 한 화면에 보여질 컨텐츠 개수
       	slidesToScroll : 1,        //스크롤 한번에 움직일 컨텐츠 개수
        speed : 100,     // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
        autoplay : true,            // 자동 스크롤 사용 여부
        autoplaySpeed : 5000,         // 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
        draggable : true,     //드래그 가능 여부 
        dots: true,
 	});
})
    </script>

<%
ProductDAO productDAO = ProductDAO.getInstance();
List<ProductDTO> mPList1 = productDAO.getMainProductsList(1);
List<ProductDTO> mPList2 = productDAO.getMainProductsList(2);


%>

	<div>
    	<div id="slider-div">
        	<div style="text-align: center; background: rgb(84, 47, 39);"> 
            	<img style="display: inline-block;" src="../../images/main_slider01.png"> 
            </div>
            <div style="text-align: center; background: rgb(103, 156, 52);"> 
            	<img style="display: inline-block;"  src="../../images/main_slider02.png"> 
            </div>
            <div style="text-align: center; background: rgb(184, 207, 213);"> 
            	<img style="display: inline-block;"  src="../../images/main_slider03.png"> 
            </div>
            <div style="text-align: center; background: rgb(250, 218, 207);"> 
            	<img style="display: inline-block;"  src="../../images/main_slider04.png"> 
            </div>
            <div style="text-align: center; background: rgb(228, 230, 229);"> 
            	<img style="display: inline-block;"  src="../../images/main_slider05.png"> 
            </div>
   		</div>
    </div>

<div id="container">
	<h2> 스낵킹 최고 인기상품 </h2>
	<table>
		<tr>
			<% int cnt = 1;
			for(ProductDTO list1 : mPList1){ %>
			<td width="25%"> 
				<img src="/images_yhmall/<%=list1.getProduct_image()%>" width="200px" height="200px"/> <br>
				<p><%=list1.getProduct_name()%></p>
				<% if(list1.getProduct_price() == list1.getProduct_sale_price()){%>
					<span class="sale_price" style="color:black;">\<%=list1.getProduct_sale_price()%></span>
				<%}else{%>
					<span class="price" style="color:#aaa;">\<%=list1.getProduct_price()%></span>
					<span class="sale_price">\<%=list1.getProduct_sale_price()%></span>
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
	
	<h2> 스낵킹  최고 할인상품</h2>
	<table>
		<tr>
			<% cnt = 1;
			for(ProductDTO list2 : mPList2){ %>
			<td width="25%"> 
				<img src="/images_yhmall/<%=list2.getProduct_image()%>" width="200px" height="200px"/> <br>
				<p><%=list2.getProduct_name()%></p>
				<% if(list2.getProduct_price() == list2.getProduct_sale_price()){%>
					<span class="sale_price" style="color:black;">\<%=list2.getProduct_sale_price()%></span>
				<%}else{%>
					<span class="price" style="color:#aaa;">\<%=list2.getProduct_price()%></span>
					<span class="sale_price">\<%=list2.getProduct_sale_price()%></span>
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