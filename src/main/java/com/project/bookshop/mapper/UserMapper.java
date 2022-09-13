package com.project.bookshop.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.project.bookshop.vo.OrdDetailVO;
import com.project.bookshop.vo.OrdVO;
import com.project.bookshop.vo.PageInfo;
import com.project.bookshop.vo.ProductVO;
import com.project.bookshop.vo.QnaVO;
import com.project.bookshop.vo.ReviewVO;
import com.project.bookshop.vo.UserVO;

public interface UserMapper {

	// 로그인 기능 수행 시 유저 컬럼들 들고 오기
	UserVO loginUser(UserVO user);

	
	// 회원가입 기능 수행 시 유저 입력
	boolean joinUser(UserVO user);
	// 만들어진 이메일 전체 갯수
	Integer userMaxNum();
	// 이메일 중복 체크
	UserVO selectDuplicateId(@Param("user_email")String user_email);

	// 상품 번호를 이용해 해당 리뷰 전체 들고 오기
	ArrayList<ReviewVO> getPdReviewList(@Param(value = "pd_num")int pd_num,@Param("pageInfo")PageInfo pageInfo);

	// 상품 번호를 이용해 QnA 전체 들고 오기
	ArrayList<QnaVO> getPdQnaList(@Param(value = "pd_num")int pd_num,@Param("pageInfo")PageInfo pageInfo);

	// 상품 번호를 이용해 상품에 관련된 리뷰 갯수 들고 오기 
	int getReivewCount(int pd_num);

	// 상품 번호를 이용해 상품에 관련된 QnA 갯수 들고 오기 
	int getQnaCount(int pd_num);

	// 이름과 주민번호를 이용해 UserVO 들고 오기
	UserVO getUserEmail(@Param("name")String name, @Param("jumin")String jumin);

	// 아이디(이메일)과 주민번호를 이용해 UserVO 들고 오기
	UserVO getUserPasswd(@Param("email")String email, @Param("jumin")String jumin);

	// 내가 주문한 상품 전체 들고 오기
	ArrayList<OrdVO> myOrder(@Param("sId")String sId);

	// 내가 주문한 상품 날짜별로 검색해서 들고 오기
	ArrayList<OrdVO> myOrderSearchDate(@Param("sId")String sId, @Param("startday")String startday, @Param("endday")String endday);

	// 주문 번호를 이용해서 한번에 구매한 상품들 들고 오기
	ArrayList<OrdDetailVO> myOrderDetail(@Param("order_num")int order_num);

	// 주문 번호를 이용해서 주문 취소 시키기
	int myOrderCancel(@Param("order_num")int order_num);

	// 취소하면 ord 찾아서 감소 시키기 위해 필요한 OrdVO 데이터 4개 들고 오기
	OrdVO selectOrder(@Param("order_num")int order_num);

	// 주문을 하나 들고와서 취소하면 마일리지와 돈 돌려 주기
	int userOrderCancel(@Param("ord")OrdVO ord);

	// 주문 번호를 이용해서 내가 주문한 상품들 자세히 가져오기
	ArrayList<OrdDetailVO> myOrderDetailList(@Param("order_num")int order_num);

	// 자세히본 상품을 가져와서 주문 취소 시키기
	int orderDetailOrderCancel(@Param("ordDetail")OrdDetailVO ordDetail);

	// 주문 번호를 이용해서 주문 목록 전체 들고 오기
	ArrayList<OrdVO> MyOrderCancelRefundView(@Param("order_num")int order_num);

	// sId를 이용해여 내정보 가져오기
	UserVO sIdToUserVO(@Param("sId")String sId);

	// 자신 번호와 상품번호를 이용해서 리뷰 들고 오기
	ReviewVO getReviewVO(@Param("user_num")int user_num, @Param("pd_num")int pd_num);

	// 리뷰 전체 갯수 들고 오기
	Integer getReviewMaxNum();

	// 리뷰 쓰기
	int WriteReview(@Param("max_review_num")int max_review_num, @Param("user_num")int user_num, @Param("pd_num")int pd_num, 
			@Param("score")float score, @Param("subject")String subject, @Param("content")String content);

	int getProductListCount(@Param("pd_type") String pd_type, @Param("sort_type")String sort_type, @Param("search")String search, @Param("searchType")String searchType);

	ArrayList<ProductVO> getProductList(@Param("pd_type") String pd_type, @Param("sort_type")String sort_type, 
			@Param("pageInfo")PageInfo pageInfo, @Param("search")String search, @Param("searchType")String searchType);

	ProductVO getProduct(@Param("pd_num")int pd_num);

	int getReviewListCount(@Param("sId")String sId);

	ArrayList<ReviewVO> getReviewList(@Param("sId")String sId, @Param("pageInfo")PageInfo pageInfo);

	int deleteMyReview(@Param("review_num")int review_num);

	ReviewVO getReviewDetail(@Param("review_num")int review_num);

	int modifyReview(@Param("score")float score, @Param("subject")String subject, @Param("content")String content, @Param("review_num")int review_num);

	int cartOn(@Param("pd_num")int pd_num, @Param("sId")String sId, @Param("quantity")int quantity);

	int existInterest(@Param("pd_num")int pd_num, @Param("sId")String sId);
	
	int InterestOn(@Param("pd_num")int pd_num, @Param("sId")String sId);

	ArrayList<ProductVO> ProductCountRank();
	
	ArrayList<ProductVO> cartList(@Param("sId")String sId);
	
	int getCartListCount(@Param("sId")String sId);
	
	ArrayList<ProductVO> InterList(@Param("sId")String sId);
	
	int cartDel(@Param("sId")String sId, @Param("pd_num")int pd_num);

	int InterDel(@Param("sId")String sId, @Param("pd_num")int pd_num);

	int cartChan(@Param("sId")String sId,@Param("pd_num")int pd_num, @Param("quan")int quan);

	int getUserPoints(@Param("sId")String sId);

	int insertOrd(@Param("pd_nums")String pd_nums, @Param("sId")String sId, @Param("point")int point, @Param("totalPrice")int totalPrice,@Param("ord_num")int ord_num);

	int insertOrddetail(@Param("ord_num")int ord_num,@Param("split_pd_nums")String split_pd_nums, @Param("sId")String sId, @Param("point")int point,@Param("totalPrice")int totalPrice);

	int getOrderNum(@Param("sId")String sId);

	int updateProduct(@Param("split_pd_nums")String split_pd_nums, @Param("sId")String sId);

	int deleteCart(@Param("split_pd_nums")String split_pd_nums, @Param("sId")String sId);

	int updateUser(@Param("totalPrice")int totalPrice, @Param("point")int point, @Param("user_num")int user_num);

	int getUserNum(@Param("sId")String sId);

	int existCart(@Param("pd_num")int pd_num, @Param("sId")String sId);

	int addCartQuan(@Param("pd_num")int pd_num, @Param("sId")String sId, @Param("quantity")int quantity);

	int userCheckCount(@Param("sId")String sId, @Param("passwd")String passwd);

	UserVO userCheckCount(@Param("sId")String sId);
	
	// 비공개 공개 qna 리스트 카운트
	int getQnaListCount(@Param(value = "qap")String qap, @Param(value = "sId") String sId);

	// 비공개 공개 qna 리스트
	ArrayList<QnaVO> getQnaList(@Param(value = "qap")String qap,@Param(value = "sId") String sId,
			@Param(value = "qnaPageInfo")PageInfo qnaPageInfo);

	// qna 디테일
	QnaVO getQnaDetail(@Param(value = "qna_num") int qna_num);

	// qna_type 이 상품일때 선택할 상품 페이징
	int getSelectProductCount(@Param(value = "productObject") String productObject);
	
	// qna_type 이 상품일때 선택할 상품 리스트
	ArrayList<ProductVO> getSelectProductList(@Param(value = "productObject") String productObject, 
			@Param(value = "qnaPageInfo")PageInfo qnaPageInfo);
	
	// qna 글쓰기
	int qnaInsert(QnaVO qna);
	
	int UserAuthenLoginCheck(@Param(value = "sId")String sId, @Param(value = "passwd")String passwd);


	UserVO userInfoChecked(@Param(value = "sId")String sId);


	int MyInfoModifyPro(@Param(value = "sId")String sId,
			@Param(value = "name")String name,
			@Param(value = "passwd")String passwd,
			@Param(value = "address_code")int address_code,
			@Param(value = "address")String address,
			@Param(value = "phone")String phone);

	int MyInfoDelPro(@Param("sId")String sId);

}
