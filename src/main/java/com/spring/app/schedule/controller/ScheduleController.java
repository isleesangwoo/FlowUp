package com.spring.app.schedule.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.spring.app.common.MyUtil;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.reservation.domain.AssetReservationVO;
import com.spring.app.reservation.service.ReservationService;
import com.spring.app.schedule.domain.Calendar_schedule_VO;
import com.spring.app.schedule.domain.Calendar_small_category_VO;
import com.spring.app.schedule.service.ScheduleService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value="/calendar/*")
public class ScheduleController {

	@Autowired
	private ScheduleService service;
	
	@Autowired
	private ReservationService serviceRe;
	
	
	// === 일정관리 시작 페이지 ===
	@GetMapping("")
	public ModelAndView requiredLogin_showSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		// System.out.println("와 이거 왜이래");
		mav.setViewName("mycontent/calendar/calendar");
		
		return mav;
	}
	
	
	// === 사내 캘린더에 사내캘린더 소분류 추가하기 ===
	@ResponseBody
	@PostMapping("addComCalendar")
	public String addComCalendar(HttpServletRequest request) throws Throwable {
		// System.out.println("와 이거 왜이래");
		String com_smcatgoname = request.getParameter("com_smcatgoname");
		String fk_employeeNo = request.getParameter("fk_employeeNo");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("com_smcatgoname",com_smcatgoname);
		paraMap.put("fk_employeeNo",fk_employeeNo);
		
		int n = service.addComCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}
	
	
	// === 내 캘린더에 내캘린더 소분류 추가하기 ===
	@ResponseBody
	@PostMapping("addMyCalendar")
	public String addMyCalendar(HttpServletRequest request) throws Throwable {
		
		String my_smcatgoname = request.getParameter("my_smcatgoname");
		String fk_employeeNo = request.getParameter("fk_employeeNo");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("my_smcatgoname",my_smcatgoname);
		paraMap.put("fk_employeeNo",fk_employeeNo);
		
		int n = service.addMyCalendar(paraMap);
				
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
		
		return jsObj.toString();
	}
	
	
	// === 사내 캘린더에서 사내캘린더 소분류  보여주기 ===
	@ResponseBody
	@GetMapping(value="showCompanyCalendar")  
	public String showCompanyCalendar() {
		
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showCompanyCalendar();
		
		JSONArray jsonArr = new JSONArray();
		
		if(calendar_small_category_VO_CompanyList != null) {
			for(Calendar_small_category_VO smcatevo : calendar_small_category_VO_CompanyList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
	// === 내 캘린더에서 내캘린더 소분류  보여주기 ===
	@ResponseBody
	@GetMapping(value="showMyCalendar") 
	public String showMyCalendar(HttpServletRequest request) {
		
		String fk_employeeNo = request.getParameter("fk_employeeNo");
		
		List<Calendar_small_category_VO> calendar_small_category_VO_CompanyList = service.showMyCalendar(fk_employeeNo);
		
		JSONArray jsonArr = new JSONArray();
		
		if(calendar_small_category_VO_CompanyList != null) {
			for(Calendar_small_category_VO smcatevo : calendar_small_category_VO_CompanyList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", smcatevo.getSmcatgono());
				jsObj.put("smcatgoname", smcatevo.getSmcatgoname());
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
	// === 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다) ===
	@PostMapping("insertSchedule")
	public ModelAndView insertSchedule(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) { 
		
		// form 에서 받아온 날짜
		String chooseDate = request.getParameter("chooseDate");
		
		mav.addObject("chooseDate", chooseDate);
		mav.setViewName("mycontent/calendar/insertSchedule");
		
		return mav;
	}
	
	
	// === 일정 등록시 내캘린더,사내캘린더 선택에 따른 서브캘린더 종류를 알아오기 ===
	@ResponseBody
	@GetMapping(value="selectSmallCategory") 
	public String selectSmallCategory(HttpServletRequest request) {
		
		String fk_lgcatgono = request.getParameter("fk_lgcatgono"); // 캘린더 대분류 번호
		String fk_employeeNo = request.getParameter("fk_employeeNo");       // 사용자아이디
		
		System.out.println("확인 fk_lgcatgono : " + fk_lgcatgono);
		System.out.println("확인 fk_employeeNo : " + fk_employeeNo);
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		paraMap.put("fk_employeeNo", fk_employeeNo);
		
		List<Calendar_small_category_VO> small_category_VOList = service.selectSmallCategory(paraMap);
		
		JSONArray jsArr = new JSONArray();
		if(small_category_VOList != null) {
			for(Calendar_small_category_VO scvo : small_category_VOList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("smcatgono", scvo.getSmcatgono());
				jsObj.put("smcatgoname", scvo.getSmcatgoname());
				
				jsArr.put(jsObj);
			}
		}
		
		return jsArr.toString();
	}
	
	
	
	// === 공유자를 찾기 위한 특정글자가 들어간 회원명단 불러오기 ===
	@ResponseBody
	@GetMapping(value="insertcalendar/searchJoinUserList")
	public String searchJoinUserList(HttpServletRequest request) {
		
		String joinUserName = request.getParameter("joinUserName");
		// System.out.println("공유자 이름 : " + joinUserName);
		// 사원 명단 불러오기
		List<EmployeeVO> joinUserList = service.searchJoinUserList(joinUserName);
		// System.out.println("공유자 이름 리스트 : " + joinUserList.size());
		JSONArray jsonArr = new JSONArray();
		if(joinUserList != null && joinUserList.size() > 0) {
			for(EmployeeVO mvo : joinUserList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("employeeNo", mvo.getEmployeeNo());
				jsObj.put("name", mvo.getName());
				
				jsonArr.put(jsObj);
			}
		}
		
		return jsonArr.toString();
		
	}
	
	
	// === 일정 등록하기 ===
	@PostMapping("registerSchedule_end")
	public ModelAndView registerSchedule_end(ModelAndView mav, HttpServletRequest request) throws Throwable {
		System.out.println("확인용 dsadsadsadsadsa ");
		String startdate= request.getParameter("startdate");
	//  System.out.println("확인용 startdate =>dsadsadsadsadsa " + startdate);
	//  확인용 startdate => 20231129140000
   	    
		String enddate = request.getParameter("enddate");
		String subject = request.getParameter("subject");
		String fk_lgcatgono= request.getParameter("fk_lgcatgono");
		String fk_smcatgono = request.getParameter("fk_smcatgono");
		String color = request.getParameter("color");
		String place = request.getParameter("place");
		String joinuser = request.getParameter("joinuser");
		
     //	System.out.println("확인용 joinuser => " + joinuser);
	 // 확인용 joinUser_es =>
	 // 또는 
	 // 확인용 joinUser_es => 이순신(leess),아이유1(iyou1),설현(seolh) 	
		
		String content = request.getParameter("content");
		String fk_employeeNo = request.getParameter("fk_employeeNo");
		
		String reservationContents = request.getParameter("reservationContents");
		String Fk_assetDetailNo = request.getParameter("Fk_assetDetailNo");
		
		
		AssetReservationVO assetreservationvo = new AssetReservationVO();

		assetreservationvo.setFk_assetDetailNo(Fk_assetDetailNo);
		assetreservationvo.setFk_employeeNo(fk_employeeNo);
		assetreservationvo.setReservationStart(startdate);
		assetreservationvo.setReservationEnd(enddate);
		assetreservationvo.setReservationContents(reservationContents);
		System.out.println("확인 Fk_assetDetailNo : " +Fk_assetDetailNo);
	//	System.out.println("확인 reservationContents : " + reservationContents);
		
	//	System.out.println("확인용 fk_employeeNo => " + fk_employeeNo);
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("subject", subject);
		paraMap.put("fk_lgcatgono",fk_lgcatgono);
		paraMap.put("fk_smcatgono", fk_smcatgono);
		paraMap.put("color", color);
		paraMap.put("place", place);
		
		paraMap.put("joinuser", joinuser);
		
		paraMap.put("content", content);
		paraMap.put("fk_employeeNo", fk_employeeNo);
		
		int result = 0;
		
		if(!"".equals(Fk_assetDetailNo)) {
			// System.out.println("공백!!!!!!!!!!!!!!");
			result = serviceRe.addReservation(assetreservationvo); // 예약추가를 해주는 메소드

			if(result != 1) {
				mav.addObject("message", "해당 시간내에 다른 예약건이 존재합니다.");
			}
			else {
				
				int n = service.registerSchedule_end(paraMap);
				
				if(n == 0) {
					mav.addObject("message", "일정 등록에 실패하였습니다.");
				}
				else {
					mav.addObject("message", "일정 등록에 성공하였습니다.");
				}
				
			}
			
		}
		else {
			
			int n = service.registerSchedule_end(paraMap);
	
			if(n == 0) {
				mav.addObject("message", "일정 등록에 실패하였습니다.");
			}
			else {
				mav.addObject("message", "일정 등록에 성공하였습니다.");
			}
			
		}
		
		mav.addObject("loc", request.getContextPath()+"/calendar/scheduleManagement");
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	
	
	// === 모든 캘린더(사내캘린더, 내캘린더, 공유받은캘린더)를 불러오는것 ===
	@ResponseBody
	@GetMapping(value="selectSchedule")
	public String selectSchedule(HttpServletRequest request) {
		
		// 등록된 일정 가져오기
		
		String fk_employeeNo = request.getParameter("fk_employeeNo");
		
		// System.out.println("fk_employeeNo 확인 : " + fk_employeeNo);
				
		List<Calendar_schedule_VO> scheduleList = service.selectSchedule(fk_employeeNo);
		
		JSONArray jsArr = new JSONArray();
		
		if(scheduleList != null && scheduleList.size() > 0) {
			
			for(Calendar_schedule_VO svo : scheduleList) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("subject", svo.getSubject());
				jsObj.put("startdate", svo.getStartdate());
				jsObj.put("enddate", svo.getEnddate());
				jsObj.put("color", svo.getColor());
				jsObj.put("scheduleno", svo.getScheduleno());
				jsObj.put("fk_lgcatgono", svo.getFk_lgcatgono());
				jsObj.put("fk_smcatgono", svo.getFk_smcatgono());
				jsObj.put("fk_employeeNo", svo.getFk_employeeNo());
				jsObj.put("joinuser", svo.getJoinuser());
				
				jsArr.put(jsObj);
			}// end of for-------------------------------------
		
		}
		
		return jsArr.toString();
	}
	
	
	
	// === 일정상세보기 ===
	@GetMapping(value="detailSchedule")
	public ModelAndView detailSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno = request.getParameter("scheduleno"); 
		// System.out.println("확인 scheduleno : " + scheduleno); // 확인 scheduleno : 2
		// 검색하고 나서 취소 버튼 클릭했을 때 필요함
		String listgobackURL_schedule = request.getParameter("listgobackURL_schedule");
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);

		
		// 일정상세보기에서 일정수정하기로 넘어갔을 때 필요함
		String gobackURL_detailSchedule = MyUtil.getCurrentURL(request);
		mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
		
		try {
			Integer.parseInt(scheduleno);
			Map<String,String> map = service.detailSchedule(scheduleno);
			mav.addObject("map", map);
			mav.setViewName("mycontent/calendar/detailSchedule");
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/calendar/");
		}
		
		return mav;
	}
	
	
	
	// === 일정삭제하기 ===
	@ResponseBody
	@PostMapping("deleteSchedule")
	public String deleteSchedule(HttpServletRequest request) throws Throwable {
		
		String scheduleno = request.getParameter("scheduleno");
				
		int n = service.deleteSchedule(scheduleno);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}
	
	
	
	
	// === 일정 수정하기 ===
	@PostMapping("editSchedule")
	public ModelAndView editSchedule(ModelAndView mav, HttpServletRequest request) {
		
		String scheduleno= request.getParameter("scheduleno");
   		
		try {
			Integer.parseInt(scheduleno);
			
			String gobackURL_detailSchedule = request.getParameter("gobackURL_detailSchedule");
			
			HttpSession session = request.getSession();
			EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
			
			Map<String,String> map = service.detailSchedule(scheduleno);
			
			if( !loginuser.getEmployeeNo().equals( map.get("fk_employeeNo") ) ) {
				String message = "다른 사용자가 작성한 일정은 수정이 불가합니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("message", message);
				mav.addObject("loc", loc);
				mav.setViewName("msg");
			}
			else {
				mav.addObject("map", map);
				mav.addObject("gobackURL_detailSchedule", gobackURL_detailSchedule);
				
				mav.setViewName("mycontent/calendar/editSchedule");
			}
		} catch (NumberFormatException e) {
			mav.setViewName("redirect:/schedule/calendar");
		}
		
		return mav;
		
	}
	
	
	
	// === 일정 수정 완료하기 ===
	@PostMapping("editSchedule_end")
	public ModelAndView editSchedule_end(Calendar_schedule_VO svo, HttpServletRequest request, ModelAndView mav) {
		
		try {
			 int n = service.editSchedule_end(svo);
			 
			 if(n==1) {
				 mav.addObject("message", "일정을 수정하였습니다.");
				 mav.addObject("loc", request.getContextPath()+"/calendar/calendar");
			 }
			 else {
				 mav.addObject("message", "일정 수정에 실패하였습니다.");
				 mav.addObject("loc", "javascript:history.back()");
			 }
			 
			 mav.setViewName("msg");
		} catch (Throwable e) {	
			e.printStackTrace();
			mav.setViewName("redirect:/calendar/calendar");
		}
			
		return mav;
	}
	
	
	
	// === (사내캘린더 또는 내캘린더)속의  소분류 카테고리인 서브캘린더 삭제하기  === 	
	@ResponseBody
	@PostMapping("deleteSubCalendar")
	public String deleteSubCalendar(HttpServletRequest request) throws Throwable {
		
		String smcatgono = request.getParameter("smcatgono");
				
		int n = service.deleteSubCalendar(smcatgono);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}
	
	
	
	// === (사내캘린더 또는 내캘린더)속의 소분류 카테고리인 서브캘린더 수정하기 === 
	@ResponseBody
	@PostMapping("editCalendar")
	public String editComCalendar(HttpServletRequest request) throws Throwable {
		System.out.println("왜이럼");
		String smcatgono = request.getParameter("smcatgono");
		String smcatgoname = request.getParameter("smcatgoname");
		String fk_employeeNo = request.getParameter("fk_employeeNo");
		String caltype = request.getParameter("caltype");
		
		System.out.println("확인 smcatgono " + smcatgono);
		System.out.println("확인 smcatgoname " + smcatgoname);
		System.out.println("확인 fk_employeeNo " + fk_employeeNo);
		System.out.println("확인 caltype " + caltype);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("smcatgono", smcatgono);
		paraMap.put("smcatgoname", smcatgoname);
		paraMap.put("fk_employeeNo", fk_employeeNo);
		paraMap.put("caltype", caltype);
		
		int n = service.editCalendar(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("n", n);
			
		return jsObj.toString();
	}
	
	
	// === 검색 기능 === //
	@GetMapping("searchSchedule")
	public ModelAndView searchSchedule(HttpServletRequest request, ModelAndView mav) { 
		
		List<Map<String,String>> scheduleList = null;
		
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String fk_employeeNo = request.getParameter("fk_employeeNo");  // 로그인한 사용자id
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		String str_sizePerPage = request.getParameter("sizePerPage");
	
		String fk_lgcatgono = request.getParameter("fk_lgcatgono");
		
		if(searchType==null || (!"subject".equals(searchType) && !"content".equals(searchType)  && !"joinuser".equals(searchType))) {  
			searchType="";
		}
		
		if(searchWord==null || "".equals(searchWord) || searchWord.trim().isEmpty()) {  
			searchWord="";
		}
		
		if(startdate==null || "".equals(startdate)) {
			startdate="";
		}
		
		if(enddate==null || "".equals(enddate)) {
			enddate="";
		}
			
		if(str_sizePerPage == null || "".equals(str_sizePerPage) || 
		   !("10".equals(str_sizePerPage) || "15".equals(str_sizePerPage) || "20".equals(str_sizePerPage))) {
				str_sizePerPage ="10";
		}
		
		if(fk_lgcatgono == null ) {
			fk_lgcatgono="";
		}
		
		Map<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("startdate", startdate);
		paraMap.put("enddate", enddate);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		paraMap.put("fk_employeeNo", fk_employeeNo);
		paraMap.put("str_sizePerPage", str_sizePerPage);

		paraMap.put("fk_lgcatgono", fk_lgcatgono);
		
		int totalCount=0;          // 총 게시물 건수		
		int currentShowPageNo=0;   // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage=0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)  
		int sizePerPage = Integer.parseInt(str_sizePerPage);  // 한 페이지당 보여줄 행의 개수
		int startRno=0;            // 시작 행번호
	    int endRno=0;              // 끝 행번호 
	    
	    // 총 일정 검색 건수(totalCount)
	    totalCount = service.getTotalCount(paraMap);
	//  System.out.println("~~~ 확인용 총 일정 검색 건수 totalCount : " + totalCount);
      
	    totalPage = (int)Math.ceil((double)totalCount/sizePerPage); 

		if(str_currentShowPageNo == null) {
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo);
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch (NumberFormatException e) {
				currentShowPageNo=1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
	    endRno = startRno + sizePerPage - 1;
	      
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    	   
	    scheduleList = service.scheduleListSearchWithPaging(paraMap);
	    // 페이징 처리한 캘린더 가져오기(검색어가 없다라도 날짜범위 검색은 항시 포함된 것임)
		
		mav.addObject("paraMap", paraMap);
		// 검색대상 컬럼과 검색어를 유지시키기 위한 것임.
		
		// === 페이지바 만들기 === //
		int blockSize= 5;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
	   
		String pageBar = "<ul style='list-style:none;'>";
		
		String url = "searchSchedule";
		
		// === [맨처음][이전] 만들기 ===
		if(pageNo!=1) {
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_employeeNo="+fk_employeeNo+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_employeeNo="+fk_employeeNo+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		while(!(loop>blockSize || pageNo>totalPage)) {
			
			if(pageNo==currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_employeeNo="+fk_employeeNo+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
		}// end of while--------------------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_employeeNo="+fk_employeeNo+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
			pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?startdate="+startdate+"&enddate="+enddate+"&searchType="+searchType+"&searchWord="+searchWord+"&fk_employeeNo="+fk_employeeNo+"&fk_lgcatgono="+fk_lgcatgono+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
		}
		pageBar += "</ul>";
		
		mav.addObject("pageBar",pageBar);
		
		String listgobackURL_schedule = MyUtil.getCurrentURL(request);
	//	System.out.println("~~~ 확인용 검색 listgobackURL_schedule : " + listgobackURL_schedule);
		
		mav.addObject("listgobackURL_schedule",listgobackURL_schedule);
		mav.addObject("scheduleList", scheduleList);
		mav.setViewName("mycontent/calendar/searchSchedule");

		return mav;
	}
	
	
	// 해당날짜의 일정이 곂쳐있는 사람을 조회하는 기능
	@GetMapping("displayUserListSelect")
	@ResponseBody
	public List<Map<String, String>> displayUserListSelect(@RequestParam String fk_employeeno,
														   @RequestParam String selectDay) {
		
		// System.out.println("plusUserArr 확인~~ : " + plusUserArr);
		// System.out.println("selectDay 확인~~ : " + selectDay);
		// plusUserArr 확인~~ : 100020
		// selectDay 확인~~ : 20250312
		
		Map<String, Object> paraMap = new HashMap<>();
		 
		// paraMap.put("plusUserArr", plusUserArr.split(","));
		paraMap.put("fk_employeeno", fk_employeeno);
		paraMap.put("startdate", selectDay+" 000000");
		paraMap.put("enddate", selectDay+" 235959");
		
		// System.out.println(paraMap.get("plusUserArr") +" 그리고 "+ paraMap.get("startdate") +" 그리고 "+ paraMap.get("enddate"));
		// 100012,100013 그리고 20250313 000000 그리고 20250313 235959
		
		List<Map<String, String>> list = service.displayUserListSelect(paraMap); // 해당날짜의 일정이 곂쳐있는 사람을 조회하는 기능
		
		return list;
	}
	
	
	
	
	

	
}
