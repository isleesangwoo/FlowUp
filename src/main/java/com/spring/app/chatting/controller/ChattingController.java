package com.spring.app.chatting.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.app.chatting.domain.ChatRoomVO;
import com.spring.app.chatting.service.ChattingService;
import com.spring.app.employee.domain.EmployeeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// === (#웹채팅관련3) ===
@Controller
@RequestMapping("/chatting/*")
public class ChattingController {
	
    @Autowired
    private ChattingService chattingService;

	
	@GetMapping("multichat")
	public String requiredLogin_multichat(HttpServletRequest request, HttpServletResponse response) {
		
		
		
		return "mycontent/chatting/multichat";
	}

    @GetMapping("multichatlist")
    public String chatRoomList(Model model, HttpSession session) {
        List<ChatRoomVO> roomList = chattingService.getChatRoomList();
        model.addAttribute("chatRoomList", roomList);
        return "mycontent/chatting/multichatList";
    }

    @PostMapping("createRoom")
    public String createRoom(@RequestParam String roomName, HttpSession session) {
        EmployeeVO loginuser = (EmployeeVO) session.getAttribute("loginuser");
        chattingService.createChatRoom(roomName, loginuser.getEmployeeNo());
        return "redirect:/chatting/multichatlist";
    }
	
}
