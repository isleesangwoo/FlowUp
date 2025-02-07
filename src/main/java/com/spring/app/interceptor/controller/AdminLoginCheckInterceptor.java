package com.spring.app.interceptor.controller;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.spring.app.employee.domain.EmployeeVO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
   Interceptor 는 Spring 에서 제공해주는 기능이다.
   이 Interceptor 를 통해서 특정 URL 요청이 Controller 에서 실행하기전에 먼저 가로채서 다른 특정 작업을 진행할 수 있도록 해준다.
   이를 통해서 특정 URL 요청의 전,후 처리가 가능해진다. 
*/

@Component
// spring 5.3 미만 버전시 사용하는 것
// public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

// spring 5.3 이상 버전에서는 HandlerInterceptorAdapter 를 더이상 사용하지 않는다(deprecated)고 함.
// extends HandlerInterceptorAdapter 대신에  implements HandlerInterceptor 를 사용해야 함.
public class AdminLoginCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		/*
			preHandle() 메소드는 지정된 컨트롤러의 동작 이전에 호출된다. preHandle() 메소드에서 false를 리턴하면 다음
			내용(Controller의 동작)을 실행하지 않는다. true를 리턴하면 다음 내용(Controller의 동작)을 실행하게 된다.
		*/
		
		// Object handler는 특정 URL 요청에 응대해야할 Controller 클래스의 객체이다.
		// 즉, 우리가 하는 실습에서의 Object handler 는 InterceptorTestController 클래스의 객체인 것이다.

		/*
			[참고] postHandle() 메소드 : 컨트롤러가 실행된 후에 호출된다. 그러므로 컨트롤러에서 예외가 발생한다면 실행되지 않는다.
			
			@Override public void postHandle( HttpServletRequest request,
			HttpServletResponse response, Object obj, ModelAndView mav) throws Exception
			{
			
			}
			
			afterCompletion() 메소드 : 뷰에서 최종 결과가 생성하는 일을 포함한 모든 일이 완료 되었을 때 실행된다.
			
			@Override public void afterCompletion( HttpServletRequest request,
			HttpServletResponse response, Object obj, Exception e) throws Exception {
			
			}
		*/

		// 로그인 여부 검사
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");

		if (loginuser == null || (loginuser != null)) {
			// 로그인이 되지 않았거나 로그인 되어진 사용자의 등급이 10 미만 이라면
			String message = "관리자 등급으로 로그인 하세요(인터셉터활용)~~~";

			String loc = "";

			if (loginuser == null) {
				loc = request.getContextPath() + "/member/login";
			} else {
				loc = "javascript:history.back()";
			}
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/msg.jsp");
			dispatcher.forward(request, response);

			return false;
		}

		return true;
	}
	/*
		다음으로 com.spring.app.config.Interceptor_Configuration 에 가서 사용하도록 설정을 해주어야 한다.
	*/
}
