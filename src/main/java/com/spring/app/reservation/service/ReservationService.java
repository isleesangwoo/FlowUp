package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

public interface ReservationService {

	// 자산 대분류를 select 해주는 메소드
	List<Map<String, String>> tbl_assetSelect();
	
	// 자산 상세를 select 해주는 메소드
	List<Map<String, String>> tbl_assetDetailSelect();
	
	// 자산 대분류를 insert 해주는 메소드
	int reservationAdd(Map<String, String> paraMap);

	

	

}
