
<%@page import="mall.member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberIdCheck</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	%>
	<jsp:useBean id="member" class="mall.member.MemberDTO"/>
	<jsp:setProperty property="*" name="member"/>
	<%
	String id = request.getParameter("id");
	MemberDAO memberDAO = MemberDAO.getInstance();
	int chk = memberDAO.idCheck(id);
	out.print("<script>");
	if(chk == 0){//rs의 next값이있다 = 중복된 계정이 있다. (사용할 수 없음)
		out.print("alert(`사용중인 아이디 입니다.\n 다른 아이디를 입력해 주세요`);");
	}else if (chk == 1){// 중복된 계정 없음 ()사용할 수 있다.
		out.print("alert('사용가능한 아이디입니다.');");
	}else {
		out.print("alert('오류가 발생 하였습니다.');");
	}
	out.print("window.close(); </script>");
	%>
</body>
</html>