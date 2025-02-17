package com.spring.app.document.model;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDAO {

	// 전자결재 문서번호 채번하기
	String getSeqDocument();

	// 전자결재 문서 생성
	int insertDocument(Map<String, String> paraMap);

	// 휴가신청서 문서 생성
	int insertAnnualDraft(Map<String, String> paraMap);



}
