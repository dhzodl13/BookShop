package com.project.bookshop.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.bookshop.vo.CenterAdVO;
import com.project.bookshop.vo.MainAdVO;
import com.project.bookshop.vo.OrdDetailVO;
import com.project.bookshop.vo.OrdVO;
import com.project.bookshop.vo.PageInfo;
import com.project.bookshop.vo.ProductVO;
import com.project.bookshop.vo.QnaVO;
import com.project.bookshop.vo.UserVO;

public interface AdminMapper {

	int OrderNoticeCount(@Param("order_status") String order_status);

	int[] ProductNoticeCount();

	int QnaNoticeCount(@Param("qna_type") String qna_type);

	int getOrderListCount(@Param("start_date")String start_date, @Param("end_date")String end_date, @Param("min_price")String min_price, @Param("max_price")String max_price, @Param("order_status") String order_status);

	List<OrdVO> getOrderList(@Param("start_date")String start_date, @Param("end_date")String end_date, @Param("min_price")String min_price, @Param("max_price")String max_price,
			@Param("order_status") String order_status, @Param("ordPageInfo") PageInfo ordPageInfo);

	List<OrdDetailVO> getOrderDetail(@Param("order_num") String order_num);

	int orderProcess(OrdVO order);

	int getProductListCount(@Param("start_date")String start_date, @Param("end_date")String end_date, @Param("pd_quan")String pd_quan, @Param("pd_type")String pd_type, @Param("search_input")String search_input);

	List<ProductVO> getProductList(@Param("start_date")String start_date, @Param("end_date")String end_date, @Param("pd_quan")String pd_quan, @Param("pd_type")String pd_type, @Param("search_input")String search_input,
			@Param("pdPageInfo") PageInfo pdPageInfo);

	int maxProduct();

	int insertProduct(@Param("product")ProductVO product, @Param("num")int num);

	ProductVO getProductDetail(@Param("pd_num")String pd_num);

	int productUpdate(@Param("product")ProductVO product);

	int productDelete(@Param("pd_num")String pd_num);
	
	int getQnaListCount(
			@Param(value = "qna_rep") String qna_rep,
			@Param(value = "qna_type") String qna_type,
			@Param(value = "order_by") String order_by,
			@Param(value = "searchObject") String searchObject,
			@Param(value = "startDate") String startDate,
			@Param(value = "endDate") String endDate);

	ArrayList<QnaVO> getQnaList(
			@Param(value = "qna_rep") String qna_rep,
			@Param(value = "qna_type") String qna_type,
			@Param(value = "order_by") String order_by,
			@Param(value = "searchObject") String searchObject,
			@Param(value = "startDate") String startDate,
			@Param(value = "endDate") String endDate,
			@Param(value = "qnaPageInfo")PageInfo qnaPageInfo);

	QnaVO getQnaDetail(int qna_num);

	int repModify(QnaVO qna);

	int getUserListCount(
			@Param(value = "startDate") String startDate,
			@Param(value = "endDate")String endDate,
			@Param(value = "gender")String gender,
			@Param(value = "searchType")String searchType,
			@Param(value = "searchObject")String searchObject,
			@Param(value = "startWon")	int startWon,
			@Param(value = "endWon")int endWon);

	ArrayList<UserVO> getUserList(
			@Param(value = "startDate") String startDate,
			@Param(value = "endDate")String endDate,
			@Param(value = "gender")String gender,
			@Param(value = "searchType")String searchType,
			@Param(value = "searchObject")String searchObject,
			@Param(value = "startWon")	int startWon,
			@Param(value = "endWon")int endWon,
			@Param(value = "userPageInfo")PageInfo userPageInfo);

	List<OrdVO> getSales();

	List<UserVO> getUserCount();
	
	UserVO getUserDetail(int user_num);

	ArrayList<MainAdVO> getMainAdList();

	int getAdProductListCount(String productObject);

	ArrayList<ProductVO> getAdProductList(
			@Param(value = "productObject")String productObject,
			@Param(value = "pageInfo")PageInfo pdPageInfo);

	int changeAdPro(MainAdVO ad);

	int selectAd(MainAdVO ad);

	int insertAd(MainAdVO ad);

	int selectCenterAd(CenterAdVO ad);

	int insertCenterAd(CenterAdVO ad);

	int changeCenterAd(CenterAdVO ad);

	ArrayList<CenterAdVO> getCenterAdList();

	

}















