package com.imnu.cnt.system.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.SysUserService;
import com.imnu.cnt.system.util.Pager;

@Controller
@RequestMapping("sysUser")
public class ProfessionalController {


	@Resource(name = "sysUserService")
	SysUserService sysUserService;
	@RequestMapping("list1")
	public String list1(HttpServletRequest request) {

		SysUser sysUser = new SysUser();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");


		Pager pageList = null;
		try {
			pageList = sysUserService.find(sysUser, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);

		return "system/Professional";
	}
	@RequestMapping("Query")
	public String query(HttpServletRequest request) {
		SysUser sysUser = new SysUser();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		String categoryId = request.getParameter("categoryId");
		Pager pageList = null;
		try {
			String userName = request.getParameter("userName");
			if (!StringUtils.isEmpty(userName)) {
				sysUser.setUserName(userName);
				request.setAttribute("userName", userName);
			}
			pageList = sysUserService.find(sysUser, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);
		request.setAttribute("categoryId", categoryId);
		request.setAttribute("expEngagedSub", request
				.getParameter("expEngagedSub"));
		request.setAttribute("expMajor", request.getParameter("expMajor"));
		return "system/Professional";
	}
	@RequestMapping(value = "toupdate", method = RequestMethod.POST)
	public String toUpdate(String updId, HttpServletResponse response,
			HttpServletRequest request) throws ServiceException {

		SysUser sysUser = null;
		try {
			sysUser = sysUserService.findSysUserById(Integer.parseInt(updId));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("sysUser", sysUser);
		String userTypeCode = request.getParameter("userTypeCode");
		return "system/Professional_change";
	}
	@RequestMapping(value = "toupdate1", method = RequestMethod.POST)
	public String toUpdate1(String updId, HttpServletResponse response,
			HttpServletRequest request) throws ServiceException {

		SysUser sysUser = null;
		try {
			sysUser = sysUserService.findSysUserById(Integer.parseInt(updId));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("sysUser", sysUser);
		String userTypeCode = request.getParameter("userTypeCode");
		return "system/Professional_change1";
	}
}
