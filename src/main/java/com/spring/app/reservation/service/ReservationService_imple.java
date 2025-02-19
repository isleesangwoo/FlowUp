package com.spring.app.reservation.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.reservation.model.ReservationDAO;

//=== 서비스 선언 === //
//트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class ReservationService_imple implements ReservationService {

	@Autowired
	private ReservationDAO dao;

	
	// 자산 대분류를 select 해주는 메소드
	@Override
	public List<Map<String, String>> tbl_assetSelect() {
		List<Map<String, String>> assetList = dao.tbl_assetSelect();
		
		return assetList;
	}
	
	
	
	// 자산 대분류를 insert 해주는 메소드
	@Override
	public int reservationAdd(Map<String, String> paraMap) {
		int n = dao.reservationAdd(paraMap);
		return n;
	}



	// 자산 상세를 select 해주는 메소드
	@Override
	public List<Map<String, String>> tbl_assetDetailSelect() {
		List<Map<String, String>> assetDetailList = dao.tbl_assetDetailSelect();
		return assetDetailList;
	}



	// 내 예약 정보를 select 해주는 메소드
	@Override
	public List<Map<String, String>> my_Reservation(String employeeNo) {
		List<Map<String, String>> my_ReservationList = dao.my_Reservation(employeeNo);
		return my_ReservationList;
	}


	// 대분류를 삭제하는 메소드
	@Override
	public int deleteAsset(String assetNo) {
		int n = dao.deleteAsset(assetNo);
		return n;
	}


	
	
}
