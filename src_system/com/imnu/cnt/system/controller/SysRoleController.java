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
import com.imnu.cnt.system.model.SysRole;
import com.imnu.cnt.system.model.SysUserRole;
import com.imnu.cnt.system.service.SysRoleService;
import com.imnu.cnt.system.util.Pager;

@Controller
@RequestMapping("sysRole")
public class SysRoleController {
	
	@Resource(name = "sysRoleService")
	SysRoleService sysRoleService;
	
	@RequestMapping("list")
	public String list(HttpServletRequest request) {
		
		SysRole sysRole = new SysRole();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");

		Pager pageList = null;
		try {
			pageList = sysRoleService.find(sysRole, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);
		
		return "system/SysRole_list";
	}
	
	@RequestMapping("query")
	public String query(HttpServletRequest request) {
		
		SysRole sysRole = new SysRole();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		Pager pageList = null;
		try {
			String roleName = request.getParameter("roleName");
			if(!StringUtils.isEmpty(roleName)){
				sysRole.setRoleName(roleName);
				request.setAttribute("roleName", roleName);
			}
			pageList = sysRoleService.find(sysRole, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);
		
		return "system/SysRole_list";
	}
	
	/*
	 *	
	 * */
	@RequestMapping("toAdd")
	public String toAdd(HttpServletRequest request) {
		return "system/SysRole_add";
	}
	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(SysRole sysRole,HttpServletResponse response, HttpServletRequest request) {
		try {
			String id = request.getParameter("roleId");
			if(!StringUtils.isEmpty(id)){
				sysRole.setRoleId(Integer.valueOf(id));
			}
			sysRole.setIsDeleted(false);
			sysRoleService.saveOrUpdateSysRole(sysRole);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return list(request);
	}
	
	@RequestMapping(value="delete",method=RequestMethod.POST)
	public String delete(String ids,HttpServletResponse response, HttpServletRequest request) {
		
		try {
			sysRoleService.batchDelete(ids);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return list(request);
	}
	
	@RequestMapping(value="toUpdate",method=RequestMethod.POST)
	public String toUpdate(String updId,HttpServletResponse response, HttpServletRequest request) {
		
		SysRole role = null;
		try {
			role = sysRoleService.findSysRoleById(Integer.parseInt(updId));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("sysRole", role);
		return "system/SysRole_add";
	}
	
	@RequestMapping("queryRelationUser")
	public String queryRelationUser(HttpServletRequest request) {
		String roleId = request.getParameter("_roleId");
		List<SysUserRole> userRoleList = Collections.EMPTY_LIST;
		try {
			userRoleList = (List<SysUserRole>)sysRoleService.findSysUserRole(Integer.valueOf(roleId));
			SysRole sysRole = sysRoleService.findSysRoleById(Integer.valueOf(roleId));
			request.setAttribute("sysRole", sysRole);
		}catch (ServiceException e) {
			e.printStackTrace();
		}
		//设置群用户在页面上的显示值和ID
		String _relationUserIds ="";
		if(userRoleList != null && !userRoleList.isEmpty()){
			for(int i=0;i<userRoleList.size();i++){
				_relationUserIds += userRoleList.get(i).getSysUser().getUserId()+",";
			}
		}
		request.setAttribute("_relationUserIds", _relationUserIds);
		request.setAttribute("userRoleList", userRoleList);
		return "system/SysRole_relationUser";
	}
	
	@RequestMapping("saveRelationUser")
	public String saveRelationUser(HttpServletRequest request) {
		try {
			String _relationUserIds = request.getParameter("_relationUserId");
			Integer roleId = Integer.valueOf(request.getParameter("roleId"));
			sysRoleService.saveOrUpdateRelationUser(roleId, _relationUserIds);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return list(request);
	}
	
	@RequestMapping(value = "isUniqueRoleName", method = RequestMethod.POST)
	public String isUniqueRoleName(HttpServletResponse response,
			HttpServletRequest request) {
		SysRole sysRole = new SysRole();
		if (!StringUtils.isEmpty(request.getParameter("roleId"))) {
			sysRole.setRoleId((Integer.valueOf(request.getParameter("roleId"))));
		}
		sysRole.setRoleName(request.getParameter("roleName"));
		try {
			boolean isSuccess = sysRoleService.isUnique(SysRole.class, sysRole, "roleName");
			if (isSuccess) {
				response.getWriter().print("success");
			} else {
				response.getWriter().print("error");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
