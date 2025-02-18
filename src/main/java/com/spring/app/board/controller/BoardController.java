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
import com.spring.app.common.MyUtil;
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
	public ModelAndView board(ModelAndView mav,HttpServletRequest request,
            @RequestParam(defaultValue = "1") String currentShowPageNo) {
	    
		
		
		
		////////////////////////////////////////
		
		// 먼저, 총 게시물 건수(totalCount)를 구해와야 한다.
				// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 검색조건이 없을때로 나뉘어진다.
				int totalCount = 0;          // 총 게시물 건수
				int sizePerPage = 5;        // 한 페이지당 보여줄 게시물 건수
				int totalPage = 0;           // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
				
				int n_currentShowPageNo = 0; 
				
				// 총 게시물 건수 (totalCount)
				totalCount = service.getTotalCount();
			//	System.out.println("~~~ 확인용 totalCount : " + totalCount);
				/*
				   ~~~ 확인용 totalCount : 211 
				   ~~~ 확인용 totalCount : 202
				   ~~~ 확인용 totalCount : 1
				   ~~~ 확인용 totalCount : 0
				*/
				
				// 만약에 총 게시물 건수(totalCount)가 124 개 이라면 총 페이지수(totalPage)는 13 페이지가 되어야 한다.
				// 만약에 총 게시물 건수(totalCount)가 120 개 이라면 총 페이지수(totalPage)는 12 페이지가 되어야 한다. 
				totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
				//  (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> 13.0 ==> 13 
			    //  (double)120/10 ==> 12.0 ==> Math.ceil(12.0) ==> 12.0 ==> 12 
				
				try {
					  n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
				
					  if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
						// get 방식이므로 사용자가 currentShowPageNo 에 입력한 값이 0 또는 음수를 입력하여 장난친 경우 
						// get 방식이므로 사용자가 currentShowPageNo 에 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을 입력하여 장난친 경우 
						 n_currentShowPageNo = 1;
					  }
					  
				} catch(NumberFormatException e) {
					// get 방식이므로 currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하거나
					// int 범위를 초과한 경우
					n_currentShowPageNo = 1;
				}
				
				
				// **** 가져올 게시글의 범위를 구한다.(공식임!!!) **** 
				/*
				     currentShowPageNo      startRno     endRno
				    --------------------------------------------
				         1 page        ===>    1           10
				         2 page        ===>    11          20
				         3 page        ===>    21          30
				         4 page        ===>    31          40
				         ......                ...         ...
				 */
				 
				 int startRno = ((n_currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
				 int endRno = startRno + sizePerPage - 1; // 끝 행번호 
				 
				 Map<String, String> paraMap = new HashMap<>();
				 
				 paraMap.put("startRno", String.valueOf(startRno)); // Oracle 11g 와 호환되는 것으로 사용하기 위함 
				 paraMap.put("endRno", String.valueOf(endRno));     // Oracle 11g 와 호환되는 것으로 사용하기 위함
				 
				// === 게시판 메인 페이지에 뿌려줄 모든 게시글 조회 === //
				 List<PostVO> postAllList = service.selectAllPost(paraMap); 
				 mav.addObject("postAllList",postAllList);
				 
//				 List<PostVO> postList = null;
//				 
//				 postList = service.postList_withPaging();
//				 // 글목록 가져오기(페이징 처리 완료.)
//				
//				 mav.addObject("postList", postList);
				 
				 // === #102. 페이지바 만들기 === //
				 int blockSize = 10;
				 // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수이다.
				 /*
					             1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
					[맨처음][이전]  11 12 13 14 15 16 17 18 19 20 [다음][마지막]  -- 1개블럭
					[맨처음][이전]  21 22 23
				 */
				 
				 int loop = 1;
				 /*
			    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
			     */
				 
				 int pageNo = ((n_currentShowPageNo - 1)/blockSize) * blockSize + 1; // *** !! 공식이다. !! *** //
					
				/*
				    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
				    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
				    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
				*/
				 
				String pageBar = "<ul style='list-style:none;'>";
				String url = "list";
				
				// === [맨처음][이전] 만들기 === //
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'>[맨처음]</a></li>";
				
				if(pageNo != 1) {
					pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>"; 
				}
				
				
				while( !(loop > blockSize || pageNo > totalPage) ) {
					
					if(pageNo == Integer.parseInt(currentShowPageNo)) {
						pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>"; 
					}
					else {
						pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
					}
					
					loop++;
					pageNo++;
				}// end of while-------------------------------
				
				
				// === [다음][마지막] 만들기 === //
				if(pageNo <= totalPage) {
					pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>"; 	
				}
				
				pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
							
				pageBar += "</ul>";	
				
				mav.addObject("pageBar", pageBar);
				 
				
				///////////////////////////////////////////////////////////

				mav.addObject("totalCount", totalCount);   // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
				mav.addObject("currentShowPageNo", currentShowPageNo); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
				mav.addObject("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것임.
				
		        ///////////////////////////////////////////////////////////
		        
				// === 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
				//           사용자가 "검색된결과목록보기" 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
				//           현재 페이지 주소를 뷰단으로 넘겨준다.
				String currentURL = MyUtil.getCurrentURL(request);
			//	System.out.println("~~~ 확인용 currentURL : " + currentURL);

				mav.addObject("goBackURL", currentURL);
		
		
		////////////////////////////////////////
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
