package com.spring.app.springscheduler.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

public interface SpringschedulerDAO {

	void scheduler_endtime_update_noClick();
	
	List<Map<String, String>> scheduler_getOverTimeYN();
	
	void scheduler_endtime_update_noDraft(String employeeNo);
	
	void scheduler_endtime_update_draft(String employeeNo);
	
	List<Map<String, String>> getEmpInfo(String str_current_Year);

	int insertAnnual(Map<String, String> paraMap);

	



	

	

	


	
	
	
	
}
