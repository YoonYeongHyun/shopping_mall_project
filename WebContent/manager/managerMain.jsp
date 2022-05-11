<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 관리자 페이지</title>
<style>
	#container{width:800px; margin:0 auto;}
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
</style>
<script>
	<%
	String managerId = (String) session.getAttribute("managerId");
	if (managerId == null) { //세션이 null인 경우
		%>alert('로그인 하세요'); location='logon/managerLoginForm.jsp';<%
	}
	%>
</script>
</head>
<body>
<div id="container">
	<h2>쇼핑몰 관리자 페이지</h2>
	<div class="m_title"><a href="#">MALL</a></div>
	<h2>쇼핑몰 관리자 페이지</h2>
	
	<table class="top_menu">
		<tr>
			<th><a href="product/productRegisterForm.jsp">상품 등록</a></th>
			<th><a href="@">상품 관리</a></th>
			<th><a href="@">주문 관리</a></th>
			<th><a href="@">회원 관리</a></th>
			<th><a href="logon/managerLogout.jsp">로그아웃</a></th>
		</tr>
	</table>
</div>
</body>
</html>