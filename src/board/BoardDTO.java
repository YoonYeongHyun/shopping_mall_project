package board;

import java.sql.Timestamp;

// DTO, VO, DataBean
// useBean 액션태그에서 사용 ->데이터의 이동에서 사용
public class BoardDTO {
	// 프로퍼티 (property)-> 멤버변수
	private int num;
	private String writer;
	private String subject;
	private String content;
	private Timestamp regDate;
	private int readCount;
	private int ref;
	private int re_step;
	private int re_level;

	// 자동 줄정렬 ctrl+shift+f
	public int getNum() {
		return num;
	}

	public String getWriter() {
		return writer;
	}

	public String getSubject() {
		return subject;
	}

	public String getContent() {
		return content;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public int getReadCount() {
		return readCount;
	}

	public int getRef() {
		return ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

	@Override
	public String toString() {
		return "BoardDTO [num=" + num + ", wirter=" + writer + ", subject=" + subject + ", content=" + content
				+ ", regDate=" + regDate + ", readCount=" + readCount + ", ref=" + ref + ", re_step=" + re_step
				+ ", re_level=" + re_level + "]";
	}
}
