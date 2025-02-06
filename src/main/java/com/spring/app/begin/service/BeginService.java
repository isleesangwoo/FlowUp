package com.spring.app.begin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.app.begin.domain.BeginDateVO;
import com.spring.app.begin.domain.BeginVO;


public interface BeginService {

	// spring_test 테이블에 insert 하기
	int insert();

	// spring_test 테이블에 select 하기
	List<BeginVO> select();
	List<BeginDateVO> select_datevo();
	List<Map<String, String>> select_map();
	
	// view단의 form 태그에서 입력받은 값을 spring_test 테이블에 insert 하기
	int insert_vo(BeginVO bvo);
	int insert_datevo(BeginDateVO bdatevo);
	int insert_map(Map<String, String> paraMap);

	// spring_test 테이블에서 1개 행만 select 하기
	BeginVO select_one_vo(String no);
	BeginVO select_one_vo_PathVariable(Long no);
	Map<String, String> select_one_map(Long no);
	
	// spring_test 테이블에 update 하기
	int update_map(HashMap<String, String> map);
		
	// spring_test 테이블에 delete 하기
	int delete_one(Long no);
		
	
}
