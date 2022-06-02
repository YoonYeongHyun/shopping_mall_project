<%@page import="manager.product.ProductDAO"%>
<%@page import="manager.product.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
#container{width: 1000px; height: auto; overflow: hidden; margin: 0 auto; }
#product_info{display: inline-block; width: 100%; height: 200px}
#product_info img{float:left; margin:20px; border: 1px solid #eee;}
#product_info h2{float:left; width:700px; height:150px; margin:0 30px; line-height: 150px;}
form{clear:both;}
#re_form_table{width: 100%; border-collapse:collapse; border-bottom: 2px solid black; border-top: 2px solid black }
#re_form_table tr{border-bottom: 1px solid #777;}
#re_form_table th{background: #eee; height: 30px; font-size: 15px;padding: 15px;}
#re_form_table td{padding: 15px; width:840px}
#re_title{width: 400px; height:20px}
#re_content{width: 800px; height:300px}
#review_btns{ text-align: center; margin-top: 30px}
#review_btns button{width: 200px; height: 40px; display: inline-block;}

</style>
<html>
<%
request.setCharacterEncoding("UTF-8");

int product_id = Integer.parseInt(request.getParameter("product_id"));

ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);
%>

<div id="container">
	<div id="product_info">
		<img src="/images_yhmall/<%=product.getProduct_image() %>" width="150px">
		<h2><%=product.getProduct_name() %></h2>
	</div>
	<form action="shopReviewPro.jsp" method="post">
		<table id="re_form_table">
			<tr> 
				<th>작성자</th>
				<td>나나나난</td>
			</tr>
			<tr> 
				<th>평가</th>
				<td>
					<input type="radio" value="1" name="re_rate"> <span>★</span>
					<input type="radio" value="2" name="re_rate"> <span>★★</span>
					<input type="radio" value="3" name="re_rate"> <span>★★★</span>
					<input type="radio" value="4" name="re_rate"> <span>★★★★</span>
					<input type="radio" value="5" name="re_rate"> <span>★★★★★</span>
				</td>
			</tr>
			<tr> 
				<th>제목</th>
				<td><input type="text" name="re_title" id="re_title"></td>
			</tr>
			<tr> 
				<th>내용</th>
				<td>
					<textarea rows="" cols="" name="re_content" id="re_content"></textarea>
				</td>
			</tr>
		</table>	
		<div id="review_btns"> 
			<button id="cancel_btn" type="button">취소</button> 
			<button id="submit_btn" type="button">등록</button>
		</div>
	</form>
</div>
</html>