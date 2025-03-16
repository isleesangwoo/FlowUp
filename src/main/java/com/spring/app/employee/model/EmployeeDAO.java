package com.spring.app.employee.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.employee.domain.AddressBookVO;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.domain.GroupVO;


@Mapper
public interface EmployeeDAO {

//	List<Map<String, String>> test();

	//로그인 처리
	EmployeeVO getLoginEmployee(Map<String, String> paraMap);

	//회원 추가
	int insert_employee(EmployeeVO empvo);

	// === 부서번호, 부서명 알아오기 === //
	List<Map<String, String>> departmentno_select();

	// === 직급번호, 직급명 알아오기 === // 
	List<Map<String, String>> positionno_select();

	// === 팀 번호, 팀명 알아오기 === //
	List<Map<String, String>> teamno_select();

	// === 부서번호별 팀번호 알아오기 ===
	List<Map<String, String>> teamNo_seek_BydepartmentNo(String departmentNo);

	//회원가입시 해당 연도에 연차 insert 해주기
	int insert_annual(String employeeNo);
	
	// === 내 정보 수정하기 === //
	int updateInfoEnd(EmployeeVO empvo);

	// 첨부파일이 있는 내 정보 수정
	int upadateInfoEnd_withFile(EmployeeVO empvo);
	
	
	// === 주소록 추가 === //
	int insert_addressBook(AddressBookVO adrsVO);

	// ===== 전체 주소록 보여주기 ======
	List<Map<String, String>> all_address_data_list(String fk_employeeNo);
	
	// ==== 부서별 주소록 목록 가져오기 ====
	List<Map<String, String>> department_address_data(String fk_employeeNo);

	// ==== 외부 주소록 목록 가져오기 ====
	List<Map<String, String>> external_address_data(String fk_employeeNo);
	
	// 우리 회사 주소록 부서별로 알아오기
	List<Map<String, String>> addressBook_select_department_list();

	// 전체주소록 중 선택한 주소 삭제하기
	int delete_address_book(String addressno);
	
	// 관리자의 사원정보 수정 view 단에 줄 사원들의 정보 갖고오기
	List<Map<String, String>> all_employee_info_list();
	
	// 변경할 직급명에 대한 직급번호 알아오기 
	String getPositionName(String positionName);

	// 변경할 부서명에 대한 부서번호 알아오기
	String getDepartmentName(String departmentName);

	// 변경할 팀명에 대한 팀번호 알아오기 
	String getTeamName(String teamName);

	// 관리자의 사원정보 수정
	int updateEmployee_byAdminEnd(Map<String, String> paraMap);

	//그룹 옵션 추가하기
	int addGroupOptionEnd(GroupVO gvo, String g_fk_employee,String groupname);

	//그룹 옵션 select 태그 안에 넣어주기
	List<Map<String, String>> groupOptionSelect();
	
	//그룹 번호와 이름 가져오기
	List<Map<String, String>> groupNo_and_groupName_select(String g_fk_employee);

	//그룹에 추가하기
	List<Map<String, String>> addGroup(String fk_employeeno);

	
	// tbl_loginhistory 테이블에 insert 해주기
	void insert_tbl_loginhistory(Map<String, String> paraMap);

	// 해당 유저의 ip 주소 갖고오기
	List<Map<String, String>> getIpAddr(String employeeno);
	
}
