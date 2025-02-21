package com.spring.app.mail.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.mail.domain.MailVO;
import com.spring.app.mail.service.MailService;

import jakarta.servlet.http.HttpServletRequest;

// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/mail/*")
public class MailController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private MailService service;
	
	@GetMapping("") // 메일 목록
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
		List<MailVO> mailList = null;
		
		mailList = service.mailListAll();
		
		mav.addObject("mailList", mailList);
		mav.setViewName("mycontent/mail/mail");
		
		return mav;
	}
	
}
