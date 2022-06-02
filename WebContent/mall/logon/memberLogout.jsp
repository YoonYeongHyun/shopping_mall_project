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
	/*
	< 세션 삭제 방법 2가지 >
	1. session.invalidate(); 모든 세션 무효화
	2. session.removeAttribute(세션이름); 세션이름에 해당하는 세션만 삭제 
	*/
	
	session.removeAttribute("memberId");
	%>
	<script>
	alert("로그아웃 되었습니다.");
	window.close();
	</script>
</body>
</html>