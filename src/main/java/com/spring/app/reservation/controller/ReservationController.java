package com.spring.app.reservation.controller;

import java.util.Arrays;
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

import com.spring.app.reservation.domain.AssetReservationVO;
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
	public ModelAndView requiredLogin_reservation(HttpServletRequest request, HttpServletResponse response,
												  ModelAndView mav) {
		
		mav.setViewName("mycontent/reservation/reservation");
		
		return mav;
	}
	
	
	
	// 자산 대분류 조회하기
	@GetMapping("selectReservationTitle")
	@ResponseBody
	public List<Map<String, String>> selectReservationTitle() {
		
		List<Map<String, String>> reservationTitleList = service.tbl_assetSelect();
		
		return reservationTitleList;
	}
	
	
	@GetMapping("selectReservationSubTitle")
	@ResponseBody
	public List<Map<String, String>> selectReservationSubTitle() {
		
		List<Map<String, String>> reservationSubTitleList = service.tbl_assetDetailSelect();
		
		return reservationSubTitleList;
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
	
	
	// 자산 대분류 info 수정
	@PostMapping("assetInfoUpdate") 
	public ModelAndView assetInfoUpdate(ModelAndView mav, 
									   HttpServletRequest request,
									   @RequestParam(defaultValue = "") String updateAssetNo,
									   @RequestParam(defaultValue = "") String assetInfoUpdate,
									   @RequestParam(defaultValue = "") String updateAssetTitle) {
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("assetNo", updateAssetNo); 
		paraMap.put("assetInfo", assetInfoUpdate);
		
		int n = service.assetInfoUpdate(paraMap); // 자산 대분류 info를 update 해주는 메소드
		
		if(n==1) {
			mav.addObject("message", "수정이 완료되었습니다.");
			mav.addObject("loc", request.getContextPath()+"/reservation/assetDetailPage?assetNo="+updateAssetNo+"&assetTitle="+updateAssetTitle);
			mav.setViewName("msg");
		}
		
		return mav;
	}
	
	
	
	// 들어오자마자 보이는 내 대여 현황
	@GetMapping("showMyReservation")
	@ResponseBody
	public List<Map<String, String>> showMyReservation(@RequestParam String employeeNo) {
		
		List<Map<String, String>> my_ReservationList = service.my_Reservation(employeeNo); // 내 예약 정보를 select 해주는 메소드
		
		// System.out.println("ajax 들어옴?????????????" + my_ReservationList.size());
		
		return my_ReservationList;
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
	
	
	// 자산 관리자용 상세페이지
	@GetMapping("showReservationOne")
	public ModelAndView requiredLogin_showReservationOne(HttpServletRequest request, HttpServletResponse response,
														 ModelAndView mav, 
														 @RequestParam String assetNo) {

		AssetVO assetvo = service.assetOneSelect(assetNo); // 자산 하나에 해당하는 대분류 정보를 select 해주는 메소드
		List<Map<String, String>> OneDeList = service.assetOneDeSelect(assetNo); // 대분류에 딸린 자산들을 select 해주는 메소드
		
		// ==== 대분류 정보 ==== //
		mav.addObject("assetvo", assetvo);
		// ==== 대분류 정보 ==== //
		
		// ==== 소분류 정보 ==== //
		mav.addObject("OneDeList", OneDeList);
		// ==== 소분류 정보 ==== //
		
		mav.setViewName("mycontent/reservation/showReservationOne");
		
		return mav;
	}

	
	// 자산 관리자용 상세페이지에서 자산정보를 조회해주는 메소드
	@PostMapping("middleTapInfo")
	@ResponseBody
	public String middleTapInfo(@RequestParam String assetNo) {
		
		List<Map<String, String>> middleTapInfoList = service.middleTapInfo(assetNo);
		// System.out.println("ajax 들어옴?????????????" + middleTapInfoList.size());
		
		JSONArray jsonArr = new JSONArray();  //  []
		
		if(middleTapInfoList != null) {
			
			for(Map<String,String> listMap : middleTapInfoList) {
				JSONObject jsonObj = new JSONObject();  //  {}
				jsonObj.put("assetInformationNo", listMap.get("assetInformationNo"));
				jsonObj.put("fk_assetDetailNo", listMap.get("fk_assetDetailNo"));
				jsonObj.put("fk_assetNo", listMap.get("fk_assetNo"));
				jsonObj.put("InformationTitle", listMap.get("InformationTitle"));
				jsonObj.put("InformationContents", listMap.get("InformationContents"));
				
				jsonArr.put(jsonObj);
			} // end of for --------------
		}
		
		return jsonArr.toString();
	}
	
	
	
	@PostMapping("addFixtures")
	@ResponseBody
	public String addFixtures(@RequestParam String str_informationTitle
	                         ,@RequestParam String fk_assetdetailno
	                         ,@RequestParam String str_release
	                         ,HttpServletRequest request) {

	    Map<String, Object> paraMap = new HashMap<>();
	    
	    // 받은 값들 출력 확인
	    System.out.println("확인용 str_informationTitle : " + str_informationTitle); 
	    System.out.println("확인용 fk_assetdetailno : " + fk_assetdetailno);
	    System.out.println("확인용 str_informationtitle : " + str_release);

	    // 받은 값을 배열로 변환
	    String[] arr_informationTitle = str_informationTitle.split(",");   // 비품 이름들 배열로 분리
	    String[] arr_release = str_release.split(",");					   // 비품 공개여부 배열로 분리

	    
	    // 파라미터 맵에 추가
	    paraMap.put("arr_informationTitle", arr_informationTitle); // 비품 이름들 배열
	    paraMap.put("arr_release", arr_release);				   // 비품 공개여부 배열
	    paraMap.put("fk_assetdetailno", fk_assetdetailno);

	    
	    // 서비스 호출
	    int result = service.addFixtures(paraMap); // 서비스 메소드 실행

	    JSONObject jsonObj = new JSONObject();
	    if (result > 0) {
	        jsonObj.put("result", 1);
	    } else {
	        jsonObj.put("result", 0);
	    }

	    return jsonObj.toString();
	}
	
	
	
	
	
	// 비품 하나를 삭제해주는 메소드
	@PostMapping("midDeleteOne")
	@ResponseBody
	public String midDeleteOne(@RequestParam String assetInformationNo) {
		
		int result = service.midDeleteOne(assetInformationNo); // 비품 하나를 삭제해주는 메소드
		
		JSONObject jsonObj = new JSONObject();
	    if (result == 1) {
	        jsonObj.put("result", 1);
	    } else {
	        jsonObj.put("result", 0);
	    }

	    return jsonObj.toString();
	}
	
	
	
	
	
	@PostMapping("addAsset")
	@ResponseBody
	public String addAsset(@RequestParam String assetName,
						   @RequestParam String fk_assetNo) {
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("assetName", assetName);
		paraMap.put("fk_assetNo", fk_assetNo);
		
	    int result = service.addAsset(paraMap); // 자산추가를 해주는 메소드

	    JSONObject jsonObj = new JSONObject();
	    if (result == 1) {
	        jsonObj.put("result", 1);
	    } else {
	        jsonObj.put("result", 0);
	    }
		
		return jsonObj.toString();
	}

	
	
	
	@PostMapping("selectAssetDe")
	@ResponseBody
	public String selectAssetDe(@RequestParam String fk_assetNo) {
		
		
		List<Map<String, String>> assetOneDeSelectList = service.assetOneDeSelect(fk_assetNo); // 자산상세를 select 해주는 메소드
		
		JSONArray jsonArr = new JSONArray();  //  []
		
		if(assetOneDeSelectList != null) {
			
			for(Map<String,String> listMap : assetOneDeSelectList) {
				JSONObject jsonObj = new JSONObject();  //  {}
				jsonObj.put("assetDetailNo", listMap.get("assetDetailNo"));
				jsonObj.put("fk_assetNo", listMap.get("fk_assetNo"));
				jsonObj.put("assetName", listMap.get("assetName"));
				jsonObj.put("assetDetailRegisterday", listMap.get("assetDetailRegisterday"));
				jsonObj.put("assetDetailChangeday", listMap.get("assetDetailChangeday"));
				
				jsonArr.put(jsonObj);
			} // end of for --------------
		}
		
		return jsonArr.toString();
	}
	
	
	
	// 자산 소분류 삭제
	@PostMapping("deleteAssetNo")
	@ResponseBody
	public String deleteAssetNo(@RequestParam String assetDetailNo) {
		
		int result = service.deleteAssetNo(assetDetailNo); // 자산 소분류 삭제
		
		JSONObject jsonObj = new JSONObject();
	    if (result == 1) {
	        jsonObj.put("result", 1);
	    } else {
	        jsonObj.put("result", 0);
	    }
		
		return jsonObj.toString();
	}
	
		
	
	
	// 자산 하나에 해당하는 비품들 조회하기
	@PostMapping("fixSelectAssetNo")
	@ResponseBody
	public List<Map<String,String>> fixSelectAssetNo(@RequestParam String fk_assetDetailNo) {
		
		List<Map<String,String>> fixSelectAssetNoList = service.fixSelectAssetNo(fk_assetDetailNo); // 자산 하나에 해당하는 비품들 조회하기
		
		return fixSelectAssetNoList;
	}
	
	
	// 자산 하나에 해당하는 비품 수정하기
	@PostMapping("GofixInfo")
	@ResponseBody
	public String GofixInfo(@RequestParam String assetDetailNo,				// 자산명 변경시 pk
							@RequestParam String assetName,					// 자산명 변경시 자산명
							@RequestParam String InformationTitle_str,		// 비품명
							@RequestParam String InformationContents_str,	// 비품 상태
							@RequestParam String release_str,				// 비품 공개유무
							@RequestParam String assetInformationNo_str) {	// 비품 pk
		
		/*
		System.out.println("확인용 assetDetailNo : " + assetDetailNo);
		System.out.println("확인용 assetName : " + assetName);
		System.out.println("확인용 InformationTitle_str : " + InformationTitle_str);
		System.out.println("확인용 InformationContents_str : " + InformationContents_str);
		System.out.println("확인용 release_str : " + release_str);
		
			확인용 assetDetailNo : 100030
			확인용 assetName : Whale
			확인용 InformationTitle_str : 화이트보드,빔프로젝트
			확인용 InformationContents_str : O,X
			확인용 release_str : 0,1
		*/
		
		///////////////////////////////////////////////////////
		String[] InformationTitle_arr = InformationTitle_str.split(",");
		String[] InformationContents_arr = InformationContents_str.split(",");
		String[] release_arr = release_str.split(",");
		String[] assetInformationNo_arr = assetInformationNo_str.split(",");
		
		// <배열들 map에 담기(비품관련)> //
		Map<String, Object> paraMapArr = new HashMap<>();
		paraMapArr.put("InformationTitle_arr", InformationTitle_arr);
		paraMapArr.put("InformationContents_arr", InformationContents_arr);
		paraMapArr.put("release_arr", release_arr);
		paraMapArr.put("assetInformationNo_arr", assetInformationNo_arr);
		
		// <넘어온 값 map에 담기(자산명관련)> //
		Map<String, String> paraMapAsset = new HashMap<>();
		paraMapAsset.put("assetDetailNo", assetDetailNo);
		paraMapAsset.put("assetName", assetName);
		///////////////////////////////////////////////////////
		
		int result2 = 1;
		// System.out.println("찍어보자 : " +InformationTitle_str);
		int result1 = service.updateAssetDetailName(paraMapAsset); // 자산명을 수정해주는 메소드
		
		if(!"".equals(InformationTitle_str)) {
			result2 = service.GofixInfo(paraMapArr); 			   // 비품내용들을 수정해주는 메소드
		}
		
		JSONObject jsonObj = new JSONObject();
		if (result1 * result2 != 0) { // 둘 다 성공하면 0이 아닐 것을 이용
	        jsonObj.put("result", 1);
	    } else {
	        jsonObj.put("result", 0);
	    }
		
		return jsonObj.toString();
	}
	
	
	
	
	
	
	
	
	
	////////////////////////////////////////////////////////////// 자산상세 페이지
	@GetMapping("showReservationDeOne")
	public ModelAndView requiredLogin_showReservationDeOne(HttpServletRequest request, HttpServletResponse response,
													       ModelAndView mav,
													       @RequestParam String assetName,
													       @RequestParam String assetDetailNo) {
	
	mav.addObject("assetName", assetName);
	mav.addObject("assetDetailNo", assetDetailNo);
		
	mav.setViewName("mycontent/reservation/showReservationDeOne");
	
	return mav;
	}
	
	
	
	// 해당 페이지 내의 일자 구간 예약정보 불러오기
	@PostMapping("selectassetReservationThis")
	@ResponseBody
	public List<AssetReservationVO> selectassetReservationThis(AssetReservationVO assetreservationvo) {
		
		// System.out.println("assetreservationvo 확인 : "+ assetreservationvo.getReservationStart());
		
		List<AssetReservationVO> reservationvoList = service.selectassetReservationThis(assetreservationvo);
		
		// System.out.println("reservationvoList 해당 일자 구간 예약 개수 : " + reservationvoList.size());
		
		return reservationvoList;
	}
	
	
	
	// 예약하기
	@PostMapping("addReservation")
	@ResponseBody
	public String addReservation(AssetReservationVO assetreservationvo) {
		/*
			System.out.println("Fk_assetDetailNo 확인 : "+ assetreservationvo.getFk_assetDetailNo()); 		// Fk_assetDetailNo 확인 : 100015
			System.out.println("Fk_employeeNo 확인 : "+ assetreservationvo.getFk_employeeNo());		 		// Fk_employeeNo 확인 : 100012
			System.out.println("ReservationStart 확인 : "+ assetreservationvo.getReservationStart()); 		// ReservationStart 확인 : 2025.02.27 11:00
			System.out.println("getReservationEnd 확인 : "+ assetreservationvo.getReservationEnd());         // getReservationEnd 확인 : 2025.02.27 13:30
			System.out.println("ReservationContents 확인 : "+ assetreservationvo.getReservationContents());  // ReservationContents 확인 : dsa
		*/
		JSONObject jsonObj = new JSONObject();
		
		int selectReservation = service.selectReservation(assetreservationvo); // 예약하기에 앞서 해당 일자에 예약한 건이 있는지 확인
		
		System.out.println("확인 : selectReservation " + selectReservation);
		
		if(selectReservation != 0) {
			jsonObj.put("result", 0);
		}
		else {
			int result = service.addReservation(assetreservationvo); // 예약추가를 해주는 메소드
	
		    
		    if (result == 1) {
		        jsonObj.put("result", 1);
		    } else {
		        jsonObj.put("result", 0);
		    }
		}
		
		return jsonObj.toString();
	}
	
	
	// 상세 하나의 비품들 조회해주기
	@GetMapping("selectInformation")
	@ResponseBody
	public List<Map<String, String>> selectInformation(@RequestParam String fk_assetdetailno) {
		
		List<Map<String, String>> informationList = service.middleTapInfo(fk_assetdetailno); // 상세에 해당하는 비품정보들을 불러주는 메소드
		
		return informationList;
	}
	
	
	
	// 회의실별 오늘에 해당하는 예약 정보 조회
	@GetMapping("selectNowReservation")
	@ResponseBody
	public List<Map<String,String>> selectNowReservation(@RequestParam String assetDetailNo_arr_str,
														 @RequestParam String reservationStart) {
		
		String[] assetDetailNo_arr = assetDetailNo_arr_str.split(",");
		
		Map<String, Object> paraMap = new HashMap<>();
		paraMap.put("reservationStart", reservationStart);
		paraMap.put("assetDetailNo_arr", assetDetailNo_arr);
		
		List<Map<String,String>> selectNowReservationList = service.selectNowReservation(paraMap); // 회의실별 오늘에 해당하는 예약 정보 조회
	
		return selectNowReservationList;
	}
	
	
	
	// 예약 삭제하기
	@PostMapping("deleteAssetReservationNo")
	@ResponseBody
	public String deleteAssetReservationNo(@RequestParam String assetReservationNo) {
		
		int result = service.deleteAssetReservationNo(assetReservationNo); // 예약을 삭제 해주는 메소드

	    JSONObject jsonObj = new JSONObject();
	    if (result == 1) {
	        jsonObj.put("result", 1);
	    } else {
	        jsonObj.put("result", 0);
	    }
		
		return jsonObj.toString();
	}
	
	
	//////////////////////////////////////////////////////////////자산 대분류 상세 페이지
	@GetMapping("assetDetailPage")
	public ModelAndView requiredLogin_assetDetailPage(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, @RequestParam String assetNo, @RequestParam String assetTitle) {
		
		
		AssetVO assetvo = service.assetOneSelect(assetNo); //자산 대분류 상세 정보 가져오기
		
		
		mav.addObject("assetNo", assetNo);
		mav.addObject("assetTitle", assetTitle);
		mav.addObject("assetvo", assetvo);
		
		mav.setViewName("mycontent/reservation/assetDetailPage");
		
		return mav;
	}
	
	
	////////////////////////////////////////////////////////////// 캘린더에서 예약기능
	@GetMapping("selectReservation")
	@ResponseBody
	public List<Map<String, String>> selectReservation(@RequestParam String startdate, @RequestParam String enddate){
		
		// System.out.println("확인용 startdate : "+startdate);
		// System.out.println("확인용 enddate : "+enddate);
		
		Map<String, String> map = new HashMap<>();
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		
		List<Map<String, String>> list = service.selectReservationCal(map);
		
		return list;
	}
	
	
	
}
