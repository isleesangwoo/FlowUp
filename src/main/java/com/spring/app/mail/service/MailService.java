package com.spring.app.mail.service;

import java.util.List;
import java.util.Map;

import com.spring.app.mail.domain.MailVO;

public interface MailService {

	// 전체 메일
	List<MailVO> mailListAll();

	// 받은 메일 개수 조회
	int getTotalCount();

	// 받은 메일 목록 조회
	List<MailVO> selectMailList(Map<String, String> paraMap);

	// 안 읽은 메일 개수 조회
	int getUnreadCount();

	// 중요(별) 상태 변경
	int toggleImportant(int mailNo);

	// 중요메일함 조회
	List<MailVO> selectImportantMail(String empNo);
	
	

}
