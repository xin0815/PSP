package com.imnu.cnt.system.service;

import org.dom4j.Document;

import com.imnu.cnt.system.exception.ServiceException;

public interface PowerService extends BaseService{
	/**
	 * 根据角色Id，查找菜单树
	 * @param roleID
	 * @return
	 * @throws ServiceException
	 */
	public Document findPageTreeByRole(Integer roleID)throws ServiceException;
	/**
	 * 根据群Id，查找菜单树
	 * @param groupId
	 * @return
	 * @throws ServiceException
	 */
	public Document findPageTreeByGroup(Integer groupId)throws ServiceException;
	/**
	 * 根据用户Id，查找菜单树
	 * @param userId
	 * @return
	 * @throws ServiceException
	 */
	public Document findPageTreeByUser(Integer userId)throws ServiceException;
	/**
	 * 维护角色和菜单的关系
	 * @param id
	 * @param roleId
	 * @return
	 * @throws ServiceException
	 */
	public void updateSysRolePage(String id, String roleId)throws ServiceException;
	/**
	 * 维护用户和菜单的关系
	 * @param id
	 * @param roleId
	 * @return
	 * @throws ServiceException
	 */
	public void updateSysUserPage(String id, String roleId)throws ServiceException;
}
