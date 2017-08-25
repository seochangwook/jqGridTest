package com.gridsampleproject.application.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gridsampleproject.application.service.GridSampleServiceImpl;
import com.gridsampleproject.application.util.GridUtil;

@RestController
public class AjaxController {
	@Autowired
	GridSampleServiceImpl gridsampleservice;
	@Autowired
	GridUtil gridutil;
	
	//일반적인 ajax는 @RequestBody 형식으로 받는다.//
	@RequestMapping(value = "/datainfo.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> info(@RequestBody Map<String, Object> info) {	
		System.out.println("name: " + info.get("name") + " / empnum: " + info.get("empnum") + " / password: " + info.get("password"));
		
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success!!");
		
		return retVal;
	}
	
	//Data 설정(jqGrid에서 url데이터는 @RequestParam 형식으로 받는다.)//
	@RequestMapping(value = "/datalist.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> datainit(@RequestParam Map<String, Object> paramInfo) {
		//기본적으로 jqGrid는 url 즉 ajax통신을 할 시 "key:page"값을 넘겨준다.(@RequestParam로 설정)//
		return gridutil.gridDataSet(gridsampleservice.getSampleDataList(paramInfo), "1");
	}
}
