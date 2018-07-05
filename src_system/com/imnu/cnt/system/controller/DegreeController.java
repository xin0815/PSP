package com.imnu.cnt.system.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Degre;
import com.imnu.cnt.system.service.DegreeService;
import com.imnu.cnt.system.util.Pager;

@Controller
@RequestMapping("sysModule")
public class DegreeController {

	@Autowired
	private DegreeService degreeservice;

	@RequestMapping("list")
	public String findall(String pageSize, String currentPage, HttpServletRequest request) throws ServiceException {
		Degre degree = new Degre();
		Pager pageList = null;
		// System.out.println(pageSize);
		// System.out.println(currentPage);
		pageList = degreeservice.findall(degree, currentPage, "10");
		// System.out.println(pageList.getTotalRecord());
		// System.out.println(pageList.getTotalPage());
		// System.out.println(pageList.getPageSize());
		// System.out.println(pageList.getCurrentPage());
		if (pageList != null) {
			request.setAttribute("pager", pageList);
			return "system/degree_list";
		} else {
			return "system/degree_list";
		}
	}

	@RequestMapping("toAdd")
	public String toadd(Integer id, Model model) {
		//System.out.println(id);

		Degre degree = degreeservice.findByid(id);
		if (degree != null)
			model.addAttribute("degree", degree);
		else
			System.out.println("no");
		return "system/degree_add";
	}

	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String add(Degre degree, String DID, HttpServletRequest request) throws ServiceException {
		// System.out.println("123");
		try {
			if (!StringUtils.isEmpty(DID)) {
				degree.setDID(Integer.valueOf(DID));
			}
			degree.setDNAME(degree.getDNAME());
			degree.setDNAME1(degree.getDNAME1());
			degree.setIs_deleted(0);
			degreeservice.saveOrUpdate(degree);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return findall(null, null, request);
	}

	@RequestMapping("del")
	public String del(Integer id, Model model, HttpServletRequest request) throws ServiceException {
		Degre degree = degreeservice.findByid(id);
		if (degree.getDID() != null) {
			degree.setIs_deleted(1);
			degreeservice.saveOrUpdate(degree);
		}
		return findall(null, null, request);

	}
	//分页
	@RequestMapping("query")
	public String query(HttpServletRequest request,String degreename,Model model) {
		Degre degree = new Degre();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		String categoryId = request.getParameter("categoryId");
		Pager pageList = null;
		if(degreename!="")
		{
			pageList = degreeservice.findByname(degreename, currentPage, "10");
			//System.out.println(pageList.getTotalRecord());
			if (pageList != null) {
				model.addAttribute("pager", pageList);
				model.addAttribute("degree", degreename);
				return "system/degree_list";
			} else {
				return "system/degree_list";
			}
			
		}
		else{
		try {
			pageList = degreeservice.findall(degree, currentPage, "10");
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);
		request.setAttribute("categoryId", categoryId);
		}
		return "system/degree_list";
	}

	@RequestMapping("findByname")
	public String findByname(String degreename, String currentPage, Model model) throws ServiceException {

		Degre degree = new Degre();
		Pager pageList = null;
		if (degreename == "") {
			pageList = degreeservice.findall(degree, currentPage, "10");
			if (pageList != null) {
				model.addAttribute("pager", pageList);
				return "system/degree_list";
			} else {
				return "system/degree_list";
			}

		} else {
			pageList = degreeservice.findByname(degreename, currentPage, "10");
			//System.out.println(pageList.getTotalRecord());
			if (pageList != null) {
				model.addAttribute("pager", pageList);
				return "system/degree_list";
			} else {
				return "system/degree_list";
			}
		}
	}

}
