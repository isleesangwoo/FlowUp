package com.spring.app.board.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.domain.PostFileVO;
import com.spring.app.board.domain.PostVO;
import com.spring.app.board.model.BoardDAO;
import com.spring.app.common.FileManager;


// === 서비스 선언 === //
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class BoardService_imple implements BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private FileManager FileManager;

	// 게시판 생성하기
	@Override
	public int addBoard(BoardVO boardvo) throws Exception {
		int n = dao.addBoard(boardvo);
		return n;
	}
	
	// 게시판 수정하기
	@Override
	public int updateBoard(BoardVO boardvo) throws Exception {
		int n = dao.updateBoard(boardvo);
		return n;
	}

	// 게시판삭제(비활성화)하기(status 값변경)
	@Override
	public int disableBoard(String boardNo) {
		int n = dao.disableBoard(boardNo);
		return n;
	}

	//게시판 생성의 공개여부 부서 설정 시 해당 부서 키워드검색(부서 검색)
	@Override
	public List<Map<String, String>> addBoardSearchDept(Map<String, String> paraMap) {
		List<Map<String, String>> wordList = dao.addBoardSearchDept(paraMap);
		return wordList;
	}

	//게시판 생성의 공개여부 부서 설정 시 부서 전체 검색(부서 검색)
	@Override
	public List<Map<String, String>> addBoardSearchAllDept() {
		List<Map<String, String>> wordList = dao.addBoardSearchAllDept();
		return wordList;
	}

	// 생성된 게시판 LeftBar에 나열하기 (출력)
	@Override
	public List<BoardVO> selectBoardList() {
		List<BoardVO> boardList = dao.selectBoardList();
		return boardList;
	}

	// 수정할 input 요소에 기존값을 뿌려주기 위함.
	@Override
	public BoardVO getBoardDetailByNo(String boardNo) {
		BoardVO boardvo = dao.getBoardDetailByNo(boardNo);
		return boardvo;
	}

	// 글쓰기 시 글작성 할 (접근 권한있는)게시판 목록 <select> 태그에 보여주기
	@Override
	public List<Map<String, String>> getAccessibleBoardList(String employeeNo) {
		List<Map<String, String>> boardList = dao.getAccessibleBoardList(employeeNo);
		return boardList;
	}
	
	// 게시글 등록하기// 파일첨부가 있는 글쓰기 // 첨부파일이 있다면 첨부파일테이블(tbl_postFile) 테이블에 파일 정보 삽입  
	@Override
	public int addPost(PostVO postvo,PostFileVO postfilevo,List<Map<String, Object>> mapList) {
		int n = dao.addPost(postvo); // 먼저 게시글 등록
		int n2=0;
		
		if(n>0) { //게시글 등록이 성공했을 때만 첨부파일 등록
			Map<String, Object> paraMap = new HashMap<>();
			postvo = dao.getInfoPost(); // 등록되는 게시글의 번호를 알아오기 위해
			paraMap.put("postNo", postvo.getPostNo()); // postNo 추가

		    if (mapList != null) {
		    	for (Map<String, Object> filename : mapList) {
		        	Map<String, Object> fileMap = new HashMap<>(); // 개별 파일 정보 저장용
		        	fileMap.put("postNo", postvo.getPostNo());
		        	fileMap.put("newFileName", filename.get("newFileName"));
		        	fileMap.put("originalFilename", filename.get("originalFilename")); // 원본 파일명 추가
		        	fileMap.put("fileSize", ((byte[]) filename.get("bytes")).length); // 파일 크기 저장
		        	
		        	n2 = dao.addPostInsertFile(fileMap); // 첨부파일 테이블에 파일정보 삽입
		        	
		        	if(n2!=0) {
			            System.out.println("파일이 저장 됐음! 저장된 파일명 : " + filename);
		        	}
		        }
		    }
			
			
		}
		return n;
	}

	// 게시판 메인 페이지에 뿌려줄 모든 게시글 조회
	@Override
	public List<PostVO> selectAllPost(Map<String, String> paraMap) {
		List<PostVO> postAllList = dao.selectAllPost(paraMap);
		return postAllList;
	}

	// 총 게시물 건수 (totalCount)
	@Override
	public int getTotalCount() {
		int totalCount = dao.getTotalCount();
		return totalCount;
	}

	// 게시글 하나 조회하기
	@Override
	public PostVO goViewOnePost(Map<String, String> paraMap) {
		PostVO postvo = dao.goViewOnePost(paraMap);  // 글 1개 조회하기
		
		String login_userid = paraMap.get("login_userid");
		// paraMap.get("login_userid") 은 로그인을 한 상태이라면 로그인한 사용자의 userid 이고,
		// 로그인을 하지 않은 상태이라면  paraMap.get("login_userid") 은 null 이다.
		
		if(login_userid != null &&
				postvo != null &&
		  !login_userid.equals(postvo.getFk_employeeNo() )) {
//		if(login_userid == null &&
//				postvo != null &&
//		  !"100014".equals(postvo.getFk_employeeNo() )) { 이거는 로그인이 안돼서 테스트용도
		  // 글조회수 증가는 로그인을 한 상태에서 다른 사람의 글을 읽을때만 증가하도록 한다.
			
		  int n = dao.increase_readCount(paraMap.get("postNo")); // 글조회수 1증가 하기 
		
		  if(n==1) {
			  postvo.setReadCount( String.valueOf(Integer.parseInt(postvo.getReadCount()) + 1) ); 
		  }
		}
		
		return postvo;
	}

	// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
	@Override
	public PostVO getView_no_increase_readCount(Map<String, String> paraMap) {

		PostVO postvo = dao.goViewOnePost(paraMap);  // 글 1개 조회하기
		
		return postvo;
	}
	
	// 실제 첨부파일을 삭제하기위해 첨부파일명을 알아오기.
	@Override
	public List<Map<String, Object>> getView_delete(String postNo) {
		List<Map<String, Object>> postListmap = dao.getView_delete(postNo);
		return postListmap;
	}

	// 파일첨부, 사진이미지가 들었는 경우의 글 삭제하기
	@Override
	public int postDel(Map<String, String> paraMap,List<Map<String, Object>> postListmap) {
		dao.postFileDel(paraMap.get("postNo")); // postFile 테이블에서 행삭제하기
	
		int n = dao.postDel(paraMap.get("postNo")); // post 테이블에서 행삭제하기
	
		
		// === 첨부파일 및 사진이미지 파일 삭제하기 시작 === //
		
	    if (postListmap != null && !postListmap.isEmpty()) { // 첨부파일이 있다면 삭제하기 
	        String filepath = paraMap.get("filepath"); // 저장된 경로
	        
	        for (Map<String, Object> filename : postListmap) {
	            if (filename != null) {
	                try {
	                    FileManager.doFileDelete((String) filename.get("filename"), filepath);// 삭제해야할 첨부파일이 저장된 경로와 삭제해야할 첨부파일명
	                } catch (Exception e) {
	                    e.printStackTrace();
	                }
	            }
	        } // end of for (Map<String, Object> filename : postListmap) {}----------------
			///////////////////////////////////////////
			
			// 글내용에 사진이미지가 들어가 있는 경우라면 사진이미지 파일도 삭제.
			String photofilename = paraMap.get("photofilename");
			
			if(photofilename != null) {
				String photo_upload_path = paraMap.get("photo_upload_path");
				
				if(photofilename.contains("/")) {
					// 사진이미지가 2개 이상인 경우
					
					String[] arr_photofilename = photofilename.split("[/]");
					
					for(int i=0; i<arr_photofilename.length; i++) {
						try {
							FileManager.doFileDelete(arr_photofilename[i], photo_upload_path);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					
				}
				else {
					// 사진이미지가 1개만 존재하는 경우
					try {
						FileManager.doFileDelete(photofilename, photo_upload_path);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		} // end of if (postListmap != null && !postListmap.isEmpty()) {}-------------
		// === 첨부파일 및 사진이미지 파일 삭제하기 끝 === //
		return n;
	}
	
	// 파일다운로드에 필요한 컬럼 추출하기(파일고유번호,새로운파일명,기존파일명)
	@Override
	public PostFileVO getWithFileDownload(Map<String, String> paraMap) {
		 PostFileVO postfilevo = dao.getWithFileDownload(paraMap); // 있는 메소드 사용함(게시글 번호,새로운 파일명,기존파일명을 추출함)
		return postfilevo;
	}

	// 글 하나의 첨부파일 기존파일명,새로운 파일명 추출
	@Override
	public List<PostFileVO> getFileOfOnePost(Map<String, String> paraMap) {
		List<PostFileVO> postfilevo = dao.getFileOfOnePost(paraMap); 
		return postfilevo;
	}
	
	// 게시글 수정하기// 파일첨부가 있는 글수정 // 첨부파일이 있다면 첨부파일테이블(tbl_postFile) 테이블에 파일 정보 수정 
	@Override
	public int updatePost(PostVO postvo,PostFileVO postfilevo,List<Map<String, Object>> mapList) {
		System.out.println( "postvo : "  + postvo.getPostNo());
		int n = dao.updatePost(postvo); // 먼저 게시글 수정
		int n2=0;
		
		if(n>0) { //게시글 수정이 성공했을 때만 첨부파일 등록
			Map<String, Object> paraMap = new HashMap<>();
			//postvo = dao.getInfoPost(); // 등록되는 게시글의 번호를 알아오기 위해
			System.out.println("보서임의 postvo.getPostNo() : " + postvo.getPostNo());
			paraMap.put("postNo", postvo.getPostNo()); // postNo 추가

			int n1 = dao.selectTblPostFile(postvo.getPostNo()); // update 문을 실행 전 해당 행이 있는지 확인하기 위함.	(하다보니 필요하지않지만 보류)
			
		    if (mapList != null) {
		    	for (Map<String, Object> filename : mapList) {
		    		
		        	Map<String, Object> fileMap = new HashMap<>(); // 개별 파일 정보 저장용
		        	
		        	fileMap.put("postNo", postvo.getPostNo());
		        	fileMap.put("newFileName", filename.get("newFileName"));
		        	fileMap.put("originalFilename", filename.get("originalFilename")); // 원본 파일명 추가
		        	fileMap.put("fileSize", ((byte[]) filename.get("bytes")).length); // 파일 크기 저장
		        	
		        	System.out.println("넌 실행을 ");
		        	
		        	 // 파일테이블에 행이 없을 경우
		        		dao.addPostInsertFile(fileMap); // 첨부파일 테이블에 파일정보 삽입
		        	
		        	System.out.println("넌 하녜? ");
		        	if(n2!=0) {
			            System.out.println("파일이 저장 됐음! 저장된 파일명 : " + filename);
		        	}
		        }
		    }
			
			
		}
		return n;
	}

	// 글 수정에서 첨부파일 삭제하기
	@Override
	public int FileDelOfPostUpdate(Map<String, String> paraMap) {
		System.out.println("paraMap.get(\"postNo\") : " + paraMap.get("postNo") );
		int n = dao.FileDelOfPostUpdate(paraMap.get("postNo"),paraMap.get("fileNo")); // 글 수정하기에서 postFile 테이블에서 행삭제하기
		
		String filepath = paraMap.get("filepath"); // 저장된 경로
        
            if (paraMap.get("newFileName") != null) {
                try {
                    FileManager.doFileDelete((String) paraMap.get("newFileName"), filepath);// 삭제해야할 첨부파일이 저장된 경로와 삭제해야할 첨부파일명
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
		return n;
	}

	// 수정 전 이미지 목록 가져오기 (DB에서 조회)
	@Override
	public List<String> getBeforeUpdateFileNames(String postNo) {
		List<String> oldFileList = dao.getBeforeUpdateFileNames(postNo);
		return oldFileList;
	}

	// 2️ 수정 후 새로운 이미지 목록 추출 (db에서 조회)
	@Override
	public List<String> getAfterUpdateFileNames(String postNo) {
		List<String> newFileList = dao.getAfterUpdateFileNames(postNo);
		return newFileList;
	}

	// 수정하기에서 사진이미지가 들었는 경우 실제 경로의 파일 삭제하기
	@Override
	public void postImgFileDel(Map<String, String> paraMap, String fileName) {
//		int n = dao.postImgFileDel(paraMap,fileName);
		System.out.println("fileName 보서임 : " + fileName);
		// 글내용에 사진이미지가 들어가 있는 경우라면 사진이미지 파일도 삭제.
		//String photofilename = paraMap.get("photofilename");
		
		if(fileName != null) {
			String photo_upload_path = paraMap.get("photo_upload_path");
			System.out.println("보서임의 photo_upload_path :  " + photo_upload_path);
			if(fileName.contains("/")) {
				// 사진이미지가 2개 이상인 경우
				
				//String[] arr_photofilename = photofilename.split("[/]");
				
				try {
					FileManager.doFileDelete(fileName, photo_upload_path);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			else {
				// 사진이미지가 1개만 존재하는 경우
				try {
					FileManager.doFileDelete(fileName, photo_upload_path);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	// 게시판 별 게시글 조회 :: 게시판/게시글 테이블 조인 -> 조건 boardNo 인 것만 조회
	@Override
	public List<PostVO> selectPostBoardGroup(Map<String, String> paraMap) {
		List<PostVO> groupPostMapList =  dao.selectPostBoardGroup(paraMap);
		return groupPostMapList;
	}

	// 게시판의 정보를 추출하기 위해(게시판명, 운영자 등등)
	@Override
	public BoardVO getBoardInfo(String boardNo) {
		BoardVO boardInfoMap = dao.getBoardInfo(boardNo);
		return boardInfoMap;
	}

	//해당 게시판의 총 게시물 건수(totalCount) 구하기
	@Override
	public int getBoardGroupPostTotalCount(String boardNo) {
		int totalCount = dao.getBoardGroupPostTotalCount(boardNo);
		return totalCount;
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	


	
}
