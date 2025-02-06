package com.spring.app.mail.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.board.service.BoardService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// === #22. 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/mail/*")
public class MailController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private BoardService service;
	
	@GetMapping("")
	public ModelAndView board(ModelAndView mav) {
		
		List<Map<String, String>> testList = service.test();
		
		mav.addObject("testList", testList);
		mav.setViewName("mycontent/board/board");
		
		return mav;
	}
	
}
