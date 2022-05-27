<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap');

body{margin: 0 auto; font-family: 'Gothic A1', sans-serif;}
a {text-decoration: none; color:black;}
ul{list-style-type: none;}
li{float: left;}
</style>
</head>

<% 
request.setCharacterEncoding("UTF-8");
//페이지 관련 파라미터
String code = request.getParameter("code");
if(code==null) code="1";
String category = request.getParameter("category");
if (category == null) category = "0";
String search = request.getParameter("search");
if (search == null) search = "0";
String subject = request.getParameter("subject");
if (subject == null) subject = "1";

//쇼핑몰 기능관련 파라미터
String product_id = request.getParameter("product_id");
String purchase_amount = request.getParameter("purchase_amount");


String memberId = memberId = (String) session.getAttribute("memberId");
if (memberId == null) { //세션이 null인 경우
memberId = "";



}
%>
<body>
	<jsp:include page="../common/header.jsp">
		<jsp:param name="memberId" value="<%=memberId%>"/>
	</jsp:include>

	<jsp:include page="../common/sideBar.jsp">
		<jsp:param name="memberId" value="<%=memberId%>"/>
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
	<jsp:param name="code" value="<%=code%>"/>
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
	<%}else if(code.equals("5")){%>
	<jsp:include page="shopOrder.jsp">
	<jsp:param name="category" value="<%=category%>"/>
	<jsp:param name="search" value="<%=search%>"/>
	<jsp:param name="product_id" value="<%=product_id%>"/>
	</jsp:include>
	<br>
	<%}%>
	
	<jsp:include page="../common/footer.jsp"></jsp:include>
	
</body>
</html>