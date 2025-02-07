package com.spring.app.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/*")
public class IndexController {

	@GetMapping("/")
	public String main() {
		return "redirect:/index";
	}
	
	
	@GetMapping("index")
	public String index(HttpServletRequest request) {
		
		return "mycontent/main/index";
	}
	
	
}
