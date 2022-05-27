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
request.setCharacterEncoding("UTF-8");
String code = request.getParameter("code");
if(code==null) code="1";
String mcode = request.getParameter("mcode");
if(mcode==null) mcode="1";
String category = request.getParameter("category");
if (category == null) category = "0";
String search = request.getParameter("search");
if (search == null) search = "0";
String subject = request.getParameter("subject");
if (subject == null) subject = "1";
String product_id = request.getParameter("product_id");
String memberId = memberId = (String) session.getAttribute("memberId");
if (memberId == null) { //세션이 null인 경우
memberId = "";
}
%>
<jsp:include page="../common/header.jsp">
	<jsp:param name="memberId" value="<%=memberId%>"/>
</jsp:include>

<jsp:include page="../common/sideBar.jsp">
	<jsp:param name="memberId" value="<%=memberId%>"/>
</jsp:include>

<%if(mcode.equals("1")){%>
<jsp:include page="../logon/memberLoginForm.jsp"></jsp:include>
<br>
<%}else if(mcode.equals("2")){%>
<jsp:include page="memberJoinForm.jsp"></jsp:include>
<br>
<%}else if(mcode.equals("3")){%>
<jsp:include page="memberInfoForm.jsp">
	<jsp:param name="category" value="<%=category%>"/>
	<jsp:param name="search" value="<%=search%>"/>
</jsp:include>
<br>
<%}%>

<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>