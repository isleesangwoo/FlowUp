package com.spring.app.document.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.document.domain.DocumentVO;

@Mapper
public interface DocumentDAO {

	// 전자결재 문서번호 채번하기
	String getSeqDocument();

	// 전자결재 문서 생성
	int insertDocument(Map<String, String> paraMap);

	// 휴가신청서 문서 생성
	int insertAnnualDraft(Map<String, String> paraMap);

	// 임시저장 문서 리스트 가져오기
	List<DocumentVO> tempList(String employeeNo);

	// 기안 문서 리스트 가져오기
	List<DocumentVO> myDocumentList(String employeeNo);

	// 부서 문서 리스트 가져오기
	List<DocumentVO> deptDocumentList(String employeeNo);



}
