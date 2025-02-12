package com.spring.app.mail.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.mail.service.MailService;


// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/organization/*")
public class Organizationchart {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private MailService service;
	
	@GetMapping("")
	public ModelAndView organization(ModelAndView mav) {
		
		List<Map<String, String>> testList = service.test();
		
		mav.addObject("testList", testList);
		mav.setViewName("mycontent/organization/organization_chart");
		
		return mav;
	}
	
}
