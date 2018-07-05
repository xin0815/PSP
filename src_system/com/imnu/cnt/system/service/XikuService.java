package com.imnu.cnt.system.service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Degre;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.util.Pager;

public interface XikuService extends BaseService {

	// 查找全部学院
	public <T> Pager findall(Xiku xiku, String currentPage, String pageSize) throws ServiceException;

	// 新增和修改学位
	public void saveOrUpdate(Xiku xiku) throws ServiceException;

	// 根据id查找
	public Xiku findByid(String code);

	// 模糊查询
	public Pager findByname(String name, String currentPage, String pageSize);
	
	//根据名字查找
	public Xiku findByname(String name);
}
