package manager.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class ProductDAO {

	private ProductDAO() {}
	
	private static ProductDAO productDAO = new ProductDAO();
	
	public static ProductDAO getInstance() {
		return productDAO;
	}

	// DB 연결, 질의 객체 선언 
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//상품등록 메서드 
	public int insertProduct(ProductDTO product, Timestamp Product_expiry_date) {
		
		String sql1 = "insert into product(product_kind, product_name, product_price, discount_rate, product_sale_price, product_qty,"
				+ "product_brand, product_expiry_date, product_image, product_content) values(?, ?, ?, ?, ?, ?, ?, ?, ? ,?)";
		
		float product_price = (float)product.getProduct_price();
		int product_sale_price = product.getProduct_sale_price();
		int discount_rate = 100 - Math.round((product_sale_price/product_price)*100);
		int result = 1;
				
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql1);
			
			//글 등록 처리
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, discount_rate);
			pstmt.setInt(5, product.getProduct_sale_price());
			pstmt.setInt(6, product.getProduct_qty());
			pstmt.setString(7, product.getProduct_brand());
			pstmt.setTimestamp(8, Product_expiry_date);
			pstmt.setString(9, product.getProduct_image());
			pstmt.setString(10, product.getProduct_content());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			result=0;
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return result;
	}
	

	//상품수정 메서드 
	public int updateProduct(ProductDTO product, Timestamp Product_expiry_date) {
		
		String sql1 = "update product set product_kind = ?, product_name = ?, product_price = ?, discount_rate = ?, product_sale_price = ?, "
				+ "product_qty = ?, product_brand = ?, product_expiry_date = ?, product_image = ?, product_content = ? where Product_id = ?";
		float product_price = (float)product.getProduct_price();
		int product_sale_price = product.getProduct_sale_price();
		int discount_rate = 100 - Math.round((product_sale_price/product_price)*100);
		int result = 1;
				
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql1);
			//글 등록 처리
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, discount_rate);
			pstmt.setInt(5, product.getProduct_sale_price());
			pstmt.setInt(6, product.getProduct_qty());
			pstmt.setString(7, product.getProduct_brand());
			pstmt.setTimestamp(8, Product_expiry_date);
			pstmt.setString(9, product.getProduct_image());
			pstmt.setString(10, product.getProduct_content());
			pstmt.setInt(11, product.getProduct_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			result=0;
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return result;
	}
	
	
	//상품리스트 조회 메서드
	public List<ProductDTO> getProductsList() {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_sale_price(rs.getInt("product_sale_price"));
				product.setProduct_qty(rs.getInt("product_qty"));
				product.setProduct_sales(rs.getInt("product_sales"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_expiry_date(rs.getTimestamp("product_expiry_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
		
		} catch (Exception e) {
			System.out.println("getProductCount: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}


	//상품리스트 조회 메서드(분류시)
	public List<ProductDTO> getProductsCategoryList(String category, int start, int size) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		try {
			conn = JDBCUtil.getConnection();
			if(!category.equals("0")) {
				String sql ="select * from product where product_kind like ? order by product_id desc limit ?, ? ";
				pstmt = conn.prepareStatement(sql);
				category +="%";
				pstmt.setString(1, category);
				pstmt.setInt(2, start-1);
				pstmt.setInt(3, size);
			}else {
				String sql = "select * from product order by product_id desc limit ?, ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, size);
			}
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_sale_price(rs.getInt("product_sale_price"));
				product.setProduct_qty(rs.getInt("product_qty"));
				product.setProduct_sales(rs.getInt("product_sales"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_expiry_date(rs.getTimestamp("product_expiry_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
		
		} catch (Exception e) {
			System.out.println("getProductsCategoryList: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	//상품 개수 조회메서드
	public int getProductCount(String category) {
		System.out.println();
		String sql = "";
		if(!category.equals("0")) {
			category +="%";
			sql = "select count(product_id) from product where product_kind like ?";
		}else{
			sql = "select count(product_id) from product";
		}
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			if(!category.equals("0")) {
				category +="%";
				pstmt.setString(1, category);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("getProductCount: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}	
	
	//상품 삭제메서드
	public int deleteProduct(int product_id) {
		String sql = "delete from product where product_id = ?";
		int cnt = 0;
				
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	//상품1건보기(업데이트용)

	public ProductDTO getProduct(int product_id) {
		ProductDTO product = new ProductDTO();
		String sql = "select * from product where product_id = ?";
			
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				product = new ProductDTO();
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setProduct_sale_price(rs.getInt("product_sale_price"));
				product.setProduct_qty(rs.getInt("product_qty"));
				product.setProduct_sales(rs.getInt("product_sales"));
				product.setProduct_brand(rs.getString("product_brand"));
				product.setProduct_expiry_date(rs.getTimestamp("product_expiry_date"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_content(rs.getString("product_content"));
				product.setReg_date(rs.getTimestamp("reg_date"));
			}
		
		} catch (Exception e) {
			System.out.println("getProductCount: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return product;
	}
	
}

	
