package com.project.bookshop.vo;

/*
관심목록(찜목록)

CREATE TABLE interest(
	inter_user_num int NOT NULL,
	inter_pd_num int NOT NULL,
	constraint int_user_num_fk FOREIGN KEY(inter_user_num) REFERENCES user(user_num),
	constraint int_pd_num_fk FOREIGN KEY(inter_pd_num) REFERENCES product(pd_num)
);
 */
public class InterestVO {
	private int inter_user_num;
	private int inter_pd_num;
	
	public int getInter_user_num() {
		return inter_user_num;
	}
	public void setInter_user_num(int inter_user_num) {
		this.inter_user_num = inter_user_num;
	}
	public int getInter_pd_num() {
		return inter_pd_num;
	}
	public void setInter_pd_num(int inter_pd_num) {
		this.inter_pd_num = inter_pd_num;
	}
	
	
	
	
	
}
