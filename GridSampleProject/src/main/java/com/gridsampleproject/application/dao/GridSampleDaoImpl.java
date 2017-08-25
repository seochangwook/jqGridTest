package com.gridsampleproject.application.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public class GridSampleDaoImpl implements GridSampleDao{

	@Override
	public List<Map<String, Object>> getSampleDataList(Map<String, Object> paramInfo) {
		//데이터 셋팅//
		System.out.println("page: " + paramInfo.get("page"));
		System.out.println("search name: " + paramInfo.get("name"));
		
		List<Map<String, Object>> datalist = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> datasize = new HashMap<String, Object>();
		
		if(paramInfo.get("name") != null){
			//조건값이 있는 경우//
			// Data Set - No DB//
			datasize.put("totcnt", "1");

			datalist.add(datasize);
			
			Map<String, Object> searchdata = new HashMap<String, Object>();

			searchdata.put("id", "6");
			searchdata.put("password", "3333");
			searchdata.put("name", "가나다");
			searchdata.put("empnum", "21099");

			datalist.add(searchdata);
			
			return datalist;
		} else if(paramInfo.get("name") == null){
			//조건값이 없으면 전체 검색//
			// Data Set - No DB//
			datasize.put("totcnt", "7");

			datalist.add(datasize);
			
			//if(paramInfo.get("page").equals("1")){
			Map<String, Object> data1 = new HashMap<String, Object>();

			data1.put("id", "1");
			data1.put("password", "1234");
			data1.put("name", "서창욱");
			data1.put("empnum", "21084");

			datalist.add(data1);

			Map<String, Object> data2 = new HashMap<String, Object>();

			data2.put("id", "2");
			data2.put("password", "5678");
			data2.put("name", "홍길동");
			data2.put("empnum", "21085");

			datalist.add(data2);
		//}
		
		//else if(paramInfo.get("page").equals("2")){
			Map<String, Object> data3 = new HashMap<String, Object>();

			data3.put("id", "3");
			data3.put("password", "1425");
			data3.put("name", "임꺽정");
			data3.put("empnum", "21086");

			datalist.add(data3);

			Map<String, Object> data4 = new HashMap<String, Object>();

			data4.put("id", "4");
			data4.put("password", "1111");
			data4.put("name", "김철수");
			data4.put("empnum", "21087");

			datalist.add(data4);
		//}
		
		//else if(paramInfo.get("page").equals("3")){
			Map<String, Object> data5 = new HashMap<String, Object>();

			data5.put("id", "5");
			data5.put("password", "2222");
			data5.put("name", "김영희");
			data5.put("empnum", "21088");

			datalist.add(data5);
			
			Map<String, Object> data6 = new HashMap<String, Object>();

			data6.put("id", "6");
			data6.put("password", "3333");
			data6.put("name", "가나다");
			data6.put("empnum", "21099");

			datalist.add(data6);
		//}

		//else if(paramInfo.get("page").equals("4")){
			Map<String, Object> data7 = new HashMap<String, Object>();

			data7.put("id", "7");
			data7.put("password", "4444");
			data7.put("name", "마바사");
			data7.put("empnum", "22000");

			datalist.add(data7);
		//}
		}
		
		return datalist;
	}
}
