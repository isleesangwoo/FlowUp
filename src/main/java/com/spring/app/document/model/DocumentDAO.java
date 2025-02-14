package com.spring.app.document.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDAO {

	List<Map<String, String>> test();

}
