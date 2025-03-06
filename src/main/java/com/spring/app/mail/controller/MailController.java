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

import com.spring.app.common.MyUtil;
import com.spring.app.employee.domain.EmployeeVO;
import com.spring.app.mail.domain.MailFileVO;
import com.spring.app.mail.domain.MailVO;
import com.spring.app.mail.service.MailService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

// === 컨트롤러 선언 === //
@Controller
@RequestMapping(value="/mail")
public class MailController {
	
	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private MailService service;
	
	@GetMapping("") // 메일 목록
	public ModelAndView mail(ModelAndView mav, 
	                         HttpServletRequest request,
	                         @RequestParam(defaultValue = "1") String currentShowPageNo,
	                         @RequestParam(defaultValue = "20") String sizePerPage, // sizePerPage 파라미터 (문자열)
	                         @RequestParam(required = false) String mailbox) { // 현재 어떤 메일함 조회중인지 식별용 (페이징 처리)
	    
	    HttpSession session = request.getSession();

	    // mailbox 값 확인
	    System.out.println("mailbox: " + mailbox);
	    
	    // ======================
	    // 페이지번호와 페이지크기 설정
	    int n_currentShowPageNo = 1;
	    int n_sizePerPage = 20; // 기본값 20

	    // currentShowPageNo
	    try {
	        n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
	    } catch(NumberFormatException e) {
	        n_currentShowPageNo = 1;
	    }

	    // sizePerPage
	    try {
	        n_sizePerPage = Integer.parseInt(sizePerPage);
	    } catch(NumberFormatException e) {
	        n_sizePerPage = 20;
	    }
	    
	    // mailbox가 null이면 세션에서 이전에 선택한 메일함 정보를 가져온다
	    if (mailbox == null || mailbox.isEmpty()) {
	        mailbox = (String) session.getAttribute("currentMailbox");
	        if (mailbox == null) {
	            mailbox = "default"; // 기본값 설정
	        }
	    }
	    
	    // 현재 선택된 메일함 정보를 세션에 저장
	    session.setAttribute("currentMailbox", mailbox);
	    
	    // paraMap 구성 (startRno, endRno, deleteStatus, saveStatus, importantStatus 등)
	    Map<String, String> paraMap = new HashMap<>();
	    
	    // mailbox 파라미터에 따라 조건 설정
	    if ("trash".equals(mailbox)) {
	        // 휴지통 => deleteStatus=1
	        paraMap.put("deleteStatus", "1");
	    }
	    /*
	    else if ("sendMail".equals(mailbox)) {
	        // 임시보관 => saveStatus=1
	        paraMap.put("saveStatus", "1");
	    }
	    */
	    
	    else if ("save".equals(mailbox)) {
	        // 임시보관 => saveStatus=1
	        paraMap.put("saveStatus", "1");
	    }
	    else if ("important".equals(mailbox)) {
	        // 중요메일 => isImportant=1
	        paraMap.put("importantStatus", "1");
	    }
	    else {
	        // 기본 => 받은메일함 => deleteStatus=0
	        paraMap.put("deleteStatus", "0");
	    }

	    // ======================
	    // 2) 전체 메일 개수, 안 읽은 메일 개수
	    // ======================
	    int totalCount = service.getMailCount(paraMap);
	    // int unreadCount = service.getUnreadCount();

	    // ======================
	    // 3) 전체 페이지 수 계산
	    // ======================
	    /*
	    int totalPage = (int) Math.ceil((double)totalCount / n_sizePerPage);
	    if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
	        n_currentShowPageNo = 1;
	    }
	    */
	    int totalPage = (int)Math.ceil((double)totalCount / n_sizePerPage);
	    
	    if(n_currentShowPageNo < 1 || n_currentShowPageNo > totalPage) {
	    	n_currentShowPageNo = 1;
	    }

	    // ======================
	    // 4) startRno / endRno 계산
	    // ======================
	    int startRno = ((n_currentShowPageNo - 1) * n_sizePerPage) + 1;
	    int endRno   = startRno + n_sizePerPage - 1;

	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno",   String.valueOf(endRno));

	    
	    // ======================
	    // 5) 목록 조회
	    // ======================
	    /*
	    List<MailVO> ReceivedMailList = service.selectMailList(paraMap);
	    mav.addObject("ReceivedMailList", ReceivedMailList);
		*/
	    List<MailVO> mailList = service.selectMailList(paraMap);
	    
	    
	    // 5) unreadCount (전체 기준인지, 현재 mailbox 기준인지 상황에 따라)
	    int unreadCount = service.getUnreadCount(); 
	    // 만약 휴지통/중요만의 미열람 수를 구하려면 동적 getMailCount를 쓰되 readStatus=0도 넣어야 함

	    // ======================
	    // 6) 페이지바 만들기
	    // ======================
	    int blockSize = 5;  // 한 블럭당 보여질 페이지 번호 개수
	    int loop = 1;
	    int pageNo = ((n_currentShowPageNo - 1) / blockSize) * blockSize + 1;
	    
	    // url에 sizePerPage 파라미터도 붙이기
	    // String url = "list?sizePerPage=" + n_sizePerPage;
	    // pageBar 생성 시에도 mailbox를 포함
	    System.out.println("mailbox : " + mailbox);
	    String url = request.getContextPath() + "/mail?mailbox=" + mailbox + "&sizePerPage=" + n_sizePerPage;
	    System.out.println("URL: " + url); // url 로그 출력
	    
	    String pageBar = "<ul style='list-style:none;'>";
	    

	    // [맨처음][이전]
	    pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'>" 
	             + "<a href='" + url + "&currentShowPageNo=1'>"
	             + "<i style='transform: scaleX(-1)' class='fa-solid fa-forward-step'></i></a></li>";

	    if(pageNo != 1) {
	        pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'>"
	                 + "<a href='" + url + "&currentShowPageNo=" + (pageNo-1) + "'>"
	                 + "<i style='transform: scaleX(-1)' class='fa-solid fa-chevron-right'></i></a></li>";
	    }

	    while(!(loop > blockSize || pageNo > totalPage)) {
	        if(pageNo == n_currentShowPageNo) {
	            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; "
	                     + "border:solid 1px gray; padding:2px 4px;'>" + pageNo + "</li>";
	        } else {
	            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'>"
	                     + "<a href='" + url + "&currentShowPageNo=" + pageNo + "'>" + pageNo + "</a></li>";
	        }
	        loop++;
	        pageNo++;
	    }

	    // [다음][마지막] 
	    if(pageNo <= totalPage) {
	        pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'>"
	                 + "<a href='" + url + "&currentShowPageNo=" + pageNo + "'>"
	                 + "<i class='fa-solid fa-chevron-right'></i></a></li>";
	    }
	    pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'>"
	             + "<a href='" + url + "&currentShowPageNo=" + totalPage + "'>"
	             + "<i class='fa-solid fa-forward-step'></i></a></li>";

	    pageBar += "</ul>";

	    // ======================
	    // 7) JSP에 값 전달
	    // ======================
	    mav.addObject("ReceivedMailList", mailList);
	    mav.addObject("pageBar", pageBar);
	    mav.addObject("totalCount", totalCount);
	    mav.addObject("unreadCount", unreadCount);
	    mav.addObject("currentShowPageNo", n_currentShowPageNo);
	    mav.addObject("sizePerPage", n_sizePerPage);// 현재 페이지크기
	    mav.addObject("mailbox", mailbox); // mailbox 파라미터 추가
	    
	    /*
	    mav.addObject("totalCount",        totalCount);
	    mav.addObject("unreadCount",       unreadCount);
	    mav.addObject("currentShowPageNo", n_currentShowPageNo);
	    mav.addObject("sizePerPage",       n_sizePerPage); // 현재 페이지크기
		*/

	    // 페이징 처리된 후 특정 글을 클릭하여 글 본 후 목록보기 시 돌아갈 페이지
	    String currentURL = MyUtil.getCurrentURL(request);
	    mav.addObject("goBackURL", currentURL);
	    mav.setViewName("mycontent/mail/mail");
	    return mav;
	}
	
	@GetMapping("/mailList")
	@ResponseBody
	public Map<String, Object> getMailList(@RequestParam String mailbox,
	                                       @RequestParam(defaultValue = "1") int currentShowPageNo,
	                                       @RequestParam(defaultValue = "20") int sizePerPage) {
	    Map<String, String> paraMap = new HashMap<>();

	    // mailbox에 따라 조건 설정
	    switch (mailbox) {
	        case "trash":
	            paraMap.put("deleteStatus", "1"); // 휴지통
	            break;
	        case "save":
	            paraMap.put("saveStatus", "1"); // 임시보관함
	            break;
	        case "important":
	            paraMap.put("importantStatus", "1"); // 중요메일함
	            break;
	        default:
	            paraMap.put("deleteStatus", "0"); // 받은메일함 (기본값)
	            break;
	    }

	    // 전체 메일 개수 조회
	    int totalCount = service.getMailCount(paraMap);

	    // 전체 페이지 수 계산
	    int totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

	    // 페이징 처리
	    int startRno = ((currentShowPageNo - 1) * sizePerPage) + 1;
	    int endRno = startRno + sizePerPage - 1;
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));

	    // 메일 목록 조회
	    List<MailVO> mailList = service.selectMailList(paraMap);

	    // 응답 데이터 구성
	    Map<String, Object> response = new HashMap<>();
	    response.put("mailList", mailList);
	    response.put("totalPage", totalPage);
	    response.put("sizePerPage", sizePerPage);

	    return response;
	}
	
	
	// 메일 내용 상세 조회
	@GetMapping("/viewMail")
	public ModelAndView viewOneMail(@RequestParam(name="mailNo", defaultValue="0") String mailNoStr,
	                                HttpServletRequest request) {
	    
	    // mailNoStr가 null(파라미터 아예 없음)일 수도 있고, ""(빈문자)일 수도 있음
	    int mailNo = 0;
	    
	    if(mailNoStr != null && !mailNoStr.trim().isEmpty()) {
	        try {
	            mailNo = Integer.parseInt(mailNoStr.trim());
	        } catch(NumberFormatException e) {
	            // 파싱 실패 => mailNo=0 유지
	        }
	    }

	    if(mailNo == 0) {
	        // mailNo가 유효하지 않으므로 목록 등으로 리다이렉트
	        return new ModelAndView("redirect:/mail/mail");
	    }
		
	    // 로그인 사용자 체크(필요하면)
	    HttpSession session = request.getSession();
	    EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
	    String login_userid = (loginuser != null) ? loginuser.getEmployeeNo() : null;

	    Map<String, String> paraMap = new HashMap<>();
	    paraMap.put("mailNo", String.valueOf(mailNo));
	    paraMap.put("login_userid", login_userid);

	    // 1) 메일 정보 조회
	    MailVO mailvo = service.viewMail(paraMap);
	    if(mailvo == null) {
	        // 없는 메일이면 목록으로 리다이렉트
	        return new ModelAndView("redirect:/mail/mail");
	    }

	    // 2) 메일을 아직 안 읽었다면(readStatus 0 이라면) readStatus 1 로 업데이트
	    //    (VO가 String이면 "0"인지 비교, int면 0인지 비교)
	    if("0".equals(mailvo.getReadStatus())) {
	        service.updateReadStatus(mailNo, 1);
	        mailvo.setReadStatus("1");
	    }

	    // 3) 첨부파일 목록 조회
	    List<MailFileVO> mailfilevo = service.getMailFile(paraMap);

	    // 4) ModelAndView에 담아 뷰로 이동
	    ModelAndView mav = new ModelAndView("mycontent/mail/viewMail");
	    mav.addObject("mailvo", mailvo);
	    mav.addObject("mailfilevo", mailfilevo);

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

        // 중요 메일 개수 로그 출력
        System.out.println("컨트롤러에서 조회된 중요 메일 개수: " + importantList.size());
        
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

    // Ajax 요청 메일 정렬 방법 선택
    @GetMapping("/sortMail")
    @ResponseBody
    public List<MailVO> sortMail(@RequestParam String sortKey) {
        // 정렬 기준 data-value => sortKey: "subject", "sendDate", "fileSize" 등
        // DB에서 해당 정렬 기준으로 메일 목록 조회 (deleteStatus=0 등 조건은 동일함)
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("sortKey", sortKey);

        // selectMailListSort() 등 새로 만든 서비스/DAO 메서드
        List<MailVO> sortedList = service.mailListSort(paramMap);

        return sortedList; // JSON
    }

    // Ajax 요청 체크박스 체크된 메일 deleteStatus 1로 업데이트
    @PostMapping("/deleteMail")
    @ResponseBody
    public String deleteMail(@RequestParam("mailNo") List<Integer> mailNoList) {
        // mailNoList = [ 101, 102, ... ]
        // 1, DB에서 해당 mailNo들에 대해 deleteStatus=1로 업데이트
        service.deleteMailStatus(mailNoList);

        // 2. 성공시 "success" 리턴
        return "success";
    }
    
    // Ajax 요청 deleteStatus 1 인것만 조회 (휴지통)
    @GetMapping("/deletedMail")
    @ResponseBody
    public List<MailVO> deletedMailAjax(@RequestParam String mailbox) {
    	
    	// mailbox 파라미터를 사용하여 휴지통 메일 조회
        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("deleteStatus", "1");
        paraMap.put("mailbox", mailbox); // mailbox 파라미터 추가
    	
        // DB에서 deleteStatus=1인 메일들만 조회
        List<MailVO> deletedList = service.selectDeletedMail(); 
        
        return deletedList; // JSON으로 반환
    }
    
    // Ajax 요청 체크박스 체크된 메일 readStatus 1로 업데이트
    @PostMapping("/readMail")
    @ResponseBody
    public String readMail(@RequestParam("mailNo") List<Integer> mailNoList) {
        // mailNoList = [ 101, 102, ... ]
        // 1, DB에서 해당 mailNo들에 대해 deleteStatus=1로 업데이트
        service.readMailStatus(mailNoList);

        // 2. 성공시 "success" 리턴
        return "success";
    }
	
}
