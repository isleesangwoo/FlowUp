package com.spring.app.employee.service;


import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.employee.domain.AddressBookVO;
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

	// === 부서번호, 부서명 알아오기 === //
	List<Map<String, String>> departmentno_select();

	// === 직급번호, 직급명 알아오기 === //
	List<Map<String, String>> positionno_select();

	// === 부서번호별 팀번호 알아오기 === 
	List<Map<String, String>> teamNo_seek_BydepartmentNo(String departmentNo);

	//로그아웃 처리하기
	ModelAndView logout(ModelAndView mav, HttpServletRequest request);
	
	// === 내 정보 수정하기 === //
	int updateInfoEnd(EmployeeVO empvo);

	// ==== 주소록 추가
	int insert_addressBook(AddressBookVO adrsVO);
	
	//===== 전체 주소록 보여주기 ======
	List<Map<String, String>> all_address_data(String fk_employeeNo);
	
	// ==== 부서별 주소록 목록 가져오기 ====
	List<Map<String, String>> department_address_data(String fk_employeeNo);

	// ==== 외부 주소록 목록 가져오기 ====
	List<Map<String, String>> external_address_data(String fk_employeeNo);
	

}
