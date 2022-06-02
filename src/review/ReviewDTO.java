package review;

import java.sql.Timestamp;

public class ReviewDTO {

	private int re_num;
	private String id;
	private String re_title;
	private String re_content;
	private Timestamp re_regDate;
	private String re_rate;
	private int product_id;
	private int readCount;

	public int getRe_num() {
		return re_num;
	}

	public String getRe_title() {
		return re_title;
	}

	public String getRe_content() {
		return re_content;
	}

	public Timestamp getRe_regDate() {
		return re_regDate;
	}

	public String getRe_rate() {
		return re_rate;
	}

	public int getProduct_id() {
		return product_id;
	}

	public String getId() {
		return id;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setRe_num(int re_num) {
		this.re_num = re_num;
	}

	public void setRe_title(String re_title) {
		this.re_title = re_title;
	}

	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}

	public void setRe_regDate(Timestamp re_regDate) {
		this.re_regDate = re_regDate;
	}

	public void setRe_rate(String re_rate) {
		this.re_rate = re_rate;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	@Override
	public String toString() {
		return "ReviewDTO [re_num=" + re_num + ", re_title=" + re_title + ", re_content=" + re_content + ", re_regDate="
				+ re_regDate + ", re_rate=" + re_rate + ", product_id=" + product_id + ", id=" + id + ", readCount="
				+ readCount + "]";
	}
}
