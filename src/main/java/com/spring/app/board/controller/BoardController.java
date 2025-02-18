package com.spring.app.board.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.domain.PostVO;
import com.spring.app.board.service.BoardService;
import com.spring.app.employee.domain.EmployeeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;




// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/board/*")
public class BoardController {
	
	
	
	@Autowired
	private BoardService service;
	
	@GetMapping("") //게시판 메인 페이지로 이동 
	public ModelAndView board(ModelAndView mav,HttpServletRequest request) {
	      mav.setViewName("mycontent/board/board");
		return mav;
	}
	
	// 생성된 게시판 LeftBar에 나열하기 (출력)
	@GetMapping("selectBoardList")
	@ResponseBody
	public List<BoardVO> selectBoardList() {
	    List<BoardVO> boardList = service.selectBoardList();  // 게시판 목록 조회
	    return boardList; // JSON 데이터로 반환됨
	}
	
	// 게시판 생성폼 View 단으로 이동하기
	@GetMapping("addBoardView") 
	public ModelAndView addBoardView(ModelAndView mav) {
		
		mav.setViewName("mycontent/board/addBoard");
		
		return mav;
	}
	
	// 게시판 생성하기
	@PostMapping("addBoard") 
	public ModelAndView addBoard(ModelAndView mav,BoardVO boardvo) {
		
		int n1 = 0,n2=0;
		try {
			n1 = service.addBoard(boardvo); // 게시판 생성하기
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
		
		mav.setViewName("redirect:/board/board");
		
		return mav;
	}
	
	//게시판 생성의 공개여부 부서 설정 시 부서 워드 검색(부서 검색)
	@GetMapping("addBoardSearchDept")
	@ResponseBody
	public List<Map<String, String>> addBoardSearchDept(@RequestParam Map<String, String> paraMap) {
		
		List<Map<String, String>> wordList = service.addBoardSearchDept(paraMap); 
		
		List<Map<String, String>> mapList = new ArrayList<>();
		
		if(wordList != null) {
			for(Map<String, String> word : wordList) {
				Map<String, String> map = new HashMap<>();
				map.put("departmentname", word.get("DEPARTMENTNAME")); 
	            map.put("departmentno", String.valueOf(word.get("DEPARTMENTNO"))); 
				mapList.add(map);
			}// end of for-------------
		}
		
		return mapList;
	}
	
	//게시판 생성의 공개여부 부서 설정 시 부서 전체 검색(부서 검색)
	@GetMapping("addBoardSearchAllDept")
	@ResponseBody
	public List<Map<String, String>> addBoardSearchAllDept() {
		
		List<Map<String, String>> deptList = service.addBoardSearchAllDept();  // 조회된 부서 전체결과 키:값
		
		List<Map<String, String>> mapList = new ArrayList<>();
		
		if(deptList != null) {
			for(Map<String, String> word : deptList) {
				Map<String, String> map = new HashMap<>();
				map.put("departmentname", word.get("DEPARTMENTNAME")); 
	            map.put("departmentno", String.valueOf(word.get("DEPARTMENTNO")));
				mapList.add(map);
			}// end of for-------------
		}
		
		return mapList;
	}

	// 게시판 수정폼 View 단으로 이동하기
	@GetMapping("updateBoardView") 
	public ModelAndView updateBoardView(ModelAndView mav,@RequestParam String boardNo) {
			
			BoardVO boardvo = service.getBoardDetailByNo(boardNo); // 수정할 input 요소에 기존값을 뿌려주기 위함.
			mav.addObject("boardvo", boardvo);
			mav.setViewName("mycontent/board/updateBoard");
		return mav;
	}
	
	// 게시판 수정하기
	@PostMapping("updateBoard")
	public ModelAndView updateBoard(ModelAndView mav,BoardVO boardvo) {
		int n = 0;
		try {
			n = service.updateBoard(boardvo); // 게시판 수정하기
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("BoardController_updateBoard에서 예외 발생.");
			mav.setViewName("mycontent/board/board");
		}
		if(n != 1) {
			System.out.println("게시판 수정 실패!");
		}
		
		mav.setViewName("redirect:/board/board");
		
		return mav;
	}
	
	//게시판삭제(비활성화)하기(status 값변경)
	@PostMapping("disableBoard")
	@ResponseBody
	public Map<String, Integer> disableBoard(ModelAndView mav,@RequestParam String boardNo) {
		int n = 0;
		try {
			n = service.disableBoard(boardNo); // 게시판 삭제(비활성화)하기
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("BoardController_deleteBoard에서 예외 발생.");
			mav.setViewName("mycontent/board/board");
		}
		if(n != 1) {
			System.out.println("게시판 삭제 실패!");
		}
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map;
	}
	
	// 글쓰기 시 글작성 할 (접근 권한있는)게시판 목록 <select> 태그에 보여주기
	@GetMapping("getAccessibleBoardList")
	@ResponseBody
	public List<Map<String,String>> getAccessibleBoardList(@RequestParam String employeeNo){
		
		List<Map<String, String>>  boardList = service.getAccessibleBoardList(employeeNo);
		/*System.out.println("boardList : " + boardList);
		 boardList : 
		 [{BOARDNO=100037, BOARDNAME=일수게시판}, 
		 {BOARDNO=100035, BOARDNAME=부춘게시판}, 
		 {BOARDNO=100033, BOARDNAME=전사게시판}, 
		 {BOARDNO=100036, BOARDNAME=공공게시판}, 
		 {BOARDNO=100034, BOARDNAME=전공게시판}]
		 */
		List<Map<String, String>> mapList = new ArrayList<>(); // 새로운 리스트
		
		if(boardList != null) {
			for(Map<String, String> board : boardList) {
				Map<String, String> map = new HashMap<>(); // 새로운맵
				map.put("boardname", board.get("BOARDNAME")); 
				map.put("boardno", board.get("BOARDNO")); 
				mapList.add(map); // 새로운 맵에 저장된 것을 새로운 리스트에 추가
			}// end of for-------------
		}
		
		return mapList;
	}
	
  // 게시글 등록하기
  @PostMapping("addPost")
  public String addPost(PostVO postvo) {
	
	  System.out.println("postvo.getFk_boardNo() 게시판 번호: " + postvo.getFk_boardNo());
	  System.out.println("postvo.getSubject() 글제목 : " + postvo.getSubject());
	  System.out.println("postvo.getContent() 글내용: " + postvo.getContent());
	  System.out.println("postvo.getFk_employeeNo() 100013으로 고정값 줌. : " + postvo.getFk_employeeNo());
	  System.out.println("postvo.getIsNotice() : " + postvo.getIsNotice());
	  System.out.println("postvo.getName() 이상우로 고정값을 줌. : " + postvo.getName());
	  System.out.println("postvo.getNoticeEndDate() : " + postvo.getNoticeEndDate());
	  System.out.println("postvo.getAllowComments() : " + postvo.getAllowComments());
	  
	  
	  
	  int n = service.addPost(postvo); 
	  
	  if(n>0) {
		  System.out.println("게시글 등록이 완료되었습니다!");
	  }
	  else {
		  System.out.println("게시글 등록이 실패되었습니다");
	  }
	
	  return "redirect:/board/board";
  }
	
	
	
	
}// end of public class BoardController {}---------------
