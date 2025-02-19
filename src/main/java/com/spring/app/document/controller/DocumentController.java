package com.spring.app.document.controller;

import java.net.http.HttpRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	
	
	// 휴가신청서 페이지
	@GetMapping("annual")
	public ModelAndView annual(ModelAndView mav) {
		
		mav.setViewName("mycontent/document/annual");
		
		return mav;
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
	
	
	// 임시저장함
	@GetMapping("tempList")
	public ModelAndView tempList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
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
	
	
	// 기안 문서함
	@GetMapping("myDocumentList")
	public ModelAndView myDocumentList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		String employeeNo = null;
		
		if(loginuser != null) {
			employeeNo = loginuser.getEmployeeNo();
		}
		else {
			employeeNo = "100014";
		}
		
		List<DocumentVO> myDocumentList = service.myDocumentList(employeeNo);
		// 기안 문서 리스트 가져오기
		
		mav.addObject("myDocumentList", myDocumentList);
		mav.setViewName("mycontent/document/myDocumentList");
		
		return mav;
	}
	
	
	// 부서 문서함
	@GetMapping("deptDocumentList")
	public ModelAndView deptDocumentList(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
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
	
}
