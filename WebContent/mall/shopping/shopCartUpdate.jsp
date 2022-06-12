<%@page import="cart.CartDTO"%>
<%@page import="cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=utf-8");

CartDAO cartDAO = CartDAO.getInstance();
String id = request.getParameter("id");
String code = request.getParameter("code");



if(code.equals("1")){
	int product_amount = Integer.parseInt(request.getParameter("product_amount"));
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	cartDAO.updateCart(id, product_id, product_amount);
}else if(code.equals("2")){
	String product_ids = request.getParameter("product_ids");
	String[] arr_product_ids = product_ids.split(",");
	for(String product_id_str : arr_product_ids){
		int product_id = Integer.parseInt(product_id_str);
		cartDAO.deleteCart(id, product_id);
	}
}

%>
</body>
</html>