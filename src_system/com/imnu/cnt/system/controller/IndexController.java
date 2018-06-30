 package com.imnu.cnt.system.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.service.SysModuleService;

@Controller
@RequestMapping("index")
public class IndexController {
	@Resource(name = "sysModuleService")
	SysModuleService sysModuleService;
	@RequestMapping("ind")
	public String list(HttpServletRequest request) {
		List<SysModule> sysModuleList = sysModuleService.findAll();	
		request.setAttribute("sysModuleList", sysModuleList);
		return "common/index";
	}
}
