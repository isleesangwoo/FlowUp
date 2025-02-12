package com.spring.app.commute.service;

import java.util.List;
import java.util.Map;

import com.spring.app.commute.domain.CommuteVO;

public interface CommuteService {
	
	// 오늘자 근태 조회 select
	CommuteVO getTodayWorkInfo(String fk_employeeNo);

	// 오늘자 출근 insert
	int insertWorkStart(String fk_employeeNo);

	// 오늘자 출근 시간 입력 update
	int updateStartTime(String fk_employeeNo);

	// 오늘자 퇴근 시간 입력 update
	int updateEndTime(String fk_employeeNo);

	// status update
	int statusChange(Map<String, String> paramap);

	// 이번주 근무시간 조회하는 메소드 select
	List<Map<String, String>> getThisWeekWorkTime(String fk_employeeNo);


	
	
	
}
