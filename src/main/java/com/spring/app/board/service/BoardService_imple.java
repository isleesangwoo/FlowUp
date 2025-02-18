package com.spring.app.board.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.domain.BoardVO;
import com.spring.app.board.domain.PostVO;
import com.spring.app.board.model.BoardDAO;


// === 서비스 선언 === //
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class BoardService_imple implements BoardService {
	
	@Autowired
	private BoardDAO dao;

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
	
	// 게시글 등록하기
	@Override
	public int addPost(PostVO postvo) {
		int n = dao.addPost(postvo); 
		return n;
	}


	
}
