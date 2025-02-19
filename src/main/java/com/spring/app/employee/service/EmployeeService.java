package com.spring.app.employee.service;


import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.employee.domain.EmployeeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface EmployeeService {

//	List<Map<String, String>> test();

	// 로그인 처리하기
	int login(HttpServletRequest request, Map<String, String> paraMap, HttpServletResponse response, ModelAndView mav);

	//로그인 처리하기-1
	EmployeeVO login(Map<String, String> paraMap);

	//회원추가 처리
	int insert_employee(EmployeeVO empvo);


}
