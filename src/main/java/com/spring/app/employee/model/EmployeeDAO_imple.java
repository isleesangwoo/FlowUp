package com.spring.app.employee.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.employee.domain.EmployeeVO;


// === Repository(DAO) 선언 === //
@Repository
public class EmployeeDAO_imple implements EmployeeDAO {
	
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	
	@Override
	public List<Map<String, String>> test() {
		List<Map<String, String>> testList = sqlsession.selectList("employee.test");
		return testList;
	}
	
}
