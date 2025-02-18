package com.spring.app.reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.app.reservation.service.ReservationService;

import jakarta.servlet.http.HttpServletRequest;


//=== 컨트롤러 선언 === //
@Controller
@RequestMapping("/reservation/*")
public class ReservationController {

	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private ReservationService service;
	
	@GetMapping("")
	public ModelAndView board(ModelAndView mav) {
		
		List<Map<String, String>> assetList = service.tbl_assetSelect(); // 자산 대분류를 select 해주는 메소드
		
		List<Map<String, String>> assetDetailList = service.tbl_assetDetailSelect(); // 자산 상세를 select 해주는 메소드
		
		mav.addObject("assetDetailList", assetDetailList);
		mav.addObject("assetList", assetList);
		
		mav.setViewName("mycontent/reservation/reservation");
		
		return mav;
	}
	
	
	// 자산 예약 대분류 생성
	@PostMapping("reservationAdd") 
	public ModelAndView reservationAdd(ModelAndView mav, 
									   HttpServletRequest request,
									   @RequestParam(defaultValue = "") String classification,
									   @RequestParam(defaultValue = "") String assetTitle,
									   @RequestParam(defaultValue = "") String assetInfo) {
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("classification", classification); 
		paraMap.put("assetTitle", assetTitle);
		paraMap.put("assetInfo", assetInfo);
		
		// System.out.println("확인만 해보자 assetTitle : " + assetTitle);
		
		int n = service.reservationAdd(paraMap); // 자산 대분류를 insert 해주는 메소드
		
		if(n==1) {
			mav.addObject("message", "등록이 완료되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/reservation");
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
		
}
