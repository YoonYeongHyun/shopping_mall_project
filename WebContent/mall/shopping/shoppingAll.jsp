
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap');
a {text-decoration: none; color:black;}
body{margin: 0 auto;}
ul{list-style-type: none;}
li{float: left;}
</style>
</head>
<body>
<%
ProductDAO productDAO = ProductDAO.getInstance();


%>
 <jsp:include page="../common/header.jsp"></jsp:include>

 <jsp:include page="shopMain.jsp"></jsp:include>
 <br>
 <jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>