package com.spring.app.springscheduler.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

public interface SpringschedulerDAO {

	void scheduler_endtime_update();

	List<Map<String, String>> getEmpInfo();


	
	
	
	
}
