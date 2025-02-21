package com.spring.app.mail.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.model.BoardDAO;
import com.spring.app.mail.domain.MailVO;
import com.spring.app.mail.model.MailDAO;


// === 서비스 선언 === //
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class MailService_imple implements MailService {
	
	@Autowired
	private MailDAO dao;

	// 전체 메일
	@Override
	public List<MailVO> mailListAll() {

		List<MailVO> mailList = dao.mailListAll();
		
		return mailList;
	}


	
}
