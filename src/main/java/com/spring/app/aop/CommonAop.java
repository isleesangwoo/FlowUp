package com.spring.app.aop;

import java.io.IOException;
import java.util.Map;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.spring.app.board.service.BoardService;
import com.spring.app.common.MyUtil;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Aspect		// 공통관심사 클래스(Aspect 클래스)로 등록된다.
@Component	// bean 으로 동록된다.
public class CommonAop {
	
	// ==== Pointcut(주업무)을 설정해야 한다. ==== //
	//		Pointcut 이란 공통관심사<예: 로그인 유무검사>를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring.app..*Controller.requiredLogin_*(..) )")
	public void requiredLogin() {}
	
	
	// ===== Before Advice(공통관심사, 보조업무)를 구현한다. ====== //
	@Before("requiredLogin()")
	public void loginCheck(JoinPoint joinpoint) { // 로그인 유무 검사를 하는 메소드 작성하기
		// JoinPoint joinpoint 는 포인트컷 되어진 주 업무의 메소드이다.
		
		// 로그인 유무를 확인하기 위해서는 request 를 통해 session 을 얻어와야 한다.
		HttpServletRequest request = (HttpServletRequest) joinpoint.getArgs()[0];	// 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다.
		HttpServletResponse response = (HttpServletResponse) joinpoint.getArgs()[1];	// 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다.
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginuser") == null) {
			String message = "먼저 로그인 하세요~~ (AOP Before Advice 활용)";
			String loc = request.getContextPath() + "/member/login";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// >>> 로그인 성공 후 로그인 하기전 페이지로 돌아가는 작업 만들기 <<< //
			String url = MyUtil.getCurrentURL(request);
			session.setAttribute("goBackURL", url); // 세션에 url 정보를 저장시켜둔다.
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			try {
				dispatcher.forward(request, response);
			} catch (ServletException | IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	
}
