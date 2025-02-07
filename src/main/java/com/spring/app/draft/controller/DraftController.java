package com.spring.app.draft.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.draft.service.DraftService;
import com.spring.app.mail.service.MailService;


// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/draft/*")
public class DraftController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private DraftService service;
	
	@GetMapping("")
	public ModelAndView board(ModelAndView mav) {
		
		List<Map<String, String>> testList = service.test();
		
		mav.addObject("testList", testList);
		mav.setViewName("mycontent/draft/draft");
		
		return mav;
	}
	
}
