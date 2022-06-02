<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login form</title>


<style>
	#container {width:500px; margin:100px auto;}
 	a {text-decoration : none; color:black}
	.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:1.2em; text-align: center;}
	.f_input {text-align: center; border: 1px solid #ccc; padding: 20px;}
	.f_input .c_id, .f_input .c_pwd { height:45px; margin-top: 20px; padding-left: 5px }
	.f_input .f_chk{ text-align: left; margin: 20px 0 0 30px; color:#777;}
	#btn_login{width:388px; height:50px; margin-top:20px; background:black; border: none;
		color:white; font-size:2em; font-weight: bold; font-family: 'Do Hyeon', sans-serif; cursor: pointer;}
	.f_a{text-align: center; margin-top: 20px;}
	.f_a a{ color:#777;}
	
</style>
<script>
	document.addEventListener("DOMContentLoaded", function(){
	    let form = document.LoginForm;
	    let btn_login = document.getElementById("btn_login");
	    
	    btn_login.addEventListener("click", function(){
	    
	   		if(!form.id.value){
	    		alert('아이디를 입력하시오!');
	    		form.id.focus();
	    		return;
	   		}
	   		if(!form.pwd.value){
	    		alert('비밀번호를 입력하시오!');
	    		form.pwd.focus();
	    		return;
	    	}

	    	//http 속성: 연결상태를 유지하지않음
	    	// cookie, session: 연결상태를 유지함
	    	// cookie: 연결정보를 클라이언트쪽에 저장
	    	// session: 연결정보를 서버에 저장
			// escape() 함수: *,-, _, +, ., / 를 제외한 모든문자를 16진수로 변환하는 함수  	    
			// 쉼표, 세미콜론 등과 같은 문자가 쿠키에서 사용되는 문자열과 충돌을 방지하기 위해 사용

	    	let chk = document.getElementById("chk");	    	
			let now = new Date();
    		let name = "cookieId";
    		let value = form.id.value;
	    	if(chk.checked){// 체크박스가 체크되었을 때 -> 쿠키 생성, 쿠키 만료시간 설정
	    		now.setDate(now.getDate()+14); //만료시간을 지금으로부터 7일뒤로 설정
	    		
	    	}else {                      // 체크박스가 체크되지 않았을 때 -> 쿠키 삭제 
    			now.setDate(now.getDate()+0);
    		}
	    	document.cookie = name + "=" + escape(value) + ";path=/;expires=" + now.toGMTString() + ";";
	    	form.submit();
	    });

		
		if(document.cookie.length > 0){// 쿠기가 존재할 경우
			var cookieData = document.cookie;
			var search = "cookieId="; //쿠키아이디값을 찾음
			var idx = cookieData.indexOf(search); //인덱스를 못찾을경우 -1출력 
			if(idx != -1){ //인덱스를 찾은경우
				idx += search.length;
				var end = cookieData.indexOf(';', idx);
				
				if(end == -1){
					end = document.cookie.length;
				}
				form.id.value = document.cookie.substring(idx, end);
				form.chk.checked = true;	
			}
		}
	});
</script>
</head>
<body>
	
<div id="container" >
	<form action="../logon/memberLoginPro.jsp" method="post" name = "LoginForm">
		<div class="f_input">
			<div class="f_id"><input type="text" id="id" name="id" class="c_id" placeholder="아이디" size="50"></div>
			<div class="f_pwd"><input type="password" id="pwd" name="pwd" class="c_pwd" placeholder="비밀번호" size="50"> </div>
			<div class="f_chk"> 
				<input type="checkbox" id="chk" class="c_chk">
				<label for="chk"> 아이디 기억 </label> 
			</div>
			<div class="f_submit"> <input type="button" value="로그인" id="btn_login" >
			</div>
		</div>
		<div class="f_a">
			<a href="#">비밀번호 찾기</a>&emsp;|&emsp;
			<a href="#">아이디 찾기</a>&emsp;|&emsp;
			<a href="../member/memberJoinForm.jsp">회원가입</a> 
		</div>
	</form>
</div>
	
	
</body>
</html>