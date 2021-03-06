package com.spring.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
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
	public String helloWorld(Model model, HttpSession session, HttpServletRequest req) throws Exception {
		/*
		 * Map<String, Object> paramMap = new HashMap<String, Object>(); paramMap =
		 * requestParamMap(req);
		 * 
		 * List<Map<String, Object>> list = helloWorldService.selectList(paramMap);
		 * String h = ""; for (int i = 0; i < list.size(); i++) { h =
		 * "<tr><td style='width:20px'><input type='checkbox'/></td>" + "<td>" +
		 * list.get(i).get("ID") + "</td>" + "<td><input type='text' value='" +
		 * list.get(i).get("NAME") + "'/></td>" + "<td><input type='text' value='" +
		 * list.get(i).get("AGE") + "'/></td>" + "<td><input type='text' value='" +
		 * list.get(i).get("PHONE_NUM") + "'/></td>" + "<td><input type='email' value='"
		 * + list.get(i).get("EMAIL") + "'/></td>" +
		 * "<td><input type='text' onclick=\"sample2_execDaumPostcode()\" id=\"sample2_address\" placeholder=\"주소\" value='"
		 * + list.get(i).get("ADDRESS") + "'/></td>" +
		 * "<td><input type='button' value='save' onClick='javascript:onSave(this);'/></td></tr>"
		 * ; } model.addAttribute("h", h);
		 */
		return "hello";
	}

	@RequestMapping(value = "/select")
	public String helloList(Model model, HttpSession session, HttpServletRequest req) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = requestParamMap(req);

		List<Map<String, Object>> list = helloWorldService.selectList(paramMap);
		/*
		 * for (Map<String, Object> map : list) { for (Map.Entry<String, Object> entry :
		 * map.entrySet()) { String key = entry.getKey(); Object value =
		 * entry.getValue(); System.out.println(key); System.out.println(value); } }
		 */
		
		String h = "";
		for (int i = 0; i < list.size(); i++) {
			h = "<tr><td style='width:20px'><input type='checkbox'/></td>" + "<td>" + list.get(i).get("ID") + "</td>"
					+ "<td><input type='text' value='" + list.get(i).get("NAME") + "'/></td>"
					+ "<td><input type='text' value='" + list.get(i).get("AGE") + "'/></td>"
					+ "<td><input type='text' value='" + list.get(i).get("PHONE_NUM") + "'/></td>"
					+ "<td><input type='email' value='" + list.get(i).get("EMAIL") + "'/></td>"
					+ "<td><input type='text' onclick=\"sample2_execDaumPostcode()\" id=\"sample2_address\" placeholder=\"주소\" value='" + list.get(i).get("ADDRESS") + "'/></td>"
					+ "<td><input type='button' value='save' onClick='javascript:onSave(this);'/></td></tr>";
		}

		model.addAttribute("hello", helloWorldService.selectList(paramMap));
		model.addAttribute("h", h);

		return "jsonView";
	}

	@RequestMapping(value = "/create")
	public String helloInsert(Model model, HttpSession session, HttpServletRequest req) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = requestParamMap(req);
		helloWorldService.createList(paramMap);
		return "jsonView";
	}

	@RequestMapping(value = "/remove")
	public String helloDelete(Model model, HttpSession session, HttpServletRequest req) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap = requestParamMap(req);
		helloWorldService.removeList(paramMap);

		return "jsonView";
	}

	@RequestMapping(value = "/update")
	public String helloUpdate(Model model, HttpSession session, HttpServletRequest req) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap = requestParamMap(req);
		helloWorldService.updateList(paramMap);

		return "jsonView";
	}

	public Map<String, Object> requestParamMap(HttpServletRequest request) throws Exception {
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
		Enumeration<String> attributeNames = (Enumeration<String>) request.getAttributeNames();
		while (attributeNames.hasMoreElements()) {
			String key = (String) attributeNames.nextElement();
			Object obj = request.getAttribute(key);
			if (obj instanceof java.lang.String) {
				paramMap.put(key, obj);
			}
		}
		return paramMap;
	}
	
	public void listHtml(Model model, HttpSession session, HttpServletRequest req) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap = requestParamMap(req);

		List<Map<String, Object>> list = helloWorldService.selectList(paramMap);
		String h = "";
		for (int i = 0; i < list.size(); i++) {
			h = "<tr><td style='width:20px'><input type='checkbox'/></td>" + "<td>" + list.get(i).get("ID") + "</td>"
					+ "<td><input type='text' value='" + list.get(i).get("NAME") + "'/></td>"
					+ "<td><input type='text' value='" + list.get(i).get("AGE") + "'/></td>"
					+ "<td><input type='text' value='" + list.get(i).get("PHONE_NUM") + "'/></td>"
					+ "<td><input type='email' value='" + list.get(i).get("EMAIL") + "'/></td>"
					+ "<td><input type='text' onclick=\"sample2_execDaumPostcode()\" id=\"sample2_address\" placeholder=\"주소\" value='" + list.get(i).get("ADDRESS") + "'/></td>"
					+ "<td><input type='button' value='save' onClick='javascript:onSave(this);'/></td></tr>";
		}
		model.addAttribute("h", h);
	}
}