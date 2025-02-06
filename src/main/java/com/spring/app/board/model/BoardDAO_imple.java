package com.spring.app.board.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

//=== #24. Repository(DAO) 선언 === //
@Repository
public class BoardDAO_imple implements BoardDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;


	@Override
	public List<Map<String, String>> test() {
		List<Map<String, String>> testList = sqlsession.selectList("board.test");
		return testList;
	}
	
	
	
	
}
