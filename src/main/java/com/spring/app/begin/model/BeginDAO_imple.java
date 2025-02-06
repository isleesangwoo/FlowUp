package com.spring.app.begin.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.spring.app.begin.domain.BeginDateVO;
import com.spring.app.begin.domain.BeginVO;
	
// import jakarta.annotation.Resource;


// ==== #3. Repository(DAO) 선언 ====
// @Component
@Repository 
public class BeginDAO_imple implements BeginDAO {

	// === #4. 의존객체 주입하기(DI: Dependency Injection) ===
	// >>> 의존 객체 자동 주입(Automatic Dependency Injection)은
	//     스프링 컨테이너가 자동적으로 의존 대상 객체를 찾아서 해당 객체에 필요한 의존객체를 주입하는 것을 말한다. 
	//     단, 의존객체는 스프링 컨테이너속에 bean 으로 등록되어 있어야 한다. 

	//     의존 객체 자동 주입(Automatic Dependency Injection)방법 2가지 
	//     1. @Autowired ==> Spring 에서 지원하는 어노테이션이다. 
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 타입을 찾아서 연결(의존객체주입)한다.
	
	//     2. @Resource  ==> Apache Tomcat 에서 지원하는 어노테이션이다.
	//                       스프링 컨테이너에 담겨진 의존객체를 주입할때 필드명(이름)을 찾아서 연결(의존객체주입)한다.
	
/*	
	@Resource
	private SqlSessionTemplate sqlsession;  // 로컬DB mymvc_user 에 연결
	// com.spring.app.config.Datasource_mymvcuser_Configuration 클래스에서 정의한 bean 이름이 sqlsession 인 bean을 주입하라는 뜻이다. 
	// 그러므로 sqlsession 는 null 이 아니다.
	
	@Resource
	private SqlSessionTemplate sqlsession_2; // 로컬DB hr 에 연결
	// com.spring.app.config.Datasource_hr_Configuration 클래스에서 정의한 bean 이름이 sqlsession_2 인 bean을 주입하라는 뜻이다. 
    // 그러므로 sqlsession_2 는 null 이 아니다. 
*/
	
 /*	
	@Autowired
	private SqlSessionTemplate abc;
	// Type 에 따라 Spring 컨테이너가 알아서 SqlSessionTemplate 클래스의 bean 을 abc 에 주입시켜준다.
	// 이것이 가능하기 위한 전제조건은 SqlSessionTemplate 클래스의 bean 이 오로지 1개만 존재할 경우에만 사용하는 것이다. 
    // 그러므로 abc 는 null 이 아니다.
     
 */	
	// SqlSessionTemplate 클래스의 bean 이 2개 이상 존재할 경우에는 반드시 @Qualifier("bean명") 으로 주입해야할 bean명을 표시해주어야 한다.!!!
	@Autowired
	@Qualifier("sqlsession")
	private SqlSessionTemplate sqlsession;
	// com.spring.app.config.Datasource_mymvcuser_Configuration 클래스에서 SqlSessionTemplate 클래스의 bean 이름이 sqlsession 인 bean을 주입하라는 뜻이다. 
	// 그러므로 sqlsession 는 null 이 아니다.	
	
	@Autowired
	@Qualifier("sqlsession_2")
	private SqlSessionTemplate sqlsession_2;
	// com.spring.app.config.Datasource_hr_Configuration 클래스에서 SqlSessionTemplate 클래스의 bean 이름이 sqlsession_2 인 bean을 주입하라는 뜻이다. 
    // 그러므로 sqlsession_2 는 null 이 아니다. 
	
	
	// spring_test 테이블에 insert 하기
	@Override
	public int insert() {
		
		int n1 = sqlsession.insert("begin.test_insert");
		int n2 = sqlsession_2.insert("hr.exam_insert");
		
		return n1*n2;
	}

	// spring_test 테이블에 select 하기
	@Override
	public List<BeginVO> select() {
		
		List<BeginVO> beginvoList = sqlsession.selectList("begin.select");
		return beginvoList;
	}

	// spring_test 테이블에 select 하기
	@Override
	public List<BeginDateVO> select_datevo() {
		List<BeginDateVO> begindatevoList = sqlsession.selectList("begin.select_datevo");
		return begindatevoList;
	}

	// spring_test 테이블에 select 하기
	@Override
	public List<Map<String, String>> select_map() {
		List<Map<String, String>> mapList = sqlsession.selectList("begin.select_map");
		return mapList;
	}

	
	// view단의 form 태그에서 입력받은 값을 spring_test 테이블에 insert 하기
	@Override
	public int insert_vo(BeginVO bvo) {
		int n = sqlsession.insert("begin.insert_vo", bvo);
		return n;
	}

	@Override
	public int insert_datevo(BeginDateVO bdatevo) {
		int n = sqlsession.insert("begin.insert_datevo", bdatevo);
		return n;
	}

	@Override
	public int insert_map(Map<String, String> paraMap) {
		int n = sqlsession.insert("begin.insert_map", paraMap);
		return n;
	}
	
	
	// spring_test 테이블에서 1개 행만 select 하기
	@Override
	public BeginVO select_one_vo(String no) {
		BeginVO bvo = sqlsession.selectOne("begin.select_one_vo", no);
		return bvo;
	}	
	
	@Override
	public Map<String, String> select_one_map(Long no) {
		Map<String, String> map = sqlsession.selectOne("begin.select_one_map", no);
		return map;
	}
	
	
	// spring_test 테이블에 update 하기
	@Override
	public int update_map(HashMap<String, String> map) {
		int n = sqlsession.update("begin.update_map", map);
		return n;
	}

	
	// spring_test 테이블에 delete 하기
	@Override
	public int delete_one(Long no) {
		int n = sqlsession.delete("begin.delete_one", no);
		return n;
	}
	

}
