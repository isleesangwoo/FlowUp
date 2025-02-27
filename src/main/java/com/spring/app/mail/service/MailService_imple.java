package com.spring.app.mail.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.domain.PostVO;
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

	
	// 받은 메일 개수 조회
	@Override
	public int getTotalCount() {
		
		int totalCount = dao.getTotalCount();
		
		return totalCount;
	}


	// 받은 메일 목록 조회
	@Override
	public List<MailVO> selectMailList(Map<String, String> paraMap) {
		
		List<MailVO> ReceivedMailList = dao.selectMailList(paraMap);
		
		return ReceivedMailList;
		
	}

	// 안 읽은 메일 개수 조회
	@Override
	public int getUnreadCount() {
		
		int unreadCount = dao.getUnreadCount();
		
		return unreadCount;
	}


	// 중요(별) 상태 변경
	@Override
	public int toggleImportant(int mailNo) {

        // 현재 importantStatus 조회
        int currentStatus = dao.getImportantStatus(mailNo);
        // 1이면 0으로, 0이면 1로 토글
        int importantStatus = (currentStatus == 1) ? 0 : 1;
        
        // DB 업데이트
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("mailNo", mailNo);
        paramMap.put("importantStatus", importantStatus);
        
        dao.updateImportantStatus(paramMap);

        // 변경된 상태값 반환
        return importantStatus;
	}

	
	// 중요(별) 상태 메일 조회
	@Override
	public List<MailVO> selectImportantMail(String empNo) {

        // DAO 호출
        return dao.selectImportantMail(empNo);
	}


	// 읽음 상태 변경
	@Override
	public int toggleReadMail(int mailNo) {
		
        // 현재 readtStatus 조회
        int currentStatus = dao.getReadStatus(mailNo);
        // 1이면 0으로, 0이면 1로 토글
        int readStatus = (currentStatus == 1) ? 0 : 1;
        
        // DB 업데이트
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("mailNo", mailNo);
        paramMap.put("readStatus", readStatus);
        
        dao.updateReadStatus(paramMap);

        // 변경된 상태값 반환
        return readStatus;
	}


	// 읽은 메일 조회
	@Override
	public List<MailVO> selectReadMail(String empNo) {

        // DAO 호출
        return dao.selectReadMail(empNo);
	}


	/*
	// 특정 메일 1개 조회
	@Override
	public MailVO viewOneMail(Map<String, String> paraMap) {

		MailVO mailvo = dao.viewOneMail(paraMap);  // 메일 1개 조회하기
		
		return mailvo;
	}
	 */


	
}
