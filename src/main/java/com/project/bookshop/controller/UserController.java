package com.project.bookshop.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.bookshop.service.UserService;
import com.project.bookshop.vo.OrdDetailVO;
import com.project.bookshop.vo.OrdVO;
import com.project.bookshop.vo.PageInfo;
import com.project.bookshop.vo.ProductVO;
import com.project.bookshop.vo.QnaVO;
import com.project.bookshop.vo.ReviewVO;
import com.project.bookshop.vo.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserService service;
	
	// 로그인 페이지로 이동
	@RequestMapping(value = "/UserLogin.us", method = RequestMethod.GET)
	public String LoginForm() {
		return "user/user_login";
	}

	// 로그인 기능 수행
	@RequestMapping(value = "/UserLoginPro.us", method = RequestMethod.POST)
	public String LoginPro(UserVO user, HttpSession session, Model model) {
		UserVO userResult = service.loginUser(user);
		if(userResult == null) {
			model.addAttribute("msg", "로그인 실패!");
			return "fail_back";
		} else {
			session.setAttribute("sId", userResult.getUser_email());
			session.setAttribute("sName", userResult.getUser_name());
			return "redirect:/";			
		}
	}
	
	// 로그아웃 수행
	@RequestMapping(value = "/UserLogoutPro.us", method = RequestMethod.GET)
	public String LogoutPro(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/";
	}
	
	// 회원가입 약관으로 이동 수행
		@RequestMapping(value = "/UserTerms.us", method = RequestMethod.GET)
		public String UserTerms() {
			
			return "user/user_terms";
		}
		
		// 회원가입 약관으로 이동 수행
		@RequestMapping(value = "/UserJoin.us", method = RequestMethod.GET)
		public String UserJoinForm() {
			
			return "user/user_join";
		}
		
		// 회원가입 수행
		@RequestMapping(value = "/UserJoinPro.us", method = RequestMethod.POST)
		public String UserJoinPro(UserVO user, String user_email2, String user_jumin2, Model model) {
			Integer user_max_num = service.userMaxNum();
			if(user_max_num == null) {
				user_max_num = 1;
			} else {
				user_max_num += 1;
			}
			user.setUser_num(user_max_num);
			user.setUser_email(user.getUser_email()+'@'+user_email2);
			user.setUser_jumin(user.getUser_jumin()+'-'+user_jumin2);
			boolean isJoinSuccess = service.joinUser(user);
			
			if(!isJoinSuccess) {
				model.addAttribute("msg", "회원가입 실패!");
				return "fail_back";
			} else {
				return "redirect:/";
			}
		}
		// 이메일 중복확인 폼으로 이동
		@RequestMapping(value = "/UserCheckIdForm.us", method = RequestMethod.GET)
		public String UserCheckIdForm() {
			return "user/user_check_id";
		}
		
		// 이메일 중복확인 체크 작동
		@RequestMapping(value = "/CheckDuplicateId.us", method = RequestMethod.GET)
		public String CheckDuplicateId(String user_email, String user_email2) {
			
			UserVO user = service.checkDuplicateId(user_email + '@' + user_email2);

			boolean isDuplicate = false;
			if(user != null) {
				isDuplicate = true;
			}
			return "redirect:/UserCheckIdForm.us?user_email=" + user_email + '@' + user_email2 + "&isDuplicate=" + isDuplicate;
		}
	
	
	// 상품의 상세 정보를 가져오는 UserProductDetail()
	@RequestMapping(value = "/UserProductDetail.us", method = RequestMethod.GET)
	public String UserProductDetail(
										@RequestParam(defaultValue = "review")String type,
										@RequestParam(defaultValue = "1")int reviewQnaPageNum,
										@RequestParam(defaultValue = "1")int pd_num,
										Model model){
		System.out.println(type);
		PageInfo pageInfo = null;
		int listLimit = 5;
		int pageLimit = 10;
		if(type.equals("review")) {
			int listCount= service.getReviewCount(pd_num);
			int maxPage = (int)Math.ceil((double)listCount / listLimit);
			int startPage = ((int)((double)reviewQnaPageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
			int endPage = startPage + pageLimit - 1;
			if(endPage > maxPage) {
				endPage = maxPage;
			}
			int startRow = (reviewQnaPageNum - 1) * listLimit;
			pageInfo = new PageInfo(reviewQnaPageNum, maxPage, startPage, endPage, listCount, startRow, listLimit);
			ArrayList<ReviewVO> reviewList = service.getPdReviewList(pd_num, pageInfo);
			model.addAttribute("pageInfo", pageInfo);
			model.addAttribute("reviewList", reviewList);
		}else {
			int listCount= service.getQnaCount(pd_num);
			int maxPage = (int)Math.ceil((double)listCount / listLimit);
			int startPage = ((int)((double)reviewQnaPageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
			int endPage = startPage + pageLimit - 1;
			if(endPage > maxPage) {
				endPage = maxPage;
			}
			int startRow = (reviewQnaPageNum - 1) * listLimit;
			pageInfo = new PageInfo(reviewQnaPageNum, maxPage, startPage, endPage, listCount, startRow, listLimit);
			ArrayList<QnaVO> qnaList = service.getPdQnaList(pd_num, pageInfo);
			model.addAttribute("pageInfo", pageInfo);
			model.addAttribute("qnaList", qnaList);
		}
		model.addAttribute("type", type);
		ProductVO product = service.getProduct(pd_num);
		model.addAttribute("product", product);
		
		return "product/user_product_detail";
	}
	
	// 아이디 찾기 페이지로 이동
	@RequestMapping(value = "/UserForgetId.us", method = RequestMethod.GET)
	public String UserForgetId() {
		return "user/user_forgetId"; 
	}
	
	// 비밀번호 찾기 페이지로 이동
	@RequestMapping(value = "/UserForgetPw.us", method = RequestMethod.GET)
	public String UserForgetPw() {
		return "user/user_forgetPw";
	}
	
	// 아이디 찾기 기능 수행
	@RequestMapping(value = "/UserFindId.us", method = RequestMethod.POST)
	public String UserFindId(String name, String jumin1, String jumin2, Model model) {
		
		UserVO user = service.getUserEmail(name, jumin1+'-'+jumin2);
		if(user == null) {
			model.addAttribute("msg", "아이디를 찾을 수 없습니다!");
			return "fail_back";
		} else {
			model.addAttribute("user", user);
			System.out.println(user);

			return "user/user_findId";
		}
	}
	
	// 비밀번호 찾기 기능 수행
	@RequestMapping(value = "/UserFindPw.us", method = RequestMethod.POST)
	public String UserFindPw(String email, String jumin1, String jumin2, Model model) {
		UserVO user = service.getUserPasswd(email, jumin1+'-'+jumin2);
		
		if(user == null) {
			model.addAttribute("msg", "비밀번호를 찾을 수 없습니다!");
			return "fail_back";
		} else {
			model.addAttribute("user",user);
			System.out.println(user);
			
			return "user/user_findPw";
		}
	}
	
	
	// 상품 배송 조회 관련 MyOrder
	@RequestMapping(value = "/MyOrder.us", method = RequestMethod.GET)
	public String MyOrder(@RequestParam(defaultValue = "")String sId, 
			String startday, String endday, Model model) {
		ArrayList<OrdVO> ordlist = new ArrayList<OrdVO>();
		if(startday==null || endday==null || startday.isEmpty() || endday.isEmpty()) {
			ordlist = service.myOrder(sId);	
			model.addAttribute("ordlist",ordlist);
		}else {
			ordlist = service.myOrderSearchDate(sId, startday, endday);
			model.addAttribute("ordlist", ordlist);
			model.addAttribute("startday", startday);
			model.addAttribute("endday", endday);
		}
		
		return "order/user_my_order";
	}
	
	// 상품 배송 상세히 조회 관련 MyOrderDetail
	@RequestMapping(value = "/MyOrderDetail.us", method = RequestMethod.GET)
	public String MyOrderDetail(@RequestParam(defaultValue = "0")int order_num, Model model) {
		
		ArrayList<OrdDetailVO> ordDetaillist = service.myOrderDetail(order_num);

		model.addAttribute("ordDetaillist", ordDetaillist);
		
		return "order/user_my_order_detail";
	}

	// 상품 배송 조회 관련 MyOrder
	@RequestMapping(value = "/MyOrderCancel.us", method = RequestMethod.GET)
	public String MyOrderCancel(@RequestParam(defaultValue = "")String sId, @RequestParam(defaultValue = "0")int order_num, Model model) {
		
		int cancelCount = service.myOrderCancel(order_num);
		
		if(cancelCount==0) {
			model.addAttribute("msg", "주문 취소 실패!");
			return "fail_back";
		} else {// 주문 취소 성공시 마일리지 차단
			OrdVO ord = service.getOrder(order_num);
			cancelCount = service.userOrderCancel(ord);
			if(cancelCount==0) {
				model.addAttribute("msg", "주문 취소는 성공했으나 마일리지 감소 실패! - 1");
				return "fail_back";
			}
			ArrayList<OrdDetailVO> ordDetaillist = service.myOrderDetailList(order_num);
			for(OrdDetailVO ordDetail : ordDetaillist) {
				cancelCount = service.orderDetailOrderCancel(ordDetail);
				if(cancelCount==0) {
					model.addAttribute("msg", "주문 취소는 성공했으나 마일리지 감소 실패! - 2");
					return "fail_back";
				}
			}
			
			return "redirect:/OrderCancelRefundView.us?sId=" + sId + "&order_num=" + order_num;
		}
	}
	
	// 상품 배송 상세히 조회 관련 MyOrderDetail
	@RequestMapping(value = "/OrderCancelRefundView.us", method = RequestMethod.GET)
	public String OrderCancelRefundView(@RequestParam(defaultValue = "")String sId, @RequestParam(defaultValue = "0")int order_num, Model model) {
		ArrayList<OrdVO> list = service.MyOrderCancelRefundView(order_num);

		model.addAttribute("list", list);
		
		return "order/user_my_order_suc_cancel";
	}

	// 상품 배송 리뷰 쓰기 Form으로 가는 WriteReviewForm
	@RequestMapping(value = "/WriteReviewForm.us", method = RequestMethod.GET)
	public String WriteReviewForm() {
		
		return "review/user_write_review_form";
	}
	
	
	// 상품 배송 리뷰 쓰기 Form으로 가는 WriteReviewForm
	@RequestMapping(value = "/WriteReviewPro.us", method = RequestMethod.GET)
	public String WriteReviewPro(@RequestParam(defaultValue = "")String sId, @RequestParam(defaultValue = "0")int pd_num, @RequestParam(defaultValue = "0")float score,
			@RequestParam(defaultValue = "")String subject, @RequestParam(defaultValue = "")String content, Model model) {

		UserVO user = service.sIdToUserVO(sId);
		ReviewVO review = service.getReviewVO(user.getUser_num(), pd_num);
		
		if(review != null) {
			model.addAttribute("msg", "이미 리뷰를 작성한 상품입니다!");
			return "fail_back";
		} else {
			Integer max_review_num = service.getReviewMaxNum();
			if(max_review_num == null) 
				max_review_num = 1; 
			else
				max_review_num += 1;
			
			int insertCount = service.WriteReview(max_review_num, user.getUser_num(), pd_num, score, subject, content);
			
			if(insertCount == 0) {
				model.addAttribute("msg", "리뷰등록 실패!");
				return "fail_back";
			} else {
				model.addAttribute("msg", "리뷰등록 성공!");
				return "alert_close";
			}
		}
	}
	
	@RequestMapping(value = "/UserSearchProductList.us", method = RequestMethod.GET)
	public String UserSearchProductList(
			@RequestParam(defaultValue = "last")String sort_type, 
			@RequestParam(defaultValue = "all")String pd_type,
			@RequestParam(defaultValue = "")String searchType){

		return "product/user_product_list";
	} 
	
	// 상품 리스트 가져오기(무한스크롤 페이징처리)
	@RequestMapping(value = "/UserProductListPro.us", method = RequestMethod.GET)
	public String UserProductListPro(
		@RequestParam(defaultValue = "last")String sort_type,
		@RequestParam(defaultValue = "all")String pd_type, 
		@RequestParam(defaultValue = "")String search,
		@RequestParam(defaultValue = "")String searchType,
		@RequestParam(defaultValue = "1")int pageNum, Model model) {
		
		int listLimit = 7;
		int pageLimit = 10;

		System.out.println(pageNum);
		
		int listCount= service.getProductListCount(pd_type, sort_type, '%'+search+'%', searchType);
		
		
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
	   
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		int startRow = (pageNum - 1) * listLimit;
		PageInfo pageInfo = new PageInfo(pageNum, maxPage, startPage, endPage, listCount, startRow, listLimit);
		
		ArrayList<ProductVO> productList = service.ProductList(pd_type,sort_type,pageInfo, '%' + search + '%', searchType);
		
		model.addAttribute("pd_type", pd_type);
		model.addAttribute("sort_type", sort_type);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("productList", productList);
		
		return "product/user_product_getlist";
	}
	
	// 상품의 상세 페이지에서 선택한 상품과 수량정보를 장바구니에 담기 위한 CartOn.us 
	@RequestMapping(value = "/CartOn.us", method = RequestMethod.GET)
	public String CartOn(
			@RequestParam(defaultValue="")int pd_num,
			@RequestParam(defaultValue="")String sId,
			@RequestParam(defaultValue="")int quantity,
			Model model
			) {
		int existCart = service.existCart(pd_num, sId);
		int insertCount = 0;
		
		if(existCart > 0) {
			insertCount = service.addCartQuan(pd_num, sId, quantity);
		}
		else {
			insertCount = service.CartOn(pd_num, sId, quantity);
		}
		
		if(insertCount == 0) {
			model.addAttribute("msg","장바구니 담기 실패!");
			return "fail_back";
		}
		else {
			model.addAttribute("msg","선택하신 상품을 장바구니에 담았습니다!");
			return "fail_back";
		}

	}
	
	// 상품이 담긴 장바구니 화면을 보여줌
		@RequestMapping(value = "/MyCart.us",method = RequestMethod.GET)
		public String MyCart(
				@RequestParam(defaultValue="")String sId,
				Model model)
				{

			ArrayList<ProductVO> cart = service.cartList(sId);
			
			model.addAttribute("cartList", cart);
		
			return "/cart/user_my_cart";
			
		}
		
		// 장바구니 삭제
		@RequestMapping(value = "/MyCartDel.us",method = RequestMethod.GET)
		public String MyCartDel(
				@RequestParam(defaultValue="")String sId,
				@RequestParam(defaultValue="")int pd_num,
				Model model)
				{
			int deleteCount = service.cartDel(sId,pd_num);
			
			if(deleteCount == 0) {
				model.addAttribute("msg", "카트 상품 삭제 실패!");
				return "fail_back";
			}
			
			return "redirect:/MyCart.us?sId=" + sId;
		}
		
		// 장바구니 수정
			@RequestMapping(value = "/CartQuanChange.us",method = RequestMethod.GET)
			public String CartChan(
					@RequestParam(defaultValue="")String sId,
					@RequestParam(defaultValue="")int pd_num,
					@RequestParam(defaultValue="")int quan,
					Model model)
					{

				int changeCount = service.cartChan(sId,pd_num,quan);
				
				if(changeCount == 0) {
					model.addAttribute("msg", "카트 수정 실패!");
					return "fail_back";
				}
				
				return "redirect:/MyCart.us?sId=" + sId;
			}
		

		// 상품이 담긴 찜 화면을 보여줌
		@RequestMapping(value = "/MyInter.us",method = RequestMethod.GET)
		public String MyInter(
				@RequestParam(defaultValue="")String sId,
				Model model)
				{

			ArrayList<ProductVO> list = service.InterList(sId);
			
			model.addAttribute("list", list);
		
			return "/interest/user_my_interest";
			
		}// 찜 삭제
		@RequestMapping(value = "/DeleteInterest.us",method = RequestMethod.GET)
		public String MyInterDel(
				@RequestParam(defaultValue="")String sId,
				@RequestParam(defaultValue="")int pd_num,
				Model model)
				{

			int deleteCount = service.InterDel(sId,pd_num);
			
			if(deleteCount == 0) {
				model.addAttribute("msg", "찜 상품 삭제 실패!");
				return "fail_back";
			}
			
			return "redirect:/MyInter.us?sId=" + sId;
		}
	
	
	// 상품의 상세 페이지에서 선택한 상품을 찜목록에 담기 위한 InterestOn.us
	@RequestMapping(value = "/InterestOn.us", method = RequestMethod.GET)
	public String InterestOn(
			@RequestParam(defaultValue="")int pd_num,
			@RequestParam(defaultValue="")String sId,
			Model model
			) {
		
		int existInterest = service.existInterest(pd_num, sId);
		if(existInterest !=0) {
			model.addAttribute("msg","이미 찜목록에 해당 상품이 존재합니다!");
			return "fail_back";
		}
		
		int insertCount = service.InterestOn(pd_num, sId);

		if(insertCount == 0) {
				model.addAttribute("msg","찜목록 담기 실패!");
				return "fail_back";
		}
		else {
				model.addAttribute("msg","선택하신 상품을 찜목록에 추가했습니다!");
				return "fail_back";
		}

	}

	
	// 내 리뷰관리를 위한 내 리뷰 리스트를 가져오는 Myreview()
	@RequestMapping(value = "/MyReview.us", method = RequestMethod.GET)
	public String MyReview(@RequestParam(defaultValue="")String sId,
			@RequestParam(defaultValue = "1")int pageNum,
			Model model) {
		
		int listLimit = 10;
		int pageLimit = 10;
		int listCount = service.getReviewListCount(sId);
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		int startPage = ((int)((double)pageNum / pageLimit + 0.9) - 1) * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
	   
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		int startRow = (pageNum - 1) * listLimit;
		PageInfo pageInfo = new PageInfo(pageNum, maxPage, startPage, endPage, listCount, startRow, listLimit);
		
		
		ArrayList<ReviewVO> reviewList = service.getReviewList(sId, pageInfo);

		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "/review/user_my_review";
	}
	
	// 내 리뷰관리(삭제) 를 수행하는 DeleteMyReview()
	@RequestMapping(value= "/DeleteMyReview.us", method = RequestMethod.GET)
	public String DeleteMyReview(
			@RequestParam(defaultValue="")int review_num,
			@RequestParam(defaultValue="")String sId,
			Model model
			) {
		
		int deleteCount = service.deleteMyReview(review_num);
		
		if(deleteCount == 0) {
			model.addAttribute("msg", "리뷰 삭제 실패!");
			return "fail_back";
		}
		
		return "redirect:/MyReview.us?sId=" + sId;
	}
	
	
	
	// 내 리뷰관리(수정) 을 위한 기존 리뷰 정보를 가져오는 ModifyMyReviewForm
	@RequestMapping(value= "/ModifyMyReviewForm.us", method = RequestMethod.GET)
	public String ModifyMyReviewForm(
			@RequestParam(defaultValue="")int review_num,
			@RequestParam(defaultValue="")String pd_subject,
			Model model
			) {
		
		ReviewVO review = service.getReviewDetail(review_num);
		
		model.addAttribute("review",review);
		
		return "review/user_modify_review_form";
	}
	
	
	// 내 리뷰관리(수정) 을 수행하는 ModifyMyReviewPro
	@RequestMapping(value="/ModifyMyReviewPro.us", method = RequestMethod.GET)
	public String ModifyMyReviewPro(
			@RequestParam(defaultValue="")float score,
			@RequestParam(defaultValue="")String subject,
			@RequestParam(defaultValue="")String content,
			@RequestParam(defaultValue="")int review_num,
			@RequestParam(defaultValue="")String pd_subject,
			Model model
			) {
		System.out.println(score + " " + subject + " " + content + " " + review_num);
		
		int updateCount = service.modifyReview(score, subject, content, review_num);
		
		if(updateCount == 0) {
			model.addAttribute("msg", "리뷰 수정 실패!");
			return "fail_back";
		}
		else {
			model.addAttribute("msg", "리뷰가 정상적으로 수정되었습니다!");
			return "alert_close";
		}
	}
	
	// 카트 수량으로 결제 하기
		@RequestMapping(value="/CartToPayment.us", method = RequestMethod.GET)
		public String CartToPayment(
				@RequestParam(defaultValue="")String sId,
				Model model
				){
		
			int userpoint = service.getUserPoints(sId);
			//cart리스트 조회시 사용한 서비스 재활용
			ArrayList<ProductVO> cart = service.cartList(sId);

			model.addAttribute("cartList", cart);
			model.addAttribute("userPoint", userpoint);

			
			return "payment/payment";
			}
		
		//결제 수행후 결제 정보를 각각의 테이블에 적용시키는 모든 메서드
		@RequestMapping(value= "/PaymentResult.us", method = RequestMethod.GET)
		public String insertOrd(
				@RequestParam(defaultValue="")String sId,
				@RequestParam(defaultValue="")String pd_nums,
				@RequestParam(defaultValue="0")int point,
				@RequestParam(defaultValue="0")int totalPrice,
				Model model
				) {
			System.out.println(1);
			System.out.println(sId);
			System.out.println(2);
			int insertCount2 = 0;
			int updateCount=0;
			int updateCount2=0;
			int	deleteCount=0;
			
			String[] split_pd_nums = pd_nums.split(",");
			int ord_num  = service.getOrderNum(sId);
			int user_num = service.getUserNum(sId);
			int insertCount = service.insertOrd(pd_nums,sId,point,totalPrice,ord_num);
			if(insertCount > 0 ) {
				for(int i=0; i<split_pd_nums.length; i++) {
				insertCount2 =  service.insertOrddetail(ord_num,split_pd_nums[i],sId,point,totalPrice);
				}
				for(int i=0; i<split_pd_nums.length; i++) {
				updateCount =  service.updateProduct(split_pd_nums[i],sId);
				}
				for(int i=0; i<split_pd_nums.length; i++) {
				deleteCount = service.deleteCart(sId,split_pd_nums[i]);
						}
				if(deleteCount > 0) {
					updateCount2 = service.updateUser(totalPrice,point,user_num);
				}
			}

			
			return "redirect:/";
		}
		
		
		// 고객센터 이동
		@RequestMapping(value = "/CustomerSupporter.us", method = RequestMethod.GET)
		public String CustomerSupporter() {
			
			
			return "qna/user_customersupporter";
		}
		// ajax 사용 qnaList(public, private)
		@RequestMapping(value = "/QnaGetList.us", method = RequestMethod.POST)
		public String QnaGetList(String qap,
				@RequestParam(defaultValue = "1") int qnaPageNum,
				String sId,
				Model model) {
			
			if(qap == null || qap == "") {
				qap = "public";
			}
			int listLimit = 5;
			int qnaPageLimit = 10;
			int listCount = service.getQnaListCount(qap,sId);
			int maxqnaPage = (int)Math.ceil((double)listCount / listLimit);
			int startqnaPage = ((int)((double)qnaPageNum / qnaPageLimit + 0.9) - 1) * qnaPageLimit + 1;
			int endqnaPage = startqnaPage + qnaPageLimit - 1;
			
			int startRow = (qnaPageNum - 1) * listLimit;
			
			if(endqnaPage > maxqnaPage) {
				endqnaPage = maxqnaPage;
			}
			PageInfo qnaPageInfo = new PageInfo(qnaPageNum, maxqnaPage, startqnaPage, endqnaPage, listCount, startRow, listLimit);
			ArrayList<QnaVO> list = service.getQnaList(qap, sId, qnaPageInfo);
			model.addAttribute("qnaPageInfo", qnaPageInfo);
			model.addAttribute("qna_accesspermission", qap);
			model.addAttribute("qnaList", list);
			return "qna/user_qna_getlist";
		}
		
		// qna 디테일
		@RequestMapping(value = "/UserQnaDetail.us",method = RequestMethod.GET)
		public String QnaDetail(int qna_num, Model model) {
			
			QnaVO qna = service.getQnaDetail(qna_num);
			
			model.addAttribute("qna", qna);
			
			return "qna/user_qna_detail";
		}
		
		// qna write폼 이동
		@RequestMapping(value = "/QnaWrite.us", method = RequestMethod.GET)
		public String QnaWriteForm() {
			
			
			return "qna/user_qna_write_form";
		}
		
		// qna_type 이 상품일때 고를 상품 선택
		@RequestMapping(value = "/UserQnaSelectProduct.us", method = RequestMethod.GET)
		public String UserQnaSelectProduct(Model model,
				@RequestParam(defaultValue = "") String productObject,
				@RequestParam(defaultValue = "1") int qnaPageNum) {
			String productObject2 = productObject;
			
			if(productObject == null || productObject == "") {
				productObject = "%%";
			}else {
				productObject = '%'+productObject+'%';
			}
			System.out.println(productObject);
			int listLimit = 12;
			int qnaPageLimit = 10;
			int listCount = service.getSelectProductCount(productObject);
			int maxqnaPage = (int)Math.ceil((double)listCount / listLimit);
			int startqnaPage = ((int)((double)qnaPageNum / qnaPageLimit + 0.9) - 1) * qnaPageLimit + 1;
			int endqnaPage = startqnaPage + qnaPageLimit - 1;
		   
			int startRow = (qnaPageNum - 1) * listLimit;
			
			if(endqnaPage > maxqnaPage) {
				endqnaPage = maxqnaPage;
			}
			PageInfo qnaPageInfo = new PageInfo(qnaPageNum, maxqnaPage, startqnaPage, endqnaPage, listCount, startRow, listLimit);
			ArrayList<ProductVO> list = service.getSelectProductList(productObject, qnaPageInfo);
			
			model.addAttribute("qnaPageInfo", qnaPageInfo);
			model.addAttribute("productObject2", productObject2);
			model.addAttribute("productList", list);
			return "qna/user_qna_selectproduct";
		}
		
		// qna 글쓰기 작업 진행
		@RequestMapping(value = "/QnaWritePro.us", method = RequestMethod.POST)
		public String QnaWritePro(QnaVO qna) {
			System.out.println(qna);
			int qnaInsertCount = service.qnaInsert(qna);
			
			if(qnaInsertCount == 0) { 
				return "redirect:/fail_back";
			}
			
			return "redirect:/CustomerSupporter.us";
		}
		
	// Popup 페이지를 띄우는 Popup.us
	@RequestMapping(value = "/Popup.us", method = RequestMethod.GET)
	public String Popup() {
		return "main/popup";
	}
	
	// popup 창 check 시 쿠키를 생성하는 MakeCookie
	@RequestMapping(value = "/MakeCookie.us", method = RequestMethod.GET)
	public String MakeCookie() {
		return "main/makeCookie";
	}
	
	// 마이페이지 클릭 => 
	
	@RequestMapping(value = "/UserAuthen.us", method = RequestMethod.GET)
	public String UserAuthen(String sId) {
		
		return "user/user_login_for_mod";
	}
	
	@RequestMapping(value = "/MyPage.us", method = RequestMethod.GET)
	public String UserAuthenLoginCheck(String sId,String passwd,Model model) {
		System.out.println(sId);
		System.out.println(passwd);
		int userCheckCount = service.UserAuthenLoginCheck(sId,passwd);
		
		if(userCheckCount == 1) {
		UserVO user = service.userInfoChecked(sId);
		System.out.println(user);
		model.addAttribute("user", user);
		}else {
			model.addAttribute("msg", "로그인 실패!");
			return "fail_back";
		}
		return "user/my_page";
		
	}
	@RequestMapping(value = "/MyInfoModPro.us", method = RequestMethod.GET)
	public String MyInfoModPro(@RequestParam(defaultValue="")String sId,
			@RequestParam(defaultValue="")String name,
			@RequestParam(defaultValue="")String passwd,
			@RequestParam(defaultValue="")int address_code,
			@RequestParam(defaultValue="")String address,
			@RequestParam(defaultValue="")String phone,
			Model model) {
			int updateCount = service.MyInfoModifyPro(sId,name,passwd,address_code,address,phone);
			
			if(updateCount == 1) {
				UserVO user = service.userInfoChecked(sId);
				System.out.println(user);
				model.addAttribute("user", user);		
			}else{
			model.addAttribute("msg", "로그인 실패!");
			return "fail_back";	
	}
			return "user/my_page";
	}
	
	@RequestMapping(value = "/MyInfoDel.us", method = RequestMethod.GET)
	public String MyInfoDel() {
	
		return "user/user_del_terms";
	}
	
	@RequestMapping(value = "/MyInfoDelPro.us", method = RequestMethod.GET)
	public String MyInfoDelPro(String sId) {
		
		int isDeleteOk = service.MyInfoDelPro(sId);
	
		return "main/main";
	}	
	
}
