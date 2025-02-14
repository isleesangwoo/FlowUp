package com.spring.app.board.service;

import java.util.List;
import java.util.Map;

public interface BoardService {
	
	
	// 게시판 생성하기
	int addBoard() throws Exception;

	// 게시판 수정하기
	int updateBoard() throws Exception;

	// 게시판삭제하기(status 값변경)
	int deleteBoard();

	
	
	
}
