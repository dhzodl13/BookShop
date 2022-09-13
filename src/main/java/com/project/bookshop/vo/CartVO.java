package com.project.bookshop.vo;

/*
장바구니 
 
CREATE TABLE cart(
	cart_user_num int NOT NULL,
	cart_pd_num int NOT NULL,
	cart_pd_quan int NOT NULL,
	constraint user_num_fk FOREIGN KEY(cart_user_num) REFERENCES user(user_num),
	constraint pd_num_fk FOREIGN KEY(cart_pd_num) REFERENCES product(pd_num)
);
 */
public class CartVO {
	private int cart_user_num;
	private int cart_pd_num;
	private int cart_pd_quan;
	
	public int getCart_user_num() {
		return cart_user_num;
	}
	public void setCart_user_num(int cart_user_num) {
		this.cart_user_num = cart_user_num;
	}
	public int getCart_pd_num() {
		return cart_pd_num;
	}
	public void setCart_pd_num(int cart_pd_num) {
		this.cart_pd_num = cart_pd_num;
	}
	public int getCart_pd_quan() {
		return cart_pd_quan;
	}
	public void setCart_pd_quan(int cart_pd_quan) {
		this.cart_pd_quan = cart_pd_quan;
	}
	
	
	
}
