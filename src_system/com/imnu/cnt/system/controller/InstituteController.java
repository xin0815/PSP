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
	private SysUserService sysUserService;
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
			Xiku xiku1 = xikuservice.findByid(id);
			//System.out.println(pageList.getTotalRecord());
			if (pageList != null) {
				model.addAttribute("pager", pageList);
				model.addAttribute("degree",xiku1.getName());
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
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public String delete(String ids, HttpServletResponse response,
			HttpServletRequest request) {

		try {
			sysUserService.batchDelete(ids);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return list(request);
	}

	/*
	 * 测试模块---跳到更新页面
	 */
	@RequestMapping(value = "toUpdate", method = RequestMethod.POST)
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
		return "system/institute_change";
	}
	@RequestMapping(value = "toUpdate1", method = RequestMethod.POST)
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
		return "system/institute_change1";
	}
	@RequestMapping(value = "resetPass", method = RequestMethod.POST)
	public String resetPass(String ids, HttpServletResponse response,
			HttpServletRequest request) {

		try {
			sysUserService.updateResetPassword(ids);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return list(request);
	}

	@RequestMapping(value = "checkUniqueAccount", method = RequestMethod.POST)
	public String checkUniqueAccount(HttpServletResponse response,
			HttpServletRequest request) {
		SysUser sysUser = new SysUser();
		if (!StringUtils.isEmpty(request.getParameter("userId"))) {
			sysUser.setUserId((Integer.valueOf(request.getParameter("userId"))));
		}
		sysUser.setAccount(request.getParameter("account"));
		try {
			boolean isSuccess = sysUserService.isUnique(SysUser.class, sysUser, "account");
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
	
	@RequestMapping(value = "checkOldPass", method = RequestMethod.POST)
	public String checkOldPass(HttpServletResponse response,
			HttpServletRequest request){
		Integer userId = Integer.valueOf(request.getParameter("userId"));
		String oldPassword = request.getParameter("oldPassword");
		try {
			SysUser sysUser = sysUserService.findSysUserById(userId);
			if(sysUser != null && oldPassword.equals(sysUser.getPassword())){
				response.getWriter().print("success");
			}
			response.getWriter().print("error");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "editPass", method = {RequestMethod.POST,RequestMethod.GET})
	public String editPass(SysUser sysUser, HttpServletResponse response,
			HttpServletRequest request){
		if(sysUser != null && sysUser.getUserId() != null && sysUser.getPassword() != null){
			try {
				String newPass = sysUser.getPassword();
				sysUser = sysUserService.findSysUserById(sysUser.getUserId());
				sysUser.setPassword(newPass);
				sysUserService.saveOrUpdateSysUser(sysUser);
				request.setAttribute("successInfo", "密码修改成功。");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "system/SysUser_editPass";
	}
	
	/**
	 * 用于角色关联用户时，查询出所有用户
	 * @param sysUser
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(value="queryAllUser")
	public String queryAllUser(SysUser sysUser,HttpServletResponse response, HttpServletRequest request) {
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		
		Pager pageList = null;
		try {
			pageList = sysUserService.findAllUser(sysUser, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pager", pageList);
		
		return "system/SysUser_allUser";
	}
	
}
