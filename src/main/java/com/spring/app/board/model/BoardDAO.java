package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {
	
	// 게시판 생성하기
	int addBoard() throws Exception;

	// 게시판 수정하기
	int updateBoard() throws Exception;

	// 게시판삭제하기(status 값변경)
	int deleteBoard();

}
