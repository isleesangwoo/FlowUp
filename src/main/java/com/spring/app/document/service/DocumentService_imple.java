package com.spring.app.document.service;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.document.model.DocumentDAO;


// === 서비스 선언 === //
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class DocumentService_imple implements DocumentService {
	
	@Autowired
	private DocumentDAO mapper_dao; // mapper 인터페이스
	

	// 휴가신청서 결재 요청
	@Override
	public int annualDraft(Map<String, String> paraMap) {
		
		// 채번하기
		String seq_document = mapper_dao.getSeqDocument();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-");
		
		String documentNo = sdf.format(date) + seq_document;
		
		paraMap.put("documentNo", documentNo);
		
		int n = mapper_dao.insertDocument(paraMap);
		int m = 0;
		if(n==1) {
			m = mapper_dao.insertAnnualDraft(paraMap);
		}
		
		return n*m;
	}

	
	// 임시저장 문서 리스트 가져오기
	@Override
	public List<Map<String, String>> tempList(String employeeNo) {
		
		List<Map<String, String>> tempList = mapper_dao.tempList(employeeNo);
		return tempList;
	}

	
}
