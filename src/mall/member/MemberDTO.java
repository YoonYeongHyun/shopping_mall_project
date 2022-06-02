package mall.member;

import java.sql.Timestamp;

//DTO, VO, DataBean
//useBean 액션태그에서 사용 ->데이터의 이동에서 사용
public class MemberDTO {
	// 프로퍼티 (property)-> 멤버변수
	private String id;
	private String pwd;
	private String name;
	private String email;
	private String tel;
	private String addrNum;
	private String addr1;
	private String addr2;
	private Timestamp regDate;

	// 자동 줄정렬 ctrl+shift+f
	public String getId() {
		return id;
	}

	public String getPwd() {
		return pwd;
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public String getTel() {
		return tel;
	}

	public String getAddrNum() {
		return addrNum;
	}

	public String getAddr1() {
		return addr1;
	}
	
	public String getAddr2() {
		return addr2;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public void setAddrNum(String addrNum) {
		this.addrNum = addrNum;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pwd=" + pwd + ", name=" + name + ", email=" + email + ", tel=" + tel
				+ ", addrNum=" + addrNum + ", addr1=" + addr1 + ", addr2=" + addr2 + ", regDate=" + regDate + "]";
	}

}
