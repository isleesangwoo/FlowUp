package com.spring.app.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.common.service.CommonService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/common/*")
public class CommonController {
	
	@Autowired
	private CommonService service;
	
	/*
	 * @GetMapping("searchEmployeeShow")
	 * 
	 * @ResponseBody public List<EmployeeVO> searchEmployeeShow(@RequestParam String
	 * word) {
	 * 
	 * List<EmployeeVO> employeeList = new ArrayList();
	 * 
	 * // employeeList =service.searchEmployeeShow(word);
	 * 
	 * return employeeList; }
	 */
	
}
