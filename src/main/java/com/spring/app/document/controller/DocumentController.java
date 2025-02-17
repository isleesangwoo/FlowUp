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
		
		paraMap.put("documentType", "휴가신청서");
		if(loginuser != null) {
			
			paraMap.put("fk_emloyeeNo", loginuser.getEmployeeNo());
			
		}
		else {
			paraMap.put("fk_emloyeeNo", "100014");
		}
		
		int n = service.annualDraft(paraMap);
		
		Map<String, String> map = new HashMap<>();
		
		map.put("n", String.valueOf(n));
		
		return map;
	}
	
}
