package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

import com.spring.app.reservation.domain.AssetVO;

public interface ReservationService {

	// 자산 대분류를 select 해주는 메소드
	List<Map<String, String>> tbl_assetSelect();
	
	// 자산 상세를 select 해주는 메소드
	List<Map<String, String>> tbl_assetDetailSelect();
	
	// 자산 대분류를 insert 해주는 메소드
	int reservationAdd(Map<String, String> paraMap);

	// 내 예약 정보를 select 해주는 메소드
	List<Map<String, String>> my_Reservation(String employeeNo);

	// 대분류를 삭제하는 메소드
	int deleteAsset(String assetNo);

	// 자산 하나에 해당하는 대분류 정보를 select 해주는 메소드
	AssetVO assetOneSelect(String assetNo);

	// 대분류 하나에 해당하는 자산 정보를 select 해주는 메소드
	List<Map<String, String>> middleTapInfo(String assetNo);

	// 비품명을 추가해주는 메소드
	int addFixtures(Map<String, Object> paraMap);

	// 대분류에 딸린 자산들을 select 해주는 메소드
	List<Map<String, String>> assetOneDeSelect(String assetNo);

	// 자산추가를 해주는 메소드
	int addAsset(Map<String, String> paraMap);

	

	

}
