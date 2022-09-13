package com.project.bookshop;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.bookshop.service.AdminService;
import com.project.bookshop.service.UserService;
import com.project.bookshop.vo.CenterAdVO;
import com.project.bookshop.vo.MainAdVO;
import com.project.bookshop.vo.ProductVO;

@Controller
public class HomeController {
	@Autowired
	private UserService service;
	@Autowired
	private AdminService service2;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		// 판매 순위 리스트 가져오기
		ArrayList<ProductVO> productList = service.ProductCountRank();
		model.addAttribute("productList", productList);
		// 어드민 디자인 페이지에서 올린 
		ArrayList<CenterAdVO> centerAdList = service2.getCenterAdList();
		ArrayList<MainAdVO> mainAdList = service2.getMainAdList();	
		model.addAttribute("center_ad", centerAdList);
		model.addAttribute("ad", mainAdList);
		
		return "main/main";
	}
	
}
