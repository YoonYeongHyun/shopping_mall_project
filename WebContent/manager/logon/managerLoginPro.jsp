<%@page import="manager.logon.*"%>
<%@page import="jdk.nashorn.internal.ir.RuntimeNode.Request"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인 처리</title>
<%
	request.setCharacterEncoding("utf-8");
	String managerId = request.getParameter("managerId");
	String managerPwd = request.getParameter("managerPwd");
	
	ManagerDAO managerDAO = ManagerDAO.getInstance();
	int chk = managerDAO.checkManager(managerId, managerPwd);
	if(chk == 1){
		session.setAttribute("managerId", managerId);
		%> <script>location="../managerMain.jsp" </script> <%
	} else{
		%> <script>alert("로그인에 실패하였습니다."); location="managerLoginForm.jsp" </script> <%	
	}
%>
</head>
<body>
</body>
</html>