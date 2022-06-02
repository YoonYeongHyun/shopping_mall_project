package mall.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;

//DAO(Data Access Object) - DB의 연결, 해제, 질의를 담당 
public class MemberDAO {

	// singleton Pattern(싱글톤 패턴) - 클래스의 인스턴스를 하나만 생성하는 방법
	//클래스 내부에서만 생성
	private MemberDAO() { }
	
	
	private static MemberDAO memberDAO = new MemberDAO();
	
	// 외부에 객체를 리턴
	public static MemberDAO getInstance() {
		return memberDAO;
	}
	
	// DB 연결, 질의 객체 선언 
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	//회원가입 메서드 
	public int insertMember(MemberDTO member) {
		String sql = "insert into member values(?, ?, ?, ?, ?, ?, ?, ?, now())";
		int cnt = 0; // 1-성공 , 0-실패, 
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddrNum());
			pstmt.setString(7, member.getAddr1());
			pstmt.setString(8, member.getAddr2());
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	
	// 아이디 중복체크
	public int idCheck (String id) {
		
		String sql = "select * from member where id = ?";
		int chk = -1;// 1-중복된 아이디 존재 (사용 불가), 0-중복된 아이디가 존재하지 않음 (사용가능)
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) chk=0;
			else chk=1;
		} 
		catch (Exception e) {e.printStackTrace();}
		finally {JDBCUtil.close(conn, pstmt, rs);}
		
		return chk;
	}
	
	// 로그인
	public int login(String id, String pwd) {
		String sql = "select * from member where id = ?";
		int chk = - 1;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){ // 아이디가 존재
				String dbpwd = rs.getString("pwd");
				if(pwd.equals(dbpwd)){//로그인 성공
					chk = 1;
				} else { // 아이디가 존재하지만 비밀번호가 틀릴 때
					chk = 0;
				}
			} else { // 아이디가 존재하지않음
				chk = 2;
			}
		} catch(Exception e){		
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return chk;
	}
	
	//회원 정보 보기(1명, 자신의 정보)
	public MemberDTO getMember(String id) {
		String sql = "select * from member where id = ?";
		MemberDTO member = new MemberDTO();
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//가입일을제외한 정보를 테이블로부터 가져와서 member객체에 저장
				member.setId(id);
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddrNum(rs.getString("addrNum"));
				member.setAddr1(rs.getString("addr1"));
				member.setAddr2(rs.getString("addr2"));
				member.setRegDate(rs.getTimestamp("regDate"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
	}
	
	
	//회원 정보 수정
	public int updateMember(MemberDTO member) {
		String sql = "update member set pwd = ?, Name = ?, Email = ?, Tel = ?, addrNum = ?, addr1 = ?, addr2 = ?, "
				+ "where id = ?";
		int cnt = 0; // 1-성공 , 0-실패, 
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddrNum());
			pstmt.setString(6, member.getAddr1());
			pstmt.setString(7, member.getAddr2());
			pstmt.setString(8, member.getId());
			
			cnt = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	//회원 삭제 (탈퇴)
	public int deleteMember(MemberDTO member) throws Exception {
		String sql1 = "delete from member where id = ?";
		String sql2 = "delete from board where writer = ?";
		int cnt = 0; // 1-성공 , 0-실패, 
		
		try {
			conn = JDBCUtil.getConnection();
			//트랜잭션처리 - DML작업이 두개 이상 함께 처리되어야할 때
			//모두 처리되던지, 처리되지 않던지 all or nothing
			
			//오토커밋종료
			conn.setAutoCommit(false);
			
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, member.getId());
			cnt = pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, member.getId());
			pstmt.executeUpdate();
			
			conn.commit();
			conn.setAutoCommit(true);
			
		} catch (Exception e) {
			conn.rollback();
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
}
