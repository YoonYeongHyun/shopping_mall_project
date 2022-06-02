package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import util.JDBCUtil;

//DAO(Data Access Object) - DB의 연결, 해제, 질의를 담당 
public class BoardDAO {
	
	// singleton Pattern(싱글톤 패턴) - 클래스의 인스턴스를 하나만 생성하는 방법
	//클래스 내부에서만 생성
	private BoardDAO() { }

	
	private static BoardDAO boardDAO = new BoardDAO();
	
	// 외부에 객체를 리턴
	public static BoardDAO getInstance() {
		return boardDAO;
	}

	// DB 연결, 질의 객체 선언 
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//게시판 글등록 메서드
	public void insertBoard(BoardDTO board) {
		String sql1 = "select max(num) from board";
		String sql2 = "update board set re_step = re_step+1 where ref=? and re_step>?";
		String sql3 = "insert into board(writer, subject, content, ref, re_step, re_level) values(?, ?, ?, ?, ?, ?)";
		
		int num = board.getNum();
		int ref = board.getRef();
		int re_step = board.getRe_step();
		int re_level = board.getRe_level();
		int number = 0;
				
		try {
			conn = JDBCUtil.getConnection();

			//글번호의 최대값 획득
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			
			if(rs.next()) number = rs.getInt(1) +1;
			else number = 1;
			
			//댓글그룹, 댓글수, 댓글깊이 
			if(num != 0) { //댓글인 경우
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			}else {// 원글인 경우
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			
			//글 등록 처리
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, ref);
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, re_level);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
	}
	
	//대댓글 등록 메서드
	public void insertReBoard(BoardDTO board) {
		String sql1 = "update board set re_step = re_step+1 where ref=? and re_step>?";
		String sql2 = "insert into board(writer, subject, content, ref, re_step, re_level) values(?, '[re]', ?, ?, ?, ?)";
		
		int num = board.getNum();
		int ref = board.getRef();
		int re_step = board.getRe_step();
		int re_level = board.getRe_level();
				
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_step);
			pstmt.executeUpdate();
			re_step = re_step + 1;
			re_level = re_level + 1;

			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, board.getWriter());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, ref);
			pstmt.setInt(4, re_step);
			pstmt.setInt(5, re_level);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
	}
	
	
	//게시판 글보기 (전체) 메서드
	public List<BoardDTO> getBoardList(int start, int size) {
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		BoardDTO board= null;
		
		
		String sql = "select * from board where re_level = 0 order by ref desc limit ?, ? ";
		
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start-1); // limit은 0부터 시작
			pstmt.setInt(2, size);
			rs = pstmt.executeQuery();
			//1 단계: 글번호, 제목, 작성자, 작성일, 조회수
			//2단계: board를 boardList에 저장
			while(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setWriter(rs.getString("writer"));
				board.setRegDate(rs.getTimestamp("regDate"));
				board.setReadCount(rs.getInt("readCount"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
				boardList.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return boardList;
	}
	
	

	//게시판 댓글정보 읽기 메서드
	public List<BoardDTO> getBoardList2(int ref) {
		List<BoardDTO> boardList = new ArrayList<BoardDTO>();
		BoardDTO board= null;
		
		
		String sql = "select * from board where ref = ? order by re_step ";
		
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			rs = pstmt.executeQuery();
			//1 단계: 글번호, 제목, 작성자, 작성일, 조회수
			//2단계: board를 boardList에 저장
			while(rs.next()) {
				board = new BoardDTO();
				board.setNum(rs.getInt("num"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setWriter(rs.getString("writer"));
				board.setRegDate(rs.getTimestamp("regDate"));
				board.setReadCount(rs.getInt("readCount"));
				board.setRef(rs.getInt("ref"));
				board.setRe_step(rs.getInt("re_step"));
				board.setRe_level(rs.getInt("re_level"));
				boardList.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return boardList;
	}
	
	
	//게시판 글보기 (1건) 매서드
	public BoardDTO getBoard(int num) {
		BoardDTO board = new BoardDTO();
		String sql1 = "update board set readCount=readCount+1 where num = ?";
		String sql2 = "select * from board where num = ?";
		
		try {
			
			conn = JDBCUtil.getConnection();
			//조회수 증가
			pstmt = conn.prepareCall(sql1);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			// 글 상세 보기
			pstmt = conn.prepareCall(sql2);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			board.setNum(rs.getInt("num"));
			board.setWriter(rs.getString("writer"));
			board.setSubject(rs.getString("subject"));
			board.setContent(rs.getString("content"));
			board.setRegDate(rs.getTimestamp("regDate"));
			board.setReadCount(rs.getInt("readCount"));
			board.setRef(rs.getInt("ref"));
			board.setRe_step(rs.getInt("re_step"));
			board.setRe_level(rs.getInt("re_level"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return board;	
	}
	

	//댓글 정보얻기 메서드
	public BoardDTO getBoardDTO(int num) {
		BoardDTO board = new BoardDTO();
		String sql = "select * from board where num = ?";
		
		try {
			
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareCall(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			board.setNum(rs.getInt("num"));
			board.setWriter(rs.getString("writer"));
			board.setSubject("[Re]");
			board.setContent(rs.getString("content"));
			board.setRegDate(rs.getTimestamp("regDate"));
			board.setReadCount(rs.getInt("readCount"));
			board.setRef(rs.getInt("ref"));
			board.setRe_step(rs.getInt("re_step"));
			board.setRe_level(rs.getInt("re_level"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return board;	
	}
	
	// 게시글 글수정폼 에서 글보기 메서드
	public BoardDTO getBoard_updateForm(int num) {
		BoardDTO board = new BoardDTO();
		String sql = "select * from board where num = ?";
		
		try {
			
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareCall(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
			board.setSubject(rs.getString("subject"));
			board.setContent(rs.getString("content"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return board;
	}
	
	
	//게시판 글수정 메서드

	public void updateBoard(BoardDTO board) {
		String sql = "update board set subject = ?, content = ? where num = ?";
		
		try {
			conn = JDBCUtil.getConnection();
			//글 등록 처리
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getSubject());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getNum());
			pstmt.executeUpdate();	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
	}
	
	
	//게시판 글삭제 메서드
	public void deleteBoard(int num) {
		String sql = "delete from board where num = ?";
		try {
			conn = JDBCUtil.getConnection();
			//글 등록 처리
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
	}
	
	//전체 글수 획득
	public int getBoardCount() {
		String sql = "select count(*) from board where re_level = 0 ";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
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
	

	// 댓글수 획득
	public int getBoardReCount(int ref) {
		String sql = "select count(*) from board where re_level > 0 and ref = ?";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
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
