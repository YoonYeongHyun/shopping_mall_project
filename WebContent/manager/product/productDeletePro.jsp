<%@page import="manager.product.ProductDAO"%>
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
	request.setCharacterEncoding("utf-8");
	int product_id = Integer.parseInt(request.getParameter("product_id"));
	
	ProductDAO productDAO = ProductDAO.getInstance();
	int cnt = productDAO.deleteProduct(product_id);
	
	%><script>
		alert("삭제되었습니다.");
		window.close();
	</script><% 
	
%>
</body>
</html>