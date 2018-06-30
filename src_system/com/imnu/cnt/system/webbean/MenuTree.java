package com.imnu.cnt.system.webbean;

import java.util.TreeMap;

import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.util.ValidationUtils;

public class MenuTree {
	private SysPage page = null;
	private TreeMap<String, MenuTree> subMenu = null;
	private String levelCode;

	public int getMaxSize() {
		if (ValidationUtils.checkProperty(subMenu)) {
			return subMenu.size();
		}
		return 0;
	}

	public MenuTree() {

	}

	public MenuTree(SysPage page, TreeMap<String, MenuTree> submenu,
			String levelCode) {
		super();
		this.page = page;
		this.subMenu = submenu;
		this.levelCode = levelCode;
	}

	public MenuTree(SysPage page, String levelCode) {
		this.page = page;
		this.levelCode = levelCode;
	}

	public MenuTree(SysPage page, TreeMap<String, MenuTree> submenu,
			String levelCode, SysPage parentMenu) {
		super();
		this.page = page;
		this.subMenu = submenu;
		this.levelCode = levelCode;
	}

	public SysPage getPage() {
		return page;
	}

	public void setPage(SysPage page) {
		this.page = page;
	}

	public String getLevelCode() {
		return levelCode;
	}

	public void setLevelCode(String levelCode) {
		this.levelCode = levelCode;
	}

	public TreeMap<String, MenuTree> getSubMenu() {
		return subMenu;
	}

	public void setSubMenu(TreeMap<String, MenuTree> subMenu) {
		this.subMenu = subMenu;
	}

}
