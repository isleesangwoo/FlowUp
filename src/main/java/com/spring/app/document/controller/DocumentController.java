package com.spring.app.document.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.document.service.DocumentService;
import com.spring.app.mail.service.MailService;


// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/document/*")
public class DocumentController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private DocumentService service;
	
	@GetMapping("")
	public ModelAndView board(ModelAndView mav) {
		
		List<Map<String, String>> testList = service.test();
		
		mav.addObject("testList", testList);
		mav.setViewName("mycontent/document/document");
		
		return mav;
	}
	
}
