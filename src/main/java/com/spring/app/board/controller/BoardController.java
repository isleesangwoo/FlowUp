package com.spring.app.board.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

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
		       우리는 WAS 의 /myspring/src/main/webapp/resources/files 라는 폴더를 생성해서 여기로 업로드 해주도록 할 것이다. 
		 */
		
		// WAS 의 webapp 의 절대경로를 알아와야 한다.
		HttpSession session = mtp_request.getSession();
		String root = session.getServletContext().getRealPath("/");
	    //	System.out.println("~~~ 확인용 webapp 의 절대경로 ==> " + root);
		// ~~~ 확인용 webapp 의 절대경로 ==> C:\NCS\workspace_spring_boot_17\myspring\src\main\webapp\
		
		String path =  root+"board_resources"+File.separator+"files";  //File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자
		
		// path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 됨.
		// System.out.println("~~~ 확인용 path ==> " + path); ~~~ 확인용 path ==> C:\NCS\workspace_spring_boot_17\myspring\src\main\webapp\resources\files
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
  @PostMapping("goViewOnePost")
  public ModelAndView goViewOnePost(ModelAndView mav, HttpServletRequest request,@RequestParam String postNo,@RequestParam String goBackURL) {
	  
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
	  
	  
	  
	  //  웹브라우저에서 페이지 새로고침을 할 경우 update문이 실행되니 select만 하고 글조회수 증가인 update문은 실행x
     

	  // 위의 글목록보기 에서 session.setAttribute("readCountPermission", "yes"); 설정함.
	  PostVO postvo = null;

	  if ("yes".equals((String) session.getAttribute("readCountPermission"))) {
		  // 글목록보기인 /board 페이지를 클릭한 다음에 특정글을 조회해온 경우

		  postvo = service.goViewOnePost(paraMap); // 게시글 하나 조회하기
		  // 글 조회수 증가와 함께 글 1개를 조회를 해오는 것( 조회수 증가는 service 단에서 처리를 해줌.)

		  session.removeAttribute("readCountPermission");
		  // 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
	  }

	  else {
		  // 글목록에서 특정 글제목을 클릭하여 본 상태에서
		  // 웹브라우저에서 새로고침(F5)을 클릭한 경우 웹브라우저에서 새로고침(F5)을 클릭한 경우");
		
		  // 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
		  postvo = service.getView_no_increase_readCount(paraMap);
		
 
  		  if (postvo == null) {
			  mav.setViewName("redirect:/board/list");
			  return mav;
		  }

		  // 또는 redirect 해주기
		  /*
		     mav.setViewName("redirect:/board/list"); return mav;
		   */
		  }

		  mav.addObject("postvo", postvo);
		  mav.addObject("goBackURL", goBackURL); // 글 하나 클릭 시 클릭된 페이지의 해당 URL을 넘겨줌.
		  mav.setViewName("mycontent/board/onePostView");
	  
	  return mav;
  }
  
  //=== 스마트에디터. 글쓰기 또는 글수정시 드래그앤드롭을 이용한 다중 사진 파일 업로드 하기 === //
  @PostMapping("image/multiplePhotoUpload")
  public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
	  /*
	   1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 함.
	   >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
	        WAS 의 webapp/board_resources/photo_upload 라는 폴더로 지정해준다.
	  */
	  // WAS 의 webapp 의 절대경로를 알아오기.
	  HttpSession session = request.getSession();
	  String root = session.getServletContext().getRealPath("/");
	  String path = root + "board_resources"+File.separator+"photo_upload";
	  // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 됨.
	
	  //  System.out.println("~~~ 확인용 path => " + path);
      //  ~~~ 확인용 path => C:\NCS\workspace_spring_boot_17\myspring\src\main\webapp\resources\photo_upload
	
	  File dir = new File(path);
	  if(!dir.exists()) {
		  dir.mkdirs();
	  }
	
	  try {
		  String filename = request.getHeader("file-name"); // 파일명(문자열)을 받는다 - 일반 원본파일명
		  // 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
		
		  //	System.out.println(">>> 확인용 filename ==> " + filename);
		  // >>> 확인용 filename ==> berkelekle%EC%8B%AC%ED%94%8C%EB%9D%BC%EC%9A%B4%EB%93%9C01.jpg
		
		  InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
		
		  // === 사진 이미지 파일 업로드 하기 === //
		  String newFilename = fileManager.doFileUpload(is, filename, path);
		  //System.out.println("### 확인용 newFilename ==> " + newFilename);
		  //  ### 확인용 newFilename ==> 20250210165110401783618706200.jpg
		
		
		  // === 웹브라우저 상에 업로드 되어진 사진 이미지 파일 이미지를 쓰기 === //
		  String ctxPath = request.getContextPath(); //  
		
		  String strURL = "";
		  strURL += "&bNewLine=true&sFileName="+newFilename; 
		  strURL += "&sFileURL="+ctxPath+"/board_resources/photo_upload/"+newFilename;
					
		  PrintWriter out = response.getWriter();
		  out.print(strURL);
		
	  } catch(Exception e) {
		e.printStackTrace();
	  }
	
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
			 
			
			 // 첨부파일이 저장되어 있는 WAS(톰캣) 디스크 경로명을 알아와야만 다운로드를 해줄 수 있다.
	         // 이 경로는 우리가 파일첨부를 위해서 /addEnd 에서 설정해두었던 경로와 똑같아야 한다.  
	         // WAS 의 webapp 의 절대경로를 알아와야 한다. 
	         HttpSession session = request.getSession(); 
	         String root = session.getServletContext().getRealPath("/");  
	         
	         //System.out.println("~~~ 확인용 webapp 의 절대경로 => " + root);
	         //~~~ 확인용 webapp 의 절대경로 => C:\GitHub\FlowUp\src\main\webapp\
	         String filepath = root+"board_resources"+File.separator+"files";
	         
	         // file_path 가 첨부파일이 저장될 WAS(톰캣)의 폴더가 된다.
	         // System.out.println("~~~ 확인용 filepath => " + filepath);
	         // ~~~ 확인용 filepath => C:\GitHub\FlowUp\src\main\webapp\resources\files
	         
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
	  	
	
	
	
	
}// end of public class BoardController {}---------------
