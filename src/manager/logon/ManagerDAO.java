package manager.logon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;

public class ManagerDAO {

	// singleton Pattern(싱글톤 패턴) - 클래스의 인스턴스를 하나만 생성하는 방법
	//클래스 내부에서만 생성
	private ManagerDAO() { }
	
	private static ManagerDAO instance = new ManagerDAO();
	
	// 외부에 객체를 리턴
	public static ManagerDAO getInstance() {
		return instance;
	}
	

	// DB 연결, 질의 객체 선언 
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	

	public int checkManager(String managerId, String managerPwd) {
		String sql = "select * from manager where managerId = ? and managerPwd = ?";
		int chk = - 1;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setString(2, managerPwd);
			rs = pstmt.executeQuery();
			if(rs.next()){
				chk = 1;
			} else {
				chk = 0;
			}
		} catch(Exception e){		
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	
	
	
	
	
	
}
