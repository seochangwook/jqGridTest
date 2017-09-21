package com.gridsampleproject.application.dao;

import java.util.List;
import java.util.Map;

public interface GridSampleDao {
	public List<Map<String, Object>> getSampleDataList(Map<String, Object> paramInfo);
	
}
