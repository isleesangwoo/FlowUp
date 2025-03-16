package com.spring.app.employee.service;


import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.Sha256;
import com.spring.app.employee.domain.AddressBookVO;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.domain.GroupVO;
import com.spring.app.employee.model.EmployeeDAO;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// === #12. 서비스 선언 ===
@Service
public class EmployeeService_imple implements EmployeeService {

	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private EmployeeDAO dao;

	// === 양방향 암호화 알고리즘인 AES256 를 사용하여 복호화 하기 위한 클래스 의존객체 주입하기(DI: Dependency
	// Injection) ===
	@Autowired
	private AES256 aes;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.app.common.AES256 의 bean 을
	// aes 에 주입시켜준다.
	// 그러므로 aes 는 null 이 아니다.
	// com.spring.app.common.AES256 의 bean 은
	// com.spring.app.config.AES256_Configuration 클래스 에서 메소드로 bean 을 등록시켜주었음.

	// === #ljh3. 로그인 처리하기 === //

	@Override
	public int login(HttpServletRequest request, Map<String, String> paraMap, HttpServletResponse response, ModelAndView mav) {

		 paraMap.put("passwd", Sha256.encrypt(paraMap.get("passwd")));


		EmployeeVO loginuser = dao.getLoginEmployee(paraMap);

		int result = 0; // 기본 실패

		if (loginuser != null) {
			result = 1;

			if (Integer.parseInt(loginuser.getLastPweChange()) >= 3) { // 비밀번호 변경일이 3개월이 지났다면
				loginuser.setRequireLastChangePwd(true);
			}

			try {

				String email = aes.decrypt(loginuser.getEmail());// 이메일 복호화
				String mobile = aes.decrypt(loginuser.getMobile()); // 휴대폰 복호화

				loginuser.setEmail(email);
				loginuser.setMobile(mobile);

			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}

		} // end of if(loginuser != null ) --------

		
		  if(loginuser == null) {//로그인 실패 시
		  
		  String message = "아이디 또는 암호가 비었습니다. 입력하세요";
		  String loc ="javascript:history.back()";
		  
		  
		  request.setAttribute("loginuser", loginuser);
		  
		  mav.addObject("message", message); 
		  mav.addObject("loc", loc);
		  
		  mav.setViewName("msg");
		  
		  }
		 

		else {

			HttpSession session = request.getSession();
			// 메모리에 생성되어져 있는 session 을 불러온다.
			session.setAttribute("loginuser", loginuser);
			// 세션에 로그인 되어진 사용자 정보 저장

			if (loginuser.isRequireLastChangePwd() == true) { // 암호를 마지막으로 변경한 것이 3개월을 지났을 때
				String message = "비밀번호를 변경하신지 3개월이 지났습니다. \\암호를 변경하시는 것을 추천합니다.";
				String loc = request.getContextPath() + "/index";
				// 현재 비밀번호 변경창 만드는 중 그때까지 메인화면 사용

				mav.addObject("message",message);
				mav.addObject("loc", loc);
				
				

			}

			else {// 비밀번호 변경이 3개월 이내인 경우
				String goBackURL = (String) session.getAttribute("goBackURL");
    			
    			if(goBackURL != null) {
    				mav.setViewName("redirect:"+goBackURL);
    				session.removeAttribute("goBackURL"); // 세션에서 반드시 제거해주어야 한다. 
    			}
    			else {
    				mav.setViewName("redirect:/index"); // 시작페이지로 이동 
    			}
			}

		}

		return result;
	}

	
	
	////////////////////////////////////////////////////////////////////////////
	
	
	
	
	
	// === #ljh3-1. 로그인 처리하기 === //
	@Override
	public EmployeeVO login(Map<String, String> paraMap) {
	  
		EmployeeVO loginuser = dao.getLoginEmployee(paraMap);
	
	    return loginuser;
	}


	// === #ljh9.회원추가 처리 === //
	
	@Override
	@Transactional(value="transactionManager_mymvc_user", propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int insert_employee(EmployeeVO empvo) {
		
		int insert_employee = dao.insert_employee(empvo);

		if(insert_employee == 1) {
			
			insert_employee = dao.insert_annual(empvo.getEmployeeNo());
		}
		
		return insert_employee;
	}


	// === 부서번호, 부서명 알아오기 === //
	@Override
	public List<Map<String, String>> departmentno_select() {
		List<Map<String, String>> mapList = dao.departmentno_select();
		return mapList;
	}


	// === 직급번호, 직급명 알아오기 === //
	@Override
	public List<Map<String, String>> positionno_select() {
		List<Map<String, String>> mapList = dao.positionno_select();
		return mapList;
	}

	// === 부서번호별 팀번호 알아오기 ===
	@Override
	public List<Map<String, String>> teamNo_seek_BydepartmentNo(String departmentNo) {
		List<Map<String, String>> mapList = dao.teamNo_seek_BydepartmentNo(departmentNo);
		return mapList;
	}



	// 로그아웃 처리하기
	@Override
	public ModelAndView logout(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String message = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/employee/login";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}


	// === 내 정보 수정하기 === //
	@Override
	public int updateInfoEnd(EmployeeVO empvo) {
		int n = dao.updateInfoEnd(empvo);
		return n;
	}
	
	//첨부파일이 있는 내 정보 수정일 때 
	@Override
	public int upadateInfoEnd_withFile(EmployeeVO empvo) {

		int n = dao.upadateInfoEnd_withFile(empvo);
		
		return n;
	}


	// ==== 주소록 추가
	@Override
	public int insert_addressBook(AddressBookVO adrsVO) {

		 int n = dao.insert_addressBook(adrsVO);
		
		return n;
	}


	//===== 전체 주소록 보여주기 ======
	@Override
	public List<Map<String, String>> all_address_data(String fk_employeeNo) {
		
		List<Map<String, String>> mapList = dao.all_address_data_list(fk_employeeNo);
		
		return mapList;
	}


	// 부서별 주소록 목록 가져오기
	@Override
	public List<Map<String, String>> department_address_data(String fk_employeeNo) {
		List<Map<String, String>>mapList=dao.department_address_data(fk_employeeNo);
		return mapList;
	}


	// ==== 외부 주소록 목록 가져오기 ====
	@Override
	public List<Map<String, String>> external_address_data(String fk_employeeNo) {
		List<Map<String, String>> mapList = dao.external_address_data(fk_employeeNo);
		return mapList;
	}


	// 우리 회사 주소록 부서별로 알아오기
	@Override
	public List<Map<String, String>> addressBook_select_department_list() {
		List<Map<String, String>>mapList = dao.addressBook_select_department_list();
		return mapList;
	}

	// 전체주소록 중 선택한 주소 삭제하기
	@Override
	public int  delete_address_book(String addressno) {

		int n  = dao.delete_address_book(addressno);
		
		return n;
	}


	// 관리자의 사원정보 수정 view 단에 줄 사원들의 정보 갖고오기
	@Override
	public List<Map<String, String>> all_employee_info_list() {
		List<Map<String, String>> mapList = dao.all_employee_info_list();
		return mapList;
	}


	// 변경할 직급명에 대한 직급번호 알아오기
	@Override
	public String getPositionName(String positionName) {
		String posiotionNo = dao.getPositionName(positionName);
		return posiotionNo;
	}



	// 변경할 부서명에 대한 부서번호 알아오기
	@Override
	public String getDepartmentName(String departmentName) {
		String departmentNo = dao.getDepartmentName(departmentName);
		return departmentNo;
	}


	// 변경할 팀명에 대한 팀번호 알아오기
	@Override
	public String getTeamName(String teamName) {
		String teamNo = dao.getTeamName(teamName);
		return teamNo;
	}


	// 관리자의 사원정보 수정
	@Override
	public int updateEmployee_byAdminEnd(Map<String, String> paraMap) {
		int n = dao.updateEmployee_byAdminEnd(paraMap);
		return n;
	}

	
	//그룹 옵션 추가하기
	@Override
	public int addGroupOptionEnd(GroupVO gvo, String g_fk_employee,String groupname) {
		
		int n = dao.addGroupOptionEnd(gvo,g_fk_employee,groupname);
		
		return n;
	}


	//그룹 옵션 select 태그 안에 넣어주기
	@Override
	public List<Map<String, String>> groupOptionSelect() {
		
		List<Map<String, String>> mapList = dao.groupOptionSelect();
		
		return mapList;
	}


	//그룹 번호와 이름 가져오기
	@Override
	public List<Map<String, String>> groupNo_and_groupName_select(String g_fk_employee) {
		List<Map<String, String>> listMap = dao.groupNo_and_groupName_select(g_fk_employee);
		return listMap;
	}


	//그룹에 추가하기
	@Override
	public List<Map<String, String>> addGroup(String fk_employeeno) {
		
		List<Map<String, String>> mapList = dao.addGroup(fk_employeeno);
		
		return mapList;
	}

	
	
	
	// tbl_loginhistory 테이블에 insert 해주기
	@Override
	public void insert_tbl_loginhistory(Map<String, String> paraMap) {
		dao.insert_tbl_loginhistory(paraMap);
		
	}


	// 해당 유저의 ip 주소 갖고오기
	@Override
	public List<Map<String, String>> getIpAddr(String employeeno) {
		List<Map<String, String>> ipMap = dao.getIpAddr(employeeno);
		return ipMap;
	}

	


}
