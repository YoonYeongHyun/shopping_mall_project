<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<style>
@import url('https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap');

header{width:100%;}
#top_menu{width:1200px; margin:0 auto; height: 40px;}
#top_menu ul{display: inline-block; margin:0; padding:9.5px; float: right;}
#top_menu ul li{margin-left: 20px;}

#upper_header {width:100%; padding:30px 0; border-bottom: 1px solid #eee; margin:0 auto;}
.inner_contents{width:1200px; margin:0 auto; height: 90px}
#main_logo{width:340px;  height: 51px; padding: 19px 0; display: inline; float: left;}
#main_logo a{font-family: 'Black Han Sans', sans-serif; font-size: 50px; color:#eeaa00;}
#search_box{width:400px; height:48px; display: inline-block; border: 1px solid #FFBB00; ;
			border-radius: 30px; margin:20px 0 20px 100px; }
#search_input{float: left; font-size: 1.5em; margin:10px 10px 7px 20px; border:none;}
#search_input:focus{outline: none;}
#search_icon{float: right; height: 32px; cursor: pointer; margin:8px 20px 8px 0;}
#header_btns{display: inline-block; width:200px; height:50px; float:right; padding:20px 0 ;}
#header_btns ul{width:200px; height:40px; margin:0 0 ;padding:5px}
#header_btns li{float: left; margin:0 0 30px 30px;}

#lower_header{width: 100%; height: 60px; border-bottom: 1px solid #eee; margin:0; box-sizing: content-box; background: white; }
#lower_header nav{height: 60px; position: relative; z-index: 2;}
#lower_header ul{width:1200px; height: 60px; margin:auto; padding:0; display:inline-block; text-align: center;}
#lower_header li{height: 60px; padding:15px; margin:0 0 0 30px; display:inline-block; font-size: 1.2em; box-sizing: border-box;}
#lower_header li:hover{font-weight: bold; border-bottom: 3px solid #F29661;}
#hidden_box1{left:390px;}
#hidden_box2{left:538px;}
#hidden_box3{left:684px;}
#hidden_box4{left:780px;}
.hidden_menu{width:150px; height:80px; position: absolute; bottom:-92px; border: 1px solid #eee; margin: auto; 
			display: none; z-index: 1; background: white; padding:5px}
.hidden_btn{font-size: 0.8em; color:#666; display: block;}
.hidden_btn:hover{font-size: 1em; color:black; display: block;}
</style>
<% 
String id = request.getParameter("id");
String memberId = "";
%>
<script>
document.addEventListener("DOMContentLoaded", function(){
	let memberId = "<%=memberId%>";
	if(memberId == ""){
		let top_logout = document.getElementById("top_logout");
		top_logout.style.display="none"
	}
	
	let showing_btn = document.getElementsByName("showing_btn");
	showing_btn.forEach(element => element.addEventListener("mouseenter", function(e){
		let hidden_menu = e.target.lastChild.previousSibling;
		hidden_menu.style.display="inline-block"
	}));
	showing_btn.forEach(element => element.addEventListener("mouseleave", function(e){
		let hidden_menu = e.target.lastChild.previousSibling;
		hidden_menu.style.display="none"
	}));
	
	let search_icon = document.getElementById("search_icon");
	search_icon.addEventListener("click", function(){
	let search_input = document.getElementById("search_input").value;
	location="shoppingAll.jsp?code=2&search=1" + search_input;
	});
})

</script>
	<header>
		<div id="top_menu">
			<ul>
				<li id="top_login">로그인</li>
				<li id="top_join">회원가입</li>
				<li id="top_logout">로그아웃</li>
				<li>마이페이지</li>
				<li>고객센터</li>
			</ul>
		</div>
		<div id="upper_header">
			<div class="inner_contents">
				<div id="main_logo" ><a href="shoppingAll.jsp?code=1">Snack King</a></div>
				<div id="search_box">
					<input type="text" id="search_input" id placeholder="<% if(memberId != ""){out.print(memberId+'님');} %> 어서오세요!!">
					<span id="search_icon"><img src="../../icons/search_icon1.png" width="32px"></span>
				</div>
				<div id="header_btns">
					<ul>
						<li><a><img src="../../icons//main_heart.png"></a></li>
						<li><a><img src="../../icons//main_cart.png"></a></li>
						<li><a><img src="../../icons//main_login.png"></a></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="lower_header">
			<nav class="inner_contents" id="header_nav">
                <ul>
                    <li><a href="shoppingAll.jsp?code=3&subject=1">인기상품</a></li>
                    <li><a href="shoppingAll.jsp?code=3&subject=2">특가상품</a></li>
                    <li><a href="shoppingAll.jsp?category=5&code=2">세트상품</a></li>
                    <li name="showing_btn">
                    	<a href="shoppingAll.jsp?category=1&code=2">과자</a>
                    	<div class="hidden_menu" id="hidden_box1">
                    		<a href="shoppingAll.jsp?category=101&code=2" class="hidden_btn">파이류</a>
                    		<a href="shoppingAll.jsp?category=102&code=2" class="hidden_btn">비스킷류</a>
                    		<a href="shoppingAll.jsp?category=103&code=2" class="hidden_btn">스넥류</a>
                    	</div>
                    </li>
                    <li name="showing_btn">
                    	<a href="shoppingAll.jsp?category=2&code=2">껌/초콜릿/사탕</a>
                    	<div class="hidden_menu" id="hidden_box2">
                    		<a href="shoppingAll.jsp?category=201&code=2" class="hidden_btn">껌</a>
                    		<a href="shoppingAll.jsp?category=202&code=2" class="hidden_btn">초콜릿</a>
                    		<a href="shoppingAll.jsp?category=203&code=2" class="hidden_btn">사탕</a>
                    	</div>
                    </li>
                    <li name="showing_btn">
                    	<a href="shoppingAll.jsp?category=3&code=2">라면</a>
                    	<div class="hidden_menu" id="hidden_box3">
                    		<a href="shoppingAll.jsp?category=301&code=2" class="hidden_btn">봉지라면</a>
                    		<a href="shoppingAll.jsp?category=302&code=2" class="hidden_btn">컵라면</a>
                    	</div>
                    </li>
                    <li name="showing_btn">
                    	<a href="shoppingAll.jsp?category=4&code=2">음료</a>
                    	<div class="hidden_menu" id="hidden_box4">
                    		<a href="shoppingAll.jsp?category=401&code=2" class="hidden_btn">탄산음료</a>
                    		<a href="shoppingAll.jsp?category=402&code=2" class="hidden_btn">이온음료</a>
                    		<a href="shoppingAll.jsp?category=403&code=2" class="hidden_btn">주스</a>
                    	</div>
                    </li>
                    <li><a href="shoppingAll.jsp?category=6&code=2">수입과자</a> </li>
                </ul>
        	</nav>
		</div>
	</header>