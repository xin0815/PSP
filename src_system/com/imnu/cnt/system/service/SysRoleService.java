package com.imnu.cnt.system.service;

import java.util.List;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysRole;
import com.imnu.cnt.system.model.SysUserRole;
import com.imnu.cnt.system.util.Pager;

public interface SysRoleService extends BaseService {

	/**
	 * 分页查询角色信息
	 * 
	 * @param <T>
	 * @param role
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @throws ServiceException
	 */
	public <T> Pager find(SysRole role, String currentPage, String pageSize)
			throws ServiceException;

	/**
	 * 根据ID查找角色
	 * 
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public SysRole findSysRoleById(Integer id) throws ServiceException;

	/**
	 * 批量删除角色
	 * 
	 * @param batchId
	 * @throws ServiceException
	 */
	public void batchDelete(String batchId) throws ServiceException;

	/**
	 * 根据角色id，查找关联用户
	 * @param roleId
	 * @return
	 * @throws ServiceException
	 */
	public List<SysUserRole> findSysUserRole(Integer roleId)
			throws ServiceException;
	/**
	 * 批量新增或修改角色和用户的关联关系
	 * @param roleId 一个角色Id
	 * @param relationUserIds 多个用户ID
	 * @throws ServiceException 
	 */
	public void saveOrUpdateRelationUser(Integer roleId,String relationUserIds) throws ServiceException;
	
	/**
	 * 保存角色
	 * @param sysRole
	 * @return
	 * @throws ServiceException
	 */
	public void saveOrUpdateSysRole(SysRole sysRole) throws ServiceException;
	
	/**
	 * 根据角色编码，查找角色
	 * @param roleCode
	 * @return
	 */
	SysRole findSysRoleByCode(String roleCode);
	
	/**
	 * 根据用户和角色查找关联关系
	 * @param userId
	 * @param roleId
	 * @return
	 */
	SysUserRole getSysUserRole(Integer userId,Integer roleId);
	
}
