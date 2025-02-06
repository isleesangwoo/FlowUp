package com.spring.app.begin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.begin.domain.BeginDateVO;
import com.spring.app.begin.domain.BeginVO;
import com.spring.app.begin.model.BeginDAO;


// ==== #2. Service 선언 ====
// 트랜잭션 처리를 담당하는 곳, 업무를 처리하는 곳, 비지니스(Business)단
// @Component
@Service
public class BeginService_imple implements BeginService {

	// === #5. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private BeginDAO dao;
	// Type 에 따라 Spring 컨테이너가 알아서 bean 으로 등록된 com.spring.app.begin.model.BeginDAO_imple 의 bean 을 dao 에 주입시켜준다. 
	// 그러므로 dao 는 null 이 아니다.	
	
	
	// spring_test 테이블에 insert 하기
	@Override
	public int insert() {
		int n = dao.insert();
		return n;
	}

	// spring_test 테이블에 select 하기
	@Override
	public List<BeginVO> select() {
		List<BeginVO> beginvoList = dao.select();
		return beginvoList;
	}

	// spring_test 테이블에 select 하기
	@Override
	public List<BeginDateVO> select_datevo() {
		List<BeginDateVO> begindatevoList = dao.select_datevo();
		return begindatevoList;
	}

	// spring_test 테이블에 select 하기
	@Override
	public List<Map<String, String>> select_map() {
		List<Map<String, String>> mapList = dao.select_map();
		return mapList;
	}
	
	
	// view단의 form 태그에서 입력받은 값을 spring_test 테이블에 insert 하기
	@Override
	public int insert_vo(BeginVO bvo) {
		int n = dao.insert_vo(bvo);
		return n;
	}

	@Override
	public int insert_datevo(BeginDateVO bdatevo) {
		int n = dao.insert_datevo(bdatevo);
		return n;
	}

	@Override
	public int insert_map(Map<String, String> paraMap) {
		int n = dao.insert_map(paraMap);
		return n;
	}
	
	
	// spring_test 테이블에서 1개 행만 select 하기
	@Override
	public BeginVO select_one_vo(String no) {
		BeginVO bvo = dao.select_one_vo(no);
		return bvo;
	}
	
	
	@Override
	public BeginVO select_one_vo_PathVariable(Long no) {
		BeginVO bvo = dao.select_one_vo(String.valueOf(no));
		return bvo;
	}
	
	
	@Override
	public Map<String, String> select_one_map(Long no) {
		Map<String, String> map = dao.select_one_map(no);
		return map;
	}

	
	// spring_test 테이블에 update 하기
	@Override
	public int update_map(HashMap<String, String> map) {
		int n = dao.update_map(map);
		return n;
	}

	// spring_test 테이블에 delete 하기
	@Override
	public int delete_one(Long no) {
		int n = dao.delete_one(no);
		return n;
	}
	
	
}
