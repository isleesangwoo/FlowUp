package com.spring.app.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.app.reservation.service.ReservationService;


//=== 컨트롤러 선언 === //
@Controller
@RequestMapping("/reservation/*")
public class ReservationController {

	@Autowired // Type 에 따라 알아서 Bean 을 주입해준다.
	private ReservationService service;
	
	@GetMapping("")
	public ModelAndView board(ModelAndView mav) {
		
		mav.setViewName("mycontent/reservation/reservation");
		
		return mav;
	}
}
