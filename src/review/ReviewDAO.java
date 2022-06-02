package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import board.BoardDTO;
import util.JDBCUtil;

public class ReviewDAO {

	private ReviewDAO() { }
	
	private static ReviewDAO reviewDAO = new ReviewDAO();
	
	public static ReviewDAO getInstance() {
		return reviewDAO;
	}


	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//리뷰 글쓰기 
	public void insertReview(ReviewDTO review) {
		String sql = "insert into review(re_title, re_content, re_rate, product_id, id) "
				+ "values(?, ?, ?, ?, ?)";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, review.getRe_title());
			pstmt.setString(2, review.getRe_content());
			pstmt.setString(3, review.getRe_rate());
			pstmt.setInt(4, review.getProduct_id());
			pstmt.setString(5, review.getId());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
	}
	

	//리뷰 게시판 글보기 메서드
	public List<ReviewDTO> getReviewList(int product_id, int start, int size) {
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		ReviewDTO review = null;
		String sql = "select * from review where product_id = ? order by re_num desc limit ?, ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setInt(2, start-1);
			pstmt.setInt(3, size);
			rs = pstmt.executeQuery();
			//1 단계: 글번호, 제목, 작성자, 작성일, 조회수
			//2단계: board를 boardList에 저장
			while(rs.next()) {
				review = new ReviewDTO();
				review.setRe_title(rs.getString("re_title"));
				review.setRe_content(rs.getString("re_content"));
				review.setRe_regDate(rs.getTimestamp("re_regDate"));
				review.setRe_rate(rs.getString("re_rate"));
				review.setId(rs.getString("id"));
				review.setReadCount(rs.getInt("readCount"));
				reviewList.add(review);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return reviewList;
	}
	

	//리뷰 글수 획득
	public int getReviewCount(int product_id) {
		String sql = "select count(*) from review where product_id = ?";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
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
