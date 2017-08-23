package com.gridsampleproject.application.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AjaxController {
	@RequestMapping(value = "/ajaxtest", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> makerepo(@RequestBody Map<String, Object> info) {	
		System.out.println("name: " + info.get("name") + " / empnum: " + info.get("empnum") + " / password: " + info.get("password"));
		
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success!!");
		
		return retVal;
	}
	
	//Data 설정//
	@RequestMapping(value = "/datalist.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> datainit(@RequestBody Map<String, Object> info) {	
		System.out.println("page: " + info.get("page"));
		
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success!!");
		
		return retVal;
	}
}
