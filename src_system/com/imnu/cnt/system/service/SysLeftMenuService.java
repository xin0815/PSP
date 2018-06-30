package com.imnu.cnt.system.service;

import java.util.List;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;

import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.webbean.MenuTree;

public interface SysLeftMenuService extends BaseService {

	public Document findPageTree(SysUser user);

	public TreeMap<String, MenuTree> findLeftMenuTree(SysUser user);

	public boolean isPopedomPossession(SysUser user, HttpServletRequest request);

	public String findSysPageURL(Integer sysPageID);

	public String findSysPageURL(String levelCode);

	public SysPage findPage(String levelCode, SysUser user);

	public String findContentTitle(Integer sysPageID);

	public String findContentTitle(String levelCode);

	public Document findPageTreeLevelCode(SysUser user);
	
	public List<SysPage> findTopSysPage(SysUser user);
	
	/**
	 * 查找该用户有权限访问的所有菜单
	 * @param user
	 * @param isPspSystem true：查找本系统的菜单  false：查找其它业务系统的菜单
	 * @return
	 */
	public List findSysPage(SysUser user) ;
	
	/**
	 * 根据父菜单id，查找所有子菜单
	 * @param parentPageId
	 * @return
	 */
	public List findSysPage(Integer parentPageId);
}
