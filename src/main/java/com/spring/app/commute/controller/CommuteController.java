package com.spring.app.commute.controller;


import java.lang.reflect.Array;
import java.security.PublicKey;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonArray;
import com.spring.app.commute.domain.AnnualVO;
import com.spring.app.commute.domain.CommuteVO;
import com.spring.app.commute.service.CommuteService;
import com.spring.app.employee.domain.DepartmentVO;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.domain.PositionVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;

@Controller
@RequestMapping(value="/commute/*")
public class CommuteController {
	
	@Autowired
	private CommuteService service;

	@GetMapping("")
	public ModelAndView commute(HttpServletRequest request, ModelAndView mav) {
		
		String referer = request.getHeader("referer");
		
		if(referer == null) {
			mav.addObject("message", "비정상적인 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/index");
			mav.setViewName("msg");
			return mav;
		}
		
		mav.setViewName("mycontent/commute/commute");

		return mav;
	}
	
	@GetMapping("getDeptname")
	@ResponseBody
	public List<DepartmentVO> getDeptname() {

		List<DepartmentVO> dvoList = service.getDepInfo(); // 모든 부서 리스트 조회

		return dvoList;
	}
	
	// 오늘자 근태 조회
	@GetMapping("getTodayWorkInfo")
	@ResponseBody
	public Map<String, Object> getTodayWorkInfo(@RequestParam String fk_employeeNo) {
	
		Map<String, Object> map = new HashMap<>();
		
		int n = 0; // 0:아직 출근 안했거나 연차,반차(출근버튼 활성화)  1:출근했다(출근버튼 비활성화) 2:퇴근했다(퇴근버튼 비활성화). 
		
		// 금일자 출근정보 조회하기
		CommuteVO cvo = service.getTodayWorkInfo(fk_employeeNo);
		
		
		if(cvo == null) {
			n = 0;
			map.put("startTime", "-");
			map.put("endTime", "-");
			map.put("status", "0");
			map.put("overTimeYN","0");
			map.put("rest","0");
			
		}
		else {
			
			if("-".equals(cvo.getStartTime())) { // 오늘자 출근기록이 없는 경우
				n = 0;
			}
			else {	// 오늘자 출근기록이 있는 경우
				
				
				if("-".equals(cvo.getEndTime())) { // 오늘자 퇴근기록이 없는 경우
					n = 1;
				}
				else {
					n = 2;
				}
				
				map.put("startTime", cvo.getStartTime());
				map.put("endTime", cvo.getEndTime());
				map.put("status", cvo.getStatus());
				map.put("overTimeYN",cvo.getOverTimeYN());
				map.put("rest",cvo.getRest());
				
			}
			
		}
		
		// 주간 근무시간 구하기
		int n_workTime_sec = 0;
		int workTime_hour = 0;
		int workTime_min = 0;
		int workTime_sec = 0;

		List<Map<String, String>> mapList = service.getThisWeekWorkTime(fk_employeeNo);

		for (Map<String, String> ThisWeekWorkTimeMap : mapList) {

			String workTime = ThisWeekWorkTimeMap.get("workTime");

			double n_workTime_day = Double.parseDouble(workTime); // 1 = 1일

			n_workTime_sec += (int) (n_workTime_day * 24 * 60 * 60);
			
		}

		workTime_hour = (n_workTime_sec / 60 / 60);

		workTime_min = (n_workTime_sec / 60 - workTime_hour * 60);

		workTime_sec = (n_workTime_sec - workTime_hour * 60 * 60 - workTime_min * 60);
		
		map.put("n", n);
		map.put("workTime_hour", workTime_hour);
		map.put("workTime_min", workTime_min);
		map.put("workTime_sec", workTime_sec);

		return map;
	}
	
	// 출근 클릭시
	@PostMapping("workStart")
	@ResponseBody
	public Map<String, Object> workStart(@RequestParam String fk_employeeNo) {
		
		int n = 0; // 0:에러, 1:성공
		
		// 금일자 출근정보가 있는지 조회
		CommuteVO cvo = service.getTodayWorkInfo(fk_employeeNo);

		if(cvo == null) { // 근태 기록이 없다면

			n = service.insertWorkStart(fk_employeeNo); // 새로운 근태 기록 insert

		}
		else { // 오늘자 근태 행이 이미 있다면 (연차, 반차 등으로 이미 insert 해준 경우)

			if (cvo.getStartTime() == null) { // 퇴근기록이 없고 출근 시간이 null 이라면
				n = service.updateStartTime(fk_employeeNo); // 출근시간 업데이트
			}
			
		}
	
		Map<String, Object> map = new HashMap<>();
		map.put("n", n);
		
		
		return map;
	}
	
	// 퇴근 클릭시
	@PostMapping("workEnd")
	@ResponseBody
	public Map<String, Object> workEnd(@RequestParam String fk_employeeNo) {

		System.out.println("퇴근 클릭 ~ ");
		
		int n = 0; // 0:에러, 1:성공,

		// 금일자 출근정보가 있는지 조회
		CommuteVO cvo = service.getTodayWorkInfo(fk_employeeNo);

		System.out.println("퇴근 클릭 ~ DB ~ cvo : " + cvo);
		
		if (!"-".equals(cvo.getStartTime())) { // 출근 기록이 있다면
			n = service.updateEndTime(fk_employeeNo); // 퇴근시간 업데이트
		}
		
		System.out.println("퇴근 클릭 ~ n : " + n);
		
		Map<String, Object> map = new HashMap<>();
		map.put("n", n);

		return map;
	}
	
	// 근무 상태 변경
	@PostMapping("statusChange")
	@ResponseBody
	public Map<String, Integer> statusChange(@RequestParam Map<String, String> paramap) {
		
		int n = 0;
		
		if(!"0".equals(paramap.get("status"))) {
			n = service.statusChange(paramap);
		}
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map;
	}
	
	// 한달치 근무 기록 조회
	@GetMapping("getMontWorkInfo")
	@ResponseBody
	public List<Map<String, String>> getMontWorkInfo(@RequestParam Map<String, String> paramap) {
		
		List<Map<String, String>> mapList = service.getMontWorkInfo(paramap);
		
		return mapList;
	}
	
	// 이번주 근무 시간 조회
	@GetMapping("getWorktime")
	@ResponseBody
	public List<Map<String, String>> getWorktime(@RequestParam Map<String, String> paramap) { 
		
		List<Map<String, String>> mapList = service.getWorktime(paramap);
		
		return mapList;
	}
	
	// 엑셀 다운로드
	@PostMapping("downloadExcel")
	public String downloadExcelFile(HttpServletRequest request, @RequestParam(defaultValue = "") String year_month, @RequestParam(defaultValue = "") String fk_employeeNo, Model model) {
	
		String referer = request.getHeader("referer");
		
		if(fk_employeeNo != null || year_month != null || referer != null ) {
			
			Map<String,String> map = service.getEmployeeInfo(fk_employeeNo);
			
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("positionName", map.get("positionName"));
			paraMap.put("name", map.get("name"));
			paraMap.put("fk_employeeNo", fk_employeeNo);
			paraMap.put("year_month", year_month);
			
			service.commuteList_to_Excel(paraMap, model);
			
			return "excelDownloadView"; // "excelDownloadView"은 ViewConfiguration의 19번째줄 메소드 이름이다..
		}
		else {
			return "mycontent/commute/commute";
		}
	}
		
	// 내 연차 조회 및 페이지 이동
	@GetMapping("myAnnual")
	public ModelAndView myAnnual(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String referer = request.getHeader("referer");
		
		if(referer == null) {
			mav.addObject("message", "비정상적인 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/index");
			mav.setViewName("msg");
			return mav;
		}
		
		HttpSession session = request.getSession();

		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		LocalDate now = LocalDate.now();
		int n_year = now.getYear();
		String year = "" + n_year;

		String fk_employeeNo = loginuser.getEmployeeNo();

		Map<String, String> map = service.getEmployeeInfo(fk_employeeNo);

		Map<String, String> paramap = new HashMap<>();
		paramap.put("year", year);
		paramap.put("fk_employeeNo", fk_employeeNo);

		AnnualVO avo = service.getAnnualInfo(paramap);

		mav.addObject("map", map);
		mav.addObject("avo", avo);
		mav.setViewName("mycontent/commute/myAnnual");

		return mav;
	}
		
		
	// 소진 연차 리스트	
	@GetMapping("getUsedAnnualList")
	@ResponseBody
	public List<Map<String, String>> getUsedAnnualList(@RequestParam Map<String, String> paraMap) {
		
		List<Map<String, String>> mapList = service.getUsedAnnualList(paraMap);
		
		return mapList;
	}
		
	// 셀렉트 태그에 해당 사원이 실제로 근무한 연도 출력
	@GetMapping("getWorkYear")
	@ResponseBody
	public List<String> getWorkYear(@RequestParam(defaultValue = "") String fk_employeeNo) {
		
		List<String> yearList = service.getWorkYear(fk_employeeNo);
		
		return yearList;
	}
		
	
	@GetMapping("commuteTable")
	public ModelAndView commuteTable(HttpServletRequest request, ModelAndView mav) {
		
		String referer = request.getHeader("referer");
		
		if(referer == null) {
			mav.addObject("message", "비정상적인 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/index");
			mav.setViewName("msg");
			return mav;
		}
		
		String departmentNo = request.getParameter("departmentNo");
		
		if(!"all".equals(departmentNo)) {
			
			DepartmentVO dvo = service.getdeptInfo(departmentNo);
			mav.addObject("departmentName", dvo.getDepartmentName());
		}
		
		mav.addObject("currentShowPageNo", "1");
		mav.addObject("departmentNo", departmentNo);
		mav.setViewName("mycontent/commute/commuteTable");
			
		return mav;
	}
	
	
	@GetMapping("getCommuteTableInfo")
	@ResponseBody
	public Map<String, Object> getCommuteTableInfo(@RequestParam Map<String, String> paraMap) {
		
		Map<String, Object> jsonMap = new HashMap<>();
		
		String currentShowPageNo = "1";
		
		if(paraMap.get("currentShowPageNo") != null) {
			currentShowPageNo = paraMap.get("currentShowPageNo");
		}
		if(!"name".equals(paraMap.get("searchType")) ) {
			paraMap.put("searchType", "");
		}
		if(paraMap.get("searchWord").trim() == null) {
			paraMap.put("searchWord", "");
		}
		else {
			paraMap.put("searchWord", paraMap.get("searchWord").trim());
		}
		
		paraMap.put("year_month", paraMap.get("year")+""+paraMap.get("month"));
		
		
		
		int totalCount = 0; 	// 총 게시물 수
		int sizePerPage = 0; 	// 페이지당 게시물 수
		int totalPage = 0; 		// 총 페이지 수
		int n_currentShowPageNo = 1;
		
		if(paraMap.get("sizePerPage") != null ) {
			sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		}
		
		totalCount = service.totalCnt(paraMap);

		totalPage = (int)( Math.ceil((double)totalCount/sizePerPage) );
		
		
		
		System.out.println("searchType : "+ paraMap.get("searchType"));
		System.out.println("searchWord : "+ paraMap.get("searchWord"));
		
		try {
			n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
			
			if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
	            n_currentShowPageNo = 1;
	        }
			
		} catch (NumberFormatException e) {
			n_currentShowPageNo = 1;
		}
		
		int startRno = ((n_currentShowPageNo - 1) * sizePerPage ) + 1;
		int endRno = startRno + sizePerPage -1;
		
		
		
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		
		List<Map<String, String>> mapList = service.getCommuteTableInfo(paraMap);
		
		int blockSize = 5; 
		int loop = 1;
		int pageNo = ((n_currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<div style='width:100%; margin:0 auto;'>";
		
	    pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody( new Date("+paraMap.get("year")+", "+(Integer.parseInt(paraMap.get("month"))-1)+", 1), 1)'><i style='transform: scaleX(-1)' class='fa-solid fa-forward-step'></i></button>";
	    
	    if(n_currentShowPageNo > 1) {
	    	pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody( new Date("+paraMap.get("year")+", "+(Integer.parseInt(paraMap.get("month"))-1)+", 1), "+ (pageNo-1) +")'><i class='fa-solid fa-chevron-left'></i></button>";

	    }
	    
	    while(!(loop > blockSize || pageNo > totalPage)) {
	    	
	    
	    	if(pageNo == n_currentShowPageNo) {
	            pageBar += "<button type='button'  class='btn' style='width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</button>";
	        }
	    	else {
	    		pageBar += "<button type='button' class='btn' style='width:30px; font-size:12pt; color:#007bff;' onclick='spread_tbody( new Date("+paraMap.get("year")+", "+(Integer.parseInt(paraMap.get("month"))-1)+", 1), "+pageNo+")'>"+pageNo+"</button>"; 
	    	}    
	    	
	    	loop++;
	    	pageNo++;
	           
	    }// end of while --------------------------------
	       
	    System.out.println("pageNo"+ pageNo);
	    System.out.println("totalPage"+ totalPage);
	    
	    if(pageNo <= totalPage) {
	    	pageBar += "<button type='button' class='btn' style='width:30px; font-size:12pt; color:#007bff;' onclick='spread_tbody( new Date("+paraMap.get("year")+", "+ (Integer.parseInt(paraMap.get("month"))-1)+ ", 1), "+pageNo+")'><i class='fa-solid fa-chevron-right'></i></button>"; 
	    }

	    pageBar += "<button type='button' class='btn' style='width:30px; font-size:12pt; color:#007bff;' onclick='spread_tbody( new Date("+paraMap.get("year")+", "+(Integer.parseInt(paraMap.get("month"))-1)+", 1), "+totalPage+")'><i class='fa-solid fa-forward-step'></i></button>"; 
		    
	    pageBar += "</div>";
		
	    jsonMap.put("pageBar", pageBar);
		jsonMap.put("paraMap", paraMap);
		jsonMap.put("mapList", mapList);
		
		return jsonMap;
		
	}
	
	@GetMapping("commuteChart")
	public ModelAndView commuteChart(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String departmentNo = request.getParameter("departmentNo");
		if(!"all".equals(departmentNo)) {
			
			DepartmentVO dvo = service.getdeptInfo(departmentNo);
			mav.addObject("departmentName", dvo.getDepartmentName());
		}
		
		mav.addObject("departmentNo", departmentNo);
		mav.setViewName("mycontent/commute/commuteChart");
			
		return mav;
	}
	
	@GetMapping("getCommuteCnt")
	@ResponseBody
	public Map<String, String> getCommuteCnt(@RequestParam Map<String,String> paraMap) {
		
		Map<String, String> map = service.getCommuteCnt(paraMap);

		return map;
		
	}
	
	@GetMapping("annualInfo")
	public ModelAndView annualInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String referer = request.getHeader("referer");
		
		if(referer == null) {
			mav.addObject("message", "비정상적인 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/index");
			mav.setViewName("msg");
			return mav;
		}
		
		mav.setViewName("mycontent/commute/annualInfo");
		mav.addObject("currentShowPageNo", "1");
		
		return mav;
	}
	
	@GetMapping("getAnnualTableInfo")
	@ResponseBody
	public Map<String, Object> getAnnualTableInfo(@RequestParam Map<String, String> paraMap) {
		
		Map<String, Object> jsonMap = new HashMap<>();
		
		String currentShowPageNo = "1";
		int totalCount = 0; 	// 총 게시물 수
		int sizePerPage = 0; 	// 페이지당 게시물 수
		int totalPage = 0; 		// 총 페이지 수
		int n_currentShowPageNo = 1;
		
		
		if(paraMap.get("currentShowPageNo") != null) {
			currentShowPageNo = paraMap.get("currentShowPageNo");
		}
		
		if(!"name".equals(paraMap.get("searchType")) ) {
			paraMap.put("searchType", "");
		}
		
		if(paraMap.get("searchWord").trim() == null) {
			paraMap.put("searchWord", "");
		}
		else {
			paraMap.put("searchWord", paraMap.get("searchWord").trim());
		}

		if(paraMap.get("sizePerPage") != null ) {
			sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		}
		
		totalCount = service.totalCnt_annaul(paraMap);

		totalPage = (int)( Math.ceil((double)totalCount/sizePerPage) );
		
		try {
			n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
			
			if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
	            n_currentShowPageNo = 1;
	        }
			
		} catch (NumberFormatException e) {
			n_currentShowPageNo = 1;
		}
		
		int startRno = ((n_currentShowPageNo - 1) * sizePerPage ) + 1;
		int endRno = startRno + sizePerPage -1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		List<Map<String, String>> mapList = service.getAnnualTableInfo(paraMap);
		
		int blockSize = 5; 
		int loop = 1;
		int pageNo = ((n_currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<div style='width:100%; margin:0 auto;'>";
		
	    pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody(1)'><i style='transform: scaleX(-1)' class='fa-solid fa-forward-step'></i></button>";
	    
	    if(n_currentShowPageNo > 1) {
	    	pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+ (pageNo-1) +")'><i class='fa-solid fa-chevron-left'></i></button>";

	    }
	    
	    while(!(loop > blockSize || pageNo > totalPage)) {
	    	
	    
	    	if(pageNo == n_currentShowPageNo) {
	            pageBar += "<button type='button'  class='btn' style='width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</button>";
	        }
	    	else {
	    		pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+pageNo+")'>"+pageNo+"</button>"; 
	    	}    
	    	
	    	loop++;
	    	pageNo++;
	           
	    }// end of while --------------------------------

	    
	    if(pageNo <= totalPage) {
	    	pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+pageNo+")'><i class='fa-solid fa-chevron-right'></i></button>"; 
	    }

	    pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+totalPage+")'><i class='fa-solid fa-forward-step'></i></button>"; 
		    
	    pageBar += "</div>";

	    
	    jsonMap.put("pageBar", pageBar);
	  	jsonMap.put("paraMap", paraMap);
	  	jsonMap.put("mapList", mapList);

		return jsonMap;
	}
	
	// 내 연차 조회 및 페이지 이동
	@GetMapping("mySalary")
	public ModelAndView mySalary(HttpServletRequest request, ModelAndView mav) {

		String referer = request.getHeader("referer");
		
		if(referer == null) {
			mav.addObject("message", "비정상적인 접근입니다.");
			mav.addObject("loc", request.getContextPath()+"/index");
			mav.setViewName("msg");
			return mav;
		}
		
		HttpSession session = request.getSession();

		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		String employeeNo = loginuser.getEmployeeNo();
			
		Map<String, String> map = service.getMyinfo(employeeNo);
			
		mav.addObject("currentShowPageNo", "1");
		mav.addObject("map", map);
		mav.setViewName("mycontent/commute/mySalary");

		return mav;
	}
	
	@GetMapping("getMySalaryInfo")
	@ResponseBody
	public Map<String, Object> getMySalaryInfo (@RequestParam Map<String, String> paraMap) {
		
		Map<String, Object> jsonMap = new HashMap<>();
		
		String currentShowPageNo = "1";
		int totalCount = 0; 	// 총 게시물 수
		int sizePerPage = 0; 	// 페이지당 게시물 수
		int totalPage = 0; 		// 총 페이지 수
		int n_currentShowPageNo = 1;
		
		
		if(paraMap.get("currentShowPageNo") != null) {
			currentShowPageNo = paraMap.get("currentShowPageNo");
		}
		
		if(paraMap.get("sizePerPage") != null ) {
			sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		}
		
		totalCount = service.totalCnt_mySalary(paraMap);

		totalPage = (int)( Math.ceil((double)totalCount/sizePerPage) );
		
		try {
			n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
			
			if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
	            n_currentShowPageNo = 1;
	        }
			
		} catch (NumberFormatException e) {
			n_currentShowPageNo = 1;
		}
		
		int startRno = ((n_currentShowPageNo - 1) * sizePerPage ) + 1;
		int endRno = startRno + sizePerPage -1;
		
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		List<Map<String, String>> mapList = service.getMySalaryInfo(paraMap);
		
		int blockSize = 5; 
		int loop = 1;
		int pageNo = ((n_currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String pageBar = "<div style='width:100%; margin:0 auto;'>";
		
	    pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody(1)'><i style='transform: scaleX(-1)' class='fa-solid fa-forward-step'></i></button>";
	    
	    if(n_currentShowPageNo > 1) {
	    	pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+ (pageNo-1) +")'><i class='fa-solid fa-chevron-left'></i></button>";

	    }
	    
	    while(!(loop > blockSize || pageNo > totalPage)) {
	    	
	    
	    	if(pageNo == n_currentShowPageNo) {
	            pageBar += "<button type='button'  class='btn' style='width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</button>";
	        }
	    	else {
	    		pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+pageNo+")'>"+pageNo+"</button>"; 
	    	}    
	    	
	    	loop++;
	    	pageNo++;
	           
	    }// end of while --------------------------------

	    
	    if(pageNo <= totalPage) {
	    	pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+pageNo+")'><i class='fa-solid fa-chevron-right'></i></button>"; 
	    }

	    pageBar += "<button type='button' class='btn' style='width: 30px; font-size:12pt; color:#007bff;' onclick='spread_tbody("+totalPage+")'><i class='fa-solid fa-forward-step'></i></button>"; 
		    
	    pageBar += "</div>";

	    
	    jsonMap.put("pageBar", pageBar);
	  	jsonMap.put("paraMap", paraMap);
	  	jsonMap.put("mapList", mapList);

		return jsonMap;
	}
	
	@GetMapping("changeAddAnnual")
	@ResponseBody
	public Map<String, Integer> changeAddAnnual(@RequestParam Map<String, String> paraMap) {
		
		int n = service.changeAddAnnual(paraMap);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map;
	}
	
	
	@GetMapping("organization")
	public ModelAndView orgChart(HttpServletRequest request, ModelAndView mav) {

		mav.setViewName("mycontent/commute/orgChart");

		return mav;
	}
	
	@GetMapping("getOrgChartInfo")
	@ResponseBody
	public Map<String, Object> getOrgChartInfo() {
		
		Map<String, Object> map = new HashMap<>();
		
		List<Map<String, String>> CEOList = service.getCEO();

		List<Map<String, String>> deptList = service.getDept();

		List<Map<String, String>> teamList = service.getTeam();
		
		map.put("CEOList", CEOList);
		map.put("deptList", deptList);
		map.put("teamList", teamList);
		
		return map;
	}
	
	
	
}
