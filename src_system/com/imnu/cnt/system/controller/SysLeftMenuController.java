package com.imnu.cnt.system.controller;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.SysLeftMenuService;
import com.imnu.cnt.system.util.ValidationUtils;

@Controller
@RequestMapping("sysLeftMenu")
/*
 * 左边菜单控制器
 * */
public class SysLeftMenuController {
	
	@Resource(name="sysLeftMenuService")
	private SysLeftMenuService sysLeftMenuService;
	
	/*
	 * 后台首页左边菜单
	 * */
	@RequestMapping(value="findSysPageURL",method=RequestMethod.POST)
	public void findSysPageURL(HttpServletResponse response, HttpServletRequest request) {
		String id = request.getParameter("id");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (ValidationUtils.checkProperty(id)) {
			String message = sysLeftMenuService.findSysPageURL(id);
			out.print(message);
		} else {
			out.print("参数错误");
		}
	}
	/*
	 * 后台首页左边菜单
	 * */
	@RequestMapping(value="findContentTitle",method=RequestMethod.POST)
	public void findContentTitle(HttpServletResponse response, HttpServletRequest request) {
		String id = request.getParameter("id");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (ValidationUtils.checkProperty(id)) {
			String message = sysLeftMenuService
					.findContentTitle(id);
			out.print(message);
		} else {
			out.print("参数错误");
		}
	}
	/*
	 * 后台首页左边菜单
	 * */
	@RequestMapping(value="downloadTree",method=RequestMethod.GET)
	public void downloadTree(HttpServletResponse response, HttpServletRequest request) {
		SysUser user = (SysUser) request.getSession().getAttribute("user");
//		Document doc = sysLeftMenuService.findPageTree(user);
		Document doc = sysLeftMenuService.findPageTreeLevelCode(user);
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
}
