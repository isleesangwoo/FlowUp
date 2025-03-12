package com.spring.app.springscheduler.service;

public interface SpringschedulerService {

	// 매일 밤 23:59에 퇴근 안찍은 사람 18:00 퇴근으로 update
	void scheduler_endtime_update();
	
	// 연말일 다음해에 사용할 연차를 insert 
	void scheduler_newYear_annual_insert();
	
	// 전날 출근기록이 없다면 insert 해준다.
	void scheduler_absenceCnt_insert();
	
	// 매달 10일 월급이 지급되며 DB에 insert
	void scheduler_monthly_payment_insert();
}
