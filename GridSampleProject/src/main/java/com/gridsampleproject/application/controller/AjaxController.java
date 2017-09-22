package com.gridsampleproject.application.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.gridsampleproject.application.dao.UserInfoDao;
import com.gridsampleproject.application.model.UserInfo;
import com.gridsampleproject.application.service.GridSampleServiceImpl;
import com.gridsampleproject.application.util.GridUtil;
import com.gridsampleproject.application.util.MailUtil;

@RestController
public class AjaxController {
	@Autowired
	GridSampleServiceImpl gridsampleservice;
	@Autowired
	GridUtil gridutil;
	@Autowired
	MailUtil mailUtil;
	 @Autowired
	 UserInfoDao userInfoDao;
	
	//일반적인 ajax는 @RequestBody 형식으로 받는다.//
	@RequestMapping(value = "/datainfo.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> info(@RequestBody Map<String, Object> info) {	
		System.out.println("name: " + info.get("name") + " / empnum: " + info.get("empnum") + " / password: " + info.get("password"));
		
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		retVal.put("result", "success");
		
		return retVal;
	}
	
	//Data 설정(jqGrid에서 url데이터는 @RequestParam 형식으로 받는다.)//
	@RequestMapping(value = "/datalist.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> datainit(@RequestParam Map<String, Object> paramInfo) {
		//기본적으로 jqGrid는 url 즉 ajax통신을 할 시 "key:page"값을 넘겨준다.(@RequestParam로 설정)//
		return gridutil.gridDataSet(gridsampleservice.getSampleDataList(paramInfo), "1");
	}
	
	@RequestMapping(value = "/sendmail.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> sendmail(@RequestBody Map<String, Object> paramInfo) {
		//메일 서비스 호출//
		mailUtil.sendSimpleMessage(paramInfo.get("email").toString(), paramInfo.get("name").toString());
		
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//

		retVal.put("result", "success");
		
		return retVal;
	}
	
	@RequestMapping(value = "/jpatest.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> getUserInfo(@RequestBody Map<String, Object> paramInfo) {
		//DB서비스 호출//
		List<UserInfo> userlist = userInfoDao.findAll();

		for(int i=0; i<userlist.size(); i++){
			System.out.println("email: " + userlist.get(i).getUser_email());
		}
			
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//

		retVal.put("result", "success");
		
		return retVal;
	}
	
	@RequestMapping(value = "/jpatestsearch.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> searchUserEmail(@RequestBody Map<String, Object> paramInfo) {
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		userInfoDao.findAll(); //CRUD작업을 하기 전 JPA 데이터 초기화//
		
		//DB서비스 호출//
		try{
			List<UserInfo> usersearch = userInfoDao.findByUserEmail(paramInfo.get("userid").toString());
			
			if(usersearch.size() == 0){
				retVal.put("result", "fail");
			} else{
				System.out.println("email: " + usersearch.get(0).getUser_email());
				
				retVal.put("result", "success");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return retVal;
	}
	
	@RequestMapping(value = "/jpatestsearchemail.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> searchUserPhonenumber(@RequestBody Map<String, Object> paramInfo) {
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		userInfoDao.findAll(); //CRUD작업을 하기 전 JPA 데이터 초기화//
		
		//DB서비스 호출//
		try{
			List<UserInfo> usersearch = userInfoDao.findByUserPhoneNumber(paramInfo.get("useremail").toString(), paramInfo.get("userid").toString());
			
			if(usersearch.size() == 0){
				retVal.put("result", "fail");
			} else{
				System.out.println("phonenumber: " + usersearch.get(0).getUser_phonenumber());
				
				retVal.put("result", "success");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return retVal;
	}
	
	@RequestMapping(value = "/jpatestdeleteuser.do", method = RequestMethod.POST, produces = {"application/json"})
	public @ResponseBody Map<String, Object> deleteUser(@RequestBody Map<String, Object> paramInfo) {
		Map<String, Object> retVal = new HashMap<String, Object>(); //諛섑솚�븷 ���엯�쓽 �겢�옒�뒪瑜� �꽑�뼵//
		
		userInfoDao.findAll(); //CRUD작업을 하기 전 JPA 데이터 초기화//
		
		//DB서비스 호출//
		try{
			int result = userInfoDao.deleteUserById(paramInfo.get("userid").toString());
			
			if(result == 0){
				retVal.put("result", "fail");
			} else{
				System.out.println("delete success " + paramInfo.get("userid").toString());
				
				retVal.put("result", "success");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return retVal;
	}
}
