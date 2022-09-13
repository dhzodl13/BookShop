package com.project.bookshop.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.bookshop.mapper.AdminMapper;
import com.project.bookshop.vo.CenterAdVO;
import com.project.bookshop.vo.MainAdVO;
import com.project.bookshop.vo.OrdDetailVO;
import com.project.bookshop.vo.OrdVO;
import com.project.bookshop.vo.PageInfo;
import com.project.bookshop.vo.ProductVO;
import com.project.bookshop.vo.QnaVO;
import com.project.bookshop.vo.UserVO;

@Service
public class AdminService {
	@Autowired
	private AdminMapper mapper;

	public int[] OrderNoticeCount() {
		int[] status = {0, 0};
		status[0] = mapper.OrderNoticeCount("결제완료");
		status[1] = mapper.OrderNoticeCount("결제취소");
		return status;
	}

	public int[] ProductNoticeCount() {
		return mapper.ProductNoticeCount();
	}

	public int[] QnaNoticeCount() {
		int[] type = {0, 0};
		type[0] = mapper.QnaNoticeCount("계정");
		type[1] = mapper.QnaNoticeCount("상품");
		return type;
	}

	public int getOrderListCount(String start_date, String end_date, String min_price, String max_price,
			String order_status) {
		return mapper.getOrderListCount(start_date, end_date, min_price, max_price, order_status);
	}

	public List<OrdVO> getOrderList(String start_date, String end_date, String min_price, String max_price,
			String order_status, PageInfo ordPageInfo) {
		return mapper.getOrderList(start_date, end_date, min_price, max_price, order_status, ordPageInfo);
	}

	public List<OrdDetailVO> getOrderDetail(String order_num) {
		return mapper.getOrderDetail(order_num);
	}

	public int orderProcess(OrdVO order) {
		return mapper.orderProcess(order);
	}

	public int getProductListCount(String start_date, String end_date, String pd_quan, String pd_type, String search_input) {
		return mapper.getProductListCount(start_date, end_date, pd_quan, pd_type, search_input);
	}

	public List<ProductVO> getProductList(String start_date, String end_date, String pd_quan, String pd_type, String search_input,
			PageInfo pdPageInfo) {
		return mapper.getProductList(start_date, end_date, pd_quan, pd_type, search_input, pdPageInfo);
	}

	public int insertProduct(ProductVO product) {
		int num = mapper.maxProduct();
		num += 1;
		return mapper.insertProduct(product, num);
	}

	public ProductVO getProductDetail(String pd_num) {
		return mapper.getProductDetail(pd_num);
	}

	public int productUpdate(ProductVO product) {
		return mapper.productUpdate(product);
	}

	public int productDeletePro(String pd_num) {
		return mapper.productDelete(pd_num);
	}
	
	public int getListCount(String qna_rep, String qna_type, String order_by, String searchObject, String startDate,
			String endDate) {
		return mapper.getQnaListCount(qna_rep, qna_type, order_by, searchObject, startDate, endDate);
	}

	public ArrayList<QnaVO> getQnaList(String qna_rep, String qna_type, String order_by, String searchObject,
			String startDate, String endDate, PageInfo qnaPageInfo) {
		return mapper.getQnaList(qna_rep, qna_type, order_by, searchObject, startDate, endDate, qnaPageInfo);
	}

	public QnaVO getQnaDetail(int qna_num) {
		return mapper.getQnaDetail(qna_num);
	}

	public int repModify(QnaVO qna) {
		return mapper.repModify(qna);
	}

	public int getUserListCount(String startDate, String endDate, String gender, String searchType, String searchObject,
			int startWon, int endWon) {
		
		return mapper.getUserListCount(startDate, endDate, gender, searchType, searchObject,startWon,endWon);
	}

	public ArrayList<UserVO> getUserList(String startDate, String endDate, String gender, String searchType,
			String searchObject, int startWon, int endWon, PageInfo userPageInfo) {
		return mapper.getUserList(startDate, endDate, gender, searchType, searchObject,startWon,endWon,userPageInfo);
	}

	public List<OrdVO> getSales() {
		return mapper.getSales();
	}

	public List<UserVO> getUserCount() {
		return mapper.getUserCount();
	}
	
	public UserVO getUserDetail(int user_num) {
		return mapper.getUserDetail(user_num);
	}

	public ArrayList<MainAdVO> getMainAdList() {
		
		
		return mapper.getMainAdList();
	}

	public int getADdProductListCount(String productObject) {
		return mapper.getAdProductListCount(productObject);
	}

	public ArrayList<ProductVO> getADProductList(String productObject, PageInfo pdPageInfo) {
		return mapper.getAdProductList(productObject,pdPageInfo);
	}

	public int changeAd(MainAdVO ad) {
		
		int count = mapper.selectAd(ad);
		
		if(count < 1) {
			return mapper.insertAd(ad);
		}else {
			return mapper.changeAdPro(ad);
		}
	}

	public int changeCenterAdPro(CenterAdVO ad) {
		int count = mapper.selectCenterAd(ad);
		
		if(count < 1) {
			return mapper.insertCenterAd(ad);
		}else {
			return mapper.changeCenterAd(ad);
			
		}
		
	}

	public ArrayList<CenterAdVO> getCenterAdList() {
		return mapper.getCenterAdList();
	}

	
	
}











