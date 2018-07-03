package com.imnu.cnt.system.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

public class scoreajax{

	@RequestMapping("changeform")
	public void changeform(String uid,HttpServletResponse response) throws IOException
	{
		if(uid == "1")
		{
			
			response.getWriter().print("1");
		}
		else
		{
			response.getWriter().print("2");
		}
	}
}
