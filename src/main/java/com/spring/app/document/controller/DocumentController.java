package com.spring.app.document.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		
//		List<Map<String, String>> testList = service.test();
//		mav.addObject("testList", testList);
		
		mav.setViewName("mycontent/document/document");
		
		return mav;
	}
	
	@GetMapping("annual")
	public ModelAndView annual(ModelAndView mav) {
		
		mav.setViewName("mycontent/document/annual");
		
		return mav;
	}
	
	@PostMapping("annualDraft")
	@ResponseBody
	public Map<String, String> annualDraft(@RequestParam Map<String, String> paraMap) {
		
		System.out.println(paraMap.get("useAmount"));
		
		Map<String, String> map = new HashMap<>();
		
		map.put("n", "1");
		
		return map;
	}
	
}
