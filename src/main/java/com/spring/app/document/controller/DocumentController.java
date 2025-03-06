package com.spring.app.document.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.document.domain.ApprovalVO;
import com.spring.app.document.domain.DocumentVO;
import com.spring.app.document.service.DocumentService;
import com.spring.app.employee.domain.EmployeeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/document/*")
public class DocumentController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private DocumentService service;
	
	// 전자결재 메인 페이지
	@GetMapping("")
	public ModelAndView document(ModelAndView mav) {
		
		mav.setViewName("mycontent/document/document");
		
		return mav;
	}
	
	
	// 결재대기문서함
	@GetMapping("todoList")
	public ModelAndView todoList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 테스트 중 로그인 안하고 처리하기 위해 임시로 사원번호 입력
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		List<DocumentVO> todoList = service.todoList(employeeNo);
		// 결재 대기 문서 리스트 가져오기
		
		mav.addObject("todoList", todoList);
		mav.setViewName("mycontent/document/todoList");
		
		return mav;
	}
	
	
	// 결재예정문서함
	@GetMapping("upcomingList")
	public ModelAndView upcomingList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 테스트 중 로그인 안하고 처리하기 위해 임시로 사원번호 입력
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		List<DocumentVO> upcomingList = service.upcomingList(employeeNo);
		// 결재 예정 문서 리스트 가져오기
		
		mav.addObject("upcomingList", upcomingList);
		mav.setViewName("mycontent/document/upcomingList");
		
		return mav;
	}
		
	
	// 기안 문서함
	@GetMapping("myDocumentList")
	public ModelAndView myDocumentList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 테스트 중 로그인 안하고 처리하기 위해 임시로 사원번호 입력
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		List<DocumentVO> myDocumentList = service.myDocumentList(employeeNo);
		// 기안을 올린 문서 리스트 가져오기
		
		mav.addObject("myDocumentList", myDocumentList);
		mav.setViewName("mycontent/document/myDocumentList");
		
		return mav;
	}
	
	
	// 임시저장함
	@GetMapping("tempList")
	public ModelAndView tempList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 테스트 중 로그인 안하고 처리하기 위해 임시로 사원번호 입력
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		List<DocumentVO> tempList = service.tempList(employeeNo);
		// 임시 저장 문서 리스트 가져오기
		
		mav.addObject("tempList", tempList);
		mav.setViewName("mycontent/document/tempList");
		
		return mav;
	}
	
	
	// 결재 문서함
	@GetMapping("approvedList")
	public ModelAndView approvedList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 테스트 중 로그인 안하고 처리하기 위해 임시로 사원번호 입력
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		List<DocumentVO> approvedList = service.approvedList(employeeNo);
		// 결재 처리한 문서 리스트 가져오기
		
		mav.addObject("approvedList", approvedList);
		mav.setViewName("mycontent/document/approvedList");
		
		return mav;
	}
	
	
	// 부서 문서함
	@GetMapping("deptDocumentList")
	public ModelAndView deptDocumentList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 테스트 중 로그인 안하고 처리하기 위해 임시로 사원번호 입력
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		List<DocumentVO> deptDocumentList = service.deptDocumentList(employeeNo);
		// 부서 문서 리스트 가져오기
		
		mav.addObject("deptDocumentList", deptDocumentList);
		mav.setViewName("mycontent/document/deptDocumentList");
		
		return mav;
	}
	
	
	// 결제 예정 문서와 결제 대기 문서의 갯수 가져오기
	@GetMapping("getDocCount")
	@ResponseBody
	public Map<String, Integer> getDocCount(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		// 테스트 중 로그인 안하고 처리하기 위해 임시로 사원번호 입력
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		Map<String, Integer> countList = new HashMap<>();
		
		int todoCount = service.todoList(employeeNo).size();			// 결재 처리할 문서 수
		int upcomingCount = service.upcomingList(employeeNo).size();	// 결제 예정인 문서 수
		
		countList.put("todoCount", todoCount);
		countList.put("upcomingCount", upcomingCount);
		
		return countList;
	}
	
	
	
	// 문서함에서 문서 1개 보기
	@GetMapping("documentView")
	public ModelAndView documentView(ModelAndView mav, @RequestParam Map<String, String> paraMap) {
		
		Map<String, String> document = service.documentView(paraMap);
		// 문서함에서 문서 1개 보여주기
		List<ApprovalVO> approvalList = service.getApprovalList(paraMap.get("documentNo"));
		// 문서함에서 보여줄 결재자 리스트 가져오기
		
		mav.addObject("document", document);
		mav.addObject("approvalList", approvalList);
		mav.setViewName("mycontent/document/documentView");
		
		return mav;
	}
	
	
	// 휴가신청서 페이지
	@GetMapping("annual")
	public ModelAndView annual(ModelAndView mav) {
		
		mav.setViewName("mycontent/document/annual");
		
		return mav;
	}
	
	
	// 조직도에 뿌려주기 위한 사원 목록 가져오기
	@GetMapping("getEmployeeList")
	@ResponseBody
	public List<EmployeeVO> getEmployeeList(){
		
		List<EmployeeVO> employeeList = service.getEmployeeList();
		return employeeList;
		
	}
	
	
	// 휴가신청서 결재 요청 
	@PostMapping("annualDraft")
	@ResponseBody
	public Map<String, String> annualDraft(@RequestParam Map<String, String> paraMap, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			paraMap.put("fk_employeeNo", loginuser.getEmployeeNo());
		}
		else {
			paraMap.put("fk_employeeNo", "100014");
		}
		
		int n = service.annualDraft(paraMap);
		
		Map<String, String> map = new HashMap<>();
		
		map.put("n", String.valueOf(n));
		
		return map;
	}
	
	
	// 임시저장하기
	@PostMapping("saveTemp")
	@ResponseBody
	public Map<String, String> saveTemp(@RequestParam Map<String, String> paraMap, HttpServletRequest request){
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			paraMap.put("fk_employeeNo", loginuser.getEmployeeNo());
		}
		else {
			paraMap.put("fk_employeeNo", "100014");
		}
		
		if("휴가신청서".equals(paraMap.get("documentType"))) {
			if("".equals(paraMap.get("startDate"))) {
				paraMap.put("startDate", "1111-11-11");
			}
			if("".equals(paraMap.get("endDate"))) {
				paraMap.put("endDate", "1111-11-11");
			}
		}
		
		paraMap.put("temp", "1");
		
		int n = service.annualDraft(paraMap);
		
		Map<String, String> map = new HashMap<>();
		
		map.put("n", String.valueOf(n));
		
		return map;
	}
	
	
	// 결재 승인하기
	@GetMapping("documentView/approve")
	@ResponseBody
	public String approve(HttpServletRequest request, @RequestParam String documentNo) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		
		Map<String, String> map = new HashMap<>();
		
		map.put("documentNo", documentNo);
		map.put("employeeNo", employeeNo);
		
		int n = service.approve(map);
		
		JSONObject json = new JSONObject();
		
		json.put("n", n);
		
		return json.toString();
	}
	
}
