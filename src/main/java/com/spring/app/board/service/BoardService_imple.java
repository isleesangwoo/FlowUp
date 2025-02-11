package com.spring.app.board.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.board.model.BoardDAO;


// === 서비스 선언 === //
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
@Service
public class BoardService_imple implements BoardService {
	
	@Autowired
	private BoardDAO dao;

	// 게시판 생성하기
	@Override
	public int addBoard() throws Exception {
		int n = dao.addBoard();
		return n;
	}
	
	// 게시판 수정하기
	@Override
	public int updateBoard() throws Exception {
		int n = dao.updateBoard();
		return n;
	}

	// 게시판삭제하기(status 값변경)
	@Override
	public int deleteBoard() {
		int n = dao.deleteBoard();
		return n;
	}

	
}
