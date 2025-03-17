package com.spring.app.chatting.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

import com.spring.app.chatting.domain.ChatRoomVO;
import com.spring.app.chatting.domain.Mongo_messageVO;

@Service
public class ChattingServiceImpl implements ChattingService {
 
	 @Autowired
	 private MongoOperations mongo;
	
	 @Override
	 public List<ChatRoomVO> getChatRoomList() {
	     return mongo.findAll(ChatRoomVO.class);
	 }
	
	 @Override
	 public void createChatRoom(String roomName, String creator) {
	     ChatRoomVO room = new ChatRoomVO();
	     room.setRoomId(UUID.randomUUID().toString());
	     room.setRoomName(roomName);
	     room.setCreator(creator);
	     room.setCreatedDate(new Date());
	     room.setMembers(new ArrayList<>());
	     mongo.insert(room);
	 }
	
	 @Override
	 public void addMessageToRoom(Mongo_messageVO message) {
	     mongo.insert(message);
	 }
	
	 @Override
	 public List<Mongo_messageVO> getRoomMessages(String roomId) {
	     Query query = new Query(Criteria.where("roomId").is(roomId));
	     return mongo.find(query, Mongo_messageVO.class);
	 }
	 
}