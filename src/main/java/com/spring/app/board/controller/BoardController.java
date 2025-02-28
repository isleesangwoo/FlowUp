package com.spring.app.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.domain.PostFileVO;
import com.spring.app.board.domain.PostVO;
import com.spring.app.board.service.BoardService;
import com.spring.app.common.FileManager;
import com.spring.app.common.MyUtil;
import com.spring.app.employee.domain.EmployeeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;




// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/board/*")
public class BoardController {
	
	
	
	@Autowired
	private BoardService service;
	
	@Autowired  // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager; 
	
	@GetMapping("") //게시판 메인 페이지로 이동 (게시판그룹의 글 전체 조회요청)
	public ModelAndView board(ModelAndView mav,HttpServletRequest request,
            @RequestParam(defaultValue = "1") String currentShowPageNo) {
	    
		/*
		 * 글조회수(readCount)증가
		  목록보기에서 해당 글을 클릭했을 경우 증가,
		  웹브라우저에서 새로고침(F5)을 했을 경우증가 x
	    */     
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		/*
		session 에  "readCountPermission" 키값으로 저장된 value값은 "yes" 이다.
		session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면 
		반드시 웹브라우저에서 주소창에 "/board/list" 이라고 입력해야만 얻어올 수 있음. 
		*/
		
		// 총 게시물 건수(totalCount)를 구하기
		int totalCount = 0;   // 총 게시물 건수
		int sizePerPage = 5;  // 한 페이지당 보여줄 게시물 건수
		int totalPage = 0;    // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int n_currentShowPageNo = 0; 
		
		// 총 게시물 건수 (totalCount)
		totalCount = service.getTotalCount();
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		// 총 게시물 건수(totalCount)가 124 개 이라면 총 페이지수(totalPage)는 13 페이지가 되어야 함.
		// (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> 13.0 ==> 13 
		
		try {
			  n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
		
			  if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
				// get 방식이므로 사용자가 currentShowPageNo 에 입력한 값이 0 또는 음수 또는 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을 입력하여 장난친 경우 
				 n_currentShowPageNo = 1;
			  }
			  
		} catch(NumberFormatException e) {
			// get 방식이므로 currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하거나 int 범위를 초과한 경우
			n_currentShowPageNo = 1;
		}
		 
		 int startRno = ((n_currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
		 int endRno = startRno + sizePerPage - 1; // 끝 행번호 
		 
		 Map<String, String> paraMap = new HashMap<>();
		 
		 paraMap.put("startRno", String.valueOf(startRno));
		 paraMap.put("endRno", String.valueOf(endRno)); 
		 
		// === 게시판 메인 페이지에 뿌려줄 모든 게시글 조회 === //
		 List<PostVO> postAllList = service.selectAllPost(paraMap); 
		 mav.addObject("postAllList",postAllList);
		 
//				 List<PostVO> postList = null;
//				 
//				 postList = service.postList_withPaging();
//				 // 글목록 가져오기(페이징 처리 완료.)
//				
//				 mav.addObject("postList", postList);
		 
		 // === 페이지바 만들기 === //
		 int blockSize = 10;
		 // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수
		 //1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
		 
		 int loop = 1; //loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수까지만 증가하는 용도
	     
		 
		 int pageNo = ((n_currentShowPageNo - 1)/blockSize) * blockSize + 1;
		 
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
		 
		mav.addObject("totalCount", totalCount);   // 페이징 처리시 보여주는 순번을 나타내기 위한 것
		mav.addObject("currentShowPageNo", currentShowPageNo); // 페이징 처리시 보여주는 순번을 나타내기 위한 것
		mav.addObject("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것
        
		
		
		
		// 페이징 처리된 후 특정 글을 클릭하여 글을 본 후 사용자가 목록보기 버튼을 클릭했을 때 돌아갈페이지를 알려주기위해 넘김 
		String currentURL = MyUtil.getCurrentURL(request);
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
	
	// 게시판 생성의 공개여부 부서 설정 시 부서 워드 검색(부서 검색)
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
  @ResponseBody
  public String addPost(PostVO postvo,PostFileVO postfilevo,MultipartHttpServletRequest mtp_request) {
	  
	  List <MultipartFile> fileList = mtp_request.getFiles("file_arr"); // getFile은 1개만 받는 것이고 getFiles은 list로 여러개를 받음 file_arr 는 emailWrite.jsp의 317 라인 의 배열 값이다.
	  // !! 주의 !! 복수개의 파일은 mtp_request.getFile 이 아니라 mtp_request.getFiles 이다.!!
      // MultipartFile interface는 Spring에서 업로드된 파일을 다룰 때 사용되는 인터페이스로 파일의 이름과 실제 데이터, 파일 크기 등을 구할 수 있다.
		
	  List<Map<String, Object>> mapList = new ArrayList<>(); //  기존파일명,새로운 파일명,사이즈 다 받아오기위
	  String originalFilename = "";
	  byte[] bytes =null;	
		/*
		   1. 사용자가 보낸 첨부파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		   >>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기 
		       우리는 WAS 의 /FlowUp/src/main/webapp/board_resources/files 라는 폴더를 생성해서 여기로 업로드 해주도록 할 것이다. 
		 */
		
		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		HttpSession session = mtp_request.getSession();
		String root = session.getServletContext().getRealPath("/");
	    //	System.out.println("~~~ 확인용 webapp 의 절대경로 ==> " + root);
		
		String path =  root+"board_resources"+File.separator+"files";  //File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자
		
		// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 됨.
		File dir = new File(path);
        if(!dir.exists()) {
            dir.mkdirs();
        } // 만약 위의 디렉토리 경로가 없으면 만들라는 의미
        
        // >>>> 첨부파일을 위의 path 경로에 올리기 <<<< //
        String[] arr_attachFilename = null; // 첨부파일명들을 기록하기 위한 용도  
        
        if(fileList != null && fileList.size() > 0) {
        	arr_attachFilename = new String[fileList.size()];
        	
        	for(int i=0; i<fileList.size(); i++) {
        		MultipartFile mtfile = fileList.get(i);
        		
        		try {
                    //  파일 내용을 byte[]로 변환
                    bytes = mtfile.getBytes();

                    // 원본 파일명 가져오기
                    originalFilename = mtfile.getOriginalFilename();

                    // fileManager.doFileUpload()를 사용해서 유니크한 파일명으로 저장
                    String newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

                    // 실제 저장된 파일명을 배열에 저장
                    arr_attachFilename[i] = newFileName;
                    
                    Map<String, Object> Map = new HashMap<>();
                    Map.put("bytes", bytes); 						// 파일 사이즈 
                    Map.put("originalFilename", originalFilename);  // 기존 파일명 
                    Map.put("newFileName", newFileName); 			// 새로운 파일명
                    
                    mapList.add(Map); // 파일 사이즈,기존파일명,새로운 파일명을 담은 리스트(파라맵리스트)
                } catch (Exception e) {
                    e.printStackTrace();
                }
            	
            	
        	} // end of for(int i=0; i<fileList.size(); i++) {}----------------------
        	
        	
        } // end of if(fileList != null && fileList.size() > 0) {}-----------------
        
        JSONObject jsonObj = new JSONObject();
        
    	try {
    		 int n = 0;
    		  // === 글쓰기 등록하기, 일단 게시글 insert 이후 첨부파일의 여부는 service단에서 함  === //
    		  n = service.addPost(postvo,postfilevo,mapList); 
    		  
    		  if(n>0) {
    			  System.out.println("게시글 등록이 완료되었습니다!");
    		  }
    		  else {
    			  System.out.println("게시글 등록이 실패되었습니다");
    		  }
    		  
    		jsonObj.put("result", 1);
    	}catch (Exception e) {
			e.printStackTrace();
			jsonObj.put("result", 0);
		}
        
    	return jsonObj.toString();
  }
  
  // 게시글 하나 조회하기 (조회수 증가 포함)
  @RequestMapping("goViewOnePost")
  public ModelAndView goViewOnePost(ModelAndView mav, HttpServletRequest request) {
	  
	  String postNo = request.getParameter("postNo");
	  String goBackURL = request.getParameter("goBackURL");
	  String checkAll_or_boardGroup = request.getParameter("checkAll_or_boardGroup");
	  // 글 상세페이지의 이전/다음글 을 전체게시판 기준으로 조회할지, 해당게시판 조건으로 조회할지
	  // 1이면 해당게시판을 조건으로, 값이 없으면 전체게시판(조건없음)
	  
	  String fk_boardNo = request.getParameter("fk_boardNo");
	  
	  
	  /* goViewOnePost_2 에서  //redirectArr.addFlashAttribute("redirect_map", redirect_map); 로 값을 옮겨준(넣어준) 경우
	  Map<String, ?> inputFlashMap = RequestContextUtils.getInputFlashMap(request);
		// redirect 되어서 넘어온 데이터가 있는지 꺼내어 와본다.
	  
		if(inputFlashMap != null) { // redirect 되어서 넘어온 데이터가 있다라면 
			System.out.println("inputFlashMap : " + inputFlashMap);
			@SuppressWarnings("unchecked") // 경고 표시를 하지 말라는 뜻이다. 
			Map<String, String> redirect_map = (Map<String, String>) inputFlashMap.get("redirect_map");
			// "redirect_map" 값은  /view_2 에서  redirectAttr.addFlashAttribute("키", 밸류값); 을 할때 준 "키" 이다. 
			// "키" 값을 주어서 redirect 되어서 넘어온 데이터를 꺼내어 온다. 
			// "키" 값을 주어서 redirect 되어서 넘어온 데이터의 값은 Map<String, String> 이므로 Map<String, String> 으로 casting 해준다. 
			
			postNo = redirect_map.get("postNo");
			checkAll_or_boardGroup = redirect_map.get("checkAll_or_boardGroup");
			fk_boardNo = redirect_map.get("fk_boardNo");
			try {
				goBackURL = URLDecoder.decode(redirect_map.get("goBackURL"), "UTF-8"); // 한글데이터가 포함되어 있으면 반드시 한글로 복구해 주어야 한다. 
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}  
			// === view_2 에서 redirect 해온것을 처리해주기 끝 === //
		}
	  */
	  
	  HttpSession session = request.getSession();
	  EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	
	  String login_userid = null;
	  if(loginuser != null) {
		login_userid = loginuser.getEmployeeNo();
		// login_userid 는 로그인 되어진 사용자의 userid 이다. 
	  }
	
	  Map<String, String> paraMap = new HashMap<>();
	  paraMap.put("postNo", postNo);
	  paraMap.put("login_userid", login_userid);
	  paraMap.put("checkAll_or_boardGroup", checkAll_or_boardGroup);
	  paraMap.put("fk_boardNo", fk_boardNo);	// 이전/다음 글 계속 클릭하여 이동 시 현재 게시판그룹을 유지시켜주기 위해
	  
	  // 위의 글목록보기 에서 session.setAttribute("readCountPermission", "yes"); 설정함.
	  PostVO postvo = null;
	  List<PostFileVO> postfilevo =null;

	  if ("yes".equals((String) session.getAttribute("readCountPermission"))) {
		  // 글목록보기인 /board 페이지를 클릭한 다음에 특정글을 조회해온 경우

		  postvo = service.goViewOnePost(paraMap); // 게시글 하나 조회하기
		  // 글 조회수 증가와 함께 글 1개를 조회를 해오는 것( 조회수 증가는 service 단에서 처리를 해줌.)
		  
		  session.removeAttribute("readCountPermission");
	  }

	  else {
		  postvo = service.getView_no_increase_readCount(paraMap); // 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
		  // 글목록에서 특정 글제목을 클릭하여 본 상태에서
		  // 웹브라우저에서 새로고침(F5)을 클릭한 경우 
		  
	  		  if (postvo == null) {
				  mav.setViewName("redirect:/board/");
				  return mav;
			  }
	  		  
		  }
	  	
	  	  postfilevo = service.getFileOfOnePost(paraMap); // 글 하나의 첨부파일 테이블의 고유번호,기존파일명,새로운 파일명 추출
	  	  
	  	  mav.addObject("checkAll_or_boardGroup", checkAll_or_boardGroup);
	  	  mav.addObject("postfilevo", postfilevo);
		  mav.addObject("postvo", postvo);
		  mav.addObject("goBackURL", goBackURL); // 글 하나 클릭 시 클릭된 페이지의 해당 URL을 넘겨줌.
		  mav.setViewName("mycontent/board/onePostView");
	  
	  return mav;
  }
	

  // 글 삭제하기( 경로의 실제 파일 삭제와 db 행 삭제)
  @PostMapping("postDel")
  public  ModelAndView postDel(ModelAndView mav, @RequestParam String postNo, HttpServletRequest request){
	  /*
	    일단 삭제할 행을 테이블에서 지운다. 
		그리고 
		삭제에 필요한 것
		String filepath = paraMap.get("filepath"); // 삭제해야할 첨부파일이 저장된 경로
		String filename = paraMap.get("filename"); // 삭제해야할 첨부파일명
		
		FileManager.dofileDelete(filename, filepath);를 통해 실제 파일을 삭제한다.
	  */
	  
	  // 실제 첨부파일을 삭제하기위해 첨부파일명을 알아오기.
	  List<Map<String, Object>> postListmap = service.getView_delete(postNo);// 리스트맵으로 한 이유 : 이미지(스마트에디터)는 컬럼 하나에 "/" 구분자로 가능, 파일첨부는 여러개이지만 컬럼 하나 당 1개의 파일이기 때문에 여러행 반환.
	  Map<String,String> paraMap = new HashMap<>();
	  
		  
	  String filename = (String) postListmap.get(0).get("filename");
		// 202502071215204988403314512900.pdf  이것이 바로 WAS(톰캣) 디스크에 저장된 '첨부 파일명' 이다. 
	  
		if(filename != null && !"".equals(filename)) { // 첨부파일이 존재하는 경우
			
	         HttpSession session = request.getSession(); 
	         String root = session.getServletContext().getRealPath("/");  
	         String filepath = root+"board_resources"+File.separator+"files";
	         
	         paraMap.put("filepath", filepath); // 삭제해야할 첨부파일이 저장된 경로
	         //paraMap.put("filename", filename); // 삭제해야할 첨부파일명
		}
		// === 파일첨부 또는 사진첨부 또는 파일첨부 및 사진첨부가 된 글이라면 글 삭제시 먼저 첨부파일을 삭제. 끝 === //
		/////////////////////////////////////////////////////////////////////
	  
	  
	  // === 글내용중에 사진이미지가 들어가 있는 경우라면 사진이미지 파일도 삭제해주어야 한다.
	  String photofilename = (String) postListmap.get(0).get("photofilename");
	  if(photofilename != null) {
		  // 글내용중에 사진이미지가 들어가 있는 경우라면
		
		  HttpSession session = request.getSession(); 
          String root = session.getServletContext().getRealPath("/"); 
        
          String photo_upload_path = root+"board_resources"+File.separator+"photo_upload";
        
          paraMap.put("photo_upload_path", photo_upload_path); // 삭제해야할 사진이미지 파일이 저장된 경로
          paraMap.put("photofilename", photofilename);         // 삭제해야할 사진이미지 파일명
	  }
	
	  // === 첨부파일이 추가된 경우 또는 사진이미지가 들어가 있는 경우 글삭제하기 === //
	  paraMap.put("postNo", postNo); // 삭제할 글번호
	  int n = service.postDel(paraMap,postListmap); // 파일첨부, 사진이미지가 들었는 경우의 글 삭제하기
	  if(n==1) {
		  mav.addObject("message", "글 삭제 성공!!");
	      mav.addObject("loc", request.getContextPath()+"/board/board");
	      mav.setViewName("msg");
	  }
	  
	    //String filename = postListmap.get("filename");
	    // 202502071215204988403314512900.pdf  이것이 바로 WAS(톰캣) 디스크에 저장된 '첨부 파일명' 이다. 
	    return mav;
    }
  
  	//=== #161. 첨부파일 다운로드 받기 === //
	@GetMapping("fileDownload")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response) {
		
		String postNo = request.getParameter("postNo"); // 첨부파일이 있는 글번호 
		String fileNo = request.getParameter("fileNo"); // 첨부파일 테이블의 고유번호
		
		/*
		    첨부파일이 있는 글번호에서
		    202502071242164990019082166200.jpg 처럼
		    이러한 fileName 값을 DB에서 가져와야 한다.
		    또한 orgFilename 값도 DB에서 가져와야 한다.
		*/
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("postNo", postNo);
		paraMap.put("fileNo", fileNo);
		
		
		// **** 웹브라우저에 출력하기 시작 **** //
		// HttpServletResponse response 객체는 전송되어져온 데이터를 조작해서 결과물을 나타내고자 할때 쓰인다.
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = null;
		// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
		
		try {
		    Integer.parseInt(postNo); 
			
		    PostFileVO postfilevo = service.getWithFileDownload(paraMap); // 파일다운로드에 필요한 컬럼 추출하기(게시글번호와 파일고유번호로 결과(행)이 하나만 나옴,새로운파일명,기존파일명)
		    
		    if(postfilevo == null || (postfilevo != null && postfilevo.getFileName() == null) ) { 
		    	out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
				return;
		    }
		    
		    else {
		    	// 정상적으로 다운로드를 할 경우 
		    	
		    	String fileName = postfilevo.getFileName();
		    	System.out.println(" fileName : " + fileName);
		    	// 202502071242164990019082166200.jpg  이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
		    	
		    	String orgFilename = postfilevo.getOrgFilename(); 
		    	System.out.println(" orgFilename : " + orgFilename);
		    	// 쉐보레전면.jpg   다운로드시 보여줄 파일명
		    	
		    	/*
				   첨부파일이 저장되어있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
				   이 경로는 우리가 파일첨부를 위해서 @PostMapping("add") 에서 설정해두었던 경로와 똑같아야 한다.    
				*/
				// WAS 의 webapp 의 절대경로를 알아와야 한다.
				HttpSession session = request.getSession();
				String root = session.getServletContext().getRealPath("/");
				
			//	System.out.println("~~~ 확인용 webapp 의 절대경로 ==> " + root);
				// ~~~ 확인용 webapp 의 절대경로 ==> C:\NCS\workspace_spring_boot_17\myspring\src\main\webapp\
				
				String path = root+"board_resources"+File.separator+"files";  
				/* File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			       운영체제가 Windows 이라면 File.separator 는  "\" 이고,
			       운영체제가 UNIX, Linux, 매킨토시(맥) 이라면  File.separator 는 "/" 이다. 
			    */
				
				// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
				System.out.println("~~~ 확인용 path ==> " + path);
				// ~~~ 확인용 path ==> C:\NCS\workspace_spring_boot_17\myspring\src\main\webapp\resources\files
		    	
				
				// ***** file 다운로드 하기 ***** //
				boolean flag = false; // file 다운로드 성공, 실패인지 여부를 알려주는 용도
				flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
				// file 다운로드 성공시 flag 는 true,
				// file 다운로드 실패시 flag 는 false 를 가진다.
				
				if(!flag) {
					// 다운로드가 실패한 경우 메시지를 띄운다.
					out = response.getWriter();
					// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
					
					out.println("<script type='text/javascript'>alert('파일다운로드가 실패되었습니다.'); history.back();</script>");
				}
		    	
		    }
			
		} catch (NumberFormatException | IOException e) {
			
			try {
				out = response.getWriter();
				// out 은 웹브라우저에 기술하는 대상체라고 생각하자.
				
				out.println("<script type='text/javascript'>alert('파일다운로드가 불가합니다.'); history.back();</script>");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			
		}
		
	}
  
  // 게시글 수정하기
  @PostMapping("updatePost")
  @ResponseBody
  public String updatePost(PostVO postvo,PostFileVO postfilevo,MultipartHttpServletRequest mtp_request) {
	  System.out.println("일단 도착");
	  String postNo = mtp_request.getParameter("postNo");
	  String deleteFiles = mtp_request.getParameter("deleteFiles");
	  //System.out.println("deleteFiles : " + deleteFiles );
	  //System.out.println("postNo  : " + postNo); // postNo  : 100136
	  
	  
	Map<String,String> paraMap = new HashMap<>();
	
	
	if(deleteFiles != null && !"".equals(deleteFiles)) { // 첨부파일이 삭제요청이 존재하는 경우
	
	// 첨부파일이 저장되어 있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
	// 이 경로는 우리가 파일첨부를 위해서 /addEnd 에서 설정해두었던 경로와 똑같아야 한다.  
	// WAS 의 webapp 의 절대경로를 알아와야 한다. 
	HttpSession session = mtp_request.getSession(); 
	String root = session.getServletContext().getRealPath("/");  
	
	//System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
	//~~~ 확인용 webapp 의 절대경로 => C:\GitHub\FlowUp\src\main\webapp\
	String filepath = root+"board_resources"+File.separator+"files";
	
	// file_path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	// System.out.println("~~~ 확인용 filepath => " + filepath);
	// ~~~ 확인용 filepath => C:\GitHub\FlowUp\src\main\webapp\resources\files
	
	paraMap.put("filepath", filepath); // 삭제해야할 첨부파일이 저장된 경로
	//paraMap.put("filename", filename); // 삭제해야할 첨부파일명
	
	JSONArray deleteFilesArray = new JSONArray(deleteFiles);
	paraMap.put("postNo", postNo); // 삭제할 글번호
	  for (int i = 0; i < deleteFilesArray.length(); i++) { // 삭제 요청한 첨부파일 목록들
	      JSONObject fileObj = deleteFilesArray.getJSONObject(i);
	      
	      String fileNo = fileObj.getString("fileNo");
	      String fileName = fileObj.getString("fileName");
	      String newFileName = fileObj.getString("newFileName");
	      
	      
	      
	      paraMap.put("fileNo", fileNo);
	      paraMap.put("fileName", fileName);
	      paraMap.put("newFileName", newFileName);
		  int n = service.FileDelOfPostUpdate(paraMap); // 글 수정에서 첨부파일 삭제하기
	  }
	}// end of if(deleteFiles != null && !"".equals(deleteFiles)) {}----------------
	
	
	// 수정 전 이미지 목록 가져오기 (DB에서 조회)
    List<String> oldFileList = Arrays.asList(service.getBeforeUpdateFileNames(postNo).get(0).split("/"));
	
	/////////////////////////////////////////////////////////////////////
	  
	  
	  
	  List <MultipartFile> fileList = mtp_request.getFiles("file_arr"); // getFile은 1개만 받는 것이고 getFiles은 list로 여러개를 받음 file_arr 는 emailWrite.jsp의 317 라인 의 배열 값이다.
	  // !! 주의 !! 복수개의 파일은 mtp_request.getFile 이 아니라 mtp_request.getFiles 이다.!!
      // MultipartFile interface는 Spring에서 업로드된 파일을 다룰 때 사용되는 인터페이스로 파일의 이름과 실제 데이터, 파일 크기 등을 구할 수 있다.
		
	  List<Map<String, Object>> mapList = new ArrayList<>(); //  기존파일명,새로운 파일명,사이즈 다 받아오기위
	  String originalFilename = "";
	  byte[] bytes =null;	
		
		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		HttpSession session = mtp_request.getSession();
		String root = session.getServletContext().getRealPath("/");
		
		String path =  root+"board_resources"+File.separator+"files"; 
		
		File dir = new File(path);
        if(!dir.exists()) {
            dir.mkdirs();
        } 
        
        // >>>> 첨부파일을 위의 path 경로에 올리기 <<<< //
        String[] arr_attachFilename = null; // 첨부파일명들을 기록하기 위한 용도  
        
        if(fileList != null && fileList.size() > 0) {
        	arr_attachFilename = new String[fileList.size()];
        	
        	for(int i=0; i<fileList.size(); i++) {
        		MultipartFile mtfile = fileList.get(i);
        		
        		try {
                    //  파일 내용을 byte[]로 변환
                    bytes = mtfile.getBytes();

                    // 원본 파일명 가져오기
                    originalFilename = mtfile.getOriginalFilename();

                    // fileManager.doFileUpload()를 사용해서 유니크한 파일명으로 저장
                    String newFileName = fileManager.doFileUpload(bytes, originalFilename, path);

                    // 실제 저장된 파일명을 배열에 저장
                    arr_attachFilename[i] = newFileName;
                    
                    Map<String, Object> Map = new HashMap<>();
                    Map.put("bytes", bytes); 						// 파일 사이즈 
                    Map.put("originalFilename", originalFilename);  // 기존 파일명 
                    Map.put("newFileName", newFileName); 			// 새로운 파일명
                    
                    mapList.add(Map); // 파일 사이즈,기존파일명,새로운 파일명을 담은 리스트(파라맵리스트)
                } catch (Exception e) {
                    e.printStackTrace();
                }
            	
            	
        	} // end of for(int i=0; i<fileList.size(); i++) {}----------------------
        	
        	
        } // end of if(fileList != null && fileList.size() > 0) {}-----------------
        JSONObject jsonObj = new JSONObject();
        
    	try {
    		 int n = 0;
    		  // === 글수정하기, 일단 게시글 update 이후 첨부파일의 여부는 service단에서 함  === //
    		  n = service.updatePost(postvo,postfilevo,mapList); 
    		
		    		  // 2️ 수정 후 새로운 이미지 목록 추출 (db에서 조회)
		    		  List<String> newFileList = Arrays.asList(service.getAfterUpdateFileNames(postNo).get(0).split("/"));
		    		  
		    		  
		    		  // 3 기존 목록과 새 목록 비교하여 삭제할 파일 찾기
		    		    List<String> filesToDelete = new ArrayList<>();
		    		    for (String oldFile : oldFileList) {
		    		        if (!newFileList.contains(oldFile)) {
		    		            filesToDelete.add(oldFile);
		    		        }
		    		    }
    		            //filesToDelete : [2025022517021816086751960400.jpg, 2025022517021816086751960300.jpg]
		    		   
		    		    ////////////////////////
		    		// 4️ 서버에서 필요 없는 파일 삭제
		    		    for (String fileName : filesToDelete) {
		    		    	String filepath = root+"board_resources"+File.separator+"photo_upload";
		    		    	paraMap.put("photo_upload_path", filepath); // 삭제해야할 첨부파일이 저장된 경로
		    		    	
		    		    	//paraMap.put("postNo", postNo); // 삭제할 글번호
		    		  	 service.postImgFileDel(paraMap,fileName); // 사진이미지가 들었는 경우 실제 경로의 파일 삭제하기
		    		    }
    		 
    		  if(n>0) {
    			  System.out.println("게시글 수정이 완료되었습니다!");
    		  }
    		  else {
    			  System.out.println("게시글 수정이 실패되었습니다");
    		  }
    		  
    		jsonObj.put("result", 1);
    	}catch (Exception e) {
			e.printStackTrace();
			jsonObj.put("result", 0);
		}
        
    	return jsonObj.toString();
  }	  	
  
  // 게시판 '별' 게시글 조회
  @GetMapping("selectPostBoardGroupView")
  public ModelAndView selectPostBoardGroupView(ModelAndView mav,@RequestParam String boardNo,HttpServletRequest request,
          											@RequestParam(defaultValue = "1") String currentShowPageNo) {
	  // 게시판의 정보를 추출하기 위해(게시판명, 운영자 등등)
	  BoardVO boardInfoMap = service.getBoardInfo(boardNo);
	  
	  // 해당 게시판 클릭 시 글 상세페이지로 이동은 전체 게시판 참조.
	  
	  
	  HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		/*
		session 에  "readCountPermission" 키값으로 저장된 value값은 "yes" 이다.
		session 에  "readCountPermission" 키값에 해당하는 value값 "yes"를 얻으려면 
		반드시 웹브라우저에서 주소창에 "/board/list" 이라고 입력해야만 얻어올 수 있음. 
		*/
		
		// 총 게시물 건수(totalCount)를 구하기
		int totalCount = 0;   // 총 게시물 건수
		int sizePerPage = 20;  // 한 페이지당 보여줄 게시물 건수
		int totalPage = 0;    // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int n_currentShowPageNo = 0; 
		
		// 해당 게시판의 총 게시물 건수(totalCount) 구하기
		totalCount = service.getBoardGroupPostTotalCount(boardNo);
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		// 총 게시물 건수(totalCount)가 124 개 이라면 총 페이지수(totalPage)는 13 페이지가 되어야 함.
		// (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> 13.0 ==> 13 
		
		try {
			  n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
		
			  if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
				// get 방식이므로 사용자가 currentShowPageNo 에 입력한 값이 0 또는 음수 또는 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을 입력하여 장난친 경우 
				 n_currentShowPageNo = 1;
			  }
			  
		} catch(NumberFormatException e) {
			// get 방식이므로 currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하거나 int 범위를 초과한 경우
			n_currentShowPageNo = 1;
		}
		 
		 int startRno = ((n_currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
		 int endRno = startRno + sizePerPage - 1; // 끝 행번호 
		 
		 Map<String, String> paraMap = new HashMap<>();

		 paraMap.put("boardNo", boardNo); 
		 paraMap.put("startRno", String.valueOf(startRno));
		 paraMap.put("endRno", String.valueOf(endRno)); 
		 

		 // 게시판 별 게시글 조회 :: 게시판/게시글 테이블 조인 -> 조건 boardNo 인 것만 조회
		 List<PostVO> groupPostMapList =  service.selectPostBoardGroup(paraMap);
		 mav.addObject("groupPostMapList",groupPostMapList);
		 // === 페이지바 만들기 === //
		 int blockSize = 10;
		 // blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수
		 //1  2  3  4  5  6  7  8  9 10 [다음][마지막]  -- 1개블럭
		 
		 int loop = 1; //loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수까지만 증가하는 용도
	     
		 
		 int pageNo = ((n_currentShowPageNo - 1)/blockSize) * blockSize + 1;
		 
		String pageBar = "<ul style='list-style:none;'>";
		String url = "selectPostBoardGroupView";
		
		// === [맨처음][이전] 만들기 === //
		pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1&boardNo="+boardNo+"'>[맨처음]</a></li>";
		
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"&boardNo="+boardNo+"'>[이전]</a></li>"; 
		}
		
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>"; 
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"&boardNo="+boardNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
		}// end of while-------------------------------
		
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>[다음]</a></li>"; 	
		}
		
		pageBar += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"&boardNo="+boardNo+"'>[마지막]</a></li>";
					
		pageBar += "</ul>";	
		
		mav.addObject("pageBar", pageBar);
		
		mav.addObject("totalCount", totalCount);   // 페이징 처리시 보여주는 순번을 나타내기 위한 것
		mav.addObject("currentShowPageNo", currentShowPageNo); // 페이징 처리시 보여주는 순번을 나타내기 위한 것
		mav.addObject("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것
      
		
		
		
		// 페이징 처리된 후 특정 글을 클릭하여 글을 본 후 사용자가 목록보기 버튼을 클릭했을 때 돌아갈페이지를 알려주기위해 넘김 
		String currentURL = MyUtil.getCurrentURL(request);
		mav.addObject("goBackURL", currentURL);
		
		////////////////////////////////////////
      //mav.setViewName("mycontent/board/board");
      
		mav.addObject("boardNo", boardNo);
	  mav.addObject("boardInfoMap",boardInfoMap);
	  mav.setViewName("mycontent/board/selectPostBoardGroupView");
	  
	  
	  return mav;
  }
  
  // 이전글제목보기, 다음글제목보기를 할때 글조회수 증가하기 위한 것
  @PostMapping("goViewOnePost_2")
  public String view_2(ModelAndView mav, 
				           @RequestParam(defaultValue = "") String postNo,
				           @RequestParam(defaultValue = "") String goBackURL,
				           HttpServletRequest request,
				           RedirectAttributes redirectArr) {
	  	String checkAll_or_boardGroup = request.getParameter("checkAll_or_boardGroup");
	  	String fk_boardNo = request.getParameter("fk_boardNo");
		try {
			goBackURL = URLEncoder.encode(goBackURL, "UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
	
		// redirect(GET방식) 시 데이터를 넘길때 GET 방식이 아닌 POST 방식처럼 데이터를 넘기려면 RedirectAttributes 를 사용
		Map<String, String> redirect_map = new HashMap<>();
		redirect_map.put("postNo", postNo);
		redirect_map.put("goBackURL", goBackURL);
		redirect_map.put("checkAll_or_boardGroup", checkAll_or_boardGroup);
		redirect_map.put("fk_boardNo", fk_boardNo);
		
		//redirectArr.addAttribute("redirect_map", redirect_map); // url에 파라미터가 들어가서 수명이 유지됨.
		//redirectArr.addFlashAttribute("redirect_map", redirect_map); // url에 보이지 않아 값이 휘발성임
		//mav.addObject(redirect_map);
		
		//mav.setViewName("redirect:/board/goViewOnePost"); // 실제로 redirect:/board/view 은 POST 방식이 아닌 GET 방식이다.
		return "redirect:/board/goViewOnePost?postNo=" + postNo + "&goBackURL=" + goBackURL + "&checkAll_or_boardGroup="+checkAll_or_boardGroup+"&fk_boardNo="+fk_boardNo;
  }
	
	
	
	
}// end of public class BoardController {}---------------
