package com.spring.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.service.HelloWorldService;

@Controller
public class HelloWorld {
	
	@Autowired
	private HelloWorldService helloWorldService;
	
    @RequestMapping(value = "/")
	public String helloWorld(Model model, HttpSession session, HttpServletRequest req) throws Exception{
		return "hello";
	}
    
    @RequestMapping(value ="/select")
    public String helloList(Model model, HttpSession session, HttpServletRequest req) throws Exception{
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	paramMap = requestParamMap(req);
    	//System.out.println(paramMap);
    	model.addAttribute("hello",helloWorldService.selectList(paramMap));
    	
    	return "jsonView";
    }
    
    @RequestMapping(value ="/create")
    public String helloInsert(Model model, HttpSession session, HttpServletRequest req) throws Exception{
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	paramMap.put("USER_ID", req.getParameter("USER_ID"));
    	paramMap.put("USER_NAME", req.getParameter("USER_NAME"));
    	paramMap.put("USER_DEP", req.getParameter("USER_DEP"));
    	paramMap.put("USER_GENDER", req.getParameter("USER_GENDER"));
    	paramMap.put("USER_AGE", req.getParameter("USER_AGE"));
    	
    	helloWorldService.createList(paramMap);
    	
    	return "jsonView";
    }
    
    @RequestMapping(value ="/remove")
    public String helloDelete(Model model, HttpSession session, HttpServletRequest req) throws Exception{
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	paramMap = requestParamMap(req);
    	helloWorldService.removeList(paramMap);
    	
    	return "jsonView";
    }
    
    @RequestMapping(value ="/update")
    public String helloUpdate(Model model, HttpSession session, HttpServletRequest req) throws Exception{
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	
    	paramMap = requestParamMap(req);
    	helloWorldService.updateList(paramMap);
    	
    	return "jsonView";
    }
    
    
    
    public Map<String, Object> requestParamMap(HttpServletRequest request) throws Exception{
    	Map<String, Object> paramMap = new HashMap<String, Object>();

        Enumeration<String> e = request.getParameterNames();
        while (e.hasMoreElements()) {
            String key = e.nextElement();
            String[] values = request.getParameterValues(key);
            if (values.length == 1) {
                paramMap.put(key, values[0].trim());
            } else {
                paramMap.put(key, values);
            }
        }
        
        /** Push Map to Request Attribute **/
        Enumeration<String>	attributeNames = (Enumeration<String>)request.getAttributeNames();
		while (attributeNames.hasMoreElements()) {
			String key = (String) attributeNames.nextElement();
			Object obj = request.getAttribute(key);
			if(obj instanceof java.lang.String){
				paramMap.put(key, obj);
			}
		}
		return paramMap;
	}
}