package com.spring.app.common.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.service.EmployeeService;
import com.spring.app.mail.service.MailService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/*")
public class IndexController {

	@Autowired
	private EmployeeService EmService;
	
	
	@Autowired
	private MailService MaService;
	
	
	@GetMapping("/")
	public String main() {
		return "redirect:/index";
	}
	
	
	@GetMapping("index")
	public String index(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO)session.getAttribute("loginuser");
		
		String employeeno = loginuser.getEmployeeNo();
		
		List<Map<String, String>> ipMap = EmService.getIpAddr(employeeno); // 해당 유저의 ip 주소 갖고오기
		request.setAttribute("ipMap", ipMap);
		
		
		List<Map<String, String>> mailMap = MaService.getMailCnt(employeeno); // 해당 유저의 중요, 읽은, 임시저장함 개수 알아오기
		request.setAttribute("mailMap", mailMap);
		
		return "mycontent/main/index";
	}
	
	
	
	
	
}
