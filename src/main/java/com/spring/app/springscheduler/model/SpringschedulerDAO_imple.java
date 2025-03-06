package com.spring.app.springscheduler.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class SpringschedulerDAO_imple implements SpringschedulerDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	@Override
	public void scheduler_endtime_update() {
		
		sqlsession.update("springscheduler.scheduler_endtime_update");
		
	}

	@Override
	public List<Map<String, String>> getEmpInfo() {
		List<Map<String, String>> empList = sqlsession.selectList("springscheduler.getEmpInfo");
		return empList;
	}


}
