package com.spring.app.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import com.spring.app.board.service.BoardService;
import com.spring.app.employee.domain.EmployeeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;




// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/board/*")
public class BoardController {
	
	
	
	@Autowired
	private BoardService service;
	
	@GetMapping("") //게시판 메인 페이지로 이동 
	public ModelAndView board(ModelAndView mav,HttpServletRequest request) {
		
		////////////////////////////////////////////
		EmployeeVO evo = new EmployeeVO();
        evo.setEmployeeNo("100010");  		//사원번호
        evo.setFK_positionNo("1"); 			//직급번호
        evo.setFK_teamNo("1"); 			//팀번호
        evo.setName("이상우"); 				//사원명
        evo.setSecurityLevel("10"); 		//보안등급
        evo.setEmail("giyf1208@naver.com"); //이메일
        evo.setMobile("01012345678"); 		//폰번호
        evo.setDirectCal("01012345678"); 	//내선번호
        evo.setBank("국민은행"); 				//은행
        evo.setAccount("12341234215074"); 	//계좌
        evo.setMaritalStatus("1"); 			//결혼 유무
        evo.setDisability("1"); 			//장애여부
        evo.setEmploymentType("1"); 		//채용구분
        evo.setRegisterDate("2025-02-11"); 	//입사일
        evo.setSalary("30000000");			//기본급
        evo.setStatus("1");					//재직상타
      
        HttpSession session = request.getSession();
        session.setAttribute("loginuser", evo);
        ////////////////////////////////////////////
	      
	      mav.setViewName("mycontent/board/board");
		return mav;
	}
	
	// 게시판 생성폼 View 단으로 이동하기
	@GetMapping("addBoardView") 
	public ModelAndView addBoardView(ModelAndView mav) {
		
		mav.setViewName("mycontent/board/addBoard");
		
		return mav;
	}
	
	// 게시판 생성하기
	@PostMapping("addBoard") 
	public ModelAndView addBoard(ModelAndView mav) {
		
		int n1 = 0,n2=0;
		try {
			n1 = service.addBoard(); // 게시판 생성하기
			if (n1 == 1) {
	            // int n2 = service.addDepartmentBoard(departmentNo, board.getBoardNo()); // 게시판 & 부서 권한매핑
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("BoardController_addBoard에서 예외 발생.");
			mav.setViewName("mycontent/board/board");
		}
		if(n1 != 1) {
			System.out.println("게시판 등록 실패!");
		}
		
		mav.setViewName("mycontent/board/board");
		
		return mav;
	}

	// 게시판 수정폼 View 단으로 이동하기
	@GetMapping("updateBoardView") 
	public ModelAndView updateBoardView(ModelAndView mav) {
			mav.setViewName("mycontent/board/updateBoard");
		return mav;
	}
	
	// 게시판 수정하기
	@PostMapping("updateBoard")
	public ModelAndView updateBoard(ModelAndView mav) {
		int n = 0;
		try {
			n = service.updateBoard(); // 게시판 수정하기
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("BoardController_updateBoard에서 예외 발생.");
			mav.setViewName("mycontent/board/board");
		}
		if(n != 1) {
			System.out.println("게시판 수정 실패!");
		}
		
		mav.setViewName("mycontent/board/board");
		
		return mav;
	}
	
	//게시판삭제하기(status 값변경)
	@PostMapping("deleteBoard")
	public ModelAndView deleteBoard(ModelAndView mav) {
		int n = 0;
		try {
			n = service.deleteBoard(); // 게시판 수정하기
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("BoardController_deleteBoard에서 예외 발생.");
			mav.setViewName("mycontent/board/board");
		}
		if(n != 1) {
			System.out.println("게시판 삭제 실패!");
		}
		mav.setViewName("mycontent/board/board");
		return mav;
	}
	
	
}// end of public class BoardController {}---------------
