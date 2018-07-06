package com.imnu.cnt.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Course;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.service.CourseService;
import com.imnu.cnt.system.util.Pager;

@Service("CourseService")
public class CourseServiceImpl extends BaseServiceImpl implements CourseService{

	@Override
	public <T> Pager findall(Course course, String currentPage, String pageSize) throws ServiceException {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Course c ");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

	@Override
	public void saveOrUpdate(Course course) throws ServiceException {
		// TODO Auto-generated method stub
		baseDao.saveOrUpdate(course);
		
	}

	@Override
	public Course findByid(String code) {
		// TODO Auto-generated method stub
		List<Course> list =  baseDao.find("from Course where courseNumber = ?", code);
		if(list.size()>0 && list != null){
			return list.get(0);
		}
		else
			return null;
	}

	@Override
	public Pager findBynameorcode(String name,String code, String currentPage, String pageSize) {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Course c where c.courseName like ? and c.courseNumber like ?");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize,"%"+name+"%","%"+code+"%");
	}

	@Override
	public Course findByname(String name) {
		List<Course> list =  baseDao.find("from Course where courseNumber = ?", name);
		if(list.size()>0 && list != null){
			return list.get(0);
		}
		else
			return null;
	}
	

}
