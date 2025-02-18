package com.spring.app.document.service;

import java.util.Map;

public interface DocumentService {

	// 휴가신청서 결재 요청
	int annualDraft(Map<String, String> paraMap);

	
}
