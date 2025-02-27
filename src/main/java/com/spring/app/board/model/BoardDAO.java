package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.domain.PostFileVO;
import com.spring.app.board.domain.PostVO;

@Mapper
public interface BoardDAO {
	
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

	// 게시글 등록하기 // 파일첨부가 있는 글쓰기 // 첨부파일이 있다면 첨부파일테이블(tbl_postFile) 테이블에 파일 정보 삽입  
	int addPost(PostVO postvo);

	// 게시판 메인 페이지에 뿌려줄 모든 게시글 조회
	List<PostVO> selectAllPost(Map<String, String> paraMap);

	// 총 게시물 건수 (totalCount)
	int getTotalCount();
	
	// 게시글 하나 조회하기
	PostVO goViewOnePost(Map<String, String> paraMap);

	// 글조회수 1증가 하기 
	int increase_readCount(String string);
	
	// 등록되어지는 게시글의 번호를 알아오기 위해
	PostVO getInfoPost();
	
	// 파일첨부가 있는 글쓰기 // 첨부파일이 있다면 첨부파일테이블(tbl_postFile) 테이블에 파일 정보 삽입  
	int addPostInsertFile(Map<String, Object>paraMap);

	// 실제 첨부파일을 삭제하기위해 첨부파일명을 알아오기.
	List<Map<String, Object>> getView_delete(String postNo);

	// 파일첨부, 사진이미지가 들었는 경우의 글 삭제하기 /post 테이블에서 행삭제하기
	int postDel(String postNo);
	
	//  파일첨부, 사진이미지가 들었는 경우의 글 삭제하기 /postFile 테이블에서 행삭제하기
	int postFileDel(String postNo);

	// 파일다운로드에 필요한 컬럼 추출하기(파일고유번호,새로운파일명,기존파일명)
	PostFileVO getWithFileDownload(Map<String, String> paraMap); // 있는 메소드 사용함(게시글 번호,새로운 파일명,기존파일명)

	// 글 하나의 첨부파일 기존파일명,새로운 파일명 추출
	List<PostFileVO> getFileOfOnePost(Map<String, String> paraMap);

	// 게시글 수정
	int updatePost(PostVO postvo);

	// 첨부파일 테이블에 파일정보 수정
	int updatePostInsertFile(Map<String, Object> fileMap);

	//updatePostInsertFile 실행 전 해당 행이 있는지 확인하기 위함.	
	int selectTblPostFile(String postNo);

	// 글 수정하기에서 postFile 테이블에서 행삭제하기
	int FileDelOfPostUpdate(String postNo, String fileNo);

	// 수정 전 이미지 목록 가져오기 (DB에서 조회)
	List<String> getBeforeUpdateFileNames(String postNo);
	
	// 수정 후 새로운 이미지 목록 추출 (db에서 조회)
	List<String> getAfterUpdateFileNames(String postNo);

	// 게시판 별 게시글 조회 :: 게시판/게시글 테이블 조인 -> 조건 boardNo 인 것만 조회
	List<PostVO> selectPostBoardGroup(Map<String, String> paraMap);

	// 게시판의 정보를 추출하기 위해(게시판명, 운영자 등등)
	BoardVO getBoardInfo(String boardNo);

	//해당 게시판의 총 게시물 건수(totalCount) 구하기
	int getBoardGroupPostTotalCount(String boardNo);


	



}
