package com.imnu.cnt.system.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.SysUserService;
import com.imnu.cnt.system.util.Constants;

@Controller
@RequestMapping("lg")
/*
 * 登录控制器
 * */
public class LoginController {
	
	@Resource(name="sysUserService")
	private SysUserService syUserService;	
	private SysUser user;
	
	@RequestMapping("login")
	@ResponseBody
	public Map<String, Object> login(@RequestBody Map<String, Object> map,HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		String stype = "0";
		String name = (String) map.get("username");
		String password = (String) map.get("password");
		String methodValue = (String) map.get("method");
		user = checkUser(name, password);
		if (methodValue != null && methodValue.equals("login") && user != null) {
			if (stype == null || stype.equals("0")) {
				session.setAttribute("user", user);
				session.setAttribute("userName", user.getUserName());
				if(StringUtils.isNotBlank(user.getUserType())){
				}
				session.setMaxInactiveInterval(20*60);
			} else {
				Cookie cookieName = new Cookie("user", user.getUserName());
				cookieName.setMaxAge(3600 * 24 * 5);
				result.put("cookieName", cookieName);
			}
			session.setAttribute("skin", "default");
			result.put("result", "0");//跳到后台主页面
		} else if (methodValue != null && methodValue.equals("userLogout")) {
			session = request.getSession();
			if (null != session.getAttribute("user")) {
				session.setAttribute("user", null);
				session.setAttribute("userName", null);
				session.removeAttribute("user");
				session.removeAttribute("teacher");
				session.removeAttribute("studentinfo");
				session.removeAttribute("userName");
				result.put("result", "1");//跳到登录页
			}
		} else if(methodValue.equals("ajaxCheck")){
			SysUser s=null;
			try {
				s = syUserService.checkUserName(name);
			} catch (ServiceException e) {
				e.printStackTrace();
			}
			if(s== null){
				result.put("result", "2");//用户不存在
			}else if(password == null || !password.equals(s.getPassword())){
				result.put("result", "3");//密码不正确
			}else{
				result.put("result", "4");//登录
			}
			
		}else{
			result.put("result", "1");//跳到后台主页面
		}
		
		
		return result;
	}
	private SysUser checkUser(String userName, String passWord) {
		Object iuser = null;
		try {
			iuser = syUserService.find(userName, passWord);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (iuser != null) {
			user = (SysUser) iuser;
			return user;
		}
		return null;
	}
	
}
