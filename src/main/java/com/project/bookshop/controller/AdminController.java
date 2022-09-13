package com.project.bookshop.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.project.bookshop.service.AdminService;
import com.project.bookshop.vo.CenterAdVO;
import com.project.bookshop.vo.MainAdVO;
import com.project.bookshop.vo.OrdDetailVO;
import com.project.bookshop.vo.OrdVO;
import com.project.bookshop.vo.PageInfo;
import com.project.bookshop.vo.ProductVO;
import com.project.bookshop.vo.QnaVO;
import com.project.bookshop.vo.UserVO;

@Controller
public class AdminController {
	@Autowired
	private AdminService service;
	
	// 관리자 페이지로 이동
	@RequestMapping(value = "/AdminPage.ad", method = RequestMethod.GET)
	public String main(Model model) {
		List<UserVO> userCountList = service.getUserCount();
		List<OrdVO> salesList = service.getSales();
		int[] ordNoArr = service.OrderNoticeCount();
		int[] pdNoArr = service.ProductNoticeCount();
		int[] qnaNoArr = service.QnaNoticeCount();
		
		model.addAttribute("userCountList", userCountList);
		model.addAttribute("salesList", salesList);
		model.addAttribute("ordNoArr", ordNoArr);
		model.addAttribute("pdNoArr", pdNoArr);
		model.addAttribute("qnaNoArr", qnaNoArr);
		
		return "main/admin_main";
	}
	
	// 관리자페이지 중 주문관리 페이지로 이동
	@RequestMapping(value = "/OrderList.ad", method = RequestMethod.GET)
	public String orderManagement() {
		return "order/admin_order_list";
	}
	
	// 주문관리 페이지 안 검색결과 출력
	@RequestMapping(value = "/OrderGetList.ad", method = RequestMethod.GET)
	public String GetOrderManagement(@RequestParam(defaultValue = "") String order_status,
			@RequestParam(defaultValue = "2022-07-01") String start_date, String end_date,
			@RequestParam(defaultValue = "0") String min_price,
			@RequestParam(defaultValue = "99999999999999") String max_price,
			@RequestParam(defaultValue = "1") int ordPageNum, Model model) {
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formatedNow = now.format(formatter);
		if(end_date == "" || end_date == null) {
			end_date = formatedNow.toString();
		}
		
		// 페이징처리
		int ordListLimit = 10;
		int ordPageLimit = 10;
		int ordListCount = service.getOrderListCount(start_date, end_date, min_price, max_price, order_status);
		int maxOrdPage = (int)Math.ceil((double)ordListCount / ordListLimit);
		int startOrdPage = ((int)((double)ordPageNum / ordPageLimit + 0.9) - 1) * ordPageLimit + 1;
		int endOrdPage = startOrdPage + ordPageLimit - 1;
		if(endOrdPage > maxOrdPage) {
			endOrdPage = maxOrdPage;
		}
		
		int ordStartRow = (ordPageNum - 1) * ordListLimit;
		
		PageInfo ordPageInfo = new PageInfo(ordPageNum, maxOrdPage, startOrdPage, endOrdPage, ordListCount, ordStartRow, ordListLimit);
		
		List<OrdVO> orderList = service.getOrderList(start_date, end_date, min_price, max_price, order_status, ordPageInfo);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("ordPageInfo", ordPageInfo);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("min_price", min_price);
		model.addAttribute("max_price", max_price);
		model.addAttribute("order_status", order_status);
		
		return "order/admin_order_getlist";
	}
	
	// 주문상세 페이지로 이동
	@RequestMapping(value = "/OrderDetail.ad", method = RequestMethod.GET)
	public String orderDetail(@RequestParam String order_num, Model model) {
		List<OrdDetailVO> orderList = service.getOrderDetail(order_num);
		model.addAttribute("orderList", orderList);
		
		return "order/admin_order_detail";
	}
	
	// 주문처리
	@RequestMapping(value = "/OrderProcess.ad", method = RequestMethod.GET)
	public String orderProcess(@ModelAttribute OrdVO order, Model model) {
		int processCount = service.orderProcess(order);
		if(processCount == 0) {
			model.addAttribute("msg", "주문처리를 실패했습니다.");
			return "fail_back";
		} else {
			return "redirect:/OrderList.ad?order_status=all";		
		}
	} 
	
	// 상품관리 페이지로 이동
	@RequestMapping(value = "/ProductList.ad", method = RequestMethod.GET)
	public String productManagement() {
		return "product/admin_product_list";
	} 
	
	// 상품관리 페이지 안 검색결과 출력
	@RequestMapping(value = "/ProductGetList.ad", method = RequestMethod.GET)
	public String GetProductManagement(@RequestParam(defaultValue = "2022-07-01") String start_date,
			String end_date, String quan, String type, @RequestParam(defaultValue = "") String search_input,
			@RequestParam(defaultValue = "1") int pdPageNum, Model model) {
		System.out.println(search_input);
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formatedNow = now.format(formatter);
		if(end_date == "" || end_date == null) {
			end_date = formatedNow.toString();
		}
		
		// 페이징처리
		int pdListLimit = 10;
		int pdPageLimit = 10;
		int pdListCount = service.getProductListCount(start_date, end_date, quan, type, "%" + search_input + "%");
		int maxpdPage = (int)Math.ceil((double)pdListCount / pdListLimit);
		int startpdPage = ((int)((double)pdPageNum / pdPageLimit + 0.9) - 1) * pdPageLimit + 1;
		int endpdPage = startpdPage + pdPageLimit - 1;
		if(endpdPage > maxpdPage) {
			endpdPage = maxpdPage;
		}
		
		int pdStartRow = (pdPageNum - 1) * pdListLimit;
		
		PageInfo pdPageInfo = new PageInfo(pdPageNum, maxpdPage, startpdPage, endpdPage, pdListCount, pdStartRow, pdListLimit);
		
		List<ProductVO> pdList = service.getProductList(start_date, end_date, quan, type, "%" + search_input + "%", pdPageInfo);
	
		model.addAttribute("pdList", pdList);
		model.addAttribute("pdPageInfo", pdPageInfo);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("pd_quan", quan);
		model.addAttribute("pd_type", type);
		model.addAttribute("search_input", search_input);
		
		return "product/admin_product_getlist";
	}
	
	// 상품등록 페이지이동
	@RequestMapping(value = "/ProductWrite.ad", method = RequestMethod.GET)
	public String productWriteForm() {
		return "product/admin_product_write";
	}
	
	// 상품등록
	@RequestMapping(value = "/ProductWritePro.ad", method = RequestMethod.POST)
	public String productWritePro(ProductVO product, HttpServletRequest request) throws Exception {
		String uploadPath = "resources/upload";
		int fileSize = 1024 * 1024 * 10;
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath(uploadPath);
		
		MultipartRequest multi = new MultipartRequest(request, realPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		product.setPd_type(multi.getParameter("pd_type"));
		product.setPd_name(multi.getParameter("pd_name"));
		product.setPd_price(Integer.parseInt(multi.getParameter("pd_price")));
		product.setPd_quan(Integer.parseInt(multi.getParameter("pd_quan")));
		product.setPd_file(multi.getFilesystemName("pd_file"));
		product.setPd_subject(multi.getParameter("pd_subject"));
		product.setPd_content(multi.getFilesystemName("pd_content"));
		int writeCount = service.insertProduct(product);
		
		if(writeCount == 0) {
			request.setAttribute("msg", "상품등록 실패!");
			return "fail_back";
		} else {
			return "product/admin_product_list";
		}		
	}
	
	// 상품상세조회 페이지 이동
	@RequestMapping(value = "/ProductInfo.ad", method = RequestMethod.GET)
	public String productDetail(String pd_num, Model model) {
		ProductVO product = service.getProductDetail(pd_num);
		
		model.addAttribute("product", product);
		
		return "product/admin_product_detail";
	}
	
	// 상품수정 페이지로 이동
	@RequestMapping(value = "/ProductUpdate.ad", method = RequestMethod.GET)
	public String productUpdateForm(String pd_num, Model model) {
		ProductVO product = service.getProductDetail(pd_num);
		
		model.addAttribute("product", product);
		
		return "product/admin_product_update";
	}
	
	// 상품수정
	@RequestMapping(value = "/ProductUpdatePro.ad", method = RequestMethod.POST)
	public String productUpdatePro(ProductVO product, HttpServletRequest request) throws Exception {
		
		String uploadPath = "resources/upload";
		int fileSize = 1024 * 1024 * 10;
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath(uploadPath);
		
		MultipartRequest multi = new MultipartRequest(request, realPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
		product.setPd_num(Integer.parseInt(multi.getParameter("pd_num")));
		product.setPd_type(multi.getParameter("pd_type"));
		product.setPd_name(multi.getParameter("pd_name"));
		product.setPd_price(Integer.parseInt(multi.getParameter("pd_price")));
		product.setPd_quan(Integer.parseInt(multi.getParameter("pd_quan")));
		product.setPd_file(multi.getFilesystemName("pd_file"));
		product.setPd_subject(multi.getParameter("pd_subject"));
		product.setPd_content(multi.getFilesystemName("pd_content"));
		int updateCount = service.productUpdate(product);
		
		request.setAttribute("product", product);
		
		if(updateCount == 0) {
			request.setAttribute("msg", "상품수정 실패!");
			return "fail_back";
		} else {
			return "product/admin_product_detail";
		}
	}
	
	// 상품삭제
	@RequestMapping(value = "/ProductDelete.ad", method = RequestMethod.GET)
	public String productDelete(String pd_num, Model model) {
		int deleteCount = service.productDeletePro(pd_num);
		if(deleteCount == 0) {
			model.addAttribute("msg", "상품삭제 실패!");
			return "fail_back";
		} else {
			return "redirect:/ProductList.ad?type=all&quan=all";			
		}
	}
	
	// 문의관리 페이지로 이동
	@RequestMapping(value = "/QnaList.ad",method = RequestMethod.GET)
	public String QnaManagement() {
		return "qna/admin_qna_list";
	}
	
	// 문의게시물 조회
	@RequestMapping(value = "/QnaGetList.ad", method = RequestMethod.POST)
	public String GetQnaManagement(
		String qna_rep,
		String qna_type,
		String order_by,
		@RequestParam(defaultValue = "")String searchObject,
		@RequestParam(defaultValue = "1999-04-17")String startDate,
		String endDate,
		@RequestParam(defaultValue = "1")int qnaPageNum,
		Model model) {

		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formatedNow = now.format(formatter);
		if(endDate == "" || endDate == null) {
			endDate = formatedNow.toString();
		}
		String searchObject2 = searchObject;
		if(searchObject == "") {
			searchObject = "%%";
		} else {
			searchObject = "%" + searchObject + "%";
		}
		
		int listLimit = 10;
		int qnaPageLimit = 10;
		int listCount = service.getListCount(qna_rep, qna_type, order_by, searchObject, startDate, endDate);
		int startRow = (qnaPageNum - 1) * listLimit;
		int maxqnaPage = (int)Math.ceil((double)listCount / listLimit);
		int startqnaPage = ((int)((double)qnaPageNum / qnaPageLimit + 0.9) - 1) * qnaPageLimit + 1;
		int endqnaPage = startqnaPage + qnaPageLimit - 1;
		if(endqnaPage > maxqnaPage) {
			endqnaPage = maxqnaPage;
		}
		PageInfo qnaPageInfo = new PageInfo(qnaPageNum, maxqnaPage, startqnaPage, endqnaPage, listCount,startRow, listLimit);
		
		model.addAttribute("qna_rep", qna_rep);
		model.addAttribute("qna_type", qna_type);
		model.addAttribute("order_by", order_by);
		model.addAttribute("searchObject", searchObject2);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("qnaPageInfo", qnaPageInfo);
		
		ArrayList<QnaVO> list = service.getQnaList(qna_rep, qna_type, order_by, searchObject, startDate, endDate, qnaPageInfo);
		
		model.addAttribute("qnaList", list);
		
		return "qna/admin_qna_getlist";
	}
	
	//
	@RequestMapping(value = "/Qnarep.ad", method = RequestMethod.GET)
	public String Qnarep(int qna_num, Model model) {
		QnaVO qna = service.getQnaDetail(qna_num);
		
		model.addAttribute("rep", qna);
		return "qna/admin_qna_rep";
	}
	
	// 
	@RequestMapping(value = "/QnaRepModify.ad",method = RequestMethod.POST)
	public String QnaRepModify(QnaVO qna, Model model) {
		int modify = service.repModify(qna);
		if(modify == 0) {
			model.addAttribute("msg", "답글 실패");
			return "alert_close";
		}else {
			model.addAttribute("msg", "답글 성공");
			return "alert_close";
		}
	}
	
	// 회원관리 페이지로 이동
	@RequestMapping(value = "/UserManagement.ad",method = RequestMethod.GET)
	public String UserManagement() {
		
		return "user/admin_user_list";
	}
	
	// 회원조회
	@RequestMapping(value = "/UserGetList.ad", method = RequestMethod.POST)
	public String UserGetList(
		@RequestParam(defaultValue = "1999-04-17")String startDate,
		@RequestParam(defaultValue = "1")int userPageNum,
		String endDate,
		String gender,
		String searchType,
		String searchObject,
		@RequestParam(defaultValue = "0")int startWon,
		@RequestParam(defaultValue = "99999999")int endWon,
		Model model) {
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formatedNow = now.format(formatter);
		if(endDate == "" || endDate == null) {
			endDate = formatedNow.toString();
		}
		String searchObject2 = searchObject;
		if(searchObject == "") {
			searchObject = "%%";
		} else {
			searchObject = "%" + searchObject + "%";
		}
		int listLimit = 10;
		int userPageLimit = 10;
		int listCount = service.getUserListCount(startDate, endDate, gender, searchType, searchObject,startWon,endWon);
		int startRow = (userPageNum - 1) * listLimit;
		int maxuserPage = (int)Math.ceil((double)listCount / listLimit);
		int startuserPage = ((int)((double)userPageNum / userPageLimit + 0.9) - 1) * userPageLimit + 1;
		int enduserPage = startuserPage + userPageLimit - 1;
		if(enduserPage > maxuserPage) {
			enduserPage = maxuserPage;
		}
		PageInfo userPageInfo = new PageInfo(userPageNum, maxuserPage, startuserPage, enduserPage, listCount,startRow, listLimit);
		ArrayList<UserVO> list = service.getUserList(startDate, endDate, gender, searchType, searchObject,startWon,endWon, userPageInfo);
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("gender", gender);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchObject", searchObject2);
		model.addAttribute("userPageInfo", userPageInfo);
		model.addAttribute("userList", list);
		
		return "user/admin_user_getlist";
	}
	
	//
	@RequestMapping(value = "/UserDetail.ad",method = RequestMethod.GET)
	public String UserDetail(int user_num, Model model) {
		
		UserVO user = service.getUserDetail(user_num);
		
		model.addAttribute("userDetail", user);
		
		return "user/admin_user_detail";
	}
	//
	@RequestMapping(value = "/Design.ad",method = RequestMethod.GET)
	public String designManagement(Model model) {
	
	ArrayList<CenterAdVO> centerAdList = service.getCenterAdList();
	ArrayList<MainAdVO> mainAdList = service.getMainAdList();	
	
		model.addAttribute("center_ad", centerAdList);
		model.addAttribute("ad", mainAdList);
		return "design/admin_design";
	}
	
	//
	@RequestMapping(value = "/ChangeMainAd.ad" ,method = RequestMethod.GET)
	public String changeMainAd(
										int main_ad_num,
										@RequestParam(defaultValue = "")String productObject,
										@RequestParam(defaultValue = "1") int pdPageNum,
										Model model) {
		
		String searchObject2 =	productObject;
		if(productObject == "" || productObject == null) {
			productObject = "%%";
		}else {
			productObject = '%' + productObject + '%';
		}
		int ad_num = main_ad_num;
		int listLimit = 5;
		int pdPageLimit = 10;
		int listCount = service.getADdProductListCount(productObject);
		int maxpdPage = (int)Math.ceil((double)listCount / listLimit);
		int startpdPage = ((int)((double)pdPageNum / pdPageLimit + 0.9) - 1) * pdPageLimit + 1;
		int endpdPage = startpdPage + pdPageLimit - 1;
		int startRow = (pdPageNum - 1) * listLimit;
		if(endpdPage > maxpdPage) {
			endpdPage = maxpdPage;
		}
		
		PageInfo pdPageInfo = new PageInfo(pdPageNum, maxpdPage, startpdPage, endpdPage, listCount,startRow, listLimit);
		ArrayList<ProductVO> list = service.getADProductList(productObject, pdPageInfo);
		
		model.addAttribute("searchObject2", searchObject2);
		model.addAttribute("ad_num", ad_num);
		model.addAttribute("pdPageInfo", pdPageInfo);
		model.addAttribute("pdList", list);
		
		return "design/admin_setmainAd";
	}
	
	//
	@RequestMapping(value = "/ChangeMainAdPro.ad", method = RequestMethod.POST)
	public String changeMainAdPro(MainAdVO mainAd, HttpServletRequest request) throws IOException {
		
		
		String uploadPath = "resources/upload/ad";
		int fileSize = 1024 * 1024 * 10;
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath(uploadPath);
			MultipartRequest multi = new MultipartRequest(request, realPath, fileSize, "UTF-8", new DefaultFileRenamePolicy());
			MainAdVO ad = new MainAdVO();
			ad.setAd_file(multi.getFilesystemName("ad_file"));
			ad.setAd_index(Integer.parseInt(multi.getParameter("ad_num")));
			ad.setAd_subject(multi.getParameter("ad_subject"));
			
			int count = service.changeAd(ad);
			
			if(count < 1) {
				request.setAttribute("msg", "Main_ad 실패");
				return "fail_back";
			}else {
				
				return "redirect:/Design.ad";
			}
			
		
	}
	
	//
	@RequestMapping(value = "/changeCenterAd.ad", method = RequestMethod.GET)
	public String changeCenterAd() {
		
		return"design/admin_product_list";
	}
	
	//
	@RequestMapping(value = "/GetProductList.ad", method = RequestMethod.POST)
	public String GetProductList(
									@RequestParam(defaultValue = "2022-07-01") String start_date,
									@RequestParam(defaultValue = "") String search_input,
									@RequestParam(defaultValue = "1") int pdPageNum,
									String end_date,
									String quan,
									String type,
									Model model) {
		
		LocalDate now = LocalDate.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String formatedNow = now.format(formatter);
		if(end_date == "" || end_date == null) {
			end_date = formatedNow.toString();
		}
		
		// 페이징처리
		int pdListLimit = 10;
		int pdPageLimit = 10;
		int pdListCount = service.getProductListCount(start_date, end_date, quan, type, "%" + search_input + "%");
		int maxpdPage = (int)Math.ceil((double)pdListCount / pdListLimit);
		int startpdPage = ((int)((double)pdPageNum / pdPageLimit + 0.9) - 1) * pdPageLimit + 1;
		int endpdPage = startpdPage + pdPageLimit - 1;
		if(endpdPage > maxpdPage) {
			endpdPage = maxpdPage;
		}
		
		int pdStartRow = (pdPageNum - 1) * pdListLimit;
		
		PageInfo pdPageInfo = new PageInfo(pdPageNum, maxpdPage, startpdPage, endpdPage, pdListCount, pdStartRow, pdListLimit);
		
		List<ProductVO> pdList = service.getProductList(start_date, end_date, quan, type, "%" + search_input + "%", pdPageInfo);
	
		model.addAttribute("pdList", pdList);
		model.addAttribute("pdPageInfo", pdPageInfo);
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("pd_quan", quan);
		model.addAttribute("pd_type", type);
		model.addAttribute("search_input", search_input);
		 
		return "design/admin_product_getlist";
	}
	
	// 
	@RequestMapping(value = "/changeCenterAdPro.ad",method = RequestMethod.POST)
	public String changeCenterAdPro(CenterAdVO ad, Model model) {
		System.out.println(ad.getAd_content());
		System.out.println(ad.getAd_index());
		System.out.println(ad.getAd_pd_num());
		int count = service.changeCenterAdPro(ad);
		
		if(count < 1) {
			model.addAttribute("msg", "광고 등록 실패");
			return "fail_back";
		}else {
			return "redirect:/Design.ad";
		}
		
	}
	
	
}


