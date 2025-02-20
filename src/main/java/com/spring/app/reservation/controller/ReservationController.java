package com.spring.app.reservation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.reservation.domain.AssetVO;
import com.spring.app.reservation.service.ReservationService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


//=== 컨트롤러 선언 === //
@Controller
@RequestMapping("/reservation/*")
public class ReservationController {

	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private ReservationService service;
	
	
	
	
	
	// 자산 예약 메인페이지
	@GetMapping("")
	public ModelAndView selectLeftBar_reservation(HttpServletRequest request, 
												  ModelAndView mav) {
		
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
	
	
	
	// 들어오자마자 보이는 내 대여 현황
	@GetMapping("showMyReservation")
	@ResponseBody
	public String showMyReservation(@RequestParam String employeeNo) {
		
		List<Map<String, String>> my_ReservationList = service.my_Reservation(employeeNo); // 내 예약 정보를 select 해주는 메소드
		
		System.out.println("ajax 들어옴?????????????" + my_ReservationList.size());
		
		JSONArray jsonArr = new JSONArray();  //  []
		
		if(my_ReservationList != null) {
			
			for(Map<String,String> listMap : my_ReservationList) {
				JSONObject jsonObj = new JSONObject();  //  {}
				jsonObj.put("assetReservationNo", listMap.get("assetReservationNo"));
				jsonObj.put("fk_assetDetailNo", listMap.get("fk_assetDetailNo"));
				jsonObj.put("fk_employeeNo", listMap.get("fk_employeeNo"));
				jsonObj.put("reservationStart", listMap.get("reservationStart"));
				jsonObj.put("reservationEnd", listMap.get("reservationEnd"));
				jsonObj.put("reservationDay", listMap.get("reservationDay"));
				
				jsonArr.put(jsonObj);
			} // end of for --------------
		}
		
		return jsonArr.toString();
	}
	
	
	
	// 자산 대분류 삭제
	@PostMapping("deleteAsset")
	@ResponseBody
	public String deleteAsset(@RequestParam String assetNo) {
		
		int n = service.deleteAsset(assetNo); // 대분류를 삭제하는 메소드
		// System.out.println("삭제하러 들어옴 n : " + n);

		JSONObject jsonObj = new JSONObject();  //  {}
		
		if(n == 1) {
			jsonObj.put("result", 1);
		}
		else {
			jsonObj.put("result", 0);
		}
		
		return jsonObj.toString();
	}
	
	
	
	@GetMapping("showReservationOne")
	public ModelAndView selectLeftBar_showReservationOne(HttpServletRequest request, 
														 ModelAndView mav, 
														 @RequestParam String assetNo) {

		AssetVO assetvo = service.assetOneSelect(assetNo); // 자산 하나에 해당하는 대분류 정보를 select 해주는 메소드
		
		// ==== 대분류 정보 ==== //
		mav.addObject("assetvo", assetvo);
		// ==== 대분류 정보 ==== //
		
		mav.setViewName("mycontent/reservation/showReservationOne");
		
		return mav;
	}

	
	
	
		
}
