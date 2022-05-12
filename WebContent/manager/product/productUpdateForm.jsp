<%@page import="manager.product.ProductDTO"%>
<%@page import="manager.product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#container{width:1000px; margin:0 auto;}
	@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Nanum+Gothic:wght@700&display=swap');
 	a {text-decoration : none; color:black}
	.m_title {font-family: 'Bebas Neue', cursive; text-align: center; font-size: 5em;}
	.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:1.5em; text-align: center;}
	h2{text-align:center;}
	
	/* top_menu */ 
	.top_menu {width:100%; height: 60px; border-collapse: collapse;}
	.top_menu th {background:#eee;}
	.top_menu th:hover {background:#555;}
	.top_menu th a:hover {color:white}
	.top_menu th a {display: block; height: 100%; text-decoration: none; color:black; line-height: 60px;font-size: 1.2em}
	.top_menu th:nth-child(2) {background:#555;}
	.top_menu th:nth-child(2) a {color:white}
	
	/* 중단 테이블 */
	.form_box{margin:0 auto; padding:50px 100px;}
	.register_table{border-collapse: collapse; width:100%; border-top: 2px solid black; border-bottom: 2px solid black}
	.register_table tr{height:50px; }
	.register_table th{background:#F8F8F8}
	.register_table td{ padding:10px 20px 10px 20px;}
	.register_table th, .register_table td{border-bottom :1px solid #aaa; padding-top: 10px; padding-bottom: 10px}
	#product_name{width:450px; height: 16px; padding:3px}
	.short_input {width:225px; height: 16px; padding:3px}
	.register_table input:focus{ outline: none;}
	.register_table #discount_rate{width:100px}
	.register_table textarea{width:448px; padding:5px}
	.register_table textarea:focus{outline: none;}
	input::file-selector-button{height:25px;border:none; background:black;color:white; cursor: pointer;}
	.form_btns{text-align: center; margin-top: 20px; }
	.form_btns input{width:100px; height:40px; border:none; background:black; font-size: 1em; font-weight: bold; color:white; cursor: pointer;}
	.form_btns input:hover {background:black; color:white;}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	System.out.println(product_id);
	ProductDAO productDAO = ProductDAO.getInstance();
	ProductDTO product = productDAO.getProduct(product_id);
	

%>
<div id="container">
	<div class="m_title"><a href="#">MALL</a></div>
	<h2>쇼핑몰 관리자 페이지</h2>
	
	<table class="top_menu">
		<tr>
			<th><a href="productManagement.jsp">상품 관리</a></th>
			<th><a href="productRegisterForm.jsp">상품 등록</a></th>
			<th><a href="@">주문 관리</a></th>
			<th><a href="@">회원 관리</a></th>
			<th><a href="../logon/managerLogout.jsp">로그아웃</a></th>
		</tr>
	</table>
	<div class="form_box">
		<form action="productRegisterPro.jsp" method="post" name='registerForm' enctype="multipart/form-data">
			<table class="register_table">
				<tr> 
					<th width="30%">상품 분류 </th>
					<td> 
						<select name="product_kind">
							<option value="101">파이류</option>
							<option value="102">비스킷류</option>
							<option value="103">스낵류</option>
							<option value="201">껌</option>
							<option value="202">초콜릿</option>
							<option value="203">사탕</option>
							<option value="301">봉지라면</option>
							<option value="302">컵라면</option>
							<option value="401">탄산음료</option>
							<option value="402">이온음료</option>
							<option value="403">주스</option>
							<option value="501">세트상품</option>
							<option value="601">수입상품</option>
						</select>
					</td>
				</tr> 
				<tr>
					<th>상품명</th>
					<td><input type="text" name="product_name" id="product_name" value="<%=product.getProduct_name() %>" ></td>
				</tr>
				<tr>
					<th>소비자가격</th>
					<td><input type="number" class="short_input" name="product_price" value="<%=product.getProduct_price() %>"></td>
				</tr> 
				<tr>
					<th>판매가격</th>
					<td><input type="number" class="short_input" name="product_sale_price" id="product_sale_price" value="<%=product.getProduct_sale_price() %>"></td>
				</tr>
				<tr>
					<th>상품수량</th>
					<td><input type="number" class="short_input" name="product_qty" value="<%=product.getProduct_qty() %>" ></td>
				</tr> 
				<tr>
					<th>제조사</th>
					<td><input type="text" class="short_input" name="product_brand" value="<%=product.getProduct_brand() %>"></td>
				</tr>
				<tr>
					<th>판매만료 날짜</th>
					<td><input type="date" name="product_expiry_date" id="product_expiry_date" onChange="onDateChange(event)"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="60" name="product_content"><%=product.getProduct_content()%></textarea></td>
				</tr>
				<tr>
					<th>이미지</th>
					<td><input type="file" name="product_image" ></td>
				</tr>
			</table>
			<div class="form_btns">
				<input type="button" value="수정" id="btn_update">
				<input type="reset"  value="초기화">
			</div>
		</form>
	</div>
</div>
</body>
</html>