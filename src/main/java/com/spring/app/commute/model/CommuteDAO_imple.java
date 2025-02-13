package com.spring.app.commute.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.commute.domain.CommuteVO;
import com.spring.app.employee.domain.DepartmentVO;

@Repository
public class CommuteDAO_imple implements CommuteDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	// 오늘자 근태 조회 select
	@Override
	public CommuteVO getTodayWorkInfo(String fk_employeeNo) {
		CommuteVO cvo = sqlsession.selectOne("commute.getTodayWorkInfo", fk_employeeNo);
		return cvo;
	}

	// 오늘자 출근 insert
	@Override
	public int insertWorkStart(String fk_employeeNo) {
		int n = sqlsession.insert("commute.insertWorkStart", fk_employeeNo);
		return n;
	}

	// 오늘자 출근 시간 입력 update
	@Override
	public int updateStartTime(String fk_employeeNo) {
		int n = sqlsession.update("commute.updateStartTime", fk_employeeNo);
		return n;
	}

	// 오늘자 출근 시간 입력 update
	@Override
	public int updateEndTime(String fk_employeeNo) {
		int n = sqlsession.update("commute.updateEndTime", fk_employeeNo);
		return n;
	}

	@Override
	public int statusChange(Map<String, String> paramap) {
		int n = sqlsession.update("commute.statusChange", paramap);
		return n;
	}

	@Override
	public List<Map<String, String>> getThisWeekWorkTime(String fk_employeeNo) {
		List<Map<String, String>> mapList = sqlsession.selectList("commute.getThisWeekWorkTime", fk_employeeNo);
		return mapList;
	}

	@Override
	public List<DepartmentVO> getDepInfo() {
		List<DepartmentVO> dvoList = sqlsession.selectList("commute.getDepInfo");
		return dvoList; 
	}



	
	
	
	
}
