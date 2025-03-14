package com.spring.app.document.service;

import java.util.List;
import java.util.Map;

import com.spring.app.document.domain.ApprovalVO;
import com.spring.app.document.domain.DocumentVO;
import com.spring.app.employee.domain.DepartmentVO;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.domain.TeamVO;

public interface DocumentService {

	// 결재 대기 문서 리스트 가져오기
	List<DocumentVO> todoList(String emplowlqwndyeeNo);
	
	// 결재 예정 문서 리스트 가져오기
	List<DocumentVO> upcomingList(String employeeNo);
	
	// 기안 문서함에서 검색어를 포함한 문서 갯수 가져오기
	int myDocumentListCount_Search(Map<String, String> paraMap);
	
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
	
	// 결재 요청하기
	Map<String, String> draft(Map<String, String> paraMap);

	// 결재 승인하기
	int approve(Map<String, String> map);

	// 결재 반려하기
	int reject(Map<String, String> map);

	// 결재 라인에 추가하기 위한 사원 1명 가져오기
	EmployeeVO getEmployeeOne(String employeeNo);

	// 임시저장 문서 삭제하기
	int deleteTemp(String documentNo);

	// 임시저장 문서 리스트 삭제하기
	int deleteTempList(List<String> checked_list);

	// 휴가신청서 잔여 연차 가져오기
	int getAnnual(String employeeNo);

	

	

	

	

	


	
}
