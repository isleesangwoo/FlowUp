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

// === #25. 공통관심사 클래스(Aspect 클래스) 생성하기 === //
// AOP (Aspect Oriented Programming)

@Aspect		// 공통관심사 클래스(Aspect 클래스)로 등록된다.
@Component	// bean 으로 동록된다.
			// !!! 중요 !!! MyspringApplication 클래스에서 @EnableAspectJAutoProxy 을 기재해야 한다.
public class CommonAop {
	
	// ===== Before Advice(보조업무) 만들기 ====== // 
	/*
		주업무(<예: 글쓰기, 글수정, 댓글쓰기, 직원목록조회 등등>)를 실행하기 앞서서  
		이러한 주업무들은 먼저 로그인을 해야만 사용가능한 작업이므로
		주업무에 대한 보조업무<예: 로그인 유무검사> 객체로 로그인 여부를 체크하는
		관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
		동작하도록 만들겠다.
	*/
	
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
	
	
	// ===== #78. After Advice(보조업무) 만들기 ====== //
	/*
		주업무(<예: 글쓰기, 제품구매 등등>)를 실행한 다음에
		회원의 포인트를 특정점수(예: 100점, 200점, 300점) 증가해 주는 것이 공통의 관심사(보조업무)라고 보자.
		관심 클래스(Aspect 클래스)를 생성하여 포인트컷(주업무)과 어드바이스(보조업무)를 생성하여
		동작하도록 만들겠다.
	*/
	// ==== Pointcut(주업무)을 설정해야 한다. ==== //
	//		Pointcut 이란 공통관심사<예: 로그인 유무검사>를 필요로 하는 메소드를 말한다.
	@Pointcut("execution(public * com.spring.app..*Controller.pointPlus_*(..) )")
	public void pointPlus() {}
	
	@Autowired
	private BoardService service;
	
	// === After Advice(공통관심사, 보조업무)를 구현한다. === //
	// 회원의 포인트를 특정점수(예: 100점, 200점, 300점) 만큼 증가시키는 메소드 생성하기
	@SuppressWarnings("unchecked") // 앞으로는 노란줄 경고 표시를 하지말라는 뜻이다.
	@AfterReturning("pointPlus()")	// @AfterReturning	는 주업무 메소드(Pointcut)가 성공한 다음에 실행된다.
//	@AfterThrowing("pointPlus()")	// @AfterThrowing	는 주업무 메소드(Pointcut)가 실패한 다음에 실행된다.
//	@After("pointPlus()")			// @After			는 주업무 메소드(Pointcut)의 성공 여부에 상관없이 실행된다.
	public void pointPlus(JoinPoint joinpoint) {
		// JoinPoint joinpoint 는 포인트컷 되어진 주업무의 메소드이다.
		
		Map<String, String> paraMap = (Map<String, String>) joinpoint.getArgs()[0];
		// 주업무 메소드의 첫번째 파라미터를 얻어오는 것이다.
		
		service.pointPlus(paraMap);
	}
	
	
	// ===== Around Advice(보조업무) 만들기 ====== //
	
}
