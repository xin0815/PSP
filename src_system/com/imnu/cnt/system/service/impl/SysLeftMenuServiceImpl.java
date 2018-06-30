package com.imnu.cnt.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;

import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.model.SysRolePage;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.SysLeftMenuService;
import com.imnu.cnt.system.util.ValidationUtils;
import com.imnu.cnt.system.webbean.Menu;
import com.imnu.cnt.system.webbean.MenuTree;

@Service("sysLeftMenuService")
public class SysLeftMenuServiceImpl extends BaseServiceImpl implements
		SysLeftMenuService {

	private String uriList = "doCoalHandlingComponent.do;"
			+ "doSysRolePage.do;" + "doSysRoleUser.do;" + "doSysUserRole.do;"
			+ "doCoalStatisticsWelcome.do";

	public String getUriList() {
		return uriList;
	}

	public void setUriList(String uriList) {
		this.uriList = uriList;
	}

	@SuppressWarnings("unchecked")
	public Document findPageTree(SysUser user) {
		Document document = DocumentHelper.createDocument();
		Element tree = document.addElement("tree");
		tree.addAttribute("id", "0");
		Element obj[] = new Element[20];
		// 查选leftMenu菜单页面数据
		String hql = " select distinct c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "left join fetch c.sysRolePages as srp "
				+ "left join fetch srp.sysRole as sr "
				+ "left join fetch sr.sysUserRoles as sur "
				+ "left join fetch sur.sysUser as su " + "where su.userId = "
				+ user.getUserId()
				+ " and c.isDeleted = 0 and sr.isDeleted = 0 "
				+ "and (m.isDeleted=0 or m.isDeleted is null) "
				+ "order by c.levelCode";
		List<SysPage> list = (List<SysPage>) baseDao.find(hql);
		// 用户直接关联菜单
		List<SysPage> pageList = (List<SysPage>) baseDao
				.find("select distinct sp from SysPage sp "
						+ "left join fetch sp.sysPage as csp "
						+ "left join fetch sp.sysPages as sps "
						+ " left join fetch sp.sysUserPages as sup "
						+ " left join fetch sp.sysModule as smo "
						+ "where sup.sysUser.userId=" + user.getUserId()
						+ " order by sp.levelCode ");
		for (int i = 0; i < pageList.size(); i++) {
			SysPage sysPage = (SysPage) pageList.get(i);
			if (!list.contains(sysPage)) {
				list.add(sysPage);
			}
		}
		hql = " select  c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "  where  c.isDeleted = 0 ";
		List<SysPage> syspages = (List<SysPage>) baseDao.find(hql);
		TreeMap<String, SysPage> treeSysPages = new TreeMap<String, SysPage>();
		for (SysPage page : syspages) {
			treeSysPages.put(page.getLevelCode(), page);
		}

		TreeMap<String, SysPage> sysPages = new TreeMap<String, SysPage>();
		for (int i = 0; i < list.size(); i++) {
			SysPage page = list.get(i);
			for (int j = 2; j <= page.getLevelCode().length(); j += 2) {
				String levelCode = StringUtils.substring(page.getLevelCode(),
						0, j);
				if (!ValidationUtils.checkProperty(sysPages.get(levelCode))) {
					SysPage pageBean = treeSysPages.get(levelCode);
					if (ValidationUtils.checkProperty(pageBean)) {
						sysPages.put(levelCode, pageBean);
					}
				}
			}
		}
		int count = 0;
		for (Entry<String, SysPage> entry : sysPages.entrySet()) {
			SysPage page = entry.getValue();
			if (page.getLevelCode().length() == 2) {
				obj[(page.getLevelCode().length() / 2 - 1)] = tree
						.addElement("item");
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
						"text", page.getPageName());
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute("id",
						page.getPageId().toString());

				if (user.getUserName().equals("guest")) {
					obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
							"open", "1");
				} else if (count == 0) {
					obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
							"open", "1");
					count = 1;

				}
			} else {
				if (page.getLevelCode().length() / 2 - 2 >= 0
						&& obj[page.getLevelCode().length() / 2 - 2] != null) {
					obj[page.getLevelCode().length() / 2 - 1] = obj[page
							.getLevelCode().length() / 2 - 2]
							.addElement("item");
				} else {
					obj[page.getLevelCode().length() / 2 - 1] = DocumentHelper
							.createElement("item");
				}
				obj[page.getLevelCode().length() / 2 - 1].addAttribute("text",
						page.getPageName());
				obj[page.getLevelCode().length() / 2 - 1].addAttribute("id",
						page.getPageId().toString());
			}
		}
		return document;
	}

	@SuppressWarnings("unchecked")
	public Document findPageTreeLevelCode(SysUser user) {
		Document document = DocumentHelper.createDocument();
		Element tree = document.addElement("tree");
		tree.addAttribute("id", "0");
		Element obj[] = new Element[20];
		// 查选用户所属角色（可以多个）的有权限的菜单
		String hql = " select distinct c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "left join fetch c.sysRolePages as srp "
				+ "left join fetch srp.sysRole as sr "
				+ "left join fetch sr.sysUserRoles as sur "
				+ "left join fetch sur.sysUser as su " + "where su.userId = "
				+ user.getUserId()
				+ " and c.isDeleted = 0 and sr.isDeleted = 0 "
				+ "and (m.isDeleted=0 or m.isDeleted is null) "
				+ "order by c.levelCode";
		List<SysPage> list = (List<SysPage>) baseDao.find(hql);
		// 用户直接关联菜单
		List<SysPage> pageList = (List<SysPage>) baseDao
				.find("select distinct sp from SysPage sp "
						+ "left join fetch sp.sysPage as csp "
						+ "left join fetch sp.sysPages as sps "
						+ " left join fetch sp.sysUserPages as sup "
						+ " left join fetch sp.sysModule as m "
						+ "where sup.sysUser.userId=" + user.getUserId()
						+ " order by sp.levelCode ");
		for (int i = 0; i < pageList.size(); i++) {
			SysPage sysPage = (SysPage) pageList.get(i);
			if (!list.contains(sysPage)) {
				list.add(sysPage);
			}
		}
		// 分组直接关联菜单
		List<SysPage> groupPageList = (List<SysPage>) baseDao
				.find("select distinct sp from SysPage sp "
						+ "left join fetch sp.sysPage as csp "
						+ "left join fetch sp.sysPages as sps "
						+ " left join fetch sp.sysGroupPages as sgp "
						+" left join fetch sgp.sysGroup sg"
						+ " left join fetch sg.sysGroupUsers sgu"
						+" left join fetch sgu.user su"
						+ " left join fetch sp.sysModule as m "
						+ "where su.userId=" + user.getUserId()
						+ " order by sp.levelCode ");
		for (int i = 0; i < groupPageList.size(); i++) {
			SysPage sysPage = (SysPage) groupPageList.get(i);
			if (!list.contains(sysPage)) {
				list.add(sysPage);
			}
		}
		hql = " select  c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "  where  c.isDeleted = 0 ";
		List<SysPage> syspages = (List<SysPage>) baseDao.find(hql);
		TreeMap<String, SysPage> treeSysPages = new TreeMap<String, SysPage>();
		for (SysPage page : syspages) {
			treeSysPages.put(page.getLevelCode(), page);
		}

		TreeMap<String, SysPage> sysPages = new TreeMap<String, SysPage>();
		for (int i = 0; i < list.size(); i++) {
			SysPage page = list.get(i);
			for (int j = 2; j <= page.getLevelCode().length(); j += 2) {
				String levelCode = StringUtils.substring(page.getLevelCode(),
						0, j);
				if (!ValidationUtils.checkProperty(sysPages.get(levelCode))) {
					SysPage pageBean = treeSysPages.get(levelCode);
					if (ValidationUtils.checkProperty(pageBean)) {
						sysPages.put(levelCode, pageBean);
					}
				}
			}
		}
		int count = 0;
		for (Entry<String, SysPage> entry : sysPages.entrySet()) {
			SysPage page = entry.getValue();
			if (page.getLevelCode().length() == 2) {
				obj[(page.getLevelCode().length() / 2 - 1)] = tree
						.addElement("item");
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
						"text", page.getPageName());
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute("id",
						page.getLevelCode().toString());
//				if (user.getUserName().equals("guest")) {
//					obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
//							"open", "1");
//				} else 
				if (count == 0) {
					obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
							"open", "1");
					count = 1;
				}
			} else {
				if (page.getLevelCode().length() / 2 - 2 >= 0
						&& obj[page.getLevelCode().length() / 2 - 2] != null) {
					obj[page.getLevelCode().length() / 2 - 1] = obj[page
							.getLevelCode().length() / 2 - 2]
							.addElement("item");
				} else {
					obj[page.getLevelCode().length() / 2 - 1] = DocumentHelper
							.createElement("item");
				}
				obj[page.getLevelCode().length() / 2 - 1].addAttribute("text",
						page.getPageName());
				obj[page.getLevelCode().length() / 2 - 1].addAttribute("id",
						page.getLevelCode().toString());
			}
		}
		return document;
	}

	@SuppressWarnings("unchecked")
	public TreeMap<String, MenuTree> findLeftMenuTree(SysUser user) {
		// 查选leftMenu菜单页面数据
		String hql = " select c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "left join fetch c.sysRolePages as srp "
				+ "left join fetch srp.sysRole as sr "
				+ "left join fetch sr.sysUserRoles as sur "
				+ "left join fetch sur.sysUser as su " + "where su.userId = "
				+ user.getUserId()
				+ " and c.isDeleted = 0 and sr.isDeleted = 0 "
				+ "and (m.isDeleted=0 or m.isDeleted is null) "
				+ "order by c.levelCode";
		List<SysPage> list = (List<SysPage>) baseDao.find(hql);
		// 用户直接关联菜单
		List<SysPage> pageList = (List<SysPage>) baseDao
				.find("select distinct sp from SysPage sp "
						+ "left join fetch sp.sysPage as csp "
						+ "left join fetch sp.sysPages as sps "
						+ " left join fetch sp.sysUserPages as sup "
						+ " left join fetch sp.sysModule as smo "
						+ "where sup.sysUser.userId=" + user.getUserId()
						+ " order by sp.levelCode ");
		for (int i = 0; i < pageList.size(); i++) {
			SysPage sysPage = (SysPage) pageList.get(i);
			if (!list.contains(sysPage)) {
				list.add(sysPage);
			}
		}
		hql = " select  c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "  where  c.isDeleted = 0 ";
		List<SysPage> syspages = (List<SysPage>) baseDao.find(hql);
		TreeMap<String, SysPage> treeSysPages = new TreeMap<String, SysPage>();
		for (SysPage page : syspages) {
			treeSysPages.put(page.getLevelCode(), page);
		}

		TreeMap<String, SysPage> sysPages = new TreeMap<String, SysPage>();
		for (int i = 0; i < list.size(); i++) {
			SysPage page = list.get(i);
			for (int j = 2; j <= page.getLevelCode().length(); j += 2) {
				String levelCode = StringUtils.substring(page.getLevelCode(),
						0, j);
				if (!ValidationUtils.checkProperty(sysPages.get(levelCode))) {
					SysPage pageBean = treeSysPages.get(levelCode);
					if (ValidationUtils.checkProperty(pageBean)) {
						sysPages.put(levelCode, pageBean);
					}
				}
			}
		}
		TreeMap<String, MenuTree> menuTree = new TreeMap<String, MenuTree>();
		MenuTree menuTrees[] = new MenuTree[20];
		for (Entry<String, SysPage> entry : sysPages.entrySet()) {
			SysPage page = entry.getValue();
			MenuTree treeTemp = new MenuTree(page, page.getLevelCode());
			menuTrees[page.getLevelCode().length() / 2 - 1] = treeTemp;
			if ((page.getLevelCode().length() / 2 - 1) == 0) {
				menuTree.put(page.getLevelCode(), treeTemp);
			} else {
				if (!ValidationUtils.checkProperty(menuTrees[page
						.getLevelCode().length() / 2 - 2])) {
					menuTrees[(page.getLevelCode().length() / 2 - 2)] = new MenuTree();
					menuTrees[(page.getLevelCode().length() / 2 - 2)]
							.setPage(page.getSysPage());
					menuTrees[(page.getLevelCode().length() / 2 - 2)]
							.setLevelCode(page.getLevelCode());
				}
				if (!ValidationUtils.checkProperty(menuTrees[page
						.getLevelCode().length() / 2 - 2].getSubMenu())) {
					menuTrees[page.getLevelCode().length() / 2 - 2]
							.setSubMenu(new TreeMap<String, MenuTree>());
				}
				menuTrees[page.getLevelCode().length() / 2 - 2].getSubMenu()
						.put(page.getLevelCode(), treeTemp);
			}
		}
		return menuTree;
	}

	public boolean isPopedomPossession(SysUser user, HttpServletRequest request) {
		TreeMap<String, SysPage> map = this.findActionMap(user);
		// String uri = request.getRequestURI();
		// String method = request.getParameter("method");
		//		
		//		
		// for (Entry<String, SysPage> entry : map.entrySet()) {
		// SysPage page = entry.getValue();
		// String uriInfo = page.getUrl();
		// if (uriInfo != null && uriInfo.length() > 0) {
		// if (method != null) {
		// if (uri.indexOf(uriInfo.substring(
		// uriInfo.lastIndexOf("/") < 0 ? 0 : uriInfo
		// .lastIndexOf("/"), uriInfo.length())) != -1) {
		// if (ValidationUtils.checkProperty(method)
		// && ValidationUtils.checkProperty(page
		// .getFunctionMethod())
		// && page.getFunctionMethod().indexOf(method) != -1) {
		// // 获取对应的用户对应角色 角色对应菜单 判定是否拥有访问对应方法的权限
		// if (checkUserRequestMethod(method, user, page)) {
		// return true;
		// }
		// } else {
		// return true;
		// }
		// }
		// } else {
		// if (uri.indexOf(uriInfo.substring(
		// uriInfo.lastIndexOf("/") < 0 ? 0 : uriInfo
		// .lastIndexOf("/"), uriInfo.length())) != -1) {
		// return true;
		// }
		// }
		// }
		// }
		// String[] uriArray = uriList.split(";");
		// for (int i = 0; i < uriArray.length; i++) {
		// if (request.getRequestURI().indexOf(uriArray[i]) > 0) {
		// return true;
		// }
		// }
		// request.setAttribute("errors", "无权限访问");
		return true;
	}

	private Boolean checkUserRequestMethod(String method, SysUser user,
			SysPage page) {
		String hql = "select distinct c from SysRolePage as c "
				+ "left join fetch c.sysRole as sr "
				+ "left join fetch sr.sysUserRoles as sur "
				+ "left join fetch sur.sysUser as su " + "where su.userId="
				+ user.getUserId() + " and c.sysPage.pageId="
				+ page.getPageId();
		List<?> list = baseDao.find(hql);
		if (list.size() > 0) {
			SysRolePage sysRolePage = (SysRolePage) list.get(0);
//			if (ValidationUtils.checkProperty(sysRolePage
//					.getRoleFunctionMethod())
//					&& ValidationUtils.checkProperty(method)
//					&& sysRolePage.getRoleFunctionMethod().indexOf(method) != -1) {
//				return true;
//			} else {
//				return false;
//			}
		}
		return false;
	}

	@SuppressWarnings("unchecked")
	private TreeMap<String, SysPage> findActionMap(SysUser user) {
		// 查选leftMenu菜单页面数据
		String hql = " select c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "left join fetch c.sysRolePages as srp "
				+ "left join fetch srp.sysRole as sr "
				+ "left join fetch sr.sysUserRoles as sur "
				+ "left join fetch sur.sysUser as su " + "where su.userId = "
				+ user.getUserId()
				+ " and c.isDeleted = 0 and sr.isDeleted = 0 "
				+ "and (m.isDeleted=0 or m.isDeleted is null) "
				+ "order by c.levelCode";
		List<SysPage> list = (List<SysPage>) baseDao.find(hql);
		// 用户直接关联菜单
		List<SysPage> pageList = (List<SysPage>) baseDao
				.find("select distinct sp from SysPage sp "
						+ "left join fetch sp.sysPage as csp "
						+ "left join fetch sp.sysPages as sps "
						+ " left join fetch sp.sysUserPages as sup "
						+ " left join fetch sp.sysModule as smo "
						+ "where sup.sysUser.userId=" + user.getUserId()
						+ " order by sp.levelCode ");
		for (int i = 0; i < pageList.size(); i++) {
			SysPage sysPage = (SysPage) pageList.get(i);
			if (!list.contains(sysPage)) {
				list.add(sysPage);
			}
		}
		hql = " select  c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "  where  c.isDeleted = 0 ";
		List<SysPage> syspages = (List<SysPage>) baseDao.find(hql);
		TreeMap<String, SysPage> treeSysPages = new TreeMap<String, SysPage>();
		for (SysPage page : syspages) {
			treeSysPages.put(page.getLevelCode(), page);
		}

		TreeMap<String, SysPage> sysPages = new TreeMap<String, SysPage>();
		for (int i = 0; i < list.size(); i++) {
			SysPage page = list.get(i);
			for (int j = 2; j <= page.getLevelCode().length(); j += 2) {
				String levelCode = StringUtils.substring(page.getLevelCode(),
						0, j);
				if (!ValidationUtils.checkProperty(sysPages.get(levelCode))) {
					SysPage pageBean = treeSysPages.get(levelCode);
					if (ValidationUtils.checkProperty(pageBean)) {
						sysPages.put(levelCode, pageBean);
					}
				}
			}
		}
		return sysPages;
	}

	@SuppressWarnings("unchecked")
	public String findSysPageURL(Integer sysPageID) {
		String hql = "select c from  SysPage as c "
				+ "left join fetch c.sysModule as m "
				+ "where c.isDeleted = 0 and m.isDeleted=0 and c.pageId = "
				+ sysPageID;
		List<SysPage> pageList = (List<SysPage>) baseDao.find(hql);
		if (pageList.size() > 0) {
			if (ValidationUtils.checkProperty(pageList.get(0).getUrl())) {
				return pageList.get(0).getSysModule().getUrl() + "/"
						+ pageList.get(0).getUrl() + ";"
						+ pageList.get(0).getLevelCode();
			}
			return "" + ";" + pageList.get(0).getLevelCode();
		} else {
			return "error" + ";" + "";
		}
	}

	@SuppressWarnings("unchecked")
	public SysPage findPage(String levelCode, SysUser user) {
		if (ValidationUtils.checkProperty(user)) {
			String hql = " select  c from SysPage as c "
					+ " left join fetch c.sysPages as sps "
					+ " left join fetch c.sysModule as m "
					+ " where  c.isDeleted = 0 " + " and m.isDeleted=0"
					+ " and c.levelCode = '" + levelCode + "' "
					+ " order by sps.levelCode";
			List<SysPage> pages = (List<SysPage>) baseDao.find(hql);
			// 查选leftMenu菜单页面数据
			hql = " select distinct c from SysPage as c "
					+ "left join fetch c.sysPage as sp "
					+ "left join fetch c.sysPages as sps "
					+ "left join fetch c.sysModule as m "
					+ "left join fetch c.sysRolePages as srp "
					+ "left join fetch srp.sysRole as sr "
					+ "left join fetch sr.sysUserRoles as sur "
					+ "left join fetch sur.sysUser as su "
					+ "where su.userId = " + user.getUserId()
					+ " and c.isDeleted = 0 and sr.isDeleted = 0 "
					+ "and (m.isDeleted=0 or m.isDeleted is null) "
					+ " and c.levelCode like '" + levelCode + "%'"
					+ "order by c.levelCode";
			List<SysPage> list = (List<SysPage>) baseDao.find(hql);
			// 用户直接关联菜单
			List<SysPage> pageList = (List<SysPage>) baseDao
					.find("select distinct sp from SysPage sp "
							+ "left join fetch sp.sysPage as csp "
							+ "left join fetch sp.sysPages as sps "
							+ " left join fetch sp.sysUserPages as sup "
							+ " left join fetch sp.sysModule as smo "
							+ "where  sup.sysUser.userId="
							+ user.getUserId()
							+ " and (smo.isDeleted=0 or smo.isDeleted is null)  "
							+ "and sp.levelCode like '" + levelCode + "%'"
							+ " order by sp.levelCode ");
			list = ListUtils.sum(list, pageList);

			hql = " select distinct c from SysPage as c "
					+ "left join fetch c.sysPage as sp "
					+ "left join fetch c.sysPages as sps "
					+ "left join fetch c.sysModule as m "
					+ "where  c.isDeleted = 0 " + "and c.levelCode like '"
					+ levelCode + "%'";
			List<SysPage> syspages = (List<SysPage>) baseDao.find(hql);
			TreeMap<String, SysPage> treeSysPages = new TreeMap<String, SysPage>();
			for (SysPage page : syspages) {
				treeSysPages.put(page.getLevelCode(), page);
			}

			TreeMap<String, SysPage> sysPages = new TreeMap<String, SysPage>();
			for (int i = 0; i < list.size(); i++) {
				SysPage page = list.get(i);
				for (int j = 2; j <= page.getLevelCode().length(); j += 2) {
					String levelCodeTemp = StringUtils.substring(page
							.getLevelCode(), 0, j);
					if (!ValidationUtils.checkProperty(sysPages
							.get(levelCodeTemp))) {
						SysPage pageBean = treeSysPages.get(levelCodeTemp);
						if (ValidationUtils.checkProperty(pageBean)) {
							sysPages.put(levelCodeTemp, pageBean);
						}
					}
				}
			}

			treeSysPages = new TreeMap<String, SysPage>();
			for (Entry<String, SysPage> entry : sysPages.entrySet()) {
				SysPage page = entry.getValue();
				if (page.getLevelCode().length() - 2 == levelCode.length()) {
					treeSysPages.put(page.getLevelCode(), page);
				}
			}
			SysPage page = pages.size() > 0 ? pages.get(0) : null;
			if (ValidationUtils.checkProperty(page)) {
				list = new ArrayList<SysPage>();
				list.addAll(treeSysPages.values());
				page.setSysPages(list);
			}

			if (ValidationUtils.checkProperty(treeSysPages)
					&& ValidationUtils.checkProperty(page)
					&& ValidationUtils.checkProperty(sysPages.get(page
							.getLevelCode()))) {
				return page;
			} else {
				return null;
			}
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	public String findContentTitle(Integer sysPageID) {

		String hql = " select c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "where c.isDeleted = 0 and c.pageId = " + sysPageID;
		List<SysPage> pageList = (List<SysPage>) baseDao.find(hql);
		if (pageList.size() == 0) {
			return "error";
		}

		if (!ValidationUtils.checkProperty(pageList.get(0).getPageName())) {
			return "";
		}

		SysPage page = pageList.get(0);
		String title = pageList.get(0).getPageName();
		title += "\u0003" + page.getPageId();

		if (ValidationUtils.checkProperty(page)
				&& page.getLevelCode().equals("08")
				&& page.getSysPages().size() == 0) {
			return "";
		}

		String url = page.getUrl();
		if (url != null && url.endsWith(".jnlp")) {
			return "\u0002";
		}

		for (; page.getLevelCode().length() != 2;) {
			page = page.getSysPage();
			// title = page.getPageName() + ">" + title;
			title = page.getPageName() + "\u0003" + page.getPageId() + "\u0004"
					+ title;
			// title = "<a href=/kns/system/doSysMenu.do?levelCode=" +
			// page.getLevelCode() + " onclick=parent.getContentTitle(" +
			// page.getPageId() + ")" + " target=right >" + page.getPageName() +
			// "</a>>" + title;
			// title = "<a href=# onclick=tonclick(" + page.getPageId() +
			// ") target=right >" + page.getPageName() + "</a>>" + title;
		}
		return title;
	}

	@SuppressWarnings("unchecked")
	public String findSysPageURL(String levelCode) {
		String hql = "select c from  SysPage as c "
				+ "left join fetch c.sysModule as m "
				+ "where c.isDeleted = 0 and m.isDeleted=0 and c.levelCode = '"
				+ levelCode + "'";
		List<SysPage> pageList = (List<SysPage>) baseDao.find(hql);
		if (pageList.size() > 0) {
			if (ValidationUtils.checkProperty(pageList.get(0).getUrl())) {
				return pageList.get(0).getSysModule().getUrl() + "/"
						+ pageList.get(0).getUrl() + ";"
						+ pageList.get(0).getLevelCode();
			}
			return "" + ";" + pageList.get(0).getLevelCode();
		} else {
			return "error" + ";" + "";
		}
	}

	@SuppressWarnings("unchecked")
	public String findContentTitle(String levelCode) {

		String hql = " select c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "where c.isDeleted = 0 and c.levelCode = '" + levelCode + "'";
		List<SysPage> pageList = (List<SysPage>) baseDao.find(hql);
		if (pageList.size() == 0) {
			return "error";
		}

		if (!ValidationUtils.checkProperty(pageList.get(0).getPageName())) {
			return "?";
		}

		SysPage page = pageList.get(0);
		String title = pageList.get(0).getPageName();
		title += "^" + page.getLevelCode();

		if (ValidationUtils.checkProperty(page)
				&& page.getLevelCode().equals("08")
				&& page.getSysPages().size() == 0) {
			return "";
		}

		String url = page.getUrl();
		if (url != null && url.endsWith(".jnlp")) {
			return "?";
		}

		for (; page.getLevelCode().length() != 2;) {
			page = page.getSysPage();
			title = page.getPageName() + "^" + page.getLevelCode() + "-"
					+ title;
		}
		return title;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<SysPage> findTopSysPage(SysUser user){
		// 查选leftMenu菜单页面数据
		String hql = " select distinct c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "left join fetch c.sysRolePages as srp "
				+ "left join fetch srp.sysRole as sr "
				+ "left join fetch sr.sysUserRoles as sur "
				+ "left join fetch sur.sysUser as su " + "where su.userId = "
				+ user.getUserId()
				+ " and c.isDeleted = 0 and sr.isDeleted = 0 "
				+ "and (m.isDeleted=0 or m.isDeleted is null) "
				+ "order by c.levelCode";
		List<SysPage> list = (List<SysPage>) baseDao.find(hql);
		// 用户直接关联菜单
		List<SysPage> pageList = (List<SysPage>) baseDao
				.find("select distinct sp from SysPage sp "
						+ "left join fetch sp.sysPage as csp "
						+ "left join fetch sp.sysPages as sps "
						+ " left join fetch sp.sysUserPages as sup "
						+ " left join fetch sp.sysModule as smo "
						+ "where sup.sysUser.userId=" + user.getUserId()
						+ " order by sp.levelCode ");
		for (int i = 0; i < pageList.size(); i++) {
			SysPage sysPage = (SysPage) pageList.get(i);
			if (!list.contains(sysPage)) {
				list.add(sysPage);
			}
		}
		hql = " select  c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "  where  c.isDeleted = 0 ";
		List<SysPage> syspages = (List<SysPage>) baseDao.find(hql);
		TreeMap<String, SysPage> treeSysPages = new TreeMap<String, SysPage>();
		for (SysPage page : syspages) {
			treeSysPages.put(page.getLevelCode(), page);
		}

		TreeMap<String, SysPage> sysPages = new TreeMap<String, SysPage>();
		for (int i = 0; i < list.size(); i++) {
			SysPage page = list.get(i);
			for (int j = 2; j <= page.getLevelCode().length(); j += 2) {
				String levelCode = StringUtils.substring(page.getLevelCode(),
						0, j);
				if (!ValidationUtils.checkProperty(sysPages.get(levelCode))) {
					SysPage pageBean = treeSysPages.get(levelCode);
					if (ValidationUtils.checkProperty(pageBean)) {
						sysPages.put(levelCode, pageBean);
					}
				}
			}
		}
		List<SysPage> syspageList = new ArrayList<SysPage>();
		for (Entry<String, SysPage> entry : sysPages.entrySet()) {
			SysPage page = entry.getValue();
			if (page.getLevelCode().length() == 2) {
				syspageList.add(page);
			} 
		}
        return syspageList;
	}
	
	public List findSysPage(SysUser user) {
		Element obj[] = new Element[20];
		// 查选用户所属角色（可以多个）的有权限的菜单
		String hql = " select distinct c from SysPage as c "
				+ "left join fetch c.sysPage as sp "
				+ "left join fetch c.sysPages as sps "
				+ "left join fetch c.sysModule as m "
				+ "left join fetch c.sysRolePages as srp "
				+ "left join fetch srp.sysRole as sr "
				+ "left join fetch sr.sysUserRoles as sur "
				+ "left join fetch sur.sysUser as su " + "where su.userId = "
				+ user.getUserId()
				+ " and c.isDeleted = 0 and sr.isDeleted = 0 and m.isDeleted=0 "
				+ "order by c.levelCode";
		List<SysPage> list = (List<SysPage>) baseDao.find(hql);
		// 用户直接关联菜单
		List<SysPage> pageList = (List<SysPage>) baseDao
				.find("select distinct sp from SysPage sp "
						+ "left join fetch sp.sysPage as csp "
						+ "left join fetch sp.sysPages as sps "
						+ " left join fetch sp.sysUserPages as sup "
						+ " left join fetch sp.sysModule as m "
						+ "where sup.sysUser.userId=" + user.getUserId()
						+ "  order by sp.levelCode ");
		//合并根据用户和角色查出的菜单
		for (int i = 0; i < pageList.size(); i++) {
			SysPage sysPage = (SysPage) pageList.get(i);
			if (!list.contains(sysPage)) {
				list.add(sysPage);
			}
		}
		
		//把查出来的所有菜单，转换成二级菜单，方便页面显示
		List<Menu> menuList = new ArrayList<Menu>();
		for(SysPage fSysPage:list){
			if(fSysPage.getSysPage() == null || fSysPage.getSysPage().getPageId() == null ){
				Menu menu = new Menu();
				List<SysPage> menuPageList = new ArrayList<SysPage>();
				menu.setfMenuName(fSysPage.getImgSrc());
				for(SysPage sSysPage:list){
					if(sSysPage.getSysPage()!=null&&sSysPage.getSysPage().getPageId() != null &&sSysPage.getSysPage().getPageId().equals(fSysPage.getPageId())){
						menuPageList.add(sSysPage);
					}
				}
				menu.setSysPages(menuPageList);
				menuList.add(menu);
			}
		}
		return menuList;
	}
	
	public List findSysPage(Integer parentPageId){
		String hql = "from SysPage c where c.isDeleted=0 and c.sysPage.pageId="+parentPageId;
		return baseDao.find(hql);
	}
}
