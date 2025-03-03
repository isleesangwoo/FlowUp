package com.spring.app.document.service;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.document.domain.ApprovalVO;
import com.spring.app.document.domain.DocumentVO;
import com.spring.app.document.model.DocumentDAO;
import com.spring.app.employee.domain.EmployeeVO;


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
		
		String documentNo = sdf.format(date) + seq_document; // 문서번호
		
		paraMap.put("documentNo", documentNo); // 문서번호 넣어주기
		
		int n = mapper_dao.insertDocument(paraMap);
		int m = 0;
		if(n==1) {
			m = mapper_dao.insertAnnualDraft(paraMap);
		}
		
		int approval_count = Integer.parseInt(paraMap.get("added_approval_count"));
		
		int a = 1;
		
		for(int i=0; i<approval_count; i++) {
			paraMap.put("fk_approver", paraMap.get("added_employee_no" + i));
			paraMap.put("approvalorder", String.valueOf(approval_count-i));
			a *= mapper_dao.insertApprover(paraMap);
		}
		
		return n*m;
	}

	
	// 결제 대기 문서 리스트 가져오기
	@Override
	public List<DocumentVO> todoList(String employeeNo) {

		List<DocumentVO> todoList = mapper_dao.todoList(employeeNo);
		return todoList;
	}
	
	
	// 임시저장 문서 리스트 가져오기
	@Override
	public List<DocumentVO> tempList(String employeeNo) {
		
		List<DocumentVO> tempList = mapper_dao.tempList(employeeNo);
		return tempList;
	}


	// 기안 문서 리스트 가져오기
	@Override
	public List<DocumentVO> myDocumentList(String employeeNo) {
		
		List<DocumentVO> myDocumentList = mapper_dao.myDocumentList(employeeNo);
		return myDocumentList;
	}


	// 부서 문서 리스트 가져오기
	@Override
	public List<DocumentVO> deptDocumentList(String employeeNo) {
		
		List<DocumentVO> deptDocumentList = mapper_dao.deptDocumentList(employeeNo);
		return deptDocumentList;
	}


	// 조직도에 뿌려주기 위한 사원 목록 가져오기
	@Override
	public List<EmployeeVO> getEmployeeList() {
		
		List<EmployeeVO> employeeList = mapper_dao.getEmployeeList();
		return employeeList;
	}


	// 문서함에서 문서 1개 보여주기
	@Override
	public Map<String, String> documentView(Map<String, String> paraMap) {
		
		Map<String, String> document = mapper_dao.documentView(paraMap);
		return document;
	}


	// 문서함에서 보여줄 결재자 리스트 가져오기
	@Override
	public List<ApprovalVO> getApprovalList(String documentNo) {
		
		List<ApprovalVO> approvalList = mapper_dao.getApprovalList(documentNo);
		return approvalList;
	}


	

	
}
