package com.spring.app.reservation.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.reservation.model.ReservationDAO;

//=== 서비스 선언 === //
//트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class ReservationService_imple implements ReservationService {

	@Autowired
	private ReservationDAO dao;
	
}
