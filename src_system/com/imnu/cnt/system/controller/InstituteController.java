package com.imnu.cnt.system.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Degre;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.service.SysUserService;
import com.imnu.cnt.system.service.XikuService;
import com.imnu.cnt.system.util.Pager;

@Controller
@RequestMapping("sysUser")
public class InstituteController {

	@Autowired
	private XikuService xikuservice;
	@RequestMapping("list")
	public String list(HttpServletRequest request) {

		Xiku xiku = new Xiku();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		Pager pageList = null;
		Pager pageList1 = null;
		try {
			pageList = xikuservice.findall(xiku, currentPage, "10");
			pageList1 = xikuservice.findall(xiku, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);
		request.setAttribute("pager1", pageList1);
		return "system/institute";
	}
	//分页
	@RequestMapping("query")
	public String query(String id,HttpServletRequest request,Model model) {
		Xiku xiku = new Xiku();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		String categoryId = request.getParameter("categoryId");
		Pager pageList = null;
		Pager pageList1 = null;
		if(id!="")
		{
			pageList = xikuservice.findByname(id, currentPage, "10");
			try {
				pageList1 = xikuservice.findall(xiku, currentPage, pageSize);
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Xiku xiku1 = xikuservice.findByid(id);
			//System.out.println(pageList.getTotalRecord());
			if (pageList != null&&xiku1!=null) {
				model.addAttribute("pager", pageList);
				model.addAttribute("degree",xiku1.getName());
				request.setAttribute("pager1", pageList1);
				return "system/institute";
			} else {
				return "system/institute";
			}
			
		}
		try {
			pageList = xikuservice.findall(xiku, currentPage, "10");
			pageList1 = xikuservice.findall(xiku, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		if(pageList!=null&&pageList1!=null)
		{
		
			request.setAttribute("pager", pageList);
			request.setAttribute("pager1", pageList1);
			request.setAttribute("categoryId", categoryId);
		}
		return "system/institute";
	}

	/*
	 * 
	 */
	@RequestMapping("toAdd")
	public String toAdd(String id,String name,HttpServletRequest request,Model model) throws ServiceException {
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
				try{
				   Integer a =  Integer.parseInt(id);
				   if(a>0&&a<=9)
				   {
					   id = "0"+id;
				   }
				  }catch(NumberFormatException e)
				  {
					  return list(request);
				  }

				Xiku xiku = xikuservice.findByid(id);
				if(xiku!=null)
				{
					xiku.setCode(xiku.getCode());
					xiku.setEnname(name);
					xiku.setName(xiku.getName());
					xiku.setXuhao(xiku.getXuhao());
					xikuservice.saveOrUpdate(xiku);
				}
			}
			return list(request);
		}
	}
}
