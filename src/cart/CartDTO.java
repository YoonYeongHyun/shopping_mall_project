package cart;

public class CartDTO {
	private int cart_num;
	private String id;
	private int product_id;
	private int product_amount;

	public int getCart_num() {
		return cart_num;
	}

	public String getId() {
		return id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public int getProduct_amount() {
		return product_amount;
	}

	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public void setProduct_amount(int product_amount) {
		this.product_amount = product_amount;
	}

	@Override
	public String toString() {
		return "CartDTO [cart_num=" + cart_num + ", id=" + id + ", product_id=" + product_id + ", product_amount="
				+ product_amount + "]";
	}

}
