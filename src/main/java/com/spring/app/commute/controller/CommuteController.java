package com.spring.app.commute.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.app.commute.service.CommuteService;

@Controller
@RequestMapping(value="/commute/*")
public class CommuteController {
	
	@Autowired
	private CommuteService service;

	
}
