package com.imnu.cnt.system.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysRole;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.PowerService;
import com.imnu.cnt.system.service.SysRoleService;
import com.imnu.cnt.system.service.SysUserService;
import com.imnu.cnt.system.util.Pager;

@Controller
@RequestMapping("power")
public class PowerController {
	
	@Resource(name = "powerService")
	PowerService powerService;
	@Resource(name = "sysRoleService")
	SysRoleService sysRoleService;
	@Resource(name = "sysUserService")
	SysUserService sysUserService;
	
	//转向权限分配页面   此页面包含  按角色分配，按用户分配，按分组分配的三个iframe
	@RequestMapping(value="main",method=RequestMethod.GET)
	public String main(HttpServletRequest request,HttpServletResponse response) {
		
		return "system/Power_main";
	}
	
	//按角色分配权限的选项卡
	@RequestMapping(value="role",method=RequestMethod.GET)
	public String role(HttpServletRequest request,HttpServletResponse response) {
		return "system/Power_role";
	}
	//按分组分配权限的选项卡
	@RequestMapping(value="group",method=RequestMethod.GET)
	public String group(HttpServletRequest request,HttpServletResponse response) {
		return "system/Power_group";
	}
	//按用户分配权限的选项卡
	@RequestMapping(value="user",method=RequestMethod.GET)
	public String user(HttpServletRequest request,HttpServletResponse response) {
		return "system/Power_user";
	}
	//查询角色  iframe
	@RequestMapping(value="findRole")
	public String findRole(HttpServletRequest request,HttpServletResponse response) {
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
		request.setAttribute("pagelist", pageList);
		return "system/Power_findRole";
	}
	
	
	//查询用户  iframe
	@RequestMapping(value="findUser")
	public String findUser(HttpServletRequest request,HttpServletResponse response) {
		SysUser sysUser = new SysUser();
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");

		Pager pageList = null;
		try {
			String userName = request.getParameter("userName");
			if(!StringUtils.isEmpty(userName)){
				sysUser.setUserName(userName);
				request.setAttribute("userName", userName);
			}
			pageList = sysUserService.find(sysUser, currentPage, pageSize);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("pagelist", pageList);
		return "system/Power_findUser";
	}
	
	/*
	 * 系统权限管理---角色管理---菜单关联维护---加载树型菜单
	 */
	@RequestMapping(value="downloadTree",method=RequestMethod.GET)
	public void downloadTree(HttpServletRequest request,HttpServletResponse response) {
	
		String type = request.getParameter("type");
		// 角色关联菜单
		String id = request.getParameter("id");
		Document doc = null;
		try {
			if("role".equals(type)){
				doc = powerService.findPageTreeByRole(new Integer(id));
			}else if ("user".equals(type)) {
				doc = powerService.findPageTreeByUser(new Integer(id));
			}else if("group".equals(type)){
				doc = powerService.findPageTreeByGroup(new Integer(id));
			}
			
		} catch (NumberFormatException e1) {
			e1.printStackTrace();
		} catch (ServiceException e1) {
			e1.printStackTrace();
		}
		response.reset();
		BufferedOutputStream bos = null;
		OutputStream os = null;
		try {
			//response.setContentType("application/x-msdownload");//非ie浏览器读取xml报错
            response.setContentType("text/xml;charset=UTF-8"); 
			response.setHeader("Content-disposition",
					"attachment; filename=tree.xml");
			bos = new BufferedOutputStream(response.getOutputStream());
			OutputFormat xmlFormat = new OutputFormat();
			xmlFormat.setEncoding("UTF-8");
			os = response.getOutputStream();
			bos = new BufferedOutputStream(os);
			XMLWriter xmlWriter = new XMLWriter(bos, xmlFormat);
			xmlWriter.write(doc);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (bos != null)
					bos.close();
				if (os != null)
					os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/*
	 * 保存权限配置
	 * */
	@RequestMapping(value="pageUpdate",method=RequestMethod.POST)
	public String pageUpdate(HttpServletRequest request,HttpServletResponse response) {
	
		String idlist = request.getParameter("id");
		String sysObjID = request.getParameter("SysObjID");
		String type = request.getParameter("type");
		String errorInfo = null;
		try {
			if("role".equals(type)){
				powerService.updateSysRolePage(idlist, sysObjID);
				return "system/Power_role";
			}else if ("user".equals(type)) {
				 powerService.updateSysUserPage(idlist, sysObjID);
				return "system/Power_user";
			}
			
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
