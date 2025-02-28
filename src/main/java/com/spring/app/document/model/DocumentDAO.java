package com.spring.app.document.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.document.domain.ApprovalVO;
import com.spring.app.document.domain.DocumentVO;
import com.spring.app.employee.domain.EmployeeVO;

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

	// 조직도에 뿌려주기 위한 사원 목록 가져오기
	List<EmployeeVO> getEmployeeList();

	// 결재 라인 승인자 추가하기
	int insertApprover(Map<String, String> paraMap);

	// 문서함에서 문서 1개 보여주기
	Map<String, String> documentView(Map<String, String> paraMap);

	// 문서함에서 보여줄 결재자 리스트 가져오기
	List<ApprovalVO> getApprovalList(String documentNo);



}
