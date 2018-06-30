package com.imnu.cnt.system.controller;

import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.service.SysModuleService;

@Controller
@RequestMapping("sysModule")
public class SysModuleController {
	
	@Resource(name = "sysModuleService")
	SysModuleService sysModuleService;
	
	@RequestMapping("list")
	public String list(HttpServletRequest request) {
		
		SysModule sysModule = new SysModule();
//		String pageSize = request.getParameter("pageSize");
//		String currentPage = request.getParameter("currentPage");

//		Pager pageList = null;
		List sysModuleList = Collections.EMPTY_LIST;
		try {
//			pageList = sysModuleService.find(sysModule, currentPage, pageSize);
			sysModuleList = sysModuleService.find(sysModule);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
//		request.setAttribute("pagelist", pageList);
		request.setAttribute("sysModuleList", sysModuleList);
		
		return "system/SysModule_list";
	}
	
	@RequestMapping("query")
	public String query(HttpServletRequest request) {
		
		SysModule sysModule = new SysModule();
//		String pageSize = request.getParameter("pageSize");
//		String currentPage = request.getParameter("currentPage");

//		Pager pageList = null;
		List sysModuleList = Collections.EMPTY_LIST;
		try {
			String name = request.getParameter("name");
			if(!StringUtils.isEmpty(name)){
				sysModule.setName(name);
				request.setAttribute("name", name);
			}
			sysModuleList = sysModuleService.find(sysModule);
//			pageList = sysModuleService.find(sysModule, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
//		request.setAttribute("pagelist", pageList);
		request.setAttribute("sysModuleList", sysModuleList);
		return "system/SysModule_list";
	}
	
	/*
	 *	
	 * */
	@RequestMapping("toAdd")
	public String toAdd(HttpServletRequest request) {
		return "system/SysModule_add";
	}
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(SysModule sysModule,HttpServletResponse response, HttpServletRequest request) {
		String id = request.getParameter("moduleId");
		if(!StringUtils.isEmpty(id)){
			sysModule.setModuleId(Integer.valueOf(id));
		}
		sysModule.setIsDeleted(false);
		sysModuleService.saveOrUpdateSysModule(sysModule);
		return list(request);
	}
	
	@RequestMapping(value="delete",method=RequestMethod.POST)
	public String delete(String ids,HttpServletResponse response, HttpServletRequest request) {
		try {
			sysModuleService.batchDelete(ids);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return list(request);
	}
	
	/*
	 * 测试模块---跳到更新页面
	 * */
	@RequestMapping(value="toUpdate",method=RequestMethod.POST)
	public String toUpdate(String updId,HttpServletResponse response, HttpServletRequest request) {
		
		SysModule sysModule = null;
		try {
			sysModule = sysModuleService.findSysModuleById(Integer.parseInt(updId));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("sysModule", sysModule);
		return "system/SysModule_add";
	}
	
}
