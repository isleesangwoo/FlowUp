package com.spring.app.common.controller;

import java.io.File;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
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

import com.spring.app.common.FileManager;
import com.spring.app.common.service.CommonService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/common/*")
public class CommonController {
	
	@Autowired
	private CommonService service;
	
	@Autowired  // Type 에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager; 
	
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
	
	
	 //=== 스마트에디터. 글쓰기 또는 글수정시 드래그앤드롭을 이용한 다중 사진 파일 업로드 하기 === //
	  @PostMapping("image/multiplePhotoUpload")
	  public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) {
		  /*
		   1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 함.
		   >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		        WAS 의 webapp/board_resources/photo_upload 라는 폴더로 지정.
		  */
		  // WAS 의 webapp 의 절대경로를 알아오기.
		  HttpSession session = request.getSession();
		  String root = session.getServletContext().getRealPath("/");
		  String path = root + "board_resources"+File.separator+"photo_upload";
		  // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 됨.
		
		  File dir = new File(path);
		  if(!dir.exists()) {
			  dir.mkdirs();
		  }
		
		  try {
			  String filename = request.getHeader("file-name"); // 파일명(문자열)을 받는다 - 일반 원본파일명
			  // 네이버 스마트에디터를 사용한 파일업로드시 싱글파일업로드와는 다르게 멀티파일업로드는 파일명이 header 속에 담겨져 넘어오게 되어있다. 
			  
			  InputStream is = request.getInputStream(); // is는 네이버 스마트 에디터를 사용하여 사진첨부하기 된 이미지 파일임.
			
			  // === 사진 이미지 파일 업로드 하기 === //
			  String newFilename = fileManager.doFileUpload(is, filename, path);
			
			
			  // === 웹브라우저 상에 업로드 되어진 사진 이미지 파일 이미지를 쓰기 === //
			  String ctxPath = request.getContextPath(); //  
			
			  String strURL = "";
			  strURL += "&bNewLine=true&sFileName="+newFilename; 
			  strURL += "&sFileURL="+ctxPath+"/board_resources/photo_upload/"+newFilename;
						
			  PrintWriter out = response.getWriter();
			  out.print(strURL);
			
		  } catch(Exception e) {
			e.printStackTrace();
		  }
		
	  }
	  

	
}
