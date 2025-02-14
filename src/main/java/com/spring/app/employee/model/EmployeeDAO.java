package com.spring.app.employee.model;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.employee.domain.EmployeeVO;


@Mapper
public interface EmployeeDAO {

//	List<Map<String, String>> test();

	//로그인 처리
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);
	
}
