<%@page import="util.JDBCUtil"%>
<%@page import="mall.member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberDeletePro</title>
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
	int cnt = memberDAO.deleteMember(member);
	out.print("<script>");
	if(cnt > 0){ //
		session.removeAttribute("memberId");
		out.print("alert(`탈퇴가 완료되었습니다.`);");
	}else {
		out.print("alert('정보를 확인하세요.');");
	}
	out.print("window.close(); </script>");
	%>

</body>
</html>