package com.spring.app.mail.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.spring.app.mail.domain.MailVO;

@Mapper //@Mapper 어노테이션을 붙여서 DAO 역할의 Mapper 인터페이스 파일을 만든다. 
		//EmpDAO 인터페이스를 구현한 DAO 클래스를 생성하면 오류가 뜨므로 절대로 DAO 클래스를 생성하면 안된다.!!! 
		//@Mapper 어노테이션을 사용하면 빈으로 등록되며 Service단에서 @Autowired 하여 사용할 수 있게 된다.
public interface MailDAO {

	// 전체 메일
	List<MailVO> mailListAll();

	// 받은 메일 개수 조회
	int getTotalCount();

	// 받은 메일 목록 조회
	List<MailVO> selectMailList(Map<String, String> paraMap);

	// 안 읽은 메일 개수 조회
	int getUnreadCount();

	// 중요(별) 상태 조회
	int getImportantStatus(int mailNo);

	// 업데이트 된 중요 상태 업데이트
	void updateImportantStatus(Map<String, Object> paramMap);

	// 중요메일함 조회
	List<MailVO> selectImportantMail(String empNo);



	
}
