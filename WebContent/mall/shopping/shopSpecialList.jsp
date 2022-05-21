<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="manager.product.*"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#container{width:1200px; margin:0 auto;}
	
table{width:1200px; border-collapse: collapse;}
tr {height: 300px; width:1200px;}
td {text-align: center;}
td p {margin:0 auto;}
td img{border: 1px solid #ccc;}

.product_img_box{position: relative; text-align: center; display:inline-block; width:202px}
.product__hidden_menu{position: absolute; top:120px; left:26.1px; visibility: hidden;}
.product__hidden_menu span{display:inline-block; width:50px; height:50px; background: white; border-radius: 100%;
							position: relative; border: 1px solid black; margin:0 10px; }
.product__hidden_menu span img{border:none; position: absolute; top:9px; left:9px;}

#product_info{display:inline-block; width:240px; height: 63px;}
.price{text-decoration: line-through;}
.sale_price{color: red}
		
#paging{text-align: center; margin-top: 20px}
#p_box{display: inline-block; width:25px; height:25px; border-radius: 10px; padding:5px; margin:5px }
#p_box:hover{background: black; color:white;}
.p_box_c{background: black; color:white; }
.p_box_b{font-weight: bold}
</style>

<%
request.setCharacterEncoding("UTF-8");

String memberId = (String) session.getAttribute("memberId");
String category = request.getParameter("category");
if (category == null) category = "0";
String search = request.getParameter("search");
if (search == null) search = "0";
String pageNum = request.getParameter("pageNum");
if (pageNum == null) pageNum = "1";
String subject = request.getParameter("subject");
if (subject == null) subject = "1";

ProductDAO productDAO = ProductDAO.getInstance();

int cnt = 0;
if(subject.equals("1")) { 
	cnt = 100;
}else if(subject.equals("2")){
	cnt = productDAO.getSpecialProductsCount();
}


int currentPage = Integer.parseInt(pageNum);//현재페이지
int pageSize = 20;
int startRow = (currentPage -1) * pageSize + 1; //현재페이지의 첫행
int endRow = currentPage * pageSize;        //현재페이지의 마지막행
// 게시판 전체 정보를 currentPage의  pageSize만큼 획득

List<ProductDTO> productList = null;
productList = productDAO.getSpecialProductsList(subject, startRow, pageSize);
%>
<script>

document.addEventListener("DOMContentLoaded", function(){
	let product_img_box = document.getElementsByName("product_img_box");
	
	product_img_box.forEach(element => element.addEventListener("mouseenter", function(e){
		let product_image = e.target.firstChild.nextSibling;
		product_image.style.opacity= "0.5";
		let hidden_box = e.target.lastChild.previousSibling;
		hidden_box.style.visibility="visible";
	}));
	product_img_box.forEach(element => element.addEventListener("mouseleave", function(e){
		let product_image = e.target.firstChild.nextSibling;
		product_image.style.opacity= "1";
		let hidden_box = e.target.lastChild.previousSibling;
		hidden_box.style.visibility="hidden";
	}));
})

</script>
<div id="container">
	<table>
		<tr>
			<% int rootCnt = 0;
			for(ProductDTO list1 : productList){ %>
				<%if((rootCnt%5)==0 && (rootCnt != 0))%></tr><tr>
				<td width="20%"> 
				<div class="product_img_box" name="product_img_box">
					<a href="shoppingAll.jsp?code=4&product_id=<%=list1.getProduct_id()%>">
						<img  id="product_img" src="/images_yhmall/<%=list1.getProduct_image()%>" width="200px" height="200px"/> 
					</a>
					<div class="product__hidden_menu">
						<input type="hidden" value="<%=list1.getProduct_id()%>">
						<span><a><img src="../../icons/heart.png"></a></span>
						<span><a><img src="../../icons/basket.png"></a></span>
					</div>
				</div>
				<br>
				<div id="product_info">
				<p><a href="shoppingAll.jsp?code=4&product_id=<%=list1.getProduct_id() %>"><%=list1.getProduct_name()%></a></p>
				<% if(list1.getProduct_price() == list1.getProduct_sale_price()){%>
					<span class="sale_price" style="color:black;">\<%=list1.getProduct_sale_price()%></span>
				<%}else{%>
					<span class="price" style="color:#aaa;">\<%=list1.getProduct_price()%></span>
					<span class="sale_price">\<%=list1.getProduct_sale_price()%></span>
				<%}
				++rootCnt;
				%>
				</div>
				</td>
			<%}%>
		</tr>
	</table>
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
				<a href='shoppingAll.jsp?pageNum=<%=1%>&subject=<%=subject%>&search=<%=search%>&code=3'>
					<div id='p_box' class='p_box_b' title='첫 페이지'>≪</div>
				</a>
				<a href='shoppingAll.jsp?pageNum=<%=startPage-10 %>&subject=<%=subject%>&search=<%=search%>&code=3'>
					<div id='p_box' class='p_box_b'title='이전 페이지'>＜</div>
				</a>
			<%}
			//페이징블럭처리
			for (int i=startPage; i<=endPage; i++){
				if(currentPage == i){
					%><div id='p_box' class='p_box_c'><%=i %></div><%
				} else{
					%><a href='shoppingAll.jsp?pageNum=<%=i%>&subject=<%=subject%>&search=<%=search%>&code=3'>
						<div id='p_box'> <%=i %> </div>
					</a><% 
				}
			}

			//다음&마지막 페이지
			if(endPage <= pageCount - (pageCount % pageSize)){%>
				<a href='shoppingAll.jsp?pageNum=<%=startPage+10%>&subject=<%=subject%>&search=<%=search%>&code=3'>
					<div id='p_box' class='p_box_b' title='다음 페이지'>＞</div>
				</a>
				<a href='shoppingAll.jsp?pageNum=<%=pageCount%>&subject=<%=subject%>&search=<%=search%>&code=3'>
					<div id='p_box' class='p_box_b' title='끝 페이지'>≫</div>
				</a>
			<%}
			//
		}
		%>
		</div>
</div>