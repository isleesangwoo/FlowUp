package com.spring.app.mail.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.mail.domain.MailFileVO;
import com.spring.app.mail.domain.MailVO;
import com.spring.app.mail.model.MailDAO;


// === 서비스 선언 === //
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class MailService_imple implements MailService {
	
	@Autowired
	private MailDAO mailDAO;

	// 전체 메일
	@Override
	public List<MailVO> mailListAll() {

		List<MailVO> mailList = mailDAO.mailListAll();
		
		return mailList;
	}

	
	// 받은 메일 개수 조회
	@Override
	public int getTotalCount() {
		
		int totalCount = mailDAO.getTotalCount();
		
		return totalCount;
	}


	// 받은 메일 목록 조회
	@Override
	public List<MailVO> selectMailList(Map<String, String> paraMap) {
		
		List<MailVO> ReceivedMailList = mailDAO.selectMailList(paraMap);
		
		return ReceivedMailList;
		
	}

	// 안 읽은 메일 개수 조회
	@Override
	public int getUnreadCount() {
		
		int unreadCount = mailDAO.getUnreadCount();
		
		return unreadCount;
	}


	// 중요(별) 상태 변경
	@Override
	public int toggleImportant(int mailNo) {

        // 현재 importantStatus 조회
        int currentStatus = mailDAO.getImportantStatus(mailNo);
        // 1이면 0으로, 0이면 1로 토글
        int importantStatus = (currentStatus == 1) ? 0 : 1;
        
        // DB 업데이트
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("mailNo", mailNo);
        paramMap.put("importantStatus", importantStatus);
        
        mailDAO.updateImportantStatus(paramMap);

        // 변경된 상태값 반환
        return importantStatus;
	}

	
	// 중요(별) 상태 메일 조회
	@Override
	public List<MailVO> selectImportantMail(String empNo) {
        
        List<MailVO> result = mailDAO.selectImportantMail(empNo);
        
        System.out.println("service에서 반환된 중요 메일 개수: " + result.size());
        
        return result;
	}


	// 읽음 상태 변경
	@Override
	public int toggleReadMail(int mailNo) {
		
        // 현재 readtStatus 조회
        int currentStatus = mailDAO.getReadStatus(mailNo);
        // 1이면 0으로, 0이면 1로 토글
        int readStatus = (currentStatus == 1) ? 0 : 1;
        
        // DB 업데이트
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("mailNo", mailNo);
        paramMap.put("readStatus", readStatus);
        
        mailDAO.updateReadStatus(paramMap);

        // 변경된 상태값 반환
        return readStatus;
	}


	// 읽은 메일 조회
	@Override
	public List<MailVO> selectReadMail(String empNo) {

        // DAO 호출
        return mailDAO.selectReadMail(empNo);
	}

	
	// 특정 메일 1개 조회
	@Override
	public MailVO viewMail(Map<String, String> paraMap) {

		MailVO mailvo = mailDAO.viewMail(paraMap);  // 메일 1개 조회하기
		
		return mailvo;
	}


	// 한개 메일 첨부파일의 파일명, 기존파일명, 새로운파일명, 파일사이즈 얻어오기
	@Override
	public List<MailFileVO> getMailFile(Map<String, String> paraMap) {

		
		
		
		return null;
	}


	// 메일 정렬 버튼 클릭시 정렬
	@Override
	public List<MailVO> mailListSort(Map<String, String> paramMap) {
		
		
		return mailDAO.mailListSort(paramMap);
	}


	// 메일 내용 조회시 읽음 으로 상태 변경
    @Override
    public void updateReadStatus(int mailNo, int readStatus) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("mailNo", mailNo);
        paramMap.put("readStatus", readStatus);

        mailDAO.updateReadStatus(paramMap);
    }


    // 체크된 메일 deleteStatus 1로 업데이트
    @Override
    public int deleteMailStatus(List<Integer> mailNoList) {
    	
        // DAO 호출
        return mailDAO.updateDeleteStatus(mailNoList);
    }


    // deleteStatus 1 인것만 조회 (휴지통)
    @Override
    public List<MailVO> selectDeletedMail() {
    	
        return mailDAO.selectDeletedMail();
    }


    // 페이지 동적 개수 조회
	@Override
	public int getMailCount(Map<String, String> paraMap) {

		return mailDAO.getMailCount(paraMap);
	}


	


	
}
