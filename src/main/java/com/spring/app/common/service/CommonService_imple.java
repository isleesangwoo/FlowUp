package com.spring.app.common.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.BoardDAO;
import com.spring.app.common.model.CommonDAO;


// === #23. 서비스 선언 === //
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class CommonService_imple implements CommonService {
	
	@Autowired
	private CommonDAO dao;


	

	
}
