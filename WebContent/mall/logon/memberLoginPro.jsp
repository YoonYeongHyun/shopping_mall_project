<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="mall.member.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	MemberDAO memberDAO = MemberDAO.getInstance();
	int cnt = memberDAO.login(id, pwd);	%>
	<script>
	<% if(cnt == 1){
		session.setAttribute("memberId", id);   

		out.print("location='../shopping/shoppingAll.jsp';");%>
	<%}else if (cnt == 0){%>
		alert('비밀번호가 틀립니다.');
		history.back();
	<%}else if (cnt == 2){%>
		alert('존재하지않는 회원입니다.');
		history.back();
	<%}else if (cnt == -1){%>
		alert('오류가 발생하였습니다.');
		history.back();
	<%}%>
	</script>
	
</body>
</html>