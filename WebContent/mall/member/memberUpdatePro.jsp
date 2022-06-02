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
	<%if(cnt > 0 ){// 데이터 삽입 성공 %>
		alert("회원수정에 성공하였습니다");
	<%} else{// 데이터 삽입 실패%>
		alert("회원수정에 실패하였습니다");
	<%}%>

	history.back();
	</script>
</body>
</html>