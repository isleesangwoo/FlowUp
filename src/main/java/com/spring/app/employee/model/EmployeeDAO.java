package com.spring.app.employee.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.employee.domain.EmployeeVO;


@Mapper
public interface EmployeeDAO {

//	List<Map<String, String>> test();

	//로그인 처리
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);

	//회원 추가
	int insert_employee(EmployeeVO empvo);

	// === 부서번호, 부서명 알아오기 === //
	List<Map<String, String>> departmentno_select();
	
}
