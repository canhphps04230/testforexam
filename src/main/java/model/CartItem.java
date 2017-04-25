package model;

import java.io.Serializable;

public class CartItem implements Serializable {
	private Integer id;
    private Cart cart;
    private Product product;
    private float price;
    private Integer quantity;

   public CartItem() {
   }

	
   public CartItem(Product product, int quantity) {
       this.product = product;
       this.price = product.getPrice();
       this.quantity = quantity;
   }
   public CartItem(Cart cart, Product product, Integer quantity) {
      this.cart = cart;
      this.product = product;
      this.price = product.getPrice();
      this.quantity = quantity;
   }
  
   public Integer getId() {
       return this.id;
   }
   
   public void setId(Integer id) {
       this.id = id;
   }
   public Cart getCart() {
       return this.cart;
   }
   
   public void setCart(Cart cart) {
       this.cart = cart;
   }
   public Product getProduct() {
       return this.product;
   }
   
   public void setProduct(Product product) {
       this.product = product;
   }
   public float getPrice() {
	return price;
}


public void setPrice(float price) {
	this.price = price;
}


public Integer getQuantity() {
       return this.quantity;
   }
   
   public void setQuantity(Integer quantity) {
       this.quantity = quantity;
   }
	
}
