package com.imnu.cnt.system.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.model.SysRole;
import com.imnu.cnt.system.model.SysRolePage;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.model.SysUserPage;
import com.imnu.cnt.system.service.PowerService;
import com.imnu.cnt.system.service.SysModuleService;
import com.imnu.cnt.system.util.ValidationUtils;

@Service("powerService")
public class PowerServiceImpl extends BaseServiceImpl implements PowerService {
	@Resource(name = "sysModuleService")
	SysModuleService sysModuleService;

	@SuppressWarnings("unchecked")
	public Document findPageTree(String hql) {
		Document document = DocumentHelper.createDocument();
		Element tree = document.addElement("tree");
		tree.addAttribute("id", "0");
		Element obj[] = new Element[20];
		List<SysPage> pageList = (List<SysPage>) baseDao.find(hql);
		List<SysPage> listSysPageAll = getTreeSysPageAllList();
		for (int i = 0, j = 0; i < listSysPageAll.size(); i++) {
			SysPage page = listSysPageAll.get(i);
			if (page.getLevelCode().length() == 2) {
				obj[(page.getLevelCode().length() / 2 - 1)] = tree
						.addElement("item");
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
						"text", page.getPageName());
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute("id",
						page.getPageId().toString());
				if (isChecked(page, pageList, j)) {
					if (ValidationUtils.checkProperty(page)
							&& page.getSysPages().size() == 0) {
						obj[(page.getLevelCode().length() / 2 - 1)]
								.addAttribute("checked", "1");
					}
				}
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
						"open", "1");
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
						"call", "1");
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
						"select", "1");
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
				// if (ValidationUtils.checkProperty(page.getFunctionDepict())
				// && ValidationUtils.checkProperty(page
				// .getFunctionMethod())) {
				// String functionDepict[] = page.getFunctionDepict().split(
				// ";");
				// String functionMethod[] = page.getFunctionMethod().split(
				// ";");
				// for (int m = 0; m < functionDepict.length; m++) {
				// if (obj[page.getLevelCode().length() / 2 - 1] != null) {
				// obj[page.getLevelCode().length() / 2] = obj[page
				// .getLevelCode().length() / 2 - 1]
				// .addElement("item");
				// } else {
				// obj[page.getLevelCode().length() / 2] = DocumentHelper
				// .createElement("item");
				// }
				// obj[page.getLevelCode().length() / 2].addAttribute(
				// "open", "1");
				// obj[page.getLevelCode().length() / 2].addAttribute(
				// "text", functionDepict[m]);
				// obj[page.getLevelCode().length() / 2].addAttribute(
				// "id", page.getPageId().toString()
				// + ("_" + functionMethod[m]));
				// if (isCheckedFunctionMethod(id, page, functionMethod[m])) {
				// obj[page.getLevelCode().length() / 2].addAttribute(
				// "checked", "1");
				// }
				// }
				// } else {
				if (isChecked(page, pageList, j)) {
					obj[page.getLevelCode().length() / 2 - 1].addAttribute(
							"checked", "1");
					j++;
				}
				// }
			}
		}
		return document;
	}

	@SuppressWarnings("unchecked")
	private List<SysPage> getTreeSysPageAllList() {

		String hql = "select distinct sp  from SysPage sp "
				+ "left join fetch sp.sysPage as sysp "
				+ "left join fetch sp.sysPages as sps "
				+ "where sp.isDeleted = 0 " + " order by sp.levelCode ";
		List<SysPage> sysPageList = (List<SysPage>) baseDao.find(hql);
		for (int i = 0; i < sysPageList.size(); i++) {
			SysPage page = sysPageList.get(i);
			List<SysPage> sps = page.getSysPages();
			List<SysPage> nsps = new ArrayList<SysPage>(0);
			for (SysPage sysPage : sps) {
				if (!sysPage.getIsDeleted()) {
					nsps.add(sysPage);
				}
			}
			page.setSysPages(nsps);
		}
		return sysPageList;
	}

	private Boolean isChecked(SysPage page, List<SysPage> pageList, int j) {
		if (j < pageList.size()) {
			for (int i = 0; i < pageList.size(); i++) {
				if (page.getPageId().equals(pageList.get(i).getPageId())) {
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public Document findPageTreeByGroup(Integer groupId)
			throws ServiceException {
		String hql = "select distinct sp from SysPage sp "
				+ " left join fetch sp.sysPage as sp2 "
				+ " left join fetch sp.sysPages as sps "
				+ "	left join fetch  sp.sysGroupPages as srp "
				+ "where sp.isDeleted = 0 and srp.sysGroup.groupId=" + groupId
				+ " order by sp.levelCode ";

		return this.findPageTree(hql);
	}

	@Override
	public Document findPageTreeByRole(Integer roleID) throws ServiceException {
		String hql = "select distinct sp from SysPage sp "
				+ " left join fetch sp.sysPage as sp2 "
				+ " left join fetch sp.sysPages as sps "
				+ "	left join fetch  sp.sysRolePages as srp "
				+ "where sp.isDeleted = 0 and srp.sysRole.roleId=" + roleID
				+ " order by sp.levelCode ";

		return this.findPageTree(hql);
	}

	@Override
	public Document findPageTreeByUser(Integer userId) throws ServiceException {
		String hql = "select distinct sp from SysPage sp "
				+ " left join fetch sp.sysPage as sp2 "
				+ " left join fetch sp.sysPages as sps "
				+ "	left join fetch  sp.sysUserPages as srp "
				+ "where sp.isDeleted = 0 and srp.sysUser.userId=" + userId
				+ " order by sp.levelCode ";

		return this.findPageTree(hql);
	}

	public void updateSysRolePage(String id, String roleId)
			throws ServiceException {
		String idlist[] = id.split(",");
		super
				.executeUpdate("delete from SysRolePage srp where srp.sysRole.roleId="
						+ roleId);
		SysRole sysRole = (SysRole) findEntityById(SysRole.class, new Integer(
				roleId));
		for (int i = 0; i < idlist.length; i++) {
			if (ValidationUtils.checkProperty(idlist[i])) {
				SysRolePage sysRolePage = new SysRolePage();
				sysRolePage.setSysRole(sysRole);
				sysRolePage.setIsDeleted(false);
				SysPage page = (SysPage) findEntityById(
						SysPage.class, new Integer(idlist[i]));
				sysRolePage.setSysPage(page);
				baseDao.save(sysRolePage);
				//只选部分二级菜单后，无法保存父菜单的关系，导致页面无法显示那些菜单的问题
				//应该在树的js中修改，为方便，暂时在后台修改
				if(page.getSysPage() != null && page.getSysPage().getPageId() != null && !ArrayUtils.contains(idlist, page.getSysPage().getPageId())){
					SysRolePage parentSRP = new SysRolePage();
					parentSRP.setSysRole(sysRole);
					parentSRP.setIsDeleted(false);
					parentSRP.setSysPage(page.getSysPage());
					baseDao.save(parentSRP);
				}
			}
		}
	}


	public void updateSysUserPage(String id, String userId)
			throws ServiceException {
		String idlist[] = id.split(",");
		executeUpdate("delete from SysUserPage srp where srp.sysUser.userId="
				+ userId);
		SysUser sysUser = (SysUser) findEntityById(SysUser.class, new Integer(
				userId));

		for (int i = 0; i < idlist.length; i++) {
			if (ValidationUtils.checkProperty(idlist[i])) {
				SysUserPage sysUserPage = new SysUserPage();
				sysUserPage.setSysUser(sysUser);
				sysUserPage.setIsDeleted(false);
				if (idlist[i].indexOf("_") != -1) {
					sysUserPage.setSysPage((SysPage) findEntityById(
							SysPage.class, new Integer(idlist[i].substring(0,
									idlist[i].indexOf("_")))));
				} else {
					sysUserPage.setSysPage((SysPage) findEntityById(
							SysPage.class, new Integer(idlist[i])));
				}
				baseDao.save(sysUserPage);
			}
		}
	}

	@SuppressWarnings("unchecked")
	private SysRolePage findSysRolePage(Integer pageId, Integer roleId) {
		String hql = "select c from SysRolePage as c where c.sysPage.pageId="
				+ pageId + " and c.sysRole.roleId=" + roleId;
		List<SysRolePage> list = (List<SysRolePage>) baseDao.find(hql);
		return list.size() > 0 ? list.get(0) : new SysRolePage();
	}


}
