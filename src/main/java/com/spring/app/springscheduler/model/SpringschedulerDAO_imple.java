package com.spring.app.springscheduler.model;

import java.sql.SQLException;
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
	public void scheduler_endtime_update_noClick() {
		
		sqlsession.update("springscheduler.scheduler_endtime_update_noClick");
	}
	
	@Override
	public List<Map<String, String>> scheduler_getOverTimeYN() {
		List<Map<String, String>> mapList = sqlsession.selectList("springscheduler.scheduler_getOverTimeYN");
		return mapList;
	}
	
	@Override
	public void scheduler_endtime_update_noDraft(String employeeNo) {
		sqlsession.update("springscheduler.scheduler_endtime_update_noDraft", employeeNo);
	}
	
	@Override
	public void scheduler_endtime_update_draft(String employeeNo) {
		sqlsession.update("springscheduler.scheduler_endtime_update_draft", employeeNo);
		
	}

	@Override
	public List<Map<String, String>> getEmpInfo() {
		List<Map<String, String>> empList = sqlsession.selectList("springscheduler.getEmpInfo");
		return empList;
	}

	@Override
	public int insertAnnual(Map<String, String> paraMap) {
		int n = sqlsession.insert("springscheduler.insertAnnual", paraMap);
		return n;
	}

	@Override
	public int scheduler_yesterday_workYN(String str_now) {
		int n = sqlsession.selectOne("springscheduler.scheduler_yesterday_workYN", str_now);
		return n;
	}

	@Override
	public List<String> scheduler_getEmployeeList(String yesterday) {
		List<String> employeeNo = sqlsession.selectList("springscheduler.scheduler_getEmployeeList", yesterday);
		return employeeNo;
	}

	@Override
	public void scheduler_absence_insert(String employeeNo) throws SQLException {
		sqlsession.insert("springscheduler.scheduler_absence_insert", employeeNo);
	}

	@Override
	public List<Map<String, String>> getEmpAnnualInfo() {
		List<Map<String, String>> empAnnualList = sqlsession.selectList("springscheduler.getEmpAnnualInfo");
		return empAnnualList;
	}

	@Override
	public void scheduler_monthly_payment_insert(Map<String, String> empAnnaulMap) {
		sqlsession.insert("springscheduler.scheduler_monthly_payment_insert",empAnnaulMap);
	}

	

	




	

	


}
