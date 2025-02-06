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
	
	
	// === #14. 로그인 폼 페이지 요청 === //
	@GetMapping("login")
	public ModelAndView login(ModelAndView mav) {
		
		mav.setViewName("mycontent1/login/loginform");
		
		return mav;
	}
	
	
	// === #15. 로그인 처리하기 === //
/*
	@PostMapping("login")
//	public ModelAndView login(ModelAndView mav,
//							  HttpServletRequest request) {
//	또는	
	public ModelAndView login(ModelAndView mav,
							  @RequestParam Map<String, String> paraMap,
							  HttpServletRequest request) {
		
//		String userid = request.getParameter("userid");
//		String pwd = request.getParameter("pwd");
		
//		Map<String, String> paraMap = new HashedMap<>();
//		paraMap.put("userid", userid);
//		paraMap.put("pwd", Sha256.encrypt(pwd));
		
		paraMap.put("pwd", Sha256.encrypt(paraMap.get("pwd")));
		
		// === 클라이언트의 IP 주소를 알아오는 것 === //
		// /myspring/src/main/webapp/JSP 파일을 실행시켰을 때 IP 주소가 제대로 출력되기위한 방법.txt 참조할 것
		String clientip = request.getRemoteAddr();
		paraMap.put("clientip", clientip);
		
		MemberVO loginuser = service.getLoginMember(paraMap);
		// 사용자가 입력한 값들을 Map 에 담아서 서비스 객체에게 넘겨 처리하도록 한다.
		
		if(loginuser == null) { // 로그인 실패 시
			String message = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("message",message);
			mav.addObject("loc",loc);
			
			mav.setViewName("msg");
			//	/WEB-INF/views/msg.jsp 파일을 생성한다.
		}
		else { // 아이디와 암호가 존재하는 경우
			
			if(loginuser.getIdle() == 1) { // 로그인 한지 1년이 경과한 경우
				
				String message = "로그인을 한지 1년이 지나서 휴면상태로 되었습니다.\\n관리자에게 문의 바랍니다.";
				String loc = request.getContextPath() + "/index";
				// 원래는 위와 같이 index 이 아니라 휴면의 계정을 풀어주는 페이지로 잡아주어야 한다.

				mav.addObject("message", message);
				mav.addObject("loc", loc);

				mav.setViewName("msg");
			}
			else { // 로그인 한지 1년 이내인 경우
				
				HttpSession session = request.getSession();
				// 메모리에 생성되어져 있는 session 을 불러온다.
				
				session.setAttribute("loginuser", loginuser);
				// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
				
				service.insert_tbl_loginhistory(paraMap); // tbl_loginhistory 테이블에 insert 해주기
				
				if(loginuser.isRequirePwdChange() == true) { // 암호를 마지막으로 변경한 것이 3개월이 경과한 경우
					String message = "비밀번호를 변경하신지 3개월이 지났습니다.\\n암호를 변경하시는 것을 추천합니다.";
					String loc = request.getContextPath() + "/index";
					// 원래는 위와 같이 index 이 아니라 사용자의 비밀번호를 변경해주는 페이지로 잡아주어야 한다.

					mav.addObject("message", message);
					mav.addObject("loc", loc);

					mav.setViewName("msg");
				}
				
				else { // 암호를 마지막으로 변경한 것이 3개월 이내인 경우

					// 로그인을 해야만 접근할 수 있는 페이지에 로그인을 하지 않은 상태에서 접근을 시도한 경우
					// "먼저 로그인을 하세요!!" 라는 메시지를 받고서 사용자가 로그인을 성공했다라면
					// 화면에 보여주는 페이지는 시작페이지로 가는 것이 아니라
					// 조금전 사용자가 시도하였던 로그인을 해야만 접근할 수 있는 페이지로 가기 위한 것이다.
					
					String goBackURL = (String) session.getAttribute("goBackURL");
					
					if(goBackURL != null) {
						mav.setViewName("redirect:" + goBackURL);
						session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다.
					}
					else {
						mav.setViewName("redirect:/index"); // 시작페이지로 이동
					}
					
				}
			}
			
		}
		
		return mav;
	}
*/
	
	// === 또는 === //
	@PostMapping("login")
	public ModelAndView login(ModelAndView mav,
							  @RequestParam Map<String, String> paraMap,
							  HttpServletRequest request) {
		
		// === 클라이언트의 IP 주소를 알아오는 것 === //
		// /myspring/src/main/webapp/JSP 파일을 실행시켰을 때 IP 주소가 제대로 출력되기위한 방법.txt 참조할 것
		String clientip = request.getRemoteAddr();
		paraMap.put("clientip", clientip);
		
		mav = service.login(mav, request, paraMap);
		
		return mav;
	}
	
	
	// === #21. 로그아웃 처리하기 === //
/*
	@GetMapping("logout")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String message = "로그아웃되었습니다.";
		String loc = request.getContextPath() + "/index";
		// 원래는 위와 같이 index 이 아니라 휴면의 계정을 풀어주는 페이지로 잡아주어야 한다.

		mav.addObject("message", message);
		mav.addObject("loc", loc);

		mav.setViewName("msg");
		return mav;
	}
*/	
	
	// === 또는 === //
	@GetMapping("logout")
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		mav = service.logout(mav, request);
		return mav;
	}
	
}