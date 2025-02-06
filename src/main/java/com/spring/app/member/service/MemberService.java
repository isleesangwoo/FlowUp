package com.spring.app.member.service;

import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import com.spring.app.member.domain.MemberVO;

import jakarta.servlet.http.HttpServletRequest;

public interface MemberService {

	// 로그인 처리하기
	MemberVO getLoginMember(Map<String, String> paraMap);
	
	// tbl_loginhistory 테이블에 insert 해주기
	void insert_tbl_loginhistory(Map<String, String> paraMap);
	
	// 로그인 처리하기
	ModelAndView login(ModelAndView mav, HttpServletRequest request, Map<String, String> paraMap);

	// 로그아웃 처리하기
	ModelAndView logout(ModelAndView mav, HttpServletRequest request);


}
