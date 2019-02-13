package com.spring.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.dao.HelloWorldDao;

@Repository
public class HelloWorldDaoImpl implements HelloWorldDao{
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String, Object>> getList(Map<String, Object> hashMap) throws SQLException {
		return sqlSessionTemplate.selectList((String) hashMap.get("queryId"), hashMap);
	}
	
	public void create(Map<String, Object> hashMap) throws SQLException {
    	sqlSessionTemplate.insert((String)hashMap.get("queryId"), hashMap);
    }

    public void update(Map<String, Object> hashMap) throws SQLException {
        sqlSessionTemplate.update((String)hashMap.get("queryId"), hashMap);
    }
    
    public void remove(Map<String, Object> hashMap) throws SQLException {
        sqlSessionTemplate.delete((String) hashMap.get("queryId"), hashMap);
    }
}
