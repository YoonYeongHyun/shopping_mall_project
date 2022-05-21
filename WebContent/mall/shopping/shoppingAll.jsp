<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{margin: 0 auto; }
a {text-decoration: none; color:black;}
ul{list-style-type: none;}
li{float: left;}
</style>
</head>
<body>
<% 
request.setCharacterEncoding("UTF-8");
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

<%if(code.equals("1")){%>
<jsp:include page="shopMain.jsp"></jsp:include>
<br>
<%}else if(code.equals("2")){%>
<jsp:include page="shopCategoryList.jsp">
<jsp:param name="category" value="<%=category%>"/>
<jsp:param name="search" value="<%=search%>"/>
</jsp:include>
<br>
<%}else if(code.equals("3")){ %>
<jsp:include page="shopSpecialList.jsp">
<jsp:param name="category" value="<%=category%>"/>
<jsp:param name="search" value="<%=search%>"/>
<jsp:param name="product_id" value="<%=product_id%>"/>
<jsp:param name="subject" value="<%=subject%>"/>
</jsp:include>
<br>
<%}else if(code.equals("4")){%>
<jsp:include page="shopContent.jsp">
<jsp:param name="category" value="<%=category%>"/>
<jsp:param name="search" value="<%=search%>"/>
<jsp:param name="product_id" value="<%=product_id%>"/>
</jsp:include>
<br>
<%}%>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>