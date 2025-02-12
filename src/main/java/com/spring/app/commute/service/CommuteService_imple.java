package com.spring.app.commute.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.commute.domain.CommuteVO;
import com.spring.app.commute.model.CommuteDAO;

@Service
public class CommuteService_imple implements CommuteService {
	
	@Autowired
	private CommuteDAO dao;

	// 오늘자 근태조회
	@Override
	public CommuteVO getTodayWorkInfo(String fk_employeeNo) {
		CommuteVO cvo = dao.getTodayWorkInfo(fk_employeeNo);
		return cvo;
	}

	// 오늘자 출근 insert
	@Override
	public int insertWorkStart(String fk_employeeNo) {
		int n = dao.insertWorkStart(fk_employeeNo);
		return n;
	}

	// 오늘자 출근 시간 입력 update
	@Override
	public int updateStartTime(String fk_employeeNo) {
		int n = dao.updateStartTime(fk_employeeNo);
		return n;
	}
	
	// 오늘자 퇴근 시간 입력 update
	@Override
	public int updateEndTime(String fk_employeeNo) {
		int n = dao.updateEndTime(fk_employeeNo);
		return n;
	}

	// status update
	@Override
	public int statusChange(Map<String, String> paramap) {
		int n = dao.statusChange(paramap);
		return n;
	}

	// 이번주 근무시간 조회하는 메소드 select
	@Override
	public List<Map<String, String>> getThisWeekWorkTime(String fk_employeeNo) {
		List<Map<String, String>> mapList = dao.getThisWeekWorkTime(fk_employeeNo);
		return mapList;
	}


	

	
}
