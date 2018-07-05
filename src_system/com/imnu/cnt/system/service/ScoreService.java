package com.imnu.cnt.system.service;

import java.util.Map;

public interface ScoreService extends BaseService {
	Map<String, Object > exportExcel(String stuNumber);
}
