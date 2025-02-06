package com.spring.app.member.controller;

import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.Sha256;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

//=== #11. 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/member/*")
public class MemberController {

	@Autowired	// Type 에 따라 알아서 Bean 을 주입해준다.
	private MemberService service;
	
	// === 로그인 폼 페이지 요청 === //
	@GetMapping("login")
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("mycontent1/login/loginform");
		
		return mav;
	}
	
	// === 로그인 처리하기 === //
	@PostMapping("login")
	public ModelAndView login(ModelAndView mav,
							  @RequestParam Map<String, String> paraMap,
							  HttpServletRequest request) {
		
		// === 클라이언트의 IP 주소를 알아오는 것 === //
		String clientip = request.getRemoteAddr();
		paraMap.put("clientip", clientip);
		
		mav = service.login(mav, request, paraMap);
		
		return mav;
	}
	
	
	// === 로그아웃 처리하기 === //
	@GetMapping("logout")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		mav = service.logout(mav, request);
		return mav;
	}
	
}