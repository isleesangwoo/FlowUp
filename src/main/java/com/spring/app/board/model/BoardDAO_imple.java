package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.board.domain.BoardVO;

//=== Repository(DAO) 선언 === //
@Repository
public class BoardDAO_imple implements BoardDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;

	// 게시판 생성하기
	@Override
	public int addBoard() throws Exception{
		int n = sqlsession.insert("board.addBoard");
		return n;
	}

	// 게시판 수정하기
	@Override
	public int updateBoard() throws Exception {
		int n = sqlsession.insert("board.updateBoard");
		return n;
	}

	// 게시판삭제하기(status 값변경)
	@Override
	public int deleteBoard() {
		int n = sqlsession.update("board.deleteBoard");
		return n;
	}

	
	
	
}
