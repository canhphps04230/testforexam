package model;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.HashSet;
import java.util.Set;

public class Product implements Serializable {
	private static final String IMGPATH = "img/product/";
	private String id, name, typeId, image, currency;
	private float price;
	private int quantity;
	private Set<CartItem> cartItems = new HashSet<CartItem>(0);

	public Product() {
		this.price = 0;
		this.quantity = 0;
		setCurrency(price);
	}

	public Product(String id, String name, float price, int quantity) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
		setCurrency(price);
	}

	public Product(String id, String name, float price, int quantity, String image, String typeId) {
		this.id = id;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
		this.image = image;
		this.typeId = typeId;
		setCurrency(price);
	}

	public Product(String id, String name, String typeId, String image, float price, int quantity,
			Set<CartItem> cartItems) {
		this.id = id;
		this.name = name;
		this.typeId = typeId;
		this.image = image;
		this.price = price;
		this.quantity = quantity;
		this.cartItems = cartItems;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTypeId() {
		return typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
		setCurrency(price);
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public static String getImgPath() {
		return IMGPATH;
	}

	public String getCurrency() {
		return currency;
	}

	private void setCurrency(float price) {
		NumberFormat formatter = new DecimalFormat("###.###");
		this.currency = formatter.format(price);
	}

	public Set<CartItem> getCartItems() {
		return cartItems;
	}

	public void setCartItems(Set<CartItem> cartItems) {
		this.cartItems = cartItems;
	}

}
