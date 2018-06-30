package com.imnu.cnt.system.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

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
import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.service.SysPageService;
import com.imnu.cnt.system.util.ValidationUtils;

@Controller
@RequestMapping("sysPage")
public class SysPageController {

	@Resource
	private SysPageService sysPageService;
	
	/*
	 * 系统权限管理---菜单设置---单击导航跳到菜单设置页面
	 * */
	@RequestMapping(value="edit",method={RequestMethod.GET,RequestMethod.POST})
	public String edit(HttpServletResponse response, HttpServletRequest request) {
		
		String hql = "from SysModule m where m.isDeleted=0 ";
		List<SysModule> sysModuleList = null;
		try {
			sysModuleList = (List<SysModule>)sysPageService.findbyHql(hql);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("sysModuleList", sysModuleList);
		return "system/SysPage_edit";
		
	}
	/*
	 * 系统权限管理---菜单设置---进入菜单操作界面后自动加载菜单到页面
	 * */
	@RequestMapping(value="downloadTree",method={RequestMethod.GET})
	public void downloadTree(HttpServletResponse response, HttpServletRequest request) {
		
		// 角色关联菜单
		Document doc = null;
		try {
			doc = sysPageService.findPageTree();
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
	 * 系统权限管理---菜单设置---单击导航跳到菜单设置页面
	 * */
	@RequestMapping(value="editSysPage",method=RequestMethod.POST)
	public void editSysPage(HttpServletResponse response, HttpServletRequest request) {
		
		// 调用方法删除
		String id = request.getParameter("id");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (ValidationUtils.checkProperty(id)) {
			String message = null;
			try {
				message = sysPageService.findSysPage(new Integer(id));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ServiceException e) {
				e.printStackTrace();
			}
			out.print(message);
		} else {
			out.print("参数错误");
		}
		
		String hql = "from SysModule m where m.isDeleted=0 ";
		List<SysModule> sysModuleList = null;
		try {
			sysModuleList = (List<SysModule>)sysPageService.findbyHql(hql);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("sysModuleList", sysModuleList);
		
	}
	/*
	 * 系统权限管理---菜单设置---点击添加菜单打开添加菜单表格
	 * */
	@RequestMapping(value="findNextLevelCode",method=RequestMethod.POST)
	public void findNextLevelCode(HttpServletResponse response, HttpServletRequest request) {
		
		// 调用方法删除
		String selectedItemID = request.getParameter("selectedItemID");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (ValidationUtils.checkProperty(selectedItemID)) {
		
			String message = null;
			try {
				message = sysPageService.findNextLevelCode(selectedItemID);
			} catch (ServiceException e) {
				e.printStackTrace();
			}
			out.print(message);
		} else {
			out.print("参数错误");
		}
		
	}
	/*
	 * 系统权限管理---菜单设置---添加节点
	 * */
	@RequestMapping(value="newSysPage",method=RequestMethod.POST)
	public String newSysPage(SysPage page,HttpServletResponse response, HttpServletRequest request) {
		
		String selectedItemID = request.getParameter("selectedItemID");
		String errorInfo = null;
		try {
			sysPageService.newSysPage(page,selectedItemID);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("errorInfo", errorInfo);
		return edit(response,request);
	}
	/*
	 * 系统权限管理---菜单设置---添加子节点
	 * */
	@RequestMapping(value="newChildItem",method=RequestMethod.POST)
	public String newChildItem(SysPage page,HttpServletResponse response, HttpServletRequest request) {
		
		String selectedItemID = request.getParameter("selectedItemID");
		String message = null;
		try {
			sysPageService.newChildSysPage(page,selectedItemID);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("errorInfo", message);
		return edit(response,request);
	}
	/*
	 * 系统权限管理---菜单设置---删除节点
	 * */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	public void delete(HttpServletResponse response, HttpServletRequest request) {
		
		// 调用方法删除
		String id = request.getParameter("id");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (ValidationUtils.checkProperty(id)) {
			String message = null;
			try {
				message = sysPageService.deleteSysPage(new Integer(id));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			} catch (ServiceException e) {
				e.printStackTrace();
			}
			if(StringUtils.isEmpty(message)){
				message = "success";
			}
			out.print(message);
		} else {
			out.print("参数错误");
		}
	}
	/*
	 * 系统权限管理---菜单设置---更新方法
	 * */
	@RequestMapping(value="update",method=RequestMethod.POST)
	public String update(SysPage page,HttpServletResponse response, HttpServletRequest request) {
		
		// 填充对象属性
		String message = null;
		try {
			sysPageService.updateSysPage(page);
		} catch (ServiceException e) {
			e.printStackTrace();
		}
		request.setAttribute("errorInfo", message);
		return edit(response,request);
	}
	/*
	 * 系统权限管理---菜单设置---点击添加菜单打开添加菜单表格
	 * */
	@RequestMapping(value="findNextChildLevelCode",method=RequestMethod.POST)
	public void findNextChildLevelCode(SysPage page,HttpServletResponse response, HttpServletRequest request) {
		
		String selectedItemID = request.getParameter("selectedItemID");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (ValidationUtils.checkProperty(selectedItemID)) {
			String message = null;
			try {
				message = sysPageService.findNextChildLevelCode(selectedItemID);
			} catch (ServiceException e) {
				e.printStackTrace();
			}
			out.print(message);
		} else {
			out.print("参数错误");
		}
	}

}
