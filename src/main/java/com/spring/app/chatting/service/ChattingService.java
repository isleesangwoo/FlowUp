package com.spring.app.chatting.service;

import java.util.List;

import com.spring.app.chatting.domain.ChatRoomVO;
import com.spring.app.chatting.domain.Mongo_messageVO;

//ChattingService.java
public interface ChattingService {
	
	 List<ChatRoomVO> getChatRoomList();
	 void createChatRoom(String roomName, String creator);
	 void addMessageToRoom(Mongo_messageVO message);
	 List<Mongo_messageVO> getRoomMessages(String roomId);
	 
}