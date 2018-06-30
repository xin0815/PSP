package com.imnu.cnt.system.filter;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.service.SysPageService;

public class LoginFilter implements Filter {

	private static SysPageService sysPageService;

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession();
		String path1 = req.getContextPath();
		String path2 = req.getRequestURI();

		if (path2.indexOf("services") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (path2.indexOf("map") > 0) {
			chain.doFilter(request, response);
			return;
		}
		// if (req.getRequestURI().indexOf("index") > 0) {
		// chain.doFilter(request, response);
		// return;
		// }
		if (path2.indexOf("images") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (path2.indexOf("css") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (path2.indexOf(".map") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (path2.indexOf("js") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (path2.indexOf("login") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (path2.indexOf("line") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (path2.indexOf("xls") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (req.getRequestURI().indexOf("ImageRandServlet") > 0) {
			chain.doFilter(request, response);
			return;
		}
		if (session.getAttribute("user") != null) {
			if (path2.equals(path1 + "/")) {
				request.getRequestDispatcher("/main/index").forward(request, response);
			} else {
				String sysPageUrl = path2.replaceFirst(path1+"/", "");
				SysPage sysPage = sysPageService.getSysPageByUrl(sysPageUrl);
				if (sysPage != null && StringUtils.isNotBlank(sysPage.getActiveBeginTime())
						&& StringUtils.isNotBlank(sysPage.getActiveEndTime())) {
					try{
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Date beginTime = sdf.parse(sysPage.getActiveBeginTime());
					Date endTime = sdf.parse(sysPage.getActiveEndTime());
					Date nowDate = new Date();
					if (nowDate.getTime() < beginTime.getTime() || nowDate.getTime() > endTime.getTime()) {
						request.setAttribute("info", sysPage.getPageName()+"开放时间：</br></br>"+sysPage.getActiveBeginTime()+" ~ "+sysPage.getActiveEndTime());
						request.getRequestDispatcher("/main/lose").forward(request, response);
					}
					}catch(Exception ee){
						ee.printStackTrace();
						//request.getRequestDispatcher("/main/errorInfo").forward(request, response);
					}
				}
			}

			chain.doFilter(request, response);
		} else {
			request.setAttribute("result", "1");
			request.getRequestDispatcher("/main/login").forward(request, response);
		}
	}

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void init(FilterConfig config) throws ServletException {
		// spring mvc中bean的注入顺序在filter之后，因此需要以下方式获得
		if (sysPageService == null) {
			ServletContext context = config.getServletContext();
			ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(context);
			sysPageService = (SysPageService) ac.getBean("sysPageService");

		}
	}

};
