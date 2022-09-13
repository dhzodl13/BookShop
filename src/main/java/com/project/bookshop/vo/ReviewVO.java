package com.project.bookshop.vo;

import java.sql.*;

public class ReviewVO {

//create table review( 
//	review_num int primary key,
//	review_user_num int,
//	review_pd_num int,
//	review_subject varchar(20), 
//	review_content varchar(500),
//	review_score float,
//	review_date date,
//	FOREIGN KEY (review_user_num) REFERENCES user(user_num),
//	FOREIGN KEY (review_pd_num) REFERENCES product(pd_num)
//);

//INSERT INTO review values(1,2,8,"1번리뷰","1번리뷰내용",4.5,now());
	private int review_num;
	private int review_user_num;
	private int review_pd_num;
	private String review_subject;
	private String review_content;
	private float review_score;
	private Date review_date;
	
	// 조인용 멤버
	private String user_name;
	private String pd_subject; 
	private String user_email; 
	
	public ReviewVO() {
		super();
	}


	public Date getReview_date() {
		return review_date;
	}
	public void setReview_date(Date review_date) {
		this.review_date = review_date;
	}
	
	public int getReview_user_num() {
		return review_user_num;
	}
	public void setReview_user_num(int review_user_num) {
		this.review_user_num = review_user_num;
	}
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public int getReview_pd_num() {
		return review_pd_num;
	}
	public void setReview_pd_num(int review_pd_num) {
		this.review_pd_num = review_pd_num;
	}
	public String getReview_subject() {
		return review_subject;
	}
	public void setReview_subject(String review_subject) {
		this.review_subject = review_subject;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public float getReview_score() {
		return review_score;
	}
	public void setReview_score(float review_score) {
		this.review_score = review_score;
	}
	
	
	//조인용 게터 세터
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPd_subject() {
		return pd_subject;
	}
	public void setPd_subject(String pd_subject) {
		this.pd_subject = pd_subject;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	
	
}
