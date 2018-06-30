package com.imnu.cnt.system.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.MainService;
import com.imnu.cnt.system.service.SysLeftMenuService;
import com.imnu.cnt.system.service.SysModuleService;

@Controller
@RequestMapping("main")
/*
 * 前台主页面控制器 和 跳到登录页
 * */
public class MainController {
	
	@Resource(name = "mainService")
	MainService mainService;
	@Resource(name = "sysLeftMenuService")
	SysLeftMenuService sysLeftMenuService;
	

	/*
	 * 公共---跳到登录页
	 * */
	@RequestMapping("login")
	public String toAdd(HttpServletRequest request) {
		
		return "login";
	}
	
	/**
	 * 访问的菜单不在有效访问时间内，则转到该界面
	 * @param errorInfo
	 * @param request
	 * @return
	 */
	@RequestMapping("lose")
	public String lose(HttpServletRequest request) {
		return "lose";
	}
	
	/*
	 * 跳到后台主页面
	 * */
	@RequestMapping("index")
	public String toIndex(HttpServletRequest request) {
		SysUser user = (SysUser)request.getSession().getAttribute("user");
		//查找本系统有权限的菜单
		List<SysPage> menuList = sysLeftMenuService.findSysPage(user);
		request.setAttribute("menuList", menuList);
		return "main";
	}
	
	/*
	 * 跳到后台主页面
	 * */
	@RequestMapping("sanJiCaiDan")
	public String toSanJiCaiDan(HttpServletRequest request) {
		String pageId = request.getParameter("pageId");
		List list = sysLeftMenuService.findSysPage(Integer.valueOf(pageId));
		request.setAttribute("sysPageList", list);
		return "sanJiCaiDan";
	}
	/*
	 * 后台主页面的最上边的页面
	 * */
	@RequestMapping("top")
	public String toTop(HttpServletRequest request) {
		
		return "top";
	}
	/*
	 * 后台主页面的中间的页面
	 * */
	@RequestMapping("center")
	public String toCenter(HttpServletRequest request) {
		return "welcome";
	}
	/*
	 * 后台主页面的最下边的页面
	 * */
	@RequestMapping("down")
	public String toDown(HttpServletRequest request) {
		
		return "down";
	}
	/*
	 * 后台主页面的中间左边的页面
	 * */
	@RequestMapping("left")
	public String toLeft(HttpServletRequest request) {
		
		return "leftMenuTree";
	}
	/*
	 * 后台主页面的中间左边的页面
	 * */
	@RequestMapping("right")
	public String toRight(HttpServletRequest request) {
		
		return "right";
	}
	/*
	 * 跳到更新成功页
	 * */
	@RequestMapping("toUpdateSucc")
	public String toUpdateSucc(HttpServletRequest request) {
		
		return "common/update_succeeded";
	}
	

	
}
