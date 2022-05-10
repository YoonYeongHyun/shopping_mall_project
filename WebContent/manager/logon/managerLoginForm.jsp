<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
<style>
/* 상단 메뉴 */
	@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Nanum+Gothic:wght@700&display=swap');
	#container {width:700px; margin:0 auto;}
 	a {text-decoration : none; color:black}
	.m_title {font-family: 'Bebas Neue', cursive; text-align: center; font-size: 5em;}
	.m_title a{color:#DC8538}
	.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:1.5em; text-align: center;}
/*  로그인 상자 */
	#login_box{text-align: center;}
	.b_box{border:1px solid black; width:50%; height:40px; display:inline-block; margin-top:20px; padding:5px ; text-align: left}
	input[type=text], input[type=password]{border:none; width:300px; height:38px; margin-left:10px; font-size: 20px}
	input:focus{outline: none}
	
	
</style>
<script>




</script>
</head>
<body>
<div id=container>
	<div class="m_title"><a href="#">MALL</a></div>
	<div class="s_title">관리자 로그인</div>
	
	<div id="login_box">
	<form action="managerLoginPro.jsp" method="post" name="managerLoginForm">
		<div class="a_box">
			<div class="b_box">
				<img src="../../icons/login_id.png"><input type="text" name="managerId" id="managerId" placeholder="아이디">
			</div>
			<div class="b_box">
				<img src="../../icons/login_pwd.png"><input type="password" name="managerPwd" id="managerPwd"  placeholder="비밀번호">
			</div>
			<div class="c_box">
				<input type="button" value="로그인" id="btn_login">
			</div>
		</div>
	</form>
	</div>
</div>
</body>
</html>