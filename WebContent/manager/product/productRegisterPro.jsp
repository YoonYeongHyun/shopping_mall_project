<%@page import="java.util.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import= "java.text.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="manager.product.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 처리 페이지</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	String realFolder = "c:/images_yhmall";
	int maxSize = 1024 * 1024 * 5 ;
	String encType = "utf-8";
	
	MultipartRequest multi = null;
	String mainFileName = "";
	String fileName[] = {"","","","",""};
	
	
	try{
		multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration<?> files = multi.getFileNames();
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			if(name.equals("product_image")) mainFileName = multi.getFilesystemName(name);
			else if(name.equals("product_content_image1")) fileName[0] = multi.getFilesystemName(name);
			else if(name.equals("product_content_image2")) fileName[1] = multi.getFilesystemName(name);
			else if(name.equals("product_content_image3")) fileName[2] = multi.getFilesystemName(name);
			else if(name.equals("product_content_image4")) fileName[3] = multi.getFilesystemName(name);
			else if(name.equals("product_content_image5")) fileName[4] = multi.getFilesystemName(name);
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	String fileNames = String.join(",", fileName);
	
	//문자열을 타임스탬프변수로 변환
	String product_expiry_date1 = (multi.getParameter("product_expiry_date"));
	String product_expiry_date2 = " 00:00:00";
	product_expiry_date1 += product_expiry_date2;
	Timestamp product_expiry_date = Timestamp.valueOf(product_expiry_date1);
	
	ProductDAO productDAO = ProductDAO.getInstance();
	String product_kind = multi.getParameter("product_kind");
	String product_name = multi.getParameter("product_name");
	int product_price = Integer.parseInt(multi.getParameter("product_price"));
	int product_sale_price = Integer.parseInt(multi.getParameter("product_sale_price"));
	int product_qty = Integer.parseInt(multi.getParameter("product_qty"));
	String product_brand = multi.getParameter("product_brand");
	String product_content = multi.getParameter("product_content");
	
	ProductDTO product = new ProductDTO();
	product.setProduct_kind(product_kind);
	product.setProduct_name(product_name);
	product.setProduct_price(product_price);
	product.setProduct_sale_price(product_sale_price);
	product.setProduct_qty(product_qty);
	product.setProduct_brand(product_brand);
	product.setProduct_content(product_content);
	if(mainFileName == null) product.setProduct_image("nothing.jpg");
	else product.setProduct_image(mainFileName);
	product.setProduct_content_image(fileNames);
	
	int result = productDAO.insertProduct(product, product_expiry_date); 
	
	if(result == 1){%>
		<script> 
			alert("상품이 등록되었습니다."); 
			location="productManagement.jsp"
		</script>
	<%}else{%>
		<script>
			alert("상품등록에 실패하였습니다."); 
			history.back();
		</script>
	<%}%>
	
</body>
</html>