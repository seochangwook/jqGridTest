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
		
		List<Map<String, Object>> datalist = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> datasize = new HashMap<String, Object>();

		// Data Set - No DB//
		datasize.put("totcnt", "5");

		datalist.add(datasize);

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

		Map<String, Object> data5 = new HashMap<String, Object>();

		data5.put("id", "5");
		data5.put("password", "2222");
		data5.put("name", "김영희");
		data5.put("empnum", "21088");

		datalist.add(data5);
		
		return datalist;
	}
}
