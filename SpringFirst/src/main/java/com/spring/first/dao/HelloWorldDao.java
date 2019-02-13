package com.spring.first.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface HelloWorldDao {

	public List<Map<String, Object>> getList(Map<String, Object> hashMap) throws SQLException;
	
	public void create(Map<String, Object> hashMap) throws SQLException;
	
	public void remove(Map<String, Object> hashMap) throws SQLException;
	
	public void update(Map<String, Object> hashMap) throws SQLException;
	
	
}
