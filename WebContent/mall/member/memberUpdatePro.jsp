<%@page import="mall.member.*"%>
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
	%>
	<jsp:useBean id="member" class="mall.member.MemberDTO"/>
	<jsp:setProperty property="*" name="member"/>
	<%
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.updateMember(member);
	
	%>
	<script>
	<%if(cnt > 0 ){ %>
		alert("성공하였습니다");
	<%} else{%>
		alert("실패하였습니다");
		history.back();
	<%}%>

	
	</script>
</body>
</html>