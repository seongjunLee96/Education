package com.spring.first.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.first.dao.HelloWorldDao;
import com.spring.first.service.HelloWorldService;

@Service
public class HelloWorldServiceImpl implements HelloWorldService {

	@Autowired
	private HelloWorldDao helloWorldDao;
	
	@Override
	public List<Map<String, Object>> selectList(Map<String, Object> hashMap) throws Exception {
		
		hashMap.put("queryId", 	"SqlHelloWorld.selectUser");
		return helloWorldDao.getList(hashMap);
	}
	
	@Override
	public void createList(Map<String, Object> hashMap) throws Exception {
		
		hashMap.put("queryId", 	"SqlHelloWorld.createUser");
		helloWorldDao.create(hashMap);
	}
	
	@Override
	public void removeList(Map<String, Object> hashMap) throws Exception {
		
		hashMap.put("queryId", 	"SqlHelloWorld.removeUser");
		helloWorldDao.remove(hashMap);
	}
	
	@Override
	public void updateList(Map<String, Object> hashMap) throws Exception {
		
		hashMap.put("queryId", 	"SqlHelloWorld.updateUser");
		helloWorldDao.update(hashMap);
	}
	
}
