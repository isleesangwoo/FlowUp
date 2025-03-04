package com.spring.app.mail.service;

import java.util.List;
import java.util.Map;

import com.spring.app.mail.domain.MailFileVO;
import com.spring.app.mail.domain.MailVO;

public interface MailService {

	// 전체 메일
	List<MailVO> mailListAll();

	// 받은 메일 개수 조회
	int getTotalCount();

	// 받은 메일 목록 조회
	List<MailVO> selectMailList(Map<String, String> paraMap);
	
	// 페이지 동적 개수 조회
    int getMailCount(Map<String,String> paraMap);
    
	// 안 읽은 메일 개수 조회
	int getUnreadCount();

	// 중요(별) 상태 변경
	int toggleImportant(int mailNo);

	// 중요메일함 조회
	List<MailVO> selectImportantMail(String empNo);

	// 읽음 상태 변경
	int toggleReadMail(int mailNo);

	// 읽은 메일 조회
	List<MailVO> selectReadMail(String empNo);

	// 특정 메일 1개 조회
	MailVO viewMail(Map<String, String> paraMap);

	// 한개 메일 첨부파일의 파일명, 기존파일명, 새로운파일명, 파일사이즈 얻어오기
	List<MailFileVO> getMailFile(Map<String, String> paraMap);

	// 메일 정렬 방법 선택
	List<MailVO> mailListSort(Map<String, String> paramMap);

	// 메일 내용 조회시 읽음 으로 상태 변경
	void updateReadStatus(int mailNo, int i);

	// 체크된 메일 deleteStatus 1로 업데이트
	int deleteMailStatus(List<Integer> mailNoList);

	// deleteStatus 1 인것만 조회 (휴지통)
	List<MailVO> selectDeletedMail();



	
	

}
