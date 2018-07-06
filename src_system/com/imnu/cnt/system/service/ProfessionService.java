package com.imnu.cnt.system.service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.model.Zyek;
import com.imnu.cnt.system.util.Pager;

public interface ProfessionService extends BaseService{

	//查找全部专业
	public <T> Pager findall(Zyek zyek,String currentPage,String pageSize) throws ServiceException;
	
	
	// 新增和修改学位
	public void saveOrUpdate(Zyek zyek) throws ServiceException;

	
	// 根据id查找
	public Zyek findByid(String code);

	// 模糊查询
	public Pager findByname(String name, String currentPage, String pageSize);
	
	//根据名字查找
	public Zyek findByname(String name);
}
