package com.imnu.cnt.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.SysLeftMenuService;
import com.imnu.cnt.system.service.SysModuleService;
import com.imnu.cnt.system.util.ValidationUtils;

@Controller
@RequestMapping("sysMenu")
/*
 * right显示导航控制器
 * */
public class SysMenuController {
	
	@Resource(name="sysLeftMenuService")
	private SysLeftMenuService sysLeftMenuService;
	@Resource(name = "sysModuleService")
	SysModuleService sysModuleService;

	@RequestMapping(value="showMenu",method=RequestMethod.GET)
	public String showMenu(HttpServletResponse response, HttpServletRequest request) {
		String levelCode = request.getParameter("levelCode");
		SysUser user = (SysUser) request.getSession().getAttribute("user");

		SysPage page = sysLeftMenuService.findPage(levelCode, user);
		if (ValidationUtils.checkProperty(page)
				&& ValidationUtils.checkProperty(user)) {
			if (ValidationUtils.checkProperty(page.getUrl())) {
				String url = "";
				if (page.getSysModule().getUrl().equals(
						request.getContextPath().replace("/", ""))) {
					url = "/" + page.getUrl();
				} else {
					url = "../" + page.getSysModule().getUrl() + "/"
							+ page.getUrl();
				}
				return page.getUrl();
			} 
//			else if (page.getSysPages().size() == 0) { // 最后一级菜单
//				if (levelCode.length() > 2) {
//					page = sysLeftMenuService.findPage(levelCode.substring(0,
//							levelCode.length() - 2), user);
//					if (ValidationUtils.checkProperty(page)) {
//						while (page.getSysPages().size() < 3) {
//							page.getSysPages().add(null);
//						}
//						request.setAttribute("sysPages", page.getSysPages());
//						return "common/menu";
//					} else {
//						return "common/content";
//					}
//				} else {
					return "common/content";
//				}
//			}
//			while (page.getSysPages().size() < 3) {
//				page.getSysPages().add(null);
//			}
//			request.setAttribute("sysPages", page.getSysPages());
//			return "common/menu";
		}

//		request.setAttribute("sysPageList", sysLeftMenuService
//				.findTopSysPage(user));
		List<SysModule> sysModuleList = sysModuleService.findAll();	
		request.setAttribute("sysModuleList", sysModuleList);
		return "common/index";
	}
}
