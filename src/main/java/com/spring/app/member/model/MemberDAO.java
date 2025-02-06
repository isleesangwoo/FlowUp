package com.spring.app.member.model;

import java.util.Map;

import com.spring.app.member.domain.MemberVO;

public interface MemberDAO {

	// 로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);

	// tbl_loginhistory 테이블에 insert 해주기
	void insert_tbl_loginhistory(Map<String, String> paraMap);

	// tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기
	void updateIdle(String userid);

}
