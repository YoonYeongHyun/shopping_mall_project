package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import mall.member.MemberDTO;
import manager.product.ProductDTO;
import review.ReviewDTO;
import util.JDBCUtil;

public class CartDAO {

	private CartDAO() {}

	private static CartDAO cartDAO = new CartDAO();
	
	public static CartDAO getInstance() {
		return cartDAO;
	}
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//장바구니 추가하기
	public int insertCart(String id, int product_id, int product_amount) {
		String sql1 = "select count(*) from cart where id = ? and product_id = ?";
		String sql2 = "insert into cart(id, product_id, product_amount) values(?, ?, ?)";
		String sql3 = "update cart set product_amount = ? where product_id = ? and id =?";
		
		int result = -1;
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setInt(2, product_id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt(1);
				if(cnt == 0) {
					result = 1;
					try {
						conn = JDBCUtil.getConnection();
						pstmt = conn.prepareStatement(sql2);
						pstmt.setString(1, id);
						pstmt.setInt(2, product_id);
						pstmt.setInt(3, product_amount);
						pstmt.executeUpdate();
					}catch (Exception e) {
						e.printStackTrace();
						result = 0;
					} finally {
						JDBCUtil.close(conn, pstmt);
					}
				}else {
					result = 1;
					try {
						conn = JDBCUtil.getConnection();
						pstmt = conn.prepareStatement(sql3);
						pstmt.setInt(1, product_amount + cnt);
						pstmt.setInt(2, product_id);
						pstmt.setString(3, id);
						pstmt.executeUpdate();
					}catch (Exception e) {
						e.printStackTrace();
						result = 0;
					} finally {
						JDBCUtil.close(conn, pstmt);
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			result = 0;
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return result;
	}
	
	//장바구니 리스트 받기
	public List<CartDTO> getCartList(String id) {
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		CartDTO cart = null;
		String sql = "select * from cart where id = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				cart = new CartDTO();
				cart.setCart_num(rs.getInt("cart_num"));
				cart.setId(rs.getString("id"));
				cart.setProduct_id(rs.getInt("product_id"));
				cart.setProduct_amount(rs.getInt("product_amount"));
				cartList.add(cart);
			}
		
		} catch (Exception e) {
			System.out.println("getProductCount: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cartList;
	}
	

	public void updateCart(String id, int product_id, int product_amount) {
		String sql = "update cart set product_amount = ? where product_id = ? and id =?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_amount);
			pstmt.setInt(2, product_id);
			pstmt.setString(3, id);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	

	public void deleteCart(String id, int product_id) throws Exception {
		String sql = "delete from cart where id = ? and product_id = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, product_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	public int getCartCount(String id) {
		String sql = "select count(*) from cart where id = ?";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
}
