package com.spring.app.calendar.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CalendarDAO {

	List<Map<String, String>> test();

}
