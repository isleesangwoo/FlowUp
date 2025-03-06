package com.spring.app.springscheduler.service;


import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.spring.app.common.AES256;
import com.spring.app.common.GoogleMail;
import com.spring.app.springscheduler.model.SpringschedulerDAO;

@Service
public class SpringschedulerService_imple implements SpringschedulerService {

	@Autowired
	public SpringschedulerDAO dao;
	
	@Autowired
	public GoogleMail mail;
	
	@Autowired
	private AES256 aes;

	@Scheduled(cron = "00 59 23 * * *")
	@Override
	public void scheduler_endtime_update() {
		
		// 퇴근 안찍고 퇴근 한놈들 퇴근시간 18:00시로 변경
		dao.scheduler_endtime_update_noClick();
		
		// 
		List<Map<String, String>> mapList = dao.scheduler_getOverTimeYN();
		
		for(Map<String, String> map: mapList) {
			
			if( map.get("overTimeYN") == "0") { // 연장근무 x
				
				dao.scheduler_endtime_update_noDraft(map.get("FK_employeeNo")); // + 연장근무 신청 안하고 퇴근 늦게 찍은놈들 퇴근시간 18:00시로 변경
			}
			else {								// 연장근무 승인 o
		
				dao.scheduler_endtime_update_draft(map.get("FK_employeeNo")); // 연장근무 승인했지만 21시 이후로 찍은사람들 21시로 변경
				
			}
			
		}
		
	}//

	@Scheduled(cron = "00 00 00 31 12 *")
	@Override
	public void newYear_annual_insert() {
		
		
		LocalDate current_date = LocalDate.now();
		int current_Year = current_date.getYear();
		String str_current_Year = current_Year+"";
		int next_Year = current_Year+1;
		String nextYear = next_Year+"";
		
		
		// 모든 직원 정보를 불러오는 메소드
		List<Map<String, String>> empList = dao.getEmpInfo(str_current_Year);
		
		
		for(Map<String, String> empMap : empList) {
			
			String employeeNo = empMap.get("employeeNo");
			String regYear = empMap.get("regYear");
			String totalAnnual = empMap.get("totalAnnual");
			String usedAnnual = empMap.get("usedAnnual");
			String remainingAnnual = empMap.get("remainingAnnual");
			
			int n_regYear = Integer.parseInt(regYear);
			int occurAnnual = 15 + (int)( ( current_Year - n_regYear - 1 ) / 2 );

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("employeeNo", employeeNo);
			paraMap.put("nextYear", nextYear);
			paraMap.put("occurAnnual", occurAnnual+"");
			paraMap.put("overAnnual", remainingAnnual);
			
			
			int n =	dao.insertAnnual(paraMap);
			
			if(n==0) {
				System.out.println("사번 : " + employeeNo + " 님의 "+ nextYear +"년 연차정보 insert 에 실패 했습니다.");
			}
			
			
		}	// for
		
	} // 
	
	
			
			
			
}
		
		
		
		
	

