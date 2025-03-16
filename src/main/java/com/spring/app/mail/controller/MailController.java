package com.spring.app.mail.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
	
	@GetMapping("") // 받은 메일 목록 (기본 메일함)
	public ModelAndView mail(ModelAndView mav, 
	                         HttpServletRequest request,
	                         @RequestParam(defaultValue = "1") String currentShowPageNo,
	                         @RequestParam(defaultValue = "20") String sizePerPage, // sizePerPage 파라미터
	                         @RequestParam(required = false) String mailbox) { // 현재 어떤 메일함 조회중인지 식별용 (페이징 처리)
	    
	    HttpSession session = request.getSession();
	    
        // 로그인된 사용자 정보 가져오기
        EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
        String loginUserId = loginuser != null ? loginuser.getEmployeeNo() : null;
        
        // paraMap 구성 (조건 설정)
        Map<String, String> paraMap = new HashMap<>();
        
        // 로그인한 사용자 ID 추가
        paraMap.put("loginUserId", loginUserId);  // 로그인한 사용자 ID 추가

	    // mailbox가 null이면 세션에서 가져오거나 기본값 설정
	    if (mailbox == null || mailbox.isEmpty()) {
	        mailbox = (String) session.getAttribute("currentMailbox");
	        if (mailbox == null) {
	            mailbox = "default"; // 최종 기본값
	        }
	    }
	    
	    // 세션에 현재 mailbox 저장
	    session.setAttribute("currentMailbox", mailbox);
	    
	    System.out.println("mailbox: " + mailbox);
	    
	    // ======================
	    // 페이지번호와 페이지크기 설정
	    // ======================
	    int n_currentShowPageNo = 1;
	    int n_sizePerPage = 20; // 기본값 20

	    try {
	        n_currentShowPageNo = Integer.parseInt(currentShowPageNo);
	    } catch(NumberFormatException e) {
	        n_currentShowPageNo = 1;
	    }

	    try {
	        n_sizePerPage = Integer.parseInt(sizePerPage);
	    } catch(NumberFormatException e) {
	        n_sizePerPage = 20;
	    }
	    
	    // -------------------------
	    // paraMap 구성 (조건 설정)
	    // -------------------------
	    if ("trash".equals(mailbox)) {
	        paraMap.put("deleteStatus", "1"); // 휴지통
	    } else if ("save".equals(mailbox)) {
	        paraMap.put("saveStatus", "1"); // 임시보관
	    } else if ("important".equals(mailbox)) {
	        paraMap.put("importantStatus", "1"); // 중요메일
	    } else {
	        paraMap.put("deleteStatus", "0"); // 받은메일함 (기본값)
	    }

	    // ======================
	    // 전체 메일 개수 및 페이지 수 계산
	    // ======================
	    int totalCount = service.getMailCount(paraMap);
	    int totalPage = (int)Math.ceil((double)totalCount / n_sizePerPage);
	    if(totalPage < 1) {
	        totalPage = 1;
	    }
	    
	    // 요청받은 페이지 번호가 1 미만이면 1, 전체 페이지보다 크면 전체 페이지로 설정
	    if(n_currentShowPageNo < 1) {
	        n_currentShowPageNo = 1;
	    } else if(n_currentShowPageNo > totalPage) {
	        n_currentShowPageNo = totalPage;
	    }

	    // ======================
	    // startRno / endRno 계산
	    // ======================
	    int startRno = ((n_currentShowPageNo - 1) * n_sizePerPage) + 1;
	    int endRno   = startRno + n_sizePerPage - 1;

	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno",   String.valueOf(endRno));

	    // ======================
	    // 목록 조회
	    // ======================
	    // 받은 메일 목록 조회
	    List<MailVO> mailList = service.selectMailList(paraMap);
	    
	    int unreadCount = service.getUnreadCount(); 

	    // ======================
	    // 페이지바 만들기
	    // ======================
	    int blockSize = 5;  // 한 블럭당 보여질 페이지 번호 개수
	    int loop = 1;
	    int pageNo = ((n_currentShowPageNo - 1) / blockSize) * blockSize + 1;
	    
	    // URL 생성 (currentShowPageNo 제외)
	    String url = request.getContextPath() + "/mail?mailbox=" + mailbox + "&sizePerPage=" + n_sizePerPage + "&";
	    System.out.println("URL: " + url);
	    
	    String pageBar = "<ul style='list-style:none;'>";
	    
	    // [맨처음]
	    pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" 
	            + url + "currentShowPageNo=1'><i style='transform: scaleX(-1)' class='fa-solid fa-forward-step'></i></a></li>";
	    
	    // [이전]
	    if(pageNo != 1) {
	        pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='" 
	                + url + "currentShowPageNo=" + (pageNo-1) + "'><i class='fa-solid fa-chevron-left'></i></a></li>"; 
	    }

	    // 페이지 번호 반복
	    while (!(loop > blockSize || pageNo > totalPage)) {
	        if (pageNo == n_currentShowPageNo) {
	            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; padding:2px 4px;'>" + pageNo + "</li>";
	        } else {
	            pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" 
	                    + url + "currentShowPageNo=" + pageNo + "'>" + pageNo + "</a></li>";
	        }
	        loop++;
	        pageNo++;
	    }

	    // [다음]
	    if(pageNo <= totalPage) {
	        pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" 
	                + url + "currentShowPageNo=" + pageNo + "'><i class='fa-solid fa-chevron-right'></i></a></li>"; 	
	    }

	    // [마지막]
	    pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='" 
	            + url + "currentShowPageNo=" + totalPage + "'><i class='fa-solid fa-forward-step'></i></a></li>";
	                
	    pageBar += "</ul>";	

	    // ======================
	    // JSP에 값 전달
	    // ======================
	    mav.addObject("ReceivedMailList", mailList);
	    mav.addObject("pageBar", pageBar);
	    mav.addObject("totalCount", totalCount);
	    mav.addObject("unreadCount", unreadCount);
	    mav.addObject("currentShowPageNo", n_currentShowPageNo);
	    mav.addObject("sizePerPage", n_sizePerPage);
	    mav.addObject("mailbox", mailbox);
	    
	    // 페이징 후, 특정 글 클릭 후 돌아올 URL 저장
	    String currentURL = MyUtil.getCurrentURL(request);
	    mav.addObject("goBackURL", currentURL);
	    mav.setViewName("mycontent/mail/mail");
	    return mav;
	}
	
	
	// 메일 목록
	@GetMapping("/mailList")
	@ResponseBody
	public Map<String, Object> getMailList(@RequestParam String mailbox,
	                                       @RequestParam(defaultValue = "1") int currentShowPageNo,
	                                       @RequestParam(defaultValue = "20") int sizePerPage) {
		System.out.println("### 요청 파라미터 확인 ###");
		System.out.println("mailbox: " + mailbox); // 디버깅용
	    System.out.println("currentShowPageNo: " + currentShowPageNo); // 디버깅용
	    System.out.println("sizePerPage: " + sizePerPage); // 디버깅용
	    
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
	            mailNo = Integer.parseInt(mailNoStr.trim());  // 비어 있지 않으면 int로 변환
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
	    /*
	    System.out.println("MailVO: " + mailvo);
	    if (mailvo.getMailfilevo() != null) {
	        System.out.println("첨부파일 개수: " + mailvo.getMailfilevo().size());
	        for (MailFileVO file : mailvo.getMailfilevo()) {
	            System.out.println("첨부파일: " + file.getOrgFileName());
	        }
	    } else {
	        System.out.println("첨부파일 없음");
	    }
	    */


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
    @PostMapping("/deleteCheckMail")
    @ResponseBody
    public Map<String, String> deleteMail(@RequestParam List<Integer> mailNoList) {
    	System.out.println("삭제 요청 받은 mailNoList: " + mailNoList);
    	System.out.println("삭제 요청 도착!");
        Map<String, String> response = new HashMap<>();
        try {
            if (mailNoList.isEmpty()) {
                response.put("status", "error");
                response.put("message", "삭제할 메일이 없습니다.");
                return response;
            }
            service.deleteMailStatus(mailNoList);
            response.put("status", "success");
            response.put("message", "메일이 삭제되었습니다.");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "서버 오류 발생");
        }
        return response;
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
    
    // Ajax 요청 체크박스 체크된 메일 readStatus 1로 업데이트 하고 아이콘 변경
    @PostMapping("/readMail")
    @ResponseBody
    public String readMail(@RequestBody Map<String, List<Integer>> request) {
        List<Integer> mailNoList = request.get("mailNo");
        // DB에서 해당 mailNo들에 대해 readStatus=1로 업데이트
        service.readMailStatus(mailNoList);

        // 업데이트된 메일의 상태를 조회
        Map<String, Object> result = new HashMap<>();
        result.put("status", "success");
        result.put("updatedMails", service.getUpdatedMailStatus(mailNoList));
        
        return "result";
    }

    
    // 메일 작성 폼 데이터 처리 (파일 저장 포함)
    @PostMapping("/sendMail")
    @ResponseBody
    public Map<String, String> sendMail(
            @RequestParam("recipient") String recipient,
            @RequestParam("cc") String cc,
            @RequestParam("subject") String subject,
            @RequestParam("content") String content,
            @RequestParam(value = "attach", required = false) MultipartFile[] files,
            HttpSession session,
            HttpServletRequest request) {

        Map<String, String> response = new HashMap<>();
        EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
        String sender = loginuser.getEmployeeNo();

        try {
            // 1. 메일 정보 저장
            MailVO mail = new MailVO();
            mail.setSubject(subject);
            mail.setContent(content);
            mail.setFk_employeeNo(sender);
            mail.setReadStatus("0");
            mail.setDeleteStatus("0");
            mail.setSaveStatus("0");
            mail.setImportantStatus("0");
            mail.setSendDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

            service.insertMail(mail); // 메일 저장
            int fk_mailNo = mail.getMailNo(); // 생성된 mailNo 추출

            // 2. 참조자 처리
            List<Map<String, Object>> referencedList = new ArrayList<>();

            // 수신자 추가 (refStatus=0)
            Map<String, Object> recipientMap = new HashMap<>();
            recipientMap.put("refEmployeeNo", service.findEmployeeNoByName(recipient));
            recipientMap.put("refStatus", 0);
            recipientMap.put("fk_mailNo", fk_mailNo);
            recipientMap.put("refName", recipient);
            referencedList.add(recipientMap);

            // 참조자 처리 (refStatus=1)
            if (cc != null && !cc.isEmpty()) {
                String[] ccList = cc.split(",");
                for (String ccName : ccList) {
                    Map<String, Object> ccMap = new HashMap<>();
                    ccMap.put("refEmployeeNo", service.findEmployeeNoByName(ccName.trim()));
                    ccMap.put("refStatus", 1);
                    ccMap.put("fk_mailNo", fk_mailNo);
                    ccMap.put("refName", ccName.trim());
                    referencedList.add(ccMap);
                }
            }

            // 3. 첨부 파일 처리
            if (files != null && files.length > 0) {
                String uploadDir = request.getServletContext().getRealPath("/uploads/mail/");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                List<Map<String, Object>> fileList = new ArrayList<>();
                for (MultipartFile file : files) {
                    if (file.isEmpty()) continue;

                    // 고유 파일명 생성 (UUID 사용)
                    String originalFileName = file.getOriginalFilename();
                    String savedFileName = UUID.randomUUID() + "_" + originalFileName;

                    // 실제 파일 저장
                    File dest = new File(uploadDir + savedFileName);
                    file.transferTo(dest); // 파일 저장

                    // DB 저장용 데이터
                    Map<String, Object> fileMap = new HashMap<>();
                    fileMap.put("fileName", savedFileName);
                    fileMap.put("orgFileName", originalFileName);
                    fileMap.put("fileSize", file.getSize()); // Long 타입으로 직접 저장
                    fileMap.put("fk_mailNo", fk_mailNo);
                    fileList.add(fileMap);

                    System.out.println("✅ 첨부파일 저장: " + savedFileName);
                }

                // 서비스 호출: 첨부파일 DB 저장
                service.sendMail(fk_mailNo, referencedList, fileList);
            }

            response.put("status", "success");
            response.put("message", "메일이 성공적으로 전송되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            response.put("status", "fail");
            response.put("message", "메일 전송 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }
    
    
    // 보낸메일함 조회
    @GetMapping("/sendMailList")
    public ModelAndView sendMailList(
            @RequestParam(defaultValue = "1") int currentShowPageNo,
            @RequestParam(defaultValue = "20") int sizePerPage,
            HttpSession session) {

        // 로그인된 사용자 정보 가져오기
        EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
        if (loginuser == null) {
            throw new RuntimeException("로그인이 필요합니다.");
        }

        String senderNo = loginuser.getEmployeeNo(); // 발신자 사번 (로그인한 사용자)

        Map<String, String> paraMap = new HashMap<>();
        paraMap.put("senderNo", senderNo);  // senderNo를 파라미터에 추가
        paraMap.put("currentShowPageNo", String.valueOf(currentShowPageNo));
        paraMap.put("sizePerPage", String.valueOf(sizePerPage));

        // 보낸 메일 목록 조회
        List<MailVO> mailList = service.selectSentMail(paraMap);

        // 총 메일 개수 조회
        int totalCount = service.getSentMailCount(senderNo);

        // 페이징 처리
        int totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

        Map<String, Object> response = new HashMap<>();
        response.put("mailList", mailList);
        response.put("totalPage", totalPage);
        response.put("sizePerPage", sizePerPage);

        // 응답 반환
        ModelAndView mav = new ModelAndView("mycontent/mail/sendMailList");
        mav.addObject("response", response);
        return mav;
    }
    
    
    // 받은 메일 목록 조회 (로그인한 사용자 기준)
    @GetMapping("/received")
    public List<MailVO> getReceivedMails(@RequestParam("employeeNo") int employeeNo) {
        return service.getReceivedMailList(employeeNo);
    }
    
    
    
    
    @GetMapping("/selectMail")
	@ResponseBody
	public Map<String, String> selectMail(@RequestParam String fk_employeeNo) {
		// System.out.println("되려나");
    	
    	Map<String, String> map = service.selectMail(fk_employeeNo); // 읽은메일, 중요메일, 임시저장 비율 구해오기
    	
		return map;
	}
    
    
}
