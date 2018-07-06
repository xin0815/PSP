package com.imnu.cnt.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Course;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.service.CourseService;
import com.imnu.cnt.system.util.Pager;

@Controller
@RequestMapping("course")
public class CourseController {

	
	@Autowired
	private CourseService courseService;
	@RequestMapping("list")
	public String list(HttpServletRequest request)
	{

		Course course = new Course();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		Pager pageList = null;
		Pager pageList1 = null;
		try {
			pageList = courseService.findall(course, currentPage, "20");
			pageList1 = courseService.findall(course, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);
		request.setAttribute("pager1", pageList1);
		return "system/course_list";		
	}
	@RequestMapping("query")
	public String query(String coursenum,String coursename,HttpServletRequest request,Model model) {
		Course course = new Course();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		String categoryId = request.getParameter("categoryId");
		Pager pageList = null;
		Pager pageList1 = null;
		if(coursenum!=""||coursename!="")
		{
			if(coursenum=="")
				coursenum = null;
			if(coursename=="")
				coursename=null;
			pageList = courseService.findBynameorcode(coursename,coursenum, currentPage, "20");
			System.out.println(pageList.getTotalRecord());
			//System.out.println(pageList.getTotalRecord());
			if (pageList != null) {
				model.addAttribute("pager", pageList);
				model.addAttribute("coursenum",coursenum);
				model.addAttribute("coursename",coursename);
				return "system/course_list";
			} else {
				return "system/course_list";
			}
			
		}
		else
		{
			try {
				pageList = courseService.findall(course, currentPage, "20");
				pageList1 = courseService.findall(course, currentPage, pageSize);
			} catch (ServiceException e) {
				e.printStackTrace();
			}
			if(pageList!=null&&pageList1!=null)
			{
			
				request.setAttribute("pager", pageList);
				request.setAttribute("pager1", pageList1);
				request.setAttribute("categoryId", categoryId);
			}
			return "system/course_list";
		}
	}
	@RequestMapping("update")
	public String update(String id,String name,HttpServletRequest request) throws ServiceException
	{		
		//System.out.println("11111111111111111111111111111111111111111");
		if(name==null||name.equals(""))
		{
			return list(request);
		}
		else
		{
			if(id==null||id=="")
			{
				return list(request);
			}
			else
			{
				//id = "0"+id;
				System.out.println(id);
				Course course = courseService.findByid(id);
				if(course!=null)
				{
					course.setCourseNumber(course.getCourseNumber());
					course.setCourseName(course.getCourseName());
					course.setCourseEnName(name);
					courseService.saveOrUpdate(course);
				}
			}
			return list(request);
		}		
	}
}
