<%@page import="review.ReviewDTO"%>
<%@page import="review.ReviewDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="mall.member.MemberDTO"%>
<%@page import="mall.member.MemberDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="manager.product.ProductDAO"%>
<%@page import="manager.product.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<style>
.container{width: 1200px; height:auto; margin: 0 auto;}

#puchase_contents{ height: auto; display: inline-block; overflow: hidden; }
#img_box{float: left; padding: 40px;}
.info_box{float:left; padding: 60px 20px; display: inline-block; width: 580px;}
#title{ font-size: 2em}
.info_box div{border-bottom: 1px solid #eee;}
#sale_price{ font-size: 1.3em; font-weight: bold;}
#origin_price{font-size: 0.9em; color: #aaa; text-decoration: line-through;}
dt{display: inline-block; width: 80px; color:#777}
dd{display: inline-block; width: 450px; margin:0;}

#purchase_qty{display: inline-block; width: 560px; height:auto; background: #eeeeee; margin:20px 0; padding: 10px 20px;}
#purchase_qty div:first-child{display: inline-block; width:100%}
#purchase_qty div:first-child p{margin:5px 0;}
#qty_set button{background:white; border:1px solid #888; ;border-radius:30%;font-size:1.3em;}
#qty_set input[type="number"]{text-align:center; border:none; background:#eee;}
#qty_set input[type="number"]:focus{outline:none;}
#total_price_input{border:none; background:none;display:inline-block;width:350px; margin-left:40px; font-size: 1.3em; text-align: right;}
#total_price_input:focus{outline:none;}
input::-webkit-inner-spin-button { -webkit-appearance:none; margin:0; }

#product_btns{display: inline-block; width: 640px; height: auto; border: none;}
#product_btns button{height:50px; margin:10px; font-size:1.2em; border: 0.5px solid #888; cursor: pointer;}
#product_btns button:hover {font-weight: bold; box-shadow: 1px 1px 5px 1px #888;}
#c_btn{width: 160px; background: white; }
#w_btn{width: 160px; background: white; }
#p_btn{width: 160px; background: #D2691E; color: white;}

.middle_menu{border-bottom: 1px solid #eee; display: inline-block; width:100%; height: 50px;text-align: center;
			 position: sticky; top:61px; z-index: 3; background: white; }
.middle_menu div{display: inline-block; width: 1200px; height: 51px	}
.middle_menu div div{float: left; width:200px;  font-size: 1.3em; font-weight:bold ; line-height: 34px; line-height: 50px; cursor: pointer;}
.se_menu{border-bottom: 2px solid #D2691E; box-sizing: border-box;}
.se_menu a{color:#D2691E; }

#product_contents{width: 1200px; text-align: center; margin: 0 auto;}

#product_reviews{display:inline-block; height:auto; width:100%; padding: 50px auto;}
#review_table{width:100%; border-bottom: 2px solid black;border-top: 2px solid black; border-collapse: collapse;}
#review_table tr{height:40px;}
#review_table td{border-bottom:1px solid #edd;}
#review_table th{background: #eee;}
#paging{text-align: center; margin-top: 20px}
#p_box{display: inline-block; width:25px; height:25px; border-radius: 10px; padding:5px; margin:5px }
#p_box:hover{background: black; color:white;}
.p_box_c{background: black; color:white; }
.p_box_b{font-weight: bold}

.hidden_review{ display: none;}
.reveal_review{ height: auto;  background: #eee;}
.reveal_review td{padding:20px 50px;} 
.reveal_review p{margin:0;}
.order_guide{padding: 40px 0;}

#location2, #location3{display: inline-block; margin-bottom: 120px}
</style>
<%
String memberId = memberId = (String) session.getAttribute("memberId");
if (memberId == null) { //세션이 null인 경우
memberId = "";
}
int product_id = Integer.parseInt(request.getParameter("product_id"));
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);

MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO member = memberDAO.getMember(memberId);

DecimalFormat formatter = new DecimalFormat("###,###");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

int pageSize = 10;
String pageNum = request.getParameter("pageNum");
if (pageNum == null) pageNum = "1";

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage -1) * pageSize + 1;
int endRow = currentPage * pageSize;

ReviewDAO reviewDAO = ReviewDAO.getInstance();
//전체 글수
int cnt = reviewDAO.getReviewCount(product.getProduct_id());

// 게시판 전체 정보를 currentPage의  pageSize만큼 획득 
List<ReviewDTO> reviewList = reviewDAO.getReviewList(product.getProduct_id(), startRow, pageSize);
int number = cnt - (currentPage-1) * pageSize;

%>
<script>
document.addEventListener("DOMContentLoaded", function(){
	function priceToString(price) {
	    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	let purchase_amount = document.getElementById("purchase_amount");
	let total_price_input = document.getElementById("total_price_input");
	document.getElementById("btn_plus").addEventListener("click", function(){
		if(purchase_amount.value > 999){
			alert("최대 구매 수량을 초과 하였습니다. (999개)");
		}else{
			purchase_amount.value = Number(purchase_amount.value)+1;	
		}
		total_price_input.value = priceToString(purchase_amount.value * <%=product.getProduct_sale_price() %>);
	});
	document.getElementById("btn_minus").addEventListener("click", function(){
		if(purchase_amount.value < 2){	
			alert("최소 1개이상 구매하셔야합니다.");
		}else{
			purchase_amount.value = Number(purchase_amount.value)-1;
		}
		total_price_input.value = priceToString(purchase_amount.value * <%=product.getProduct_sale_price() %>);
	});
	
	document.getElementById("purchase_amount").addEventListener("keyup", function(){
		if(purchase_amount.value > 999){
			purchase_amount.value = 1;	
			alert("최대 구매 수량을 초과 하였습니다. (999개)");
		}else if(purchase_amount.value < 1){
			purchase_amount.value = 1;	
			alert("최소 1개이상 구매하셔야합니다.");
		}
		total_price_input.value = priceToString(purchase_amount.value * <%=product.getProduct_sale_price() %>);
	});

	document.getElementById("p_btn").addEventListener("click", function(){
		
		
	});
	
	
	let review_title = document.querySelectorAll("#review_title");
	review_title.forEach(element => element.addEventListener("click", function(e){
		let hidden = e.target.parentNode.parentNode.nextSibling.nextSibling;
		if(hidden.className == 'hidden_review'){
			hidden.className = 'reveal_review';
		}else{
			hidden.className = 'hidden_review';
		}
		
	}));
	
	//버튼 클릭에따른 버튼색변화 
	let middle_menu_btns = document.querySelectorAll(".middle_menu_btns");
	let middle_menu1 =  document.getElementById("middle_menu1");
	let middle_menu2 =  document.getElementById("middle_menu2");
	let middle_menu3 =  document.getElementById("middle_menu3");
	middle_menu_btns.forEach(element => element.addEventListener("click", function(e){
		if(e.target == middle_menu1 || e.target.parentNode == middle_menu1){
			middle_menu1.className = 'se_menu';
			middle_menu2.className = '';
			middle_menu3.className = '';
			location="javascript:window.scrollTo( 0, 785)";
		}else if(e.target == middle_menu2 || e.target.parentNode == middle_menu2){
			middle_menu1.className = '';
			middle_menu2.className = 'se_menu';
			middle_menu3.className = '';
			location="#location2";
		}else if(e.target == middle_menu3 || e.target.parentNode == middle_menu3){
			middle_menu1.className = '';
			middle_menu2.className = '';
			middle_menu3.className = 'se_menu';
			location="#location3";
		}
	}));
	
})

$(document).ready(function(){
	$('#c_btn').on("click", function(e){
		let id = '<%=memberId%>';
	    let product_id = '<%=product_id%>';
	    let product_amount = $('#purchase_amount').val();
	    e.preventDefault()
	    <%if(memberId == null){%>
			alert("로그인 하세요");
			location="../member/memberAll.jsp?"
	    <%}else{ %>
	    $.ajax({
	        type:'post',
	        async:false,
	        url:'shopCartInsert.jsp',
	        dataType:'text',
	        data:{id:id,product_id:product_id, product_amount:product_amount},
	        success:function(data, textStatus) {
	        	alert("장바구니에 담겼습니다.");
	        },
	        error:function (data, textStatus) {
	            alert("오류가 발생하였습니다.")
	        }
	    })
	    <%}%>
	})
});

//스크롤에따른 버튼색 변화
window.addEventListener("scroll", (event) => { 
	
	let product_contents_height = document.getElementById("product_contents").getBoundingClientRect();
	let product_contents_height_top = (product_contents_height.top-120);
	let product_contents_height_bottom = (product_contents_height.bottom-120);
	let product_reviews_height = document.getElementById("product_reviews").getBoundingClientRect();
	let product_reviews_height_top = (product_reviews_height.top-100);
	let product_reviews_height_bottom = (product_reviews_height.bottom-100);
	let order_guide_height = document.getElementById("order_guide").getBoundingClientRect();
	let order_guide_height_top = (order_guide_height.top-120);
	let order_guide_height_bottom = (order_guide_height.bottom-120);
	
	if(product_contents_height_top <= 0 && product_contents_height_bottom >= 0){
		middle_menu1.className = 'se_menu';
		middle_menu2.className = '';
		middle_menu3.className = '';
	}else if(product_reviews_height_top <= 0 && product_reviews_height_bottom >= 0){
		middle_menu1.className = '';
		middle_menu2.className = 'se_menu';
		middle_menu3.className = '';
	}else if(order_guide_height_top <= 0 && order_guide_height_bottom >= 0){
		middle_menu1.className = '';
		middle_menu2.className = '';
		middle_menu3.className = 'se_menu';
	}
});

</script>
<div class="container">
	<div id="puchase_contents">
		<div id="img_box" >
			<img src="/images_yhmall/<%=product.getProduct_image() %>" width="500px" height="500px">
		</div>
		<div class="info_box">
			<form action="shoppingAll.jsp?code=5" method="post">
				<input type="hidden" name="product_id" value="<%=product_id%>">
				<div>
					<p id="title"><%=product.getProduct_name() %></p>
					<p>
						<span id="sale_price"><%=formatter.format(product.getProduct_sale_price())%>원</span>
						<span id="origin_price"><%=formatter.format(product.getProduct_price())%>원</span>
					</p>
				</div>
				<div>
					<dl>
						<dt>구매제한</dt>
						<dd>옵션당 최소 1개</dd>
					</dl>
					<dl>
						<dt>배송비</dt>
						<dd>2500원 / 주문시결제(선결제)</dd>
					</dl>
					<dl>
						<dt>브랜드</dt>
						<dd><%=product.getProduct_brand()%></dd>
					</dl>
				</div>
				<div id="purchase_qty">
					 <div>
					 	<p><%=product.getProduct_name()%></p>
					 </div>
					 <div id="qty_set">
					 	<button type="button" id="btn_plus">+</button>
					 	<input type="number" id="purchase_amount" name="purchase_amount" value="1" max="999" min="1">
					 	<button type="button" id="btn_minus">-</button>
					 	<input type="text" id="total_price_input" value="<%=formatter.format(product.getProduct_sale_price())%>">원
					 </div>
				</div>
				<div id="product_btns">
					<button type="button" id="c_btn">장바구니</button>
					<button type="button" id="w_btn">찜하기</button>
					<button type="submit" id="p_btn">구매하기</button>
				</div>
			</form>
		</div>
	</div>
</div>
<div class="middle_menu" >
	<div>
		<div id="middle_menu1" class="middle_menu_btns"><a>상품정보</a></div>
		<div id="middle_menu2" class="middle_menu_btns"><a>상품문의</a></div>
		<div id="middle_menu3" class="middle_menu_btns"><a>교환 및 반품안내</a></div>
	</div>
</div>
<div class="container">
	<div id="product_contents">
		<img src="../../images/Shipping_Notice.png" width="1000px">
	</div>
	
	<div id="location2"></div>
	<div id="product_reviews">
		<h2>상품후기</h2>
		<table id="review_table" >
			<tr>
				<th width="10%">평점</th>
				<th width="50%">제목</th>
				<th width="10%">작성자</th>
				<th width="15%">작성일</th>
				<th width="10%">조회수</th>
			</tr>
			<%
			if (reviewList.size() == 0) {
			%>
			<tr>
				<td colspan="5" style="text-align:center;">등록된 글이 없습니다.</td>
			</tr>
			<%
			} else {
				for (ReviewDTO review : reviewList) {
			%>
			<tr>
				<td style="text-align:center; margin-right: 20px">
					<img src="../../icons/Star<%=review.getRe_rate()%>.png" width="80px">
				</td>
				<td>
					<a id="review_title" style="cursor:pointer;"> <%=review.getRe_title()%> </a>
				</td>
				<td style="text-align: center"><%=review.getId() %></td>
				<td style="text-align: center"><%=sdf.format(review.getRe_regDate())%></td>
				<td style="text-align: center"><%=review.getReadCount()%></td>
			</tr>
			<tr class="hidden_review">
				<td colspan="5">
					<p><%=review.getRe_content()%></p>
				</td>
			</tr>
				<%}%>
			<%}%>
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
				<a href='@'><div id='p_box' class='p_box_b' title='첫 페이지'>≪</div></a>
				<a href='@'><div id='p_box' class='p_box_b'title='이전 페이지'>＜</div></a>
			<%}
			//페이징블럭처리
			for (int i=startPage; i<=endPage; i++){
				if(currentPage == i){
					%><div id='p_box' class='p_box_c'><%=i %></div><%
				} else{
					%><a href='@'><div id='p_box'> <%=i %> </div></a><% 
				}
			}
			//다음&마지막 페이지
			if(endPage <= pageCount - (pageCount % pageSize)){%>
				<a href='@'><div id='p_box' class='p_box_b' title='다음 페이지'>＞</div></a>
				<a href='@'><div id='p_box' class='p_box_b' title='끝 페이지'>≫</div></a>
			<%}
			//
		}
		%>
		</div>
	</div>
	<div id="location3"></div>
	<div class="order_guide" id="order_guide">
		<h3>배송안내</h3>
		<p>- 배송비 : 기본 배송료는 2,500원 입니다. (도서, 산간, 오지 일부 지역 및 상품의 부피와 수량에 따라 배송비가 추가될 수 있습니다.-추가 배송비 안내 후 상품 출고 진행)</span></p>
		<p>- 본 상품의 평균 배송일은 2~3일입니다.(입금 확인 후) [배송 예정일은 주문 시점(주문 순서)에 따른 유동성이 발생하므로 평균 배송일과는 차이가 발생할 수 있습니다.]</span></p>
		<p>- 평일 오후 3시 이전 결제 완료 건의 경우 당일 출고 됩니다.(배송 지연 시 별도 안내드립니다.)</span></p>
		<p>- 대량 주문의 경우 상품 수량 부족으로 당일 출고가 어려울 수도 잇으며 주문 전 고객 센터에 문의하시면 안내 도와드리겠습니다.</span></p>
		<p>- 대량 주문 또는 박스 수량이 많은 경우 택배사 물량에 따라 동일한 날짜에 상품 수령이 어려울 수도 있습니다.</span></p>
	</div>
	<div class="order_guide">
		<h3>교환 및 반품안내</h3>
		<p>- 교환 및 반품은 수령일로부터 7일 이내로 가능합니다.</p>
		<p>- 교환 및 반품 시 고객 센터로 먼저 문의 후 접수 처리를 하셔야 합니다.(임의로 보내시는 물품은 교환 및 반품 불가합니다)</p>
		<p>- 상품 개봉 또는 상품 가치 훼손 시에는 상품수령후 7일 이내라도 교환 및 반품이 불가능합니다.</p>
		<p>- 고객 변심에 의한 교환 및 반품은 고객께서 배송비를 부담하셔야 합니다.(제품의 하자,배송오류는 제외)</p>
		<p>- 지정 택배사 외 임의로 타택배사를 이용할 경우 배송비용은 고객께서 부담하셔야 합니다.</p>
		<p>- 택배사 물량 증가로 인한 배송 지연의 경우 교환 및 반품이 불가합니다.</p>
	</div>
	<div class="order_guide">
		<h3>환불안내</h3>
		<p>- 상품 청약철회 가능 기간은 상품 수령일로부터 7일 이내입니다.</p>
		<p>- 전자상거래등에서의소비자보호에관한법률 등에 의한 청약철회 제한 사유에 해당하는 경우 및 이에 준하는 것으로 인정되는 경우 청약철회가 제한될 수 있습니다.</p>
		<p>- 제품 하자가 아닌 소비자의 단순 변심, 착오 구매에 따른 환불, 교환, 반품 시 고객께서 부담하는 반품 비용은 편도 2,500원입니다.(최초 배송비 무료인 경우 5,000원 부과)</p>
	</div>
	<div class="order_guide">
		<h3>AS안내</h3>
		<p>- 소비자분쟁해결 기준(공정거래위원회 고시)에 따라 피해를 보상받을 수 있습니다.</p>
		<p>- A/S는 판매자에게 문의하시기 바랍니다.</p>
	</div>
</div>
</html>