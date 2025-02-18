package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.board.domain.BoardVO;
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

	// 게시글 등록하기
	int addPost(PostVO postvo);


}
