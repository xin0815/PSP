package com.imnu.cnt.system.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("sysUser")
public class ScoreController {

	@RequestMapping("list3")
	public String list()
	{
		return "system/Score";
	}
}
