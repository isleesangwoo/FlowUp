package com.spring.app.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.spring.app.interceptor.controller.AdminLoginCheckInterceptor;
import com.spring.app.interceptor.controller.LoginCheckInterceptor;

@Configuration	// Spring 컨테이너가 처리해주는 클래스로서, 클래스내에 하나 이상의 @Bean 메소드를 선언만 해주면 런타임시 해당 빈에 대해 정의되어진 대로 요청을 처리해준다.
public class Interceptor_Configuration implements WebMvcConfigurer {
	
	
	// 로그인 Interceptor 설정하기
	@Autowired
	LoginCheckInterceptor loginCheckInterceptor;
	
	// 관리자 권한이 있는 사용자 로그인 Interceptor 설정하기
	@Autowired
	AdminLoginCheckInterceptor adminLoginCheckInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
	
		registry.addInterceptor(loginCheckInterceptor)
				.addPathPatterns("/**/*") //해당 경로에 접근하기 전에 인터셉터가 가로챈다.
				.addPathPatterns("/**/**/") //해당 경로에 접근하기 전에 인터셉터가 가로챈다.
				.excludePathPatterns("/employee/login", "/bootstrap-4.6.2-dist/**", "/js/**", "/jquery-ui-1.13.1.custom/**", "/css/**", "/images/**");
		
		registry.addInterceptor(adminLoginCheckInterceptor)
				.addPathPatterns("/interceptor/special_member/special_member_a", "/interceptor/special_member/special_member_b"); //해당 경로에 접근하기 전에 인터셉터가 가로챈다.
		
		/*
			addInterceptor() : 인터셉터를 등록해준다.
			addPathPatterns() : 인터셉터를 호출하는 주소와 경로를 추가한다. 
			excludePathPatterns() : 인터셉터 호출에서 제외하는 주소와 경로를 추가한다. 
		*/
		
	}
	
//	@Override
//	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(loginCheckInterceptor)
//				.addPathPatterns("/**/*") // 해당 경로에 접근하기 전에 인터셉터가 가로챈다.
//				.excludePathPatterns("/", "/index", "/member/login", "/member/loginEnd", "/board/list", "/board/view", "/interceptor/anyone/**", "/interceptor/special_member/**"); // 해당 경로는 인터셉터가 가로채지 않는다.
//      
//		addInterceptor() : 인터셉터를 등록해준다.
//		addPathPatterns() : 인터셉터를 호출하는 주소와 경로를 추가한다. 
//		excludePathPatterns() : 인터셉터 호출에서 제외하는 주소와 경로를 추가한다. 
//	}
}
