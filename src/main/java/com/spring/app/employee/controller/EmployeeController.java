package com.spring.app.employee.controller;



import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.employee.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


//=== 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/employee/*")
public class EmployeeController {

	@Autowired	// Type 에 따라 알아서 Bean 을 주입해준다.
	private EmployeeService service;
	
	
	// === #ljh1. 로그인 폼 페이지 요청 === //
	@GetMapping("login")
	public ModelAndView login(ModelAndView mav) {
		mav.setViewName("mycontent/employee/login");
		return mav;
	}
	
	
	// === #ljh2. 로그인 처리하기 === //
	@PostMapping("login")
	public Map<String,Integer> login(HttpServletRequest request, @RequestParam Map<String,String>paraMap, 
									 HttpServletResponse response, ModelAndView mav) {
		
		int n = 0; // 0:실패, 1:성공
		Map<String,Integer>resultMap = new HashMap<>(); // 되돌려줄 값
		
		// 클라이언트 ip 값 불러오기
		String clientIp = request.getRemoteAddr(); 
		paraMap.put("clientIp", clientIp);
		
		
		n = service.login(request, paraMap, response,mav);
		
		resultMap.put("n", n);

		return resultMap;
	}
	
	
	
}