package com.spring.app.begin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.begin.domain.BeginDateVO;
import com.spring.app.begin.domain.BeginVO;
import com.spring.app.begin.service.BeginService;

import jakarta.servlet.http.HttpServletRequest;

/*
	DispatcherServlet 이 저장된 장소는 
    Maven Dependencies > spring-webmvc-6.1.12.jar > org.springframework.web.servlet > DispatcherServlet.class 에 있음. 
	
	사용자 웹브라우저 요청(View) <==> Application 클래스(MyspringApplication) ==> DispatcherServlet ==> @Controller 클래스 <==>> Service단(핵심업무로직단, business logic단) <==>> Model단[Repository](DAO, DTO) <==>> myBatis <==>> DB(오라클)           
	(http://localhost:9090/myspring/...  )   										                    |                                                                                                                              
	 ↑               																				View Resolver
	 |																			                    	↓
	 |               																				View단(.jsp 또는 Bean명)
	 ---------------------------------------------------------------------------------------------------| 
	
	사용자(클라이언트)가 웹브라우저에서 http://localhost:9090/myspring/myspring_insert 를 실행하면
	Application 클래스인 com.spring.app.MyspringApplication 이 작동된다.
	MyspringApplication 은 bean 으로 등록된 객체중 controller 빈을 찾아서 URL값이 "/myspring/myspring_insert" 으로
	매핑된 메소드를 실행시키게 된다.                                               
	Service(서비스)단 객체를 업무 로직단(비지니스 로직단)이라고 부른다.
	Service(서비스)단 객체가 하는 일은 Model단에서 작성된 데이터베이스 관련 여러 메소드들 중 관련있는것들만을 모아 모아서
	하나의 트랜잭션 처리 작업이 이루어지도록 만들어주는 객체이다.
	여기서 업무라는 것은 데이터베이스와 관련된 처리 업무를 말하는 것으로 Model 단에서 작성된 메소드를 말하는 것이다.
	이 서비스 객체는 @Controller 단에서 넘겨받은 어떤 값을 가지고 Model 단에서 작성된 여러 메소드를 호출하여 실행되어지도록 해주는 것이다.
	실행되어진 결과값을 @Controller 단으로 넘겨준다.
	*/
	
// ==== #1. 컨트롤러 선언 ====
// @Component
/* 클래스명 앞에 @Component 어노테이션을 적어주면 해당 클래스는 bean으로 자동 등록된다. 
   그리고 bean의 이름은 해당 클래스명에서 첫글자만 소문자로 바뀐 이름으로 되어진다. 
   즉, 여기서 bean의 이름은 beginController 인 것이다. 
   여기서 @Controller 를 사용하므로 @Controller 에는 @Component 기능이 이미 포함되어 있으므로 @Component를 명기하지 않아도 BeginController 는 bean 으로 등록되어 스프링컨테이너가 자동적으로 관리해준다. 
*/
@Controller
@RequestMapping(value="/test/*")
public class BeginController {

	// === 의존객체 주입하기(DI: Dependency Injection) ===
    // ※ 의존객체주입(DI : Dependency Injection) 
	//  ==> 스프링은 객체를 관리해주는 컨테이너를 제공해주고 있다.
	//      스프링 컨테이너는 bean으로 등록되어진 BeginController 클래스 객체가 사용되어질때, 
	//      BeginController 클래스의 인스턴스 객체변수(의존객체)인 BeginService service 에 
	//      자동적으로 bean 으로 등록되어 생성되어진 BeginService service 객체를  
	//      BeginController 클래스의 인스턴스 변수 객체로 사용되어지게끔 넣어주는 것을 의존객체주입(DI : Dependency Injection)이라고 부른다. 
	//      이것이 바로 IoC(Inversion of Control == 제어의 역전) 인 것이다.
	//      즉, 개발자가 인스턴스 변수 객체를 필요에 의해 생성해주던 것에서 탈피하여 스프링은 컨테이너에 객체를 담아 두고, 
	//      필요할 때에 컨테이너로부터 객체를 가져와 사용할 수 있도록 하고 있다. 
	//      스프링은 객체의 생성 및 생명주기를 관리할 수 있는 기능을 제공하고 있으므로, 더이상 개발자에 의해 객체를 생성 및 소멸하도록 하지 않고
	//      객체 생성 및 관리를 스프링 프레임워크가 가지고 있는 객체 관리기능을 사용하므로 Inversion of Control == 제어의 역전 이라고 부른다.  
	//      그래서 스프링 컨테이너를 IoC 컨테이너라고도 부른다.
	
	//  IOC(Inversion of Control) 란 ?
	//  ==> 스프링은 사용하고자 하는 객체를 빈형태로 이미 만들어 두고서 컨테이너(Container)에 넣어둔후
	//      필요한 객체사용시 컨테이너(Container)에서 꺼내어 사용하도록 되어있다.
	//      이와 같이 객체 생성 및 소멸에 대한 제어권을 개발자가 하는것이 아니라 스프링 Container 가 하게됨으로써 
	//      객체에 대한 제어역할이 개발자에게서 스프링 Container로 넘어가게 됨을 뜻하는 의미가 제어의 역전 
	//      즉, IOC(Inversion of Control) 이라고 부른다.
	
	
	//  === 느슨한 결합 ===
	//      스프링 컨테이너가 BeginController 객체에서 BeginService 객체를 사용할 수 있도록 
	//      만들어주는 것을 "느슨한 결합" 이라고 부른다.
	//      느스한 결합은 BeginController 객체가 메모리에서 삭제되더라도 BeginService service 객체는 메모리에서 동시에 삭제되는 것이 아니라 남아 있다.
	
	// ===> 단단한 결합(개발자가 인스턴스 변수 객체를 필요에 의해서 생성해주던 것)
	// private BeginService service = new BeginService_imple(); 
	// ===> BeginController 객체가 메모리에서 삭제 되어지면  BeginService service 객체는 멤버변수(필드)이므로 메모리에서 자동적으로 삭제되어진다.	
	
	
	// === #6. 의존객체 주입하기(DI: Dependency Injection) === 
	@Autowired  // Type에 따라 알아서 Bean 을 주입해준다.
	private BeginService service;

	
    // ========================= **** spring 기초 시작  **** ========================= //

//	@RequestMapping(value = "insert", method= {RequestMethod.GET})  // 오로지 GET방식만 허락하는 것임.
 //	@RequestMapping(value = "insert", method= {RequestMethod.POST}) // 오로지 POST방식만 허락하는 것임.
 //	@RequestMapping(value = "insert")  // GET방식 또는 POST방식 둘 모두 허락하는 것임. 
	                                   // http://localhost:9090/myspring/test/insert
	// Spring Boot 에서는 @RequestMapping 을 사용하지 말고 @GetMapping(오로지 GET방식만 허락하는 것임) 또는 @PostMapping(오로지 POST방식만 허락하는 것임) 을 사용하는 것을 권장함.!!
	// Spring Framework 에서는 @RequestMapping 을 사용해도 괜찮으며 사용하지 말라는 권장 메시지가 나오지 않음.
//	@GetMapping(value = "insert")
//	@GetMapping(path = "insert")	// value 와 path 는 동일한 결과를 가져오므로 아무거나 사용하면 된다.
	@GetMapping("insert") // value 또는 path 는 생략가능함.
	public String insert(HttpServletRequest request) {
		
		int n = service.insert();
		
		String message = "";
		
		if(n==1) {
			message = "데이터 입력 성공!!";
		}
		else {
			message = "데이터 입력 실패!!";
		}
		
		request.setAttribute("message", message);
		request.setAttribute("n", n);
		
		return "begin/insert";  
		//   /WEB-INF/views/begin/insert.jsp 페이지를 만들어야 한다.
	}
	
	
	// 먼저 오라클에서 
	/*
		insert into spring_test(no, name, writeday)
		values(102, '김태희', default);
		
		insert into spring_test(no, name, writeday)
		values(103, '변우석', default);
		
		commit; 
		
		을 먼저 하고서 다음의 것을 한다. 
	*/
	
	@GetMapping("select")  // http://localhost:9090/myspring/test/select
	public String select(HttpServletRequest request) {
		
		List<BeginVO> beginvoList = service.select();
		
		request.setAttribute("beginvoList", beginvoList);
		
		return "begin/select";
		//   /WEB-INF/views/begin/select.jsp 페이지를 만들어야 한다.
	}
	
	
	@GetMapping("select_datevo")  // http://localhost:9090/myspring/test/select_datevo
	public String select_datevo(HttpServletRequest request) {
		
		List<BeginDateVO> begindatevoList = service.select_datevo();
		
		request.setAttribute("begindatevoList", begindatevoList);
		
		return "begin/select_datevo";
		//   /WEB-INF/views/begin/select_datevo.jsp 페이지를 만들어야 한다.
	}
	
	
	@GetMapping("select_map")   
	public String select_map(HttpServletRequest request) {
		
		List<Map<String, String>> mapList = service.select_map();
		
		request.setAttribute("mapList", mapList);
		
		return "begin/select_map";
		//   /WEB-INF/views/begin/select_map.jsp 페이지를 만들어야 한다.
	}
	
	
 //	@RequestMapping(value = "form_request", method= {RequestMethod.GET})  // 오로지 GET방식만 허락하는 것임.
 //	@RequestMapping(value = "form_request", method= {RequestMethod.POST}) // 오로지 POST방식만 허락하는 것임.
 //	@RequestMapping(value = "form_request") // GET방식 또는 POST방식 둘 모두 허락하는 것임.
	@RequestMapping(path = "form_request")  // GET방식 또는 POST방식 둘 모두 허락하는 것임.
	public String form_request(HttpServletRequest request) {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) { // GET 방식이라면
			return "begin/form_request"; // view 단 페이지를 띄워라
			//  /WEB-INF/views/myspring/form_request.jsp 페이지를 만들어야 한다.
		}
		else { // POST 방식이라면
			String no = request.getParameter("no");
			String name = request.getParameter("name");
			
			BeginVO bvo = new BeginVO();
			bvo.setNo(no);
			bvo.setName(name);
		//	bvo.setIrum(name);
			
			int n = service.insert_vo(bvo);
			
			if(n==1) {
				return "redirect:/test/select";
				//  /test/select URL로 redirect(페이지이동)해라는 말이다.
			}
			else {
				return "redirect:/test/form_request";
				//  /test/form_request URL로 redirect(페이지이동)해라는 말이다.
			}
		}
	}
	
	
	@RequestMapping(value = "form_vo") // GET방식 또는 POST방식 둘 모두 허락하는 것임.
	public String form_vo(HttpServletRequest request, BeginVO bvo) {
		// BeginVO bvo 의 setXXX() 은 form 태그의 name 속성 value 값과 일치해야만 된다.
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) { // GET 방식이라면
			return "begin/form_vo"; // view 단 페이지를 띄워라
			//  /WEB-INF/views/begin/form_vo.jsp 페이지를 만들어야 한다.
		}
		else { // POST 방식이라면
			
			int n = service.insert_vo(bvo);
			
			if(n==1) {
				return "redirect:/test/select";
				//  /test/select URL로 redirect(페이지이동)해라는 말이다.
			}
			else {
				return "redirect:/test/form_vo";
				//  /test/form_vo URL로 redirect(페이지이동)해라는 말이다.
			}
		}
	}
	
	
	@GetMapping("form_beginvo") // GET방식 만 허락하는 것임.
	public String form_beginvo() {
		
		return "begin/form_beginvo"; // view 단 페이지를 띄워라
			//  /WEB-INF/views/begin/form_beginvo.jsp 페이지를 만들어야 한다.
	}
		
	@PostMapping("form_beginvo") // POST방식 만 허락하는 것임.
	public String form_beginvo(BeginVO bvo) {
		
		int n = service.insert_vo(bvo);
		
		if(n==1) {
			return "redirect:/test/select";
			//  /test/select URL로 redirect(페이지이동)해라는 말이다.
		}
		else {
			return "redirect:/test/form_beginvo";
			//  /test/form_beginvo URL로 redirect(페이지이동)해라는 말이다.
		}
	}
	
	
	@GetMapping("form_datevo") 
	public String form_datevo() {
		
		return "begin/form_datevo"; 
	}
		
	@PostMapping("form_datevo") 
	public String form_datevo(BeginDateVO bdatevo) {
		
		int n = service.insert_datevo(bdatevo);
		
		if(n==1) {
			return "redirect:/test/select_datevo";
			
		}
		else {
			return "redirect:/test/form_datevo";
		}
	}
	
	
	@GetMapping("form_request_map") // GET방식 만 허락하는 것임.
	public String form_request_map() {
		
		return "begin/form_request_map"; // view 단 페이지를 띄워라
	    //  /WEB-INF/views/begin/form_request_map.jsp 페이지를 만들어야 한다.
	}
		
	@PostMapping("form_request_map") // POST방식 만 허락하는 것임.
	public String form_request_map(HttpServletRequest request) {
		
		String no = request.getParameter("no");
		String name = request.getParameter("name");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("no", no);
		paraMap.put("name", name);
		
		int n = service.insert_map(paraMap); 
		
		if(n==1) {
			return "redirect:/test/select_map";
			//  /test/select_map URL로 redirect(페이지이동)해라는 말이다.
		}
		else {
			return "redirect:/test/form_request_map";
			//  /test/form_request_map URL로 redirect(페이지이동)해라는 말이다.
		}
	}	
	
	
	
	@GetMapping("form_RequestParam_Map") // GET방식 만 허락하는 것임.
	public String form_RequestParam_Map() {
		
		return "begin/form_RequestParam_Map"; // view 단 페이지를 띄워라
		//  /WEB-INF/views/begin/form_RequestParam_Map.jsp 페이지를 만들어야 한다.
	}
		
	@PostMapping("form_RequestParam_Map") // POST방식 만 허락하는 것임.
	public String form_RequestParam_Map(@RequestParam Map<String, String> paraMap) {
		/* 폼에서 건네준 값들을 컨트롤러에서 Map 으로 받을수 있음. 
		   반드시 @ReqestParam 을 Map 앞에 붙여 주어야 함. 안 붙이면 오류발생함!!!
		   이때 Map 의 key 값은 자동적으로 폼의 name 명이 key 값이 되어짐. */
		
		int n = service.insert_map(paraMap);
		
		if(n==1) {
			return "redirect:/test/select_map";
			//  /test/select_map URL로 redirect(페이지이동)해라는 말이다.
		}
		else {
			return "redirect:/test/form_RequestParam_Map";
			//  /test/form_RequestParam_Map URL로 redirect(페이지이동)해라는 말이다.
		}
	}	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////
	
	@GetMapping("select_all_1")  // http://localhost:9090/myspring/test/select_all_1
	public String select_all(HttpServletRequest request) {
		
		List<BeginVO> beginvoList = service.select();
		
		request.setAttribute("beginvoList", beginvoList);
		
		return "begin/select_all_1";
		//   /WEB-INF/views/begin/select_all_1.jsp 페이지를 만들어야 한다.
	}
	
/*	
 	@GetMapping("select_one")
 	public String select_one(HttpServletRequest request) {
 		
 		String no = request.getParameter("no");
 		BeginVO bvo = service.select_one_vo(no);
 		request.setAttribute("bvo", bvo);
 		
 		return "begin/select_one";
 	}
 */
	
	// 또는	
 	
 	@GetMapping("select_one")
 	public String select_one(// @RequestParam(name="no" defaultValue="101") String num, 
 			                 // @RequestParam(value="no" defaultValue="101") String num,
 			                    @RequestParam(defaultValue="101") String no,
 			                    HttpServletRequest request) {
 	
 	//	BeginVO bvo = service.select_one_vo(num);
 		BeginVO bvo = service.select_one_vo(no);
 		request.setAttribute("bvo", bvo);
 		
 		return "begin/select_one";
 	}
	
 	
    //////////////////////////////////////////////////////////////////////
	// === @PathVariable 어노테이션에 대해서 알아보기 === 
	
	@GetMapping("select_all_2")  // http://localhost:9090/myspring/test/select_all_2
	public String select_all_PathVariable(HttpServletRequest request) {
		
		List<BeginVO> beginvoList = service.select();
		
		request.setAttribute("beginvoList", beginvoList);
		
		return "begin/select_all_2";
		//   /WEB-INF/views/begin/select_all_2.jsp 페이지를 만들어야 한다.
	}
	
	
	@GetMapping(value="select_one/{no}")  // http://localhost:9090/myspring/test/select_one/101
	public String select_one(@PathVariable Long no
			                 ,HttpServletRequest request) {
		
		BeginVO bvo = service.select_one_vo_PathVariable(no);
		request.setAttribute("bvo", bvo);
		
		return "begin/select_one_PathVariable";
		//   /WEB-INF/views/begin/select_one_PathVariable.jsp 페이지를 만들어야 한다.
	}
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////////
	
	// ================  Ajax  연습시작  ================ //
	@GetMapping("ajax_form_1") 
	public String ajax_form_1() {
		
		return "begin/ajax_form_1"; 
	}
	
 /*
    @ResponseBody 란?
	 메소드에 @ResponseBody Annotation이 되어 있으면 return 되는 값은 View 단 페이지를 통해서 출력되는 것이 아니라 
	 return 되어지는 값이 문자열이라면 문자열 그 자체를 웹브라우저에 바로 직접 쓰여지게 하는 것이고,
	 return 되어지는 값이 객체(VO, Map, List<E>) 이라면 자동적을 JSON 형태로 변형되어 JSON 값을 Return 시켜준다.
	 일반적으로 JSON 값을 Return 할때 많이 사용된다. 
	 
    >>> 스프링에서 json 또는 gson을 사용한 ajax 구현시 데이터를 화면에 출력해 줄때 한글로 된 데이터가 '?'로 출력되어 한글이 깨지는 현상이 있다. 
        이것을 해결하는 방법은 @RequestMapping 어노테이션의 속성 중 produces="text/plain;charset=UTF-8" 를 사용하면 
        응답 페이지에 대한 UTF-8 인코딩이 가능하여 한글 깨짐을 방지 할 수 있다. <<< 
 */	
	
 /*  == [참고] ==
	@Controller 어노테이션을 사용하면, 기본적으로 view 페이지를 찾아서 띄어주는 역할을 한다.
	하지만 REST-API(JSON, XML)를 개발해야하는 상황이라면 각 메소드마다 @ResponseBody를 붙여주면 
	메소드가 문자열로 리턴하면 문자열을 그대로 반환해주고, 
	메소드가 객체형태[VO(DTO), Map, List<E>]로 리턴하면 객체를 자동적으로 JSON 형태로 바뀌어 반환해준다. 
	즉, @ResponseBody 어노테이션은 view 페이지가 아닌 응답값 그대로 반환하거나 JSON 형태로 바뀌어 반환하려고 할 때 사용하는 것이다.
	 
	@RestController 를 사용하면, 각 메소드마다 @ResponseBody 어노테이션을 붙이지 않는다. 자동적으로 메소드마다 @ResponseBody 을 붙인 기능을 하도록 되어있다.
	즉, @RestController 가 @Controller 에 @ResponseBody 기능을 합친것이다.
	@RestController 는 Spring 4.0 에서 새로이 추가된 어노테이션 이다.
	
	REST-API 란? REST 를 기반으로 만들어진 API 를 말한다.
	- REST(REpresentational State Transfer) 란? 자원을 이름으로 구분하여 해당자원의 상태를 주고 받는것. http 프로토콜을 사용한 소프트웨어 개발의 아키텍처중 하나임.
	- 즉, REST 란 HTTP URI(Uniform Resource Identifier)로서 자원(Resource)을 나타내고,
	             HTTP Method(POST, GET, PUT, DELETE, PATCH)를 통해 
	                       해당자원(URI)에 대한 CRUD 작업을 적용하는 것을 말하며, HTTP 메시지의 포맷은 JSON 을 사용한다.
	             Create : 데이터생성(POST) , 
	             Read : 데이터조회(GET) , 
	             Update : 데이터수정(PUT, PATCH),                        
	             Delete : 데이터삭제(DELETE) 
	             
	- API(Application Programming Interface)는 애플리케이션 프로그래밍 인터페이스를 뜻하며, 
	   소프트웨어 프로그램간에 데이터와 기능을 교환할 수 있도록 하는 규칙이나 프로토콜을 의미한다.                       
*/	
	
	@GetMapping(value="ajax_select_1", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String ajax_select_1() {
		
		List<BeginVO> beginvoList = service.select();
		
		JSONArray jsonArr = new JSONArray(); //  [] 
		
		if(beginvoList != null) {
			for(BeginVO vo : beginvoList) {
				JSONObject jsonObj = new JSONObject();     // {} 
				jsonObj.put("no", vo.getNo());             // {"no":"102"} 
				jsonObj.put("name", vo.getName());         // {"no":"102", "name":"김태희"}
			//	jsonObj.put("name", vo.getIrum());
				jsonObj.put("writeday", vo.getWriteday()); // {"no":"102", "name":"김태희", "writeday":"2025-01-02 20:41:25"}
				
				jsonArr.put(jsonObj); // [{"no":"102", "name":"김태희", "writeday":"2025-01-02 20:41:25"}]
			}// end of for------------------------
		}
		
		return jsonArr.toString(); // "[{"no":"102","name":"김태희","writeday":"2025-01-02 20:41:25"}
                                   //  ,{"no":"101","name":"이순신","writeday":"2025-01-02 20:41:20"}]" 
                                   // 또는 "[]"
	}	
	
	
	@PostMapping("ajax_insert_1")
	@ResponseBody
	public String ajax_insert_1(BeginVO bvo) {
		
		int n = service.insert_vo(bvo);
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n); // {"n":1}
		
		return jsonObj.toString();  // "{"n":1}" 
	}
		
	
	/////////////////////////////////////////////////////////////////////////////////////////////////
	
	@GetMapping("ajax_form_2") 
	public String ajax_form_2() {
		
		return "begin/ajax_form_2"; 
	}
	
	
	@GetMapping("ajax_select_2")
	@ResponseBody
	public List<BeginVO> ajax_select_2() {
		
		List<BeginVO> beginvoList = service.select();
		// BeginVO 의 getXXX() 의 XXX 를 첫번째 글자는 소문자로 바꾼것이 JSON 의 키(key)명이 된다.
				
		return beginvoList; 
		// return 되어지는 값이 객체(VO, Map, List<E>) 이라면 자동적을 JSON 형태로 변형되어 JSON 값을 Return 시켜준다.
	 	
	 	/*
	 		 [{"no":"5007","writeday":"2025-01-17 09:40:12","irum":"오천칠"}
	 		 ,{"no":"5006","writeday":"2025-01-16 14:42:12","irum":"오천육"}
	 		 ,{"no":"5005","writeday":"2025-01-16 14:30:42","irum":"오천오"}
	 		 ,{"no":"5004","writeday":"2025-01-15 00:00:00","irum":"오천사"}
	 		 ,{"no":"5003","writeday":"2025-01-16 12:19:29","irum":"오천삼"}
	 		 ,{"no":"5002","writeday":"2025-01-16 12:09:07","irum":"오천이"}
	 		 ,{"no":"5001","writeday":"2025-01-16 11:46:45","irum":"오천일"}
	 		 ,{"no":"103","writeday":"2025-01-15 17:20:54","irum":"변우석"}
	 		 ,{"no":"102","writeday":"2025-01-15 17:20:54","irum":"김태희"}
	 		 ,{"no":"101","writeday":"2025-01-15 16:49:51","irum":"이순신"}] 
	 	  */
	 		
	 	  /*
			 [{"no":"5007","writeday":"2025-01-17 09:40:12","name":"오천칠"}
			 ,{"no":"5006","writeday":"2025-01-16 14:42:12","name":"오천육"}
			 ,{"no":"5005","writeday":"2025-01-16 14:30:42","name":"오천오"}
			 ,{"no":"5004","writeday":"2025-01-15 00:00:00","name":"오천사"}
			 ,{"no":"5003","writeday":"2025-01-16 12:19:29","name":"오천삼"}
			 ,{"no":"5002","writeday":"2025-01-16 12:09:07","name":"오천이"}
			 ,{"no":"5001","writeday":"2025-01-16 11:46:45","name":"오천일"}
			 ,{"no":"103","writeday":"2025-01-15 17:20:54","name":"변우석"}
			 ,{"no":"102","writeday":"2025-01-15 17:20:54","name":"김태희"}
			 ,{"no":"101","writeday":"2025-01-15 16:49:51","name":"이순신"}] 
		  */
		
		  /* 또는 
		     [] 
		  */
	}
	
	
	@PostMapping("ajax_insert_2")
 	@ResponseBody
 	public Map<String, Integer> ajax_insert_2(BeginVO bvo) {
 	    
 		int n = service.insert_vo(bvo);
 		
 		Map<String, Integer> map = new HashMap<>();
 		map.put("n", n);
 		
 		return map; // "{"n":1}"
 	}
	
	
	@PostMapping("ajax_insert_2_2")
	@ResponseBody
	public Map<String, Integer> ajax_insert_2_2(@RequestBody BeginVO bvo) {  
		// @RequestBody 은 입력받는 데이터 값이 JSON 형태의 문자열 이므로, 이것(JSON 형태의 문자열)을 자동적으로 자바의 객체로 변형시켜주는 것이 @RequestBody 이다.     
		
		int n = service.insert_vo(bvo);
		
		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map;  // "{"n":1}" 
	}
	
	
	@GetMapping("ajax_select_vo_one")
	@ResponseBody
	public BeginVO ajax_select_vo_one() {
		
		BeginVO vo = new BeginVO();
		
		List<BeginVO> beginvoList = service.select();
		
		if(beginvoList != null && beginvoList.size() > 0) {
			vo = beginvoList.get(0);
		}
		
		return vo; //     "{"no":"5006","name":"오천육","writeday":"2025-01-16 14:42:12"}" 
                   // 또는 "{"no":null, "name":null, "writeday":null}"
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	
	@GetMapping("ajax_form_3") 
	public String ajax_form_3() {
		
		return "begin/ajax_form_3"; 
	}
	
	
	@GetMapping("ajax_select_3")
	@ResponseBody
	public List<Map<String, String>> ajax_select_3() {
		
		List<Map<String, String>> mapList = service.select_map();
		
		return mapList; 
		/*
		  [{"NO":"6004","WRITEDAY":"2025-01-17 11:35:25","NAME":"육천사"}
		  ,{"NO":"6003","WRITEDAY":"2025-01-17 11:32:03","NAME":"육천삼"}
		  ,{"NO":"6002","WRITEDAY":"2025-01-17 11:12:06","NAME":"육천이"}
		  ,{"NO":"6001","WRITEDAY":"2025-01-17 10:48:12","NAME":"육천일"}
		  ,{"NO":"5009","WRITEDAY":"2025-01-17 10:43:38","NAME":"이진호"}
		  ,{"NO":"5008","WRITEDAY":"2025-01-17 10:43:30","NAME":"강이훈"}
		  ,{"NO":"5007","WRITEDAY":"2025-01-17 09:40:12","NAME":"오천칠"}
		  ,{"NO":"5006","WRITEDAY":"2025-01-16 14:42:12","NAME":"오천육"}
		  ,{"NO":"5005","WRITEDAY":"2025-01-16 14:30:42","NAME":"오천오"}
		  ,{"NO":"5004","WRITEDAY":"2025-01-15 00:00:00","NAME":"오천사"}
		  ,{"NO":"5003","WRITEDAY":"2025-01-16 12:19:29","NAME":"오천삼"}
		  ,{"NO":"5002","WRITEDAY":"2025-01-16 12:09:07","NAME":"오천이"}
		  ,{"NO":"5001","WRITEDAY":"2025-01-16 11:46:45","NAME":"오천일"}
		  ,{"NO":"103","WRITEDAY":"2025-01-15 17:20:54","NAME":"변우석"}
		  ,{"NO":"102","WRITEDAY":"2025-01-15 17:20:54","NAME":"김태희"}
		  ,{"NO":"101","WRITEDAY":"2025-01-15 16:49:51","NAME":"이순신"}]
		  
	      또는 []
	   */
	}
	
	
	@GetMapping("ajax_select_map_one")
	@ResponseBody
	public Map<String, String> ajax_select_map_one() {
		
		Map<String, String> map = new HashMap<>();
		
		List<Map<String, String>> mapList = service.select_map();
		
		if(mapList != null && mapList.size() > 0) {
		    map = mapList.get(0);
		}
		
		return  map; // {"NO":"6004","WRITEDAY":"2025-01-17 11:35:25","NAME":"육천사"}
		             // 또는 {}
	}
	
	
	@PostMapping("ajax_insert_3")
	@ResponseBody
	public Map<String, Integer> ajax_insert_3(@RequestBody HashMap<String, String> map) {  
		// @RequestBody 은 입력받는 데이터 값이 JSON 형태의 문자열 이므로, 이것(JSON 형태의 문자열)을 자동적으로 자바의 객체로 변형시켜주는 것이 @RequestBody 이다.    
		
		int n = service.insert_map(map);
		
		Map<String, Integer> returnMap = new HashMap<>();
		returnMap.put("n", n);
		
		return returnMap;  // "{"n":1}" 
	}
	
	
	///////////////////////////////////////////////////////////
	//  ============== REST-API 시작 ===============
	/* 
	   REST-API 란? REST 를 기반으로 만들어진 API 를 말한다.
		- REST(REpresentational State Transfer) 란? 자원을 이름으로 구분하여 해당자원의 상태를 주고 받는것. http 프로토콜을 사용한 소프트웨어 개발의 아키텍처중 하나임.
		- 즉, REST 란 HTTP URI(Uniform Resource Identifier)로서 자원(Resource)을 나타내고,
		  HTTP Method(POST, GET, PUT, DELETE, PATCH)를 통해 
	          해당자원(URI)에 대한 CRUD 작업을 적용하는 것을 말하며, HTTP 메시지의 포맷은 JSON 을 사용한다.
			              Create : 데이터생성(POST) , 
			              Read   : 데이터조회(GET) , 
			              Update : 데이터수정(PUT, PATCH),                        
			              Delete : 데이터삭제(DELETE) 
			             
		- API(Application Programming Interface)는 애플리케이션 프로그래밍 인터페이스를 뜻하며, 
		   소프트웨어 프로그램간에 데이터와 기능을 교환할 수 있도록 하는 규칙이나 프로토콜을 의미한다.
	*/
	
	@GetMapping("select_all_crud")  // http://localhost:9090/myspring/test/select_all_crud
	public String select_all_crud(HttpServletRequest request) {
		
		return "begin/select_all_crud";
		//   /WEB-INF/views/begin/select_all_crud.jsp 페이지를 만들어야 한다.
	}
	
	// 먼저, 웹브라우저에서 http://localhost:9090/myspring/test/select_all_crud 를 실행하여 화면을 띄운다.
	@GetMapping("select_all_view") 
	@ResponseBody
	public List<Map<String, String>> select_all_view() {
		
		List<Map<String, String>> mapList = service.select_map();
		return mapList;
	}
	
	
	@PostMapping("crud/create_update") 
	@ResponseBody
	public Map<String, Integer> create_crud(@RequestBody HashMap<String, String> map) {
		
		int n = service.insert_map(map);
		
		Map<String, Integer> returnMap = new HashMap<>();
		returnMap.put("n", n);
		
		return returnMap;  // "{"n":1}"
	}
	
	
	@GetMapping(value="crud/{no}") 
	@ResponseBody
	public Map<String, String> select_one_crud(@PathVariable Long no) {
		
		Map<String, String> map = service.select_one_map(no);
		return map;
		// {"NO":"6005","WRITEDAY":"2025-01-17 12:28:41","NAME":"육천오"}
	}
	
	
	@PutMapping("crud/create_update") 
	@ResponseBody
	public Map<String, Integer> update_crud(@RequestBody HashMap<String, String> map) {
		
		int n = service.update_map(map);
		
		Map<String, Integer> returnMap = new HashMap<>();
		returnMap.put("n", n);
		
		return returnMap;  // "{"n":1}"
	}
	
	
	@DeleteMapping(value="crud/{no}") 
	@ResponseBody
	public Map<String, Integer> delete_one_crud(@PathVariable Long no) {
		
		int n = service.delete_one(no); 

		Map<String, Integer> map = new HashMap<>();
		map.put("n", n);
		
		return map;
	 // {"n":1}	
	}
    //  ============== REST-API 끝 ===============
	//////////////////////////////////////////////////////
	
	// ================  Ajax  연습끝  ================ //
	
	
	// === 이제부터는 뷰단을 나타내어줄때 return 타입을 String 을 사용하지 않고 ModelAndView 를 사용해보겠습니다. === //
	@GetMapping(value = "modelandview_select")   
	public ModelAndView modelandview_select(ModelAndView mav) {
		
		List<BeginVO> beginvoList = service.select();
		
		mav.addObject("beginvoList", beginvoList);
	//  위의 것은	
	//	request.setAttribute("beginvoList", beginvoList); 와 같은 것이다. 
		
		mav.setViewName("begin/modelandview_select");
	//  view 단 페이지의 파일명 지정하기
	//	/WEB-INF/views/begin/modelandview_select.jsp 페이지를 만들어야 한다.
		
		return mav;
	}
	
	
	
	// ========================= **** spring 기초 끝  **** ========================= //
		
}
