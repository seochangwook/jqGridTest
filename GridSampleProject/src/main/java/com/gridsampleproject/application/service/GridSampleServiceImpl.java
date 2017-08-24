package com.gridsampleproject.application.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gridsampleproject.application.dao.GridSampleDaoImpl;

@Service
public class GridSampleServiceImpl implements GridSampleService{
	@Autowired
	GridSampleDaoImpl gridsampledao;
	
	@Override
	public List<Map<String, Object>> getSampleDataList(Map<String, Object> paramInfo) {
		
		return gridsampledao.getSampleDataList(paramInfo);
	}

}
