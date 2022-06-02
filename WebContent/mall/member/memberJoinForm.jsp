<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<style>
	#container {width:700px; margin:60px auto;}
 	a {text-decoration : none; color:black}
	.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:2em; text-align: center; margin-bottom: 30px}
	table{width:100%; border-top:2px solid black; border-bottom: 2px solid black; }
	th, td{ border-bottom: 1px solid lightgray;}
	td{width:550px}
	tr {height:50px;}
	input[type=text], input[type=password]{background:#eee; border:none; height:25px; width:200px}
	input[type=text]:focus, input[type=password]:focus {background:white;}
	#addrNum{width: 100px}
	#btn_address, #btn_chk_id{ height:25px; width:80px; background: #e9967a; color:white; font-weight:bold; 
				border:none; border-radius: 5px; cursor:pointer;}
	.addr_row{height:100px}
	.addr_row #addr2 { margin-top: 10px}
	.btns{text-align:center; margin:30px 0 0 10px;}
	.btns input[type=button]{width:120px; height:40px}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
let isChk = false;
document.addEventListener("DOMContentLoaded", function(){
    let form = document.joinForm;
    let id = form.id;
    let pwd = form.pwd;
    let pwd2 = form.pwd2;
    let name = form.name;
    let email = form.email;
    let tel = form.tel;
    let addrNum = form.addrNum;
    let addr1 = form.addr1;
    let addr2 = form.addr2;

  
    
    //id의 유무
    let chk_id = document.getElementById("chk_id");
    id.addEventListener("keyup", function (){
    	if(id.value.length < 4){
    		chk_id.innerText = "아이디는 4글자 이상 입력하세요";
    	} else {
    		chk_id.innerText = "";
    	}
    });
    
    //id의 중복체크
    let btn_chk_id = document.getElementById("btn_chk_id");
    btn_chk_id.addEventListener("click", function (){
		if(id.value.length < 4) { //아이디를 4글자 미만으로 입력했을때
    		alert("아이디를 4글자 이상 입력해 주세요");
			id.focus();
    	}else {//아이디를 4글자 이상으로 입력했을때
    		//location = 'memberIdCheck.jsp?id=' + id.value;
    		window.open('memberIdCheck.jsp?id=' + id.value,"","width=500, height=300");
    		isChk = true;
    	}
    });
    
  	//비밀번호의 유효성검사
    let chk_pwd = document.getElementById("chk_pwd");
    pwd.addEventListener("keyup", function (){
    	if(pwd.value.length < 4){
    		chk_pwd.style.color = "red";
    		chk_pwd.innerText = "비밀번호가 짧습니다.";
    	}else {
    		chk_pwd.style.color = "green";
    		chk_pwd.innerText = "사용가능한 비밀번호입니다.";
    	}
    });
	
  	//비밀번호확인 검사
    let chk_pwd2 = document.getElementById("chk_pwd2");
    pwd2.addEventListener("keyup", function (){
    	if(pwd.value == pwd2.value){
    		chk_pwd2.innerText = "";
    	}else {
    		chk_pwd2.style.color = "red";
    		chk_pwd2.innerText = "비밀번호와 다릅니다.";
    	}
    });
    
    //이메일 주소의 유효성검사
    let chk_email = document.getElementById("chk_email");
    email.addEventListener("keyup", function (){
    	let isEmail = (value) =>{
            return (value.indexOf("@") > 1) && (value.split("@")[1].indexOf(".") > 1);
        }
            
        if(isEmail(email.value)){ // 이메일 형식일 
      		chk_pwd.style.color = "green";
        	chk_email.innerText = "이메일 형식입니다."
     	 } else {// 이메일 형식이 아닐 때
    		chk_pwd.style.color = "red";
    		chk_email.innerText = "이메일 형식이 아닙니다."
       	}
    });
    
  	//주소입력칸을 클릭하면
    document.getElementById("btn_address").addEventListener("click", function (){
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
            	addrNum.value = data.zonecode; // 주소 넣기
                addr1.value = data.address; // 주소 넣기
                document.querySelector("input[name=addr2]").focus(); //상세입력 포커싱
            }
        }).open();
    });
  	
  	
  	//회원가입 페이지의 페이지 이동제어
  	let btn_insert = document.getElementById("btn_insert");
  	btn_insert.addEventListener("click", function (){
		if(id.value.length == 0){
			alert('아이디를 입력하시오');
			id.focus();
			return;
		}
		if(isChk == false){
			alert('아이디 중복확인을 하세요');
			id.focus();
			return;
		}
		if(pwd.value.length == 0){
			alert('비밀번호를 입력하시오');
			pwd.focus();
			return;
		}
		if(pwd2.value.length == 0){
			alert('비밀번호 확인을 입력하시오');
			pwd2.focus();
			return;
		}
		if(pwd2.value != pwd.value){
			alert('비밀번호확인을 제대로 입력하시오');
			return;
		}
		if(name.value.length == 0){
			alert('이름을 입력하시오');
			name.focus();
			return;
		}
		if(email.value.length == 0){
			alert('이메일을 입력하시오');
			email.focus();
			return;
		}
		if(tel.value.length == 0){
			alert('연락처를 입력하시오');
			tel.focus();
			return;
		}
		if(addr1.value.length == 0){
			alert('주소를 입력하시오');
			addr1.focus();
			return;
		}
		form.submit();
  	});

  	
  	
});

</script>
</head>
<body>
<div id="container">
	<div class="s_title">회원가입</div>
	<form action="memberJoinPro.jsp" method="post" name="joinForm">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" id="id">
					<input type="button" value="중복 확인" id="btn_chk_id" class="btn_chk">
					<span id="chk_id">아이디를 입력하세요 </span>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pwd" id="pwd" maxlength='16'>
					<span id="chk_pwd"></span>
				</td>
			</tr>
			<tr>
				<th>비밀번호확인</th>
				<td>
					<input type="password" name="pwd2" id="pwd2" maxlength='16'>
					<span id="chk_pwd2"></span>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="name" maxlength='8'> </td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="text" name="email" id="email" maxlength='30'>
					<span id="chk_email"> </span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel" id="tel" maxlength='11'> </td>
			</tr>
			<tr class="addr_row">
				<th>주소</th>
				<td>
					<input type="text" name="addrNum" id="addrNum" >
					<input type="button" value="주소찾기" id="btn_address"><br>
					<input type="text" name="addr1" id="addr1">
					<input type="text" name="addr2" id="addr2">
				</td>
			</tr>
		</table>
		<div class="btns">
			<input type="button" value="회원가입" id="btn_insert">
			<input type="button" value="취소" id="btn_cancel">
		</div>
	</form>
</div>
</body>
</html>