package com.spring.app.member.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.Sha256;
import com.spring.app.member.domain.MemberVO;
import com.spring.app.member.model.MemberDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


// === #12. 서비스 선언 ===
@Service
public class MemberService_imple implements MemberService {

	@Autowired	// Type 에 따라 알아서 Bean 을 주입해준다.
	private MemberDAO dao;

	
	// === #20. 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency Injection) === //
	@Autowired
	private AES256 aes;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.app.common.AES256 의 bean 을  aES256 에 주입시켜준다. 
	// 그러므로 aES256 는 null 이 아니다.
	// com.spring.app.common.AES256 의 bean 은 com.spring.app.config.AES256_Configuration 클래스 에서 메소드로 bean 을 등록시켜주었음.
	
	// === #16. 로그인 처리하기 === //
	@Override
	public MemberVO getLoginMember(Map<String, String> paraMap) {
		
		MemberVO loginuser = dao.getLoginMember(paraMap);
		
		if( loginuser != null ) {
			
			if(loginuser.getLastlogingap() >= 12 && loginuser.getIdle() == 0) {
				// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정
				
				loginuser.setIdle(1);
				
				// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 === //
				dao.updateIdle(paraMap.get("userid"));
			}
			
			if(loginuser.getIdle() == 0) { // 휴면이 아닌 계정
				
				try {
					String email = aes.decrypt(loginuser.getEmail());
					String mobile = aes.decrypt(loginuser.getMobile());
					
					loginuser.setEmail(email);
					loginuser.setMobile(mobile);
					
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
			}
			
			if(loginuser.getPwdchangegap() >= 3 ) { // 비밀번호가 변경 된지 3개월 이상인 경우
				// mapper 에서 set을 해주어서 get 을 할 수 있다.
				loginuser.setRequirePwdChange(true);
			}
		}
		
		return loginuser;
	}
	
	// tbl_loginhistory 테이블에 insert 해주기
	@Override
	public void insert_tbl_loginhistory(Map<String, String> paraMap) {
		
		dao.insert_tbl_loginhistory(paraMap);
	}

	
	// 로그아웃 처리하기
	@Override
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

	
	// 로그인 처리하기
	@Override
	public ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap) {

		paraMap.put("pwd", Sha256.encrypt(paraMap.get("pwd")));
		
		MemberVO loginuser = dao.getLoginMember(paraMap);
		
		if( loginuser != null ) {
			
			if(loginuser.getLastlogingap() >= 12 && loginuser.getIdle() == 0) {
				// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정
				
				loginuser.setIdle(1);
				
				// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기 === //
				dao.updateIdle(paraMap.get("userid"));
			}
			
			if(loginuser.getIdle() == 0) { // 휴면이 아닌 계정
				
				try {
					String email = aes.decrypt(loginuser.getEmail());
					String mobile = aes.decrypt(loginuser.getMobile());
					
					loginuser.setEmail(email);
					loginuser.setMobile(mobile);
					
				} catch (UnsupportedEncodingException | GeneralSecurityException e) {
					e.printStackTrace();
				}
			}
			
			if(loginuser.getPwdchangegap() >= 3 ) { // 비밀번호가 변경 된지 3개월 이상인 경우
				// mapper 에서 set을 해주어서 get 을 할 수 있다.
				loginuser.setRequirePwdChange(true);
			}
			
		} // end of if(loginuser != null)------------------------------------------------------
		
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
				
				dao.insert_tbl_loginhistory(paraMap); // tbl_loginhistory 테이블에 insert 해주기
				
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
}
