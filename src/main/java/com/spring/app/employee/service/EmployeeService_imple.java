package com.spring.app.employee.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.common.AES256;
import com.spring.app.common.Sha256;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.employee.model.EmployeeDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


// === #12. 서비스 선언 ===
@Service
public class EmployeeService_imple implements EmployeeService {

	@Autowired	// Type 에 따라 알아서 Bean 을 주입해준다.
	private EmployeeDAO dao;

	@Override
	public List<Map<String, String>> test() {
		List<Map<String, String>> testList = dao.test();
		return testList;
	}
	
}
