
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.member.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	%>
	<jsp:useBean id="member" class="mall.member.MemberDTO"/>
	<jsp:setProperty property="*" name="member"/>
	<%
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.insertMember(member);
	%>
	<script>
	<%if(cnt > 0 ){// 데이터 삽입 성공 %>
		alert("회원가입에 성공하였습니다");
		location="memberAll.jsp?mcode=1"
	<%} else{// 데이터 삽입 실패%>
		alert("회원가입에 실패하였습니다");
		history.back();
	<%}%>
	</script>
</body>
</html>