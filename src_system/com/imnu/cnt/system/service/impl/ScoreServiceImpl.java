package com.imnu.cnt.system.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.imnu.cnt.system.service.ScoreService;
@Service
public class ScoreServiceImpl extends BaseServiceImpl implements ScoreService {

	@Override
	public Map<String, Object> exportExcel(String stuNumber) {
		// TODO Auto-generated method stub
		Map<String,Object> beans = new HashMap<String,Object>();
        return beans;
	}

}
