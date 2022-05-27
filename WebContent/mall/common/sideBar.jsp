<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
	.side_bar{position: fixed;   z-index:3;}
	#sb1{left:1700px; top:300px; width:100px; height:300px; border:1px solid #eee;  background: white; text-align: center;}
	#sb1 p{ margin: 10px auto; font-size: 0.7em}
	
	#sb2{left:1750px; bottom:40px; width:66px;}
	#arrow-up{width:34px; height:34px; border:2px solid black; border-radius: 20%; background: white; cursor: pointer;}
	#arrow-up:hover{ filter : invert(1);}
</style>
<html>

<aside class=side_bar id="sb1">
	<div><p>최근 본 상품</p></div>
</aside>

<aside class=side_bar id="sb2">
	<div class="arrow" id="arrow-up" onclick="window.scrollTo(0,0)" ><img width="32px"  src=" ../../icons/up-arrow.png"></div>
</aside>
</html>