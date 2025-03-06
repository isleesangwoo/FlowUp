package com.spring.app.springscheduler.service;


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
		
		dao.scheduler_endtime_update();
		
	}

	@Scheduled(cron = "00 00 00 31 12 *")
	@Override
	public void newYear_annual_insert() {
		
		// 모든 직원 정보를 불러오는 메소드
		List<Map<String, String>> empList = dao.getEmpInfo();
		
		for(Map<String, String> empMap : empList) {
			
			String employeeNo = empMap.get("employeeNo");
			String regYear = empMap.get("regYear");
	
			LocalDate current_date = LocalDate.now();
			int current_Year = current_date.getYear();
			int n_regYear = Integer.parseInt(regYear);
			int occurAnnual = 15 + ( current_Year - n_regYear - 1 ) / 2;

			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("occurAnnual", occurAnnual+"");
			paraMap.put("employeeNo", employeeNo);
			
		}	
		
		
		
	}
	
	
			
			
			
}
		
		
		
		
	

