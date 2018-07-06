package com.imnu.cnt.system.service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Course;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.util.Pager;

public interface CourseService extends BaseService{

	
	// 查找全部学院
	public <T> Pager findall(Course course, String currentPage, String pageSize) throws ServiceException;

	// 新增和修改学位
	public void saveOrUpdate(Course course) throws ServiceException;

	// 根据id查找
	public Course findByid(String code);

	// 模糊查询
	public Pager findBynameorcode(String code,String name, String currentPage, String pageSize);
	
	//根据名字查找
	public Course findByname(String name);
}
