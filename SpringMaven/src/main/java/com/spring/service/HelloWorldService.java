package com.spring.service;

import java.util.List;
import java.util.Map;

public interface HelloWorldService {

	public List<Map<String, Object>> selectList(Map<String, Object> hashMap) throws Exception; 
	
	public void createList(Map<String, Object> hashMap) throws Exception; 
	
	public void removeList(Map<String, Object> hashMap) throws Exception; 
	
	public void updateList(Map<String, Object> hashMap) throws Exception; 
}
