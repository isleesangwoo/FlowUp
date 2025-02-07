package com.spring.app.commute.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.app.commute.model.CommuteDAO;

@Service
public class CommuteService_imple implements CommuteService {
	
	@Autowired
	private CommuteDAO dao;

	

	
}
