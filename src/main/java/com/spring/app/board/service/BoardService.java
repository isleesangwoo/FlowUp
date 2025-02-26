package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.domain.PostFileVO;
import com.spring.app.board.domain.PostVO;

public interface BoardService {
	
	// 게시판 생성하기
	int addBoard(BoardVO boardvo) throws Exception;

	// 게시판 수정하기
	int updateBoard(BoardVO boardvo) throws Exception;

	// 게시판삭제(비활성화)하기(status 값변경)
	int disableBoard(String boardNo);
	
	//게시판 생성의 공개여부 부서 설정 시 부서 워드 검색(부서 검색)
	List<Map<String, String>> addBoardSearchDept(Map<String, String> paraMap);

	//게시판 생성의 공개여부 부서 설정 시 부서 전체 검색(부서 검색)
	List<Map<String, String>> addBoardSearchAllDept();

	// 생성된 게시판 LeftBar에 나열하기 (출력)
	List<BoardVO> selectBoardList();
	
	// 수정할 input 요소에 기존값을 뿌려주기 위함.
	BoardVO getBoardDetailByNo(String boardNo);

	// 글쓰기 시 글작성 할 (접근 권한있는)게시판 목록 <select> 태그에 보여주기
	List<Map<String, String>> getAccessibleBoardList(String employeeNo);

	// 게시글 등록하기
	int addPost(PostVO postvo,PostFileVO postfilevo,List<Map<String, Object>> mapList);

	// 게시판 메인 페이지에 뿌려줄 모든 게시글 조회
	List<PostVO> selectAllPost(Map<String, String> paraMap);

	// 총 게시물 건수 (totalCount)
	int getTotalCount();

	// 게시글 하나 조회하기
	PostVO goViewOnePost(Map<String, String> paraMap);

	// 글 하나의 첨부파일 기존파일명,새로운 파일명 추출
	List<PostFileVO> getFileOfOnePost(Map<String, String> paraMap);

	// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
	PostVO getView_no_increase_readCount(Map<String, String> paraMap);

	// 실제 첨부파일을 삭제하기위해 첨부파일명을 알아오기.
	List<Map<String, Object>> getView_delete(String postNo);

	 // 파일첨부, 사진이미지가 들었는 경우의 글 삭제하기
	int postDel(Map<String, String> paraMap,List<Map<String, Object>> postListmap);

	// 파일다운로드에 필요한 컬럼 추출하기(파일고유번호,새로운파일명,기존파일명)
	PostFileVO getWithFileDownload(Map<String, String> paraMap);

	// === 글수정하기, 일단 게시글 update 이후 첨부파일의 여부는 service단에서 함  === //
	int updatePost(PostVO postvo, PostFileVO postfilevo, List<Map<String, Object>> mapList);

	// 글 수정에서 첨부파일 삭제하기
	int FileDelOfPostUpdate(Map<String, String> paraMap);

	// 수정 전 이미지 목록 가져오기 (DB에서 조회)
	List<String> getBeforeUpdateFileNames(String postNo);

	// 수정 후 새로운 이미지 목록 추출 (db에서 조회)
	List<String> getAfterUpdateFileNames(String postNo);

	// 수정하기에서 사진이미지가 들었는 경우 실제 경로의 파일 삭제하기
	void postImgFileDel(Map<String, String> paraMap, String fileName);

	// 게시판 별 게시글 조회 :: 게시판/게시글 테이블 조인 -> 조건 boardNo 인 것만 조회
	List<PostVO> selectPostBoardGroup(String boardNo);

	// 게시판의 정보를 추출하기 위해(게시판명, 운영자 등등)
	BoardVO getBoardInfo(String boardNo);


	

	
	
	
}
