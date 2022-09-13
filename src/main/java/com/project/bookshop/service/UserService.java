package com.project.bookshop.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.bookshop.mapper.UserMapper;
import com.project.bookshop.vo.OrdDetailVO;
import com.project.bookshop.vo.OrdVO;
import com.project.bookshop.vo.PageInfo;
import com.project.bookshop.vo.ProductVO;
import com.project.bookshop.vo.QnaVO;
import com.project.bookshop.vo.ReviewVO;
import com.project.bookshop.vo.UserVO;

@Service
public class UserService {
	@Autowired
	private UserMapper mapper;
	
	// 로그인 기능 수행 시 유저 컬럼들 들고 오기
	public UserVO loginUser(UserVO user) {
		return mapper.loginUser(user);
	}

	
	// 회원가입 기능 수행 시 유저 입력
	public boolean joinUser(UserVO user) {
		return mapper.joinUser(user);
	}

	// 만들어진 이메일 전체 갯수
	public Integer userMaxNum() {
		return mapper.userMaxNum();
	}
	
	// 이메일 중복 체크
	public UserVO checkDuplicateId(String user_email) {
		return mapper.selectDuplicateId(user_email);
	}
		
	// 상품 번호를 이용해 해당 리뷰 전체 들고 오기
	public ArrayList<ReviewVO> getPdReviewList(int pd_num, PageInfo pageInfo) {
		return mapper.getPdReviewList(pd_num, pageInfo);
	}

	// 상품 번호를 이용해 QnA 전체 들고 오기
	public ArrayList<QnaVO> getPdQnaList(int pd_num, PageInfo pageInfo) {
		return mapper.getPdQnaList(pd_num, pageInfo);
	}

	// 상품 번호를 이용해 상품에 관련된 리뷰 갯수 들고 오기 
	public int getReviewCount(int pd_num) {
		return mapper.getReivewCount(pd_num);
	}

	// 상품 번호를 이용해 상품에 관련된 QnA 갯수 들고 오기 
	public int getQnaCount(int pd_num) {
		return mapper.getQnaCount(pd_num);
	}
	
	// 이름과 주민번호를 이용해 UserVO 들고 오기
	public UserVO getUserEmail(String name, String jumin) {
		return mapper.getUserEmail(name, jumin);
	}
	
	// 아이디(이메일)과 주민번호를 이용해 UserVO 들고 오기
	public UserVO getUserPasswd(String email, String jumin) {
		return mapper.getUserPasswd(email, jumin);
	}

	// 내가 주문한 상품 전체 들고 오기
	public ArrayList<OrdVO> myOrder(String sId) {
		return mapper.myOrder(sId);
	}
	
	// 내가 주문한 상품 날짜별로 검색해서 들고 오기
	public ArrayList<OrdVO> myOrderSearchDate(String sId, String startday, String endday) {
		return mapper.myOrderSearchDate(sId, startday, endday);
	}

	// 주문 번호를 이용해서 한번에 구매한 상품들 들고 오기
	public ArrayList<OrdDetailVO> myOrderDetail(int order_num) {
		return mapper.myOrderDetail(order_num);
	}

	// 주문 번호를 이용해서 주문 취소 시키기
	public int myOrderCancel(int order_num) {
		return mapper.myOrderCancel(order_num);
	}
	
	// 취소하면 ord 찾아서 감소 시키기 위해 필요한 OrdVO 데이터 4개 들고 오기
	public OrdVO getOrder(int order_num) {
		return mapper.selectOrder(order_num);
	}

	// 주문을 하나 들고와서 취소하면 마일리지와 돈 돌려 주기
	public int userOrderCancel(OrdVO ord) {
		return mapper.userOrderCancel(ord);
	}

	// 주문 번호를 이용해서 내가 주문한 상품들 자세히 가져오기
	public ArrayList<OrdDetailVO> myOrderDetailList(int order_num) {
		return mapper.myOrderDetailList(order_num);
	}
	
	// 자세히본 상품을 가져와서 주문 취소 시키기
	public int orderDetailOrderCancel(OrdDetailVO ordDetail) {
		return mapper.orderDetailOrderCancel(ordDetail);
	}

	// 주문 번호를 이용해서 주문 목록 전체 들고 오기
	public ArrayList<OrdVO> MyOrderCancelRefundView(int order_num) {
		return mapper.MyOrderCancelRefundView(order_num);
	}

	// sId를 이용해여 내정보 가져오기
	public UserVO sIdToUserVO(String sId) {
		return mapper.sIdToUserVO(sId);
	}

	// 자신 번호와 상품번호를 이용해서 리뷰 들고 오기
	public ReviewVO getReviewVO(int user_num, int pd_num) {
		return mapper.getReviewVO(user_num, pd_num);
	}

	// 리뷰 전체 갯수 들고 오기
	public Integer getReviewMaxNum() {
		return mapper.getReviewMaxNum();
	}

	// 리뷰 쓰기
	public int WriteReview(int max_review_num, int user_num, int pd_num, float score, String subject,
			String content) {
		return mapper.WriteReview(max_review_num, user_num, pd_num, score, subject, content);
	}

	public int getProductListCount(String pd_type, String sort_type, String search, String searchType) {
		return mapper.getProductListCount(pd_type, sort_type, search, searchType);
	}

	public ArrayList<ProductVO> ProductList(String pd_type, String sort_type, PageInfo pageInfo, String search, String searchType) {
		System.out.println(pd_type);
		System.out.println(search);
		System.out.println(searchType);
		return mapper.getProductList(pd_type, sort_type, pageInfo, search, searchType);
	}

	public ProductVO getProduct(int pd_num) {
		return mapper.getProduct(pd_num);
	}

	public int getReviewListCount(String sId) {
		return mapper.getReviewListCount(sId);
	}

	public ArrayList<ReviewVO> getReviewList(String sId, PageInfo pageInfo) {
		return mapper.getReviewList(sId, pageInfo);
	}

	public int deleteMyReview(int review_num) {
		return mapper.deleteMyReview(review_num);
	}

	public ReviewVO getReviewDetail(int review_num) {
		return mapper.getReviewDetail(review_num);
	}

	public int modifyReview(float score, String subject, String content, int review_num) {
		return mapper.modifyReview(score, subject, content, review_num);
	}

	public int CartOn(int pd_num, String sId, int quantity) {
		return mapper.cartOn(pd_num, sId, quantity);
	}

	public int existInterest(int pd_num, String sId) {
		return mapper.existInterest(pd_num, sId);
	}
	
	public int InterestOn(int pd_num, String sId) {
		return mapper.InterestOn(pd_num, sId);
	}

	public ArrayList<ProductVO> ProductCountRank() {
		return mapper.ProductCountRank();
	}
	
public ArrayList<ProductVO> cartList(String sId) {
		
		return mapper.cartList(sId);
	}

	public ArrayList<ProductVO> InterList(String sId) {
		
		return mapper.InterList(sId);
	
	}

	public int cartDel(String sId, int pd_num) {
		return mapper.cartDel(sId,pd_num);
	}

	public int InterDel(String sId, int pd_num) {
		return mapper.InterDel(sId,pd_num);
	}

	public int cartChan(String sId, int pd_num, int quan) {
		return mapper.cartChan(sId,pd_num,quan);
	}

	public int getUserPoints(String sId) {
		return mapper.getUserPoints(sId);
		
	}

	public int insertOrd(String pd_nums, String sId, int point, int totalPrice,int ord_num) {
		
		return mapper.insertOrd(pd_nums,sId,point,totalPrice,ord_num);
	}

	public int insertOrddetail(int ord_num,String split_pd_nums, String sId, int point, int totalPrice) {
	
		return mapper.insertOrddetail(ord_num,split_pd_nums,sId,point,totalPrice);
	}

	public int getOrderNum(String sId) {
		return mapper.getOrderNum(sId);
	}

	public int updateProduct(String split_pd_nums, String sId) {
		
		return mapper.updateProduct(split_pd_nums,sId);	
		}

	public int deleteCart(String sId, String split_pd_nums) {
		return mapper.deleteCart(split_pd_nums,sId);
	}

	public int updateUser(int totalPrice, int point, int user_num) {
		return mapper.updateUser(totalPrice,point,user_num);
	}

	public int getUserNum(String sId) {
		return mapper.getUserNum(sId);
	}

	public int existCart(int pd_num, String sId) {
		return mapper.existCart(pd_num, sId);
	}

	public int addCartQuan(int pd_num, String sId, int quantity) {
		return mapper.addCartQuan(pd_num, sId, quantity);
	}
	
	// 비공개 공개 qna 리스트 카운트
	public int getQnaListCount(String qap, String sId) {
		
		return mapper.getQnaListCount(qap, sId);
	}
	// 비공개 공개 qna 리스트
	public ArrayList<QnaVO> getQnaList(String qap, String sId, PageInfo qnaPageInfo) {
		return mapper.getQnaList(qap,sId,qnaPageInfo);
	}
	// qna 디테일
	public QnaVO getQnaDetail(int qna_num) {
		return mapper.getQnaDetail(qna_num);
	}
	// qna_type 이 상품일때 선택할 상품 페이징
	public int getSelectProductCount(String productObject) {
		return mapper.getSelectProductCount(productObject);
	}
	// qna_type 이 상품일때 선택할 상품 리스트
	public ArrayList<ProductVO> getSelectProductList(String productObject, PageInfo qnaPageInfo) {
		
		return mapper.getSelectProductList(productObject,qnaPageInfo);
	}
	// qna 글쓰기
	public int qnaInsert(QnaVO qna) {
		return mapper.qnaInsert(qna);
	}
	

	public int UserAuthenLoginCheck(String sId,String passwd) {
		return mapper.UserAuthenLoginCheck(sId,passwd);
	}

	public int MyInfoModifyPro(String sId, String name, String passwd, int address_code,
			String address, String phone) {
		return mapper.MyInfoModifyPro(sId,name,passwd,address_code,address,phone);
	}

	public UserVO userInfoChecked(String sId) {
		return mapper.userInfoChecked(sId);
	}
	
	public int MyInfoDelPro(String sId) {
		return mapper.MyInfoDelPro(sId);
	}


	
}
