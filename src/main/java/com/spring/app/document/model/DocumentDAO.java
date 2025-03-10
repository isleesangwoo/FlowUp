package com.spring.app.document.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.document.domain.ApprovalVO;
import com.spring.app.document.domain.DocumentVO;
import com.spring.app.employee.domain.DepartmentVO;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.domain.TeamVO;

@Mapper
public interface DocumentDAO {

	// 결재 대기 문서 리스트 가져오기
	List<DocumentVO> todoList(String employeeNo);
	
	// 결재 예정 문서 리스트 가져오기
	List<DocumentVO> upcomingList(String employeeNo);
	
	// 기안 문서함에서 검색어를 포함한 문서 갯수 가져오기
	Integer myDocumentListCount_Search(Map<String, String> paraMap);
	
	// 기안 문서함에서 검색어를 포함한 페이징 처리한 문서 리스트 가져오기
	List<DocumentVO> myDocumentList_Search_Paging(Map<String, String> paraMap);
	
	// 임시저장 문서 리스트 가져오기
	List<DocumentVO> tempList(String employeeNo);
	
	// 결재 처리한 문서 리스트 가져오기
	List<DocumentVO> approvedList(String employeeNo);

	// 부서 문서 리스트 가져오기
	List<DocumentVO> deptDocumentList(String employeeNo);
	
	// 문서함에서 문서 1개 보여주기
	Map<String, String> documentView(Map<String, String> paraMap);
	
	// 문서함에서 보여줄 결재자 리스트 가져오기
	List<ApprovalVO> getApprovalList(String documentNo);

	// 조직도에 뿌려주기 위한 부서 목록 가져오기
	List<DepartmentVO> getDepartmentList();
	
	// 조직도에 뿌려주기 위한 팀 목록 가져오기
	List<TeamVO> getTeamList();
	
	// 조직도에 뿌려주기 위한 사원 목록 가져오기
	List<EmployeeVO> getEmployeeList();

	// 결재 라인 승인자 추가하기
	int insertApprover(Map<String, String> paraMap);
	
	// 전자결재 문서번호 채번하기
	String getSeqDocument();
	
	// 전자결재 문서 생성
	int insertDocument(Map<String, String> paraMap);
	
	// 휴가신청서 문서 생성
	int insertAnnualDraft(Map<String, String> paraMap);
	
	// 연장근무신청서 문서 생성
	int insertOvertimeDraft(Map<String, String> paraMap);

	// 결재 승인하기
	int approve(Map<String, String> map);

	// 결재자의 승인 순서 알아오기
	int getApprovalOrder(Map<String, String> map);

	// 문서의 결재 상태를 업데이트 하기
	int updateDocumentApprovalStatus(Map<String, String> map);

	// 결재 반려하기
	int reject(Map<String, String> map);

	

	


	

	

	

	




}
