package com.spring.app.employee.controller;



import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestBody;



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
	
/*	
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
*/
	
	// === #ljh2-1. 로그인 처리하기 === //
	
	@PostMapping("login")
	public ModelAndView login (HttpServletRequest request, @RequestParam Map<String,String>paraMap) {
		
		ModelAndView mav = new ModelAndView();
		
		//클라이언트 ip 가져오기
		String clientIp = request.getRemoteAddr();
		paraMap.put("clientIp", clientIp);

		EmployeeVO loginuser = service.login(paraMap);
		
		 
		if(loginuser != null ) { // 로그인 유저가 null 이 아닐때 
			
			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser); //로그인 유저 세션에 저장
			
			
			
			mav.setViewName("redirect:/index"); // 로그인이 성공했을 때 메인페이지로 이동
		}
		
		else {
			
			mav.addObject("message", "아이디 또는 비밀번호가 틀렸습니다");
			mav.addObject("loc", "javaScript:history.back()");
			mav.setViewName("msg"); // 실패 시 메시지 페이지로 이동
			
		}
		
		return mav;
	}
	
	
	
	// === #ljh6. 관리자  페이지 요청 === //
	@GetMapping("admin")
	public ModelAndView admin(ModelAndView mav) {
		mav.setViewName("mycontent/employee/admin_main");
		return mav;
	}
	
	
	// === #ljh7. 관리자 회원추가 페이지 요청 === //
	@GetMapping("addEmployee")
	public ModelAndView addEmployee(ModelAndView mav,  @RequestParam Map<String,String>paraMap) {
		mav.setViewName("mycontent/employee/addEmployee");
		return mav;
	}

	
	
	// === #ljh8.회원추가 처리 === //
	@PostMapping("addEmployeeFrm")
	public ModelAndView addEmployeeFrm(EmployeeVO empvo) {
		ModelAndView mav = new ModelAndView();
		
		int n = service.insert_employee(empvo);
		
		if(n != 0) {
			mav.setViewName("mycontent/employee/addEmployee");// 기존 페이지에 간다.
			System.out.println("사원 추가 성공적");
		}
		
		else { // 회원 추가 실패
			mav.addObject("message", "회원추가가 실패하였습니다");
			mav.addObject("loc", "javaScript:history.back()");
			mav.setViewName("msg"); // 실패 시 메시지 페이지로 이동
		}
		
	
		//System.out.println("확인");
		return mav;
	}
	
		
	
}