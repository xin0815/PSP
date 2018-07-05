package com.imnu.cnt.system.service;

import java.util.List;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Degre;
import com.imnu.cnt.system.util.Pager;

public interface DegreeService extends BaseService{

	//查找全部学位
	public <T> Pager findall(Degre degree,String currentPage,String pageSize) throws ServiceException;
	
	//新增和修改学位
	public void saveOrUpdate(Degre degree)throws ServiceException;
	
	//根据id差早
	public Degre findByid(Integer DID);
	
	//模糊查询
	public Pager findByname(String name,String currentPage,String pageSize);
	
	
}
