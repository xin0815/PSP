package com.imnu.cnt.system.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.model.Zyek;
import com.imnu.cnt.system.service.ProfessionService;
import com.imnu.cnt.system.util.Pager;

@Controller
@RequestMapping("professional")
public class ProfessionalController {

	@Autowired
	private ProfessionService professionServce;
	@RequestMapping("list1")
	public String list1(HttpServletRequest request) {

		Zyek zyek = new Zyek();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");


		Pager pageList = null;
		try {
			pageList = professionServce.findall(zyek, currentPage, "10");
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);

		return "system/Professional";
	}
	@RequestMapping("Query")
	public String query(String profession,HttpServletRequest request,Model model) {
		Zyek zyek = new Zyek();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		String categoryId = request.getParameter("categoryId");
		Pager pageList = null;
		Pager pageList1 = null;
		if(profession!=""||profession!=null)
		{
			pageList = professionServce.findByname(profession, currentPage, "10");
			//System.out.println(pageList.getTotalPage());
			//Zyek zyek1 = professionServce.findByid(profession);
			if (pageList != null) {
				model.addAttribute("pager", pageList);
				model.addAttribute("degree",profession);
				return "system/Professional";
			} else {
				return "system/Professional";
			}
			
		}
		else
		{
			{
				try {
					pageList = professionServce.findall(zyek, currentPage, "10");					
				} catch (ServiceException e) {
					e.printStackTrace();
				}
				if(pageList!=null&&pageList1!=null)
				{
					
					request.setAttribute("pager", pageList);
					request.setAttribute("categoryId", categoryId);
				}
				return "system/Professional";
			}
		}
	}
	
	@RequestMapping("toAdd")
	public String toAdd(String id,String name,HttpServletRequest request,Model model) throws ServiceException {
		if(name==null||name.equals(""))
		{
			return list1(request);
		}
		else
		{
			if(id==null||id=="")
			{
				return list1(request);
			}
			else
			{
				try{
				   Integer a =  Integer.parseInt(id);
				   if(a>0&&a<=9)
				   {
					   id = "0"+id;
				   }
				  }catch(NumberFormatException e)
				  {
					  return list1(request);
				  }

				Zyek zyek = professionServce.findByid(id);
				if(zyek!=null)
				{
					zyek.setCode(zyek.getCode());
					zyek.setEnName(name);
					zyek.setGCode(zyek.getGCode());
					zyek.setName(zyek.getName());
					professionServce.saveOrUpdate(zyek);
				}
			}
			return list1(request);
		}
	}

}
