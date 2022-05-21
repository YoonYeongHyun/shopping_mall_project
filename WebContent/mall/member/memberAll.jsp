<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{margin: 0 auto;}
a {text-decoration: none; color:black;}
ul{list-style-type: none;}
li{float: left;}
</style>
</head>
<body>
<% 
String id= "yyh";
String code = request.getParameter("code");
if(code==null) code="1";
String category = request.getParameter("category");
if (category == null) category = "0";
String search = request.getParameter("search");
if (search == null) search = "0";
String subject = request.getParameter("subject");
if (subject == null) subject = "1";


String product_id = request.getParameter("product_id");
%>
<jsp:include page="../common/header.jsp">
	<jsp:param name="id" value="<%=id%>"/>
</jsp:include>


<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>