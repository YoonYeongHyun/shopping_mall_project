<%@page import="java.text.DecimalFormat"%>
<%@page import="mall.member.MemberDTO"%>
<%@page import="mall.member.MemberDAO"%>
<%@page import="manager.product.ProductDTO"%>
<%@page import="manager.product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.container{width: 1200px; height:auto; overflow:hidden; margin: 0 auto; padding: 20px 0;}
.order_box{float:left; width:870px; height:auto; margin: 30px auto;}	
input[type="text"]:focus{outline: none;}

table {border-top: 1px solid black; border-collapse: collapse; width: 100%;}
#product_table td, #product_table th{padding: 20px 0; text-align: center; vertical-align: middle; border-bottom: 1px solid #ddd;}
#product_table td{height: 100px}

.h2_side{display:inline-block; width:750px; text-align: right; font-size: 16px; margin:0px;}
#order_table {border-top: 1px solid black; border-bottom: 1px solid #aaa; padding: 20px 0; display: inline-block; float: right;}
#order_table th{ text-align: left; padding: 25px; font-size: 1.1em; font-weight:bolder;}
#order_table td input[type="text"]{ width:300px;height:30px; font-size: 16px; padding: 6px 16px; border: 1px solid #aaa;}
#order_table td p{display: inline-block; width: 600px}

#delivery_table {border-top: 1px solid black; border-bottom: 1px solid #aaa; padding: 20px 0; display: inline-block; float: right;}
#delivery_table th{ text-align: left; padding: 25px; font-size: 1.1em; font-weight:bolder;}
#delivery_table td input[type="text"]{ height:30px; font-size: 16px; padding: 6px 16px; border: 1px solid #aaa;}
#delivery_table td input[type="text"]:not(#delivery_addrNum, #delivery_addr1, #delivery_addr2){width:300px;}
#delivery_addrNum{width:150px; margin-bottom:5px}
#delivery_addr1{ margin-bottom:5px; width: 600px;}
#delivery_addr2{ width: 600px;}
#delivery_th{vertical-align: top;}




.fixed{position: absolute; top:384px;}
.non_fixed{position: fixed; top:200px;}
#final_payment_box{display:inline-block; width:250px; height: 400px;  border:2px solid #ff3399; 
				   border-radius:10px; padding: 20px; margin-left: 30px; background: white; z-index: 5;}
#final_payment_1{ padding-bottom:20px; border-bottom: 1px solid #ccc;}
#final_payment_1 span{display: inline-block; width: 115px;margin: 10px auto;}
#final_payment_1 .left_span{ color:#777;}
#final_payment_1 .right_span{ text-align: right; font-weight: bold;}

#final_payment_2{ padding:20px 0;}
#final_payment_2 span{display: inline-block; margin: 10px auto; color:#ff3399; font-weight: bold;}
#final_payment_2 .left_span{width: 100px; font-size: 1em;}
#final_payment_2 .right_span{width: 135px; font-size: 1.4em;text-align: right; font-weight: bold;}
#final_payment_2 form{text-align: center; padding: 30px 0; }
#final_payment_2 input[type="button"]{width:200px; height:50px; background:#ff3399; color: white; font-size:1.3em; font-weight:bold;
cursor: pointer; border-radius:30px; border: 1px solid #eee;}

#final_confirm{position:relative; width: 250px }
#final_confirm input{position: absolute; left: 0px; top: 0px}
#final_confirm label{position: absolute; left: 30px; top: 0px display:inline-block; width: 200px;}
				   
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script> 
document.addEventListener("DOMContentLoaded", function(){
	document.getElementById("addr_btn").addEventListener("click", function(){
		let addrNum = document.getElementById("delivery_addrNum");
		let addr1 = document.getElementById("delivery_addr1");
		let addr2 = document.getElementById("delivery_addr2");
		//카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
            	addrNum.value = data.zonecode; // 주소 넣기
                addr1.value = data.address; // 주소 넣기
                addr2.value = "";
                addr2.focus(); //상세입력 포커싱
            }
		}).open(); 
	});
});

window.addEventListener("scroll", (event) => { 
	scoll_top = document.querySelector('html').scrollTop;
	let final_payment_box = document.getElementById("final_payment_box")
	console.log(scoll_top);
	
	if(scoll_top>200){
		final_payment_box.className = 'non_fixed';
	}else{
		final_payment_box.className = 'fixed';
	}
});
</script>
<%
String memberId = memberId = (String) session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>alert('로그인 하세요');location='../member/memberAll.jsp?'</script>");
}


String product_id_str = request.getParameter("product_id");
String product_id_arr[] = product_id_str.split(",");
String purchase_amount_str = request.getParameter("purchase_amount");
String product_amount_arr[] = purchase_amount_str.split(",");
ProductDAO productDAO = ProductDAO.getInstance();


MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO member = memberDAO.getMember(memberId);

DecimalFormat formatter = new DecimalFormat("###,###");
%>
<div class="container">
	<form action="">
		<div class="order_box">
			<h1>상품주문</h2>
			<table id="product_table">
				<tr> 
					<th width="14%"></th>
					<th width="36%">상품명</th>
					<th width="7%">수량</th>
					<th width="14%">상품금액</th>
					<th width="14%">합계금액</th>
					<th width="15%">배송비</th>
				</tr>
				<% 
				boolean flag = true;
				int index = 0;
				int total_product_price = 0;
				int delivery_fee = 0;
				int total_order_price = 0;
				for(String productId_str : product_id_arr){
					int list_size = product_id_arr.length;
					int productId = Integer.parseInt(productId_str);
					int purchase_amount = Integer.parseInt(product_amount_arr[index]);
					ProductDTO product = productDAO.getProduct(productId);
				%>
				<tr>
					<td>
						<img src="/images_yhmall/<%=product.getProduct_image()%>" style="width:100px; float: left;">
					</td>
					<td style="text-align: left;">
						<%=product.getProduct_name()%>
					</td>
					<td><%=purchase_amount%>개</td>
					<td><%=formatter.format(product.getProduct_sale_price())%>원</td>
					<td style="font-weight:bold;"><%=formatter.format(purchase_amount * product.getProduct_sale_price())%>원</td>
					<%if(flag){%>
					<td rowspan="<%=list_size%>">
						<span>4만원이상무료</span><br>
						<span id="delivery_fee_span"></span>원<br>
						<span>(택배-선결제)</span>
						<% 
						flag = false;
					}%>
					</td>
				</tr>
				<%
				total_product_price += purchase_amount * product.getProduct_sale_price();
				index++;
				} 
				if(total_product_price >= 40000){
					delivery_fee = 0;
				}else{
					delivery_fee = 2500;
				}
				total_order_price = total_product_price + delivery_fee;
				%>
				<script> 
				document.addEventListener("DOMContentLoaded", function(){
					document.getElementById('delivery_fee_span').innerHTML = <%=delivery_fee%>
				});
				</script>
			</table>
			<br>
			<a href="shoppingAll.jsp?code=6"> <strong>＜ 장바구니 돌아가기</strong></a>
		</div>
		<div class="order_box">
			<h2>주문자정보<p class="h2_side"><img src="../../icons/check.png" width="10px">표시는 필수입력항목 입니다.</p> </h2>
			<table id="order_table">
				<tr>
					<th width="30%">주문자 성명&nbsp;<img src="../../icons/check.png" width="16px"></th>
					<td width="70%"><input type="text" value="<%=member.getName()%>"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<p>[<%=member.getAddrNum()%>] <%=member.getAddr1()%> <%=member.getAddr2()%></p>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name >
					</td>
				</tr>
				<tr>
					<th>휴대폰 번호&nbsp;<img src="../../icons/check.png" width="16px"></th>
					<td>
						<input type="text" value="<%=member.getTel()%>">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" value="<%=member.getEmail()%>">
					</td>
				</tr>
			</table>
		</div>
		
		<div class="order_box">
			<h2>배송지정보<p class="h2_side"><img src="../../icons/check.png" width="10px">표시는 필수입력항목 입니다.</p> </h2>
			<table id="delivery_table">
				<tr>
					<th width="30%">이름&nbsp;<img src="../../icons/check.png" width="16px"></th>
					<td width="70%"><input type="text" value="<%=member.getName()%>"></td>
				</tr>
				<tr>
					<th id="delivery_th" height="122px">주소&nbsp;<img src="../../icons/check.png" width="16px" style="vertical-align: top;"></th>
					<td id="delivery_td">
						<input type="text" id="delivery_addrNum" value="<%=member.getAddrNum()%>"> 
						<input type="button" id="addr_btn" value="주소찾기"> <br>
						<input type="text" id="delivery_addr1" value="<%=member.getAddr1()%>"> <br>
						<input type="text" id="delivery_addr2" value="<%=member.getAddr2()%>">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text">
					</td>
				</tr>
				<tr>
					<th>휴대폰 번호&nbsp;<img src="../../icons/check.png" width="16px"></th>
					<td>
						<input type="text" value="<%=member.getTel()%>"> 
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" value="<%=member.getEmail()%>">
					</td>
				</tr>
			</table>
		</div>
	</form>
	<div id="final_payment_box" class="fixed">
		<h3>최종 결제정보</h3>
		<div id="final_payment_1">
			<span class="left_span">총 상품금액</span>
			<span class="right_span"><%=formatter.format(total_product_price)%>원</span>
			<span class="left_span">배송비</span>
			<span class="right_span">+&nbsp;<%=formatter.format(delivery_fee)%>원</span>
		</div>
		<div id="final_payment_2">
			<span class="left_span">최종 결제금액</span>
			<span class="right_span"><%=formatter.format(total_order_price)%>원</span>
			<form action="#" method="post">
				<input type="button" id="final_order_btn" value="결제하기"> <br>
				<input type="hidden" value="">
				<input type="hidden" value="">
				<input type="hidden" value="">
				<input type="hidden" value="">
			</form>
			<div id="final_confirm">
				<input type="checkbox" id="final_order_chk"> 
				<label for="final_order_chk"><strong>(필수)</strong>구매하신 상품에 대한 진행에 동의합니다.</label>
			</div>
		</div>
	</div>
</div>
</html>