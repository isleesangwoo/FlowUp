package com.spring.app.mail.controller;

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

import com.spring.app.board.domain.PostFileVO;
import com.spring.app.common.MyUtil;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.mail.domain.MailVO;
import com.spring.app.mail.service.MailService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/mail/*")
public class MailController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private MailService service;
	
	@GetMapping("") // 메일 목록
	public ModelAndView mail(ModelAndView mav, HttpServletRequest request,
			@RequestParam(defaultValue = "1") String currentShowPageNo) {
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		// 총 메일 개수(totalCount) 구하기
		int totalCount = 0;    // 총 메일 개수
		int sizePerPage = 20;  // 한 페이지당 보여줄 메일 개수
		int totalPage = 0;     // 총 페이지수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		int unreadCount = 0;   // 안 읽은 메일 개수
		
		int n_currentShowPageNo = 0; 
		
		// 총 메일 개수 조회 (totalCount)
		totalCount = service.getTotalCount();
	    // 안 읽은 메일 개수 조회 (unreadCount)
	    unreadCount = service.getUnreadCount();
		
		totalPage = (int) Math.ceil((double)totalCount/sizePerPage);
		// 총 메일 개수(totalCount)가 124 개 이라면 총 페이지수(totalPage)는 13 페이지가 되어야 함.
		// (double)124/10 ==> 12.4 ==> Math.ceil(12.4) ==> 13.0 ==> 13
		
		try {
			n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
		
			if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
				// get 방식이므로 사용자가 currentShowPageNo 에 입력한 값이 0 또는 음수 또는 입력한 값이 실제 데이터베이스에 존재하는 페이지수 보다 더 큰값을 입력하여 장난친 경우 
				n_currentShowPageNo = 1;
			}
			  
		} catch(NumberFormatException e) {
			// get 방식이므로 currentShowPageNo 에 입력한 값이 숫자가 아닌 문자를 입력하거나 int 범위를 초과한 경우
			n_currentShowPageNo = 1;
		}
		
		int startRno = ((n_currentShowPageNo - 1) * sizePerPage) + 1; // 시작 행번호
		int endRno = startRno + sizePerPage - 1; // 끝 행번호 
		
		Map<String, String> paraMap = new HashMap<>();
		 
		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno)); 
		
		
		// === 받은 메일함 페이지에 뿌려줄 모든 메일 조회 === //
		
		// 페이징 처리한 받은 메일 목록 조회 서비스 메서드 호출하기
		List<MailVO> ReceivedMailList = service.selectMailList(paraMap);
		
		// 조회한 메일 목록을 ModelAndView 객체에 "ReceivedMailList"라는 이름으로 저장
		mav.addObject("ReceivedMailList", ReceivedMailList);
		
        // === 페이지바 만들기 === //
        int blockSize = 5;  // 한 블럭(구간)당 보여질 페이지 번호의 개수 (예: 1~10)
        // loop: 블럭 내에서 몇 개의 페이지 번호를 출력했는지 확인하기 위한 변수
        int loop = 1;
        
        // 현재 블럭의 시작 페이지 번호 계산 (예: 1, 11, 21 등)
        int pageNo = ((n_currentShowPageNo - 1) / blockSize) * blockSize + 1;
         
        // 페이지바를 HTML ul 태그로 시작 (스타일은 inline으로 지정)
        String pageBar = "<ul style='list-style:none;'>";
        String url = "list";  // 페이지 링크에 사용할 기본 URL
        
		// === [맨처음][이전] 만들기 === //
        // 맨처음
		pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo=1'><i style='transform: scaleX(-1)' class=\'fa-solid fa-forward-step\'></i></a></li>";
		
		if(pageNo != 1) {
			// 이전
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+(pageNo-1)+"'><i style='transform: scaleX(-1)' class='fa-solid fa-chevron-right\'></i></a></li>"; 
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; padding:2px 4px;'>"+pageNo+"</li>"; 
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
		}// end of while-------------------------------
		
		// === [다음][마지막] 만들기 === //
		if(pageNo <= totalPage) {
			// 다음
			pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+pageNo+"'><i class=\"fa-solid fa-chevron-right\"></i></a></li>"; 	
		}
		// 마지막
		pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?currentShowPageNo="+totalPage+"'><i class=\"fa-solid fa-forward-step\"></i></a></li>";
					
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		 
		mav.addObject("totalCount", totalCount);   // 페이징 처리시 보여주는 순번을 나타내기 위한 것
		mav.addObject("currentShowPageNo", currentShowPageNo); // 페이징 처리시 보여주는 순번을 나타내기 위한 것
		mav.addObject("sizePerPage", sizePerPage); // 페이징 처리시 보여주는 순번을 나타내기 위한 것
        
		// 페이징 처리된 후 특정 글을 클릭하여 글을 본 후 사용자가 목록보기 버튼을 클릭했을 때 돌아갈페이지를 알려주기위해 넘김 
		String currentURL = MyUtil.getCurrentURL(request);
		mav.addObject("goBackURL", currentURL);
		
		
	    // 전체 메일개수 model에 담기
	    mav.addObject("totalCount", totalCount);
	    // 안 읽은 메일 개수 model에 담기
	    mav.addObject("unreadCount", unreadCount);
		
		////////////////////////////////////////
		
		mav.setViewName("mycontent/mail/mail");
		
		return mav;
	}
	
	
	// 메일 한개 조회
	@GetMapping("viewMail")
	public ModelAndView viewOneMail(ModelAndView mav, HttpServletRequest request,@RequestParam String mailNo,@RequestParam String goBackURL) {
		
		HttpSession session = request.getSession();
		EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
		
		String login_userid = null;
		if(loginuser != null) {
			login_userid = loginuser.getEmployeeNo();
			// login_userid 는 로그인 되어진 사용자의 userid 이다. 
		}
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("mailNo", mailNo);
		paraMap.put("login_userid", login_userid);
		
		MailVO mailvo = null;
		List<PostFileVO> mailfilevo = null;
		
		mailvo = service.viewMail(paraMap);
			
	 
		if ("yes".equals((String) session.getAttribute("readCountPermission"))) {
			// 글목록보기인 /board 페이지를 클릭한 다음에 특정글을 조회해온 경우

			mailvo = service.viewMail(paraMap); // 게시글 하나 조회하기
			// 글 조회수 증가와 함께 글 1개를 조회를 해오는 것( 조회수 증가는 service 단에서 처리를 해줌.)
		  
			session.removeAttribute("readCountPermission");
			// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
		}

		else {
			// 글목록에서 특정 글제목을 클릭하여 본 상태에서
			// 웹브라우저에서 새로고침(F5)을 클릭한 경우 
		
			// 글 조회수 증가는 없고 단순히 글 1개만 조회를 해오는 것
			mailvo = service.viewMail(paraMap);
		  
	  		if (mailvo == null) {
	  			mav.setViewName("redirect:/mail/viewMail");
	  			return mav;
	  		}
	  		  
		}
		
		
		mailfilevo = service.getMailFile(paraMap); // 글 하나의 첨부파일 테이블의 고유번호,기존파일명,새로운 파일명 추출
		 
		mav.addObject("mailfilevo", mailfilevo);
		mav.addObject("mailvo", mailvo);
		mav.addObject("goBackURL", goBackURL); // 글 하나 클릭 시 클릭된 페이지의 해당 URL을 넘겨줌.
	  	mav.setViewName("mycontent/mail/viewMail");
		
	  	
		return mav;
	}
	
	
	
    // Ajax 요청 중요(별) 상태 변경
    @PostMapping("/toggleImportant")
    @ResponseBody
    public String toggleImportant(@RequestParam("mailNo") int mailNo) {
        int importantStatus = service.toggleImportant(mailNo);
        // 숫자를 문자열로 변환하여 반환 (JSON 대신 간단히 문자열 사용)
        return String.valueOf(importantStatus);
    }
    
    // Ajax 요청 읽음 상태 변경
    @PostMapping("/toggleReadMail")
    @ResponseBody
    public String toggleReadMail(@RequestParam("mailNo") int mailNo) {
        int readtStatus = service.toggleReadMail(mailNo);
        // 숫자를 문자열로 변환하여 반환 (JSON 대신 간단히 문자열 사용)
        return String.valueOf(readtStatus);
    }
    
    // Ajax 요청 중요메일함 조회
    @GetMapping("/important")
    @ResponseBody
    public List<MailVO> importantMailAjax(HttpServletRequest request) {
    	
        // 로그인 사용자 정보(사번 등) 가져오기
        HttpSession session = request.getSession();
        EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
        String empNo = loginuser.getEmployeeNo();

        // Service 호출
        List<MailVO> importantList = service.selectImportantMail(empNo);

        // JSON으로 반환
        return importantList;
    }
    
    // Ajax 요청 임시보관함 조회
    @GetMapping("/saveMail")
    @ResponseBody
    public List<MailVO> saveMail(@RequestParam("saveStatus") int saveStatus) {
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("saveStatus", String.valueOf(saveStatus));

        // DB 조회
        List<MailVO> mailList = service.selectMailList(paraMap);

        return mailList; // JSON으로 응답
    }

	
}
