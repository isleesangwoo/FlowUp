package com.spring.app.document.service;

import java.util.List;
import java.util.Map;

public interface DocumentService {

	// 휴가신청서 결재 요청
	int annualDraft(Map<String, String> paraMap);

	// 임시저장 문서 리스트 가져오기
	List<Map<String, String>> tempList(String employeeNo);

	
}
