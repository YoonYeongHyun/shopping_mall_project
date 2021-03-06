<%@page import="java.util.List"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	#container{width:1000px; margin:0 auto;}
	@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Nanum+Gothic:wght@700&display=swap');
 	a {text-decoration : none; color:black}
	.m_title {font-family: 'Bebas Neue', cursive; text-align: center; font-size: 5em;}
	.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:1.5em; text-align: center;}
	h2{text-align:center;}
	.top_menu th:nth-child(1) {background:#555;}
	.top_menu th:nth-child(1) a {color:white}
	
	/* 상단 메뉴 */ 
	.top_menu {width:100%; height: 60px; border-collapse: collapse;}
	.top_menu th {background:#eee;}
	.top_menu th:hover {background:#555;}
	.top_menu th a:hover {color:white}
	.top_menu th a {display: block; height: 100%; text-decoration: none; color:black; line-height: 60px;font-size: 1.2em}
	/* 상품 목록*/
	.list_table{width:100%; border-collapse:collapse; border-bottom: 2px solid black; border-top: 2px solid black; margin-top: 20px;}
	tr{height: 50px}
	th{background:#aaa;}
	
	td{border:1px solid #eee;}
	.list_table td:nth-child(1){text-align: center}
	.list_table td:nth-child(2){text-align: center}
	.list_table td:nth-child(4){text-align: center}
	.list_table td:nth-child(5){text-align: center}
	.list_table td:nth-child(6){text-align: center}
	.list_table td:nth-child(7){text-align: center}
	list_button{text-align: center}
	#update_btn{width:50px; height:30px; background:#86E57F; color:white; border: none; border-radius:20%; font-weight: bold; cursor: pointer;}
	#delete_btn{width:50px; height:30px; background:#aaa;    color:white; border: none; border-radius:20%; font-weight: bold; cursor: pointer;}
	
	#paging{text-align: center; margin-top: 20px}
	#p_box{display: inline-block; width:25px; height:25px; border-radius: 10px; padding:5px; margin:5px }
	#p_box:hover{background: black; color:white;}
	.p_box_c{background: black; color:white; }
	.p_box_b{font-weight: bold}
</style>

<%
request.setCharacterEncoding("UTF-8");

String managerId = (String) session.getAttribute("managerId");
if (managerId == null) { //세션이 null인 경우
	%><script>alert('로그인 하세요'); location='../logon/managerLoginForm.jsp';</script><%
}

String category = request.getParameter("category");
if (category == null) category = "0";

String search = request.getParameter("search");
if (search == null) search = "0";

String pageNum = request.getParameter("pageNum");
if (pageNum == null) pageNum = "1";
ProductDAO productDAO = ProductDAO.getInstance();
int cnt = productDAO.getProductCount(category, search);

int currentPage = Integer.parseInt(pageNum);    //현재페이지
int pageSize = 10;
int startRow = (currentPage -1) * pageSize + 1; //현재페이지의 첫행
int endRow = currentPage * pageSize;            //현재페이지의 마지막행
// 게시판 전체 정보를 currentPage의  pageSize만큼 획득 
List<ProductDTO> productList = productDAO.getProductsCategoryList(category, search, startRow, pageSize);
%>
<script>
	document.addEventListener("DOMContentLoaded", function(){
		
		document.getElementById('search_btn').addEventListener("click", function(){
			let s_select = document.getElementById('s_select');
			let s_input = document.getElementById('s_input');
			let search = s_select.value + s_input.value; //검색분류와 검색값을 같이 보냄
			location="productManagement.jsp?category=" + <%=category%> + "&search=" + search;
		});
		
		//리스트 수정 및 삭제 버튼 구현
		let update_btns = document.getElementsByName("update_btn");
		let delete_btns = document.getElementsByName("delete_btn");
		
		delete_btns.forEach(element => element.addEventListener("click", function(e){
			if(confirm("정말 삭제하시겠습니까?")){
				let l_num = e.target.previousSibling.previousSibling.previousSibling.previousSibling.value;
				window.open('productDeletePro.jsp?product_id='+l_num, "", "width = 500, height = 200 left = 740");
				setTimeout(function(){
					location.reload();
				},500);
			}
		}));

		update_btns.forEach(element => element.addEventListener("click", function(e){
			let l_num = e.target.previousSibling.previousSibling.value;
		/location="productUpdateForm.jsp?product_id="+ l_num + "&pageNum=<%=pageNum%>&category=<%=category%>&search=<%=search%>";
			function reloadDivArea() {
			    $('#list_table').load(location.href+' #list_table');
			}
		}));
		
		
	});

	function main_category(){
		let main_category = document.getElementById("main_category")
		if(main_category != "0") location="productManagement.jsp?category="+main_category.value; 
	}
	 
</script>
</head>
<body>
	<div id="container">
		<div class="m_title"><a href="#">MALL</a></div>
		<h2>쇼핑몰 관리자 페이지</h2>
		
		<table class="top_menu">
			<tr>
				<th><a href="productManagement.jsp">상품 관리</a></th>
				<th><a href="productRegisterForm.jsp">상품 등록</a></th>
				<th><a href="@">주문 관리</a></th>
				<th><a href="@">회원 관리</a></th>
				<th><a href="../logon/managerLogout.jsp">로그아웃</a></th>
			</tr>
		</table>
		
		<div>
			<span>상품 종류</span>
			<select id=main_category onchange="main_category()">
				<option value="0">대분류</option>
				<option value="1">과자</option>
				<option value="2">껌/초콜릿/사탕</option>
				<option value="3">라면</option>
				<option value="4">음료</option>
				<option value="5">세트상품</option>
				<option value="6">수입상품</option>
			</select>
		</div>
		
		<div class="top_search">
			<input type="hidden" name="search" value="0">
			<span class="c_1">
				<select id="s_select">
					<option value = "1" selected>제품명</option>
					<option value = "2">제조사</option>
				</select>
			</span>
			<span class="c_2"><input type="text" id="s_input"> </span>
			<span class="c_3"> <input type="button" value="검색" id="search_btn"> </span>
		</div>
		<p><%=cnt %> </p>
		<div id="list_table">
		<table class="list_table" >
			<tr>
				<th width="10%">상품코드</th>
				<th width="5%"></th>
				<th width="30%">상품명</th>
				<th width="10%">제조사</th>
				<th width="10%">판매가격</th>
				<th width="10%">재고</th>
				<th width="10%">판매량</th>
				<th width="15%">기능</th>
			</tr>
			<%if(cnt == 0){ %>
				<tr><td colspan="8"> 등록된 상품이 없습니다. <%=cnt %> </td></tr>
			<%}else if(cnt != 0){
				for(ProductDTO pList: productList){%>
					<tr>
						<td id="1con"><%=pList.getProduct_id() %></td>
						<td>
							<img src="/images_yhmall/<%=pList.getProduct_image()%>" width="30px" height="30px"/>
						</td>
						<td><%=pList.getProduct_name()%></td>
						<td><%=pList.getProduct_brand()%></td>
						<td><%=pList.getProduct_sale_price()%></td>
						<td><%=pList.getProduct_qty()%> </td>
						<td><%=pList.getProduct_sales()%></td>
						<td>
							<form action="" class="list_button">
								<input type="hidden" name="l_id" id="l_id" value="<%=pList.getProduct_id()%>">
								<input type="button" value="수정" name="update_btn" id="update_btn">
								<input type="button" value="삭제" name="delete_btn" id="delete_btn">
							</form> 
						</td>
					</tr>
				<%}	
			}%>
		</table>
		</div>
		<div id="paging">
		<%
		if(cnt > 0){
			int pageCount =(cnt/pageSize) + (cnt%pageSize==0 ? 0 : 1);	
			int pageBlock = 10;
			
			//시작페이지 설정
			int startPage = 1;
			if(currentPage % 10 != 0) startPage = (currentPage/10) * 10 +1;
			else startPage = (currentPage/10 -1) * 10 +1;
			
			//끝페이지 설정
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			//이전&첫 페이지
			if(startPage > 10){%>
				<a href='productManagement.jsp?pageNum=<%=1 %>&category=<%=category%>&search=<%=search%>'>
					<div id='p_box' class='p_box_b' title='첫 페이지'>≪</div>
				</a>
				<a href='productManagement.jsp?pageNum=<%=startPage-10 %>&category=<%=category%>&search=<%=search%>'>
					<div id='p_box' class='p_box_b'title='이전 페이지'>＜</div>
				</a>
			<%}
			//페이징블럭처리
			for (int i=startPage; i<=endPage; i++){
				if(currentPage == i){
					%><div id='p_box' class='p_box_c'><%=i %></div><%
				} else{
					%><a href='productManagement.jsp?pageNum=<%=i%>&category=<%=category%>&search=<%=search%>'>
						<div id='p_box'> <%=i %> </div>
					</a><% 
				}
			}

			//다음&마지막 페이지
			if(endPage <= pageCount - (pageCount % pageSize)){%>
				<a href='productManagement.jsp?pageNum=<%=startPage+10%>&category=<%=category%>&search=<%=search%>'>
					<div id='p_box' class='p_box_b' title='다음 페이지'>＞</div>
				</a>
				<a href='productManagement.jsp?pageNum=<%=pageCount%>&category=<%=category%>&search=<%=search%>'>
					<div id='p_box' class='p_box_b' title='끝 페이지'>≫</div>
				</a>
			<%}
			//
		}
		%>
		</div>
	</div>
	
	
</body>
</html>