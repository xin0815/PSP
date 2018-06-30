package com.imnu.cnt.system.webbean;

import java.util.ArrayList;
import java.util.List;

import com.imnu.cnt.system.model.SysPage;

public class Menu {
	String fMenuName;
	List<SysPage> sysPages = new ArrayList<SysPage>();

	public String getfMenuName() {
		return fMenuName;
	}

	public void setfMenuName(String fMenuName) {
		this.fMenuName = fMenuName;
	}

	public List<SysPage> getSysPages() {
		return sysPages;
	}

	public void setSysPages(List<SysPage> sysPages) {
		this.sysPages = sysPages;
	}

}
