package com.spring.app.document.service;

import java.util.List;
import java.util.Map;

import com.spring.app.document.domain.ApprovalVO;
import com.spring.app.document.domain.DocumentVO;
import com.spring.app.employee.domain.EmployeeVO;

public interface DocumentService {

	// 휴가신청서 결재 요청
	int annualDraft(Map<String, String> paraMap);

	// 결제 대기 문서 리스트 가져오기
	List<DocumentVO> todoList(String employeeNo);

	// 임시저장 문서 리스트 가져오기
	List<DocumentVO> tempList(String employeeNo);

	// 기안 문서 리스트 가져오기
	List<DocumentVO> myDocumentList(String employeeNo);

	// 부서 문서 리스트 가져오기
	List<DocumentVO> deptDocumentList(String employeeNo);

	// 조직도에 뿌려주기 위한 사원 목록 가져오기
	List<EmployeeVO> getEmployeeList();

	// 문서함에서 문서 1개 보여주기
	Map<String, String> documentView(Map<String, String> paraMap);

	// 문서함에서 보여줄 결재자 리스트 가져오기
	List<ApprovalVO> getApprovalList(String documentNo);


	
}
