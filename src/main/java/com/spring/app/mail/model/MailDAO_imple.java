package com.spring.app.mail.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

//=== Repository(DAO) 선언 === //
@Repository
public class MailDAO_imple implements MailDAO {

	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;


	@Override
	public List<Map<String, String>> test() {
		List<Map<String, String>> testList = sqlsession.selectList("mail.test");
		return testList;
	}
	
	
	
	
}
