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
.container{width: 1200px; height: 1200px;  margin: 0 auto; padding: 50px 20px;}
#order_box{float:left; width:900px; height: 1200px;}	

#final_payment_box{float:right; width:250px; height: 400px; position: sticky; top:200px; border:3px solid #8B4513; 
				   border-radius:10px; padding: 10px; margin-top: 70px}
table {border-top: 1px solid black; border-collapse: collapse; width: 100%;}
#product_table td, #product_table th{padding: 20px 0; text-align: center; vertical-align: middle; border-bottom: 1px solid #ddd;}
#product_table td{height: 100px}
</style>
<script> 

</script>
<%
String memberId = memberId = (String) session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>alert('로그인 하세요');location='../member/memberAll.jsp?'</script>");
}
int product_id = Integer.parseInt(request.getParameter("product_id"));
int purchase_amount = Integer.parseInt(request.getParameter("purchase_amount"));
ProductDAO productDAO = ProductDAO.getInstance();
ProductDTO product = productDAO.getProduct(product_id);

MemberDAO memberDAO = MemberDAO.getInstance();
MemberDTO member = memberDAO.getMember(memberId);

DecimalFormat formatter = new DecimalFormat("###,###");
%>
<div class="container">
	<div id="order_box">
		<h2>상품주문</h2>
		<table id="product_table">
			<tr> 
				<th width="14%"></th>
				<th width="36%">상품명</th>
				<th width="7%">수량</th>
				<th width="14%">상품금액</th>
				<th width="14%">합계금액</th>
				<th width="15%">배송비</th> 
			</tr>
			<tr>
				<td>
					<img src="/images_yhmall/<%=product.getProduct_image()%>" style="width:100px; float: left;" >
				</td>
				<td style="text-align: left;">
					<%=product.getProduct_name()%>
				</td>
				<td><%=purchase_amount %></td>
				<td><%=formatter.format(product.getProduct_sale_price())%>원</td>
				<td style="font-weight:bold;"><%=formatter.format(purchase_amount * product.getProduct_sale_price())%>원</td>
				<td> 
					<span>4만원이상무료</span><br>
					<span>
					<%if(purchase_amount * product.getProduct_sale_price() >= 40000){ %>
						0원
					<%}else{%>
						2500원
					<%}%>
					</span><br>
					<span>(택배-선결제)</span>
				</td>
			</tr>
		</table>
	</div>
	<div id="final_payment_box">
	
	</div>
<input type="text" value="<%=product.getProduct_name()%>">
<input type="text" value="<%=purchase_amount%>">
<input type="text" value="<%=member.getId()%>">

</div>
</html>