<%@page import="cart.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");

CartDAO cartDAO = CartDAO.getInstance();
String id = request.getParameter("id");
int product_id = Integer.parseInt(request.getParameter("product_id"));
int product_amount = Integer.parseInt(request.getParameter("product_amount"));
int result = cartDAO.insertCart(id, product_id, product_amount);
%>