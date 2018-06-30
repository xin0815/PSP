package com.imnu.cnt.system.service;

import org.hibernate.usertype.UserType;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.util.Pager;

public interface SysUserService extends BaseService{
	
	/**
	 * 验证用户名
	 * @param userName
	 * @return
	 * @throws ServiceException
	 */
	public SysUser checkUserName(String userName) throws ServiceException;
	
	/**
	 * 根据用户名和密码查找用户
	 * @param name
	 * @param password
	 * @return
	 * @throws ServiceException
	 */
	public Object  find(String name , String password)throws ServiceException ;
	
	/**
	 * 分页查询用户
	 * @param <T>
	 * @param sysUser
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @throws ServiceException
	 */
	public <T> Pager find(SysUser sysUser, String currentPage, String pageSize)throws ServiceException;
	/**
	 * 批量删除用户
	 * @param batchId
	 * @return
	 * @throws ServiceException
	 */
	public void batchDelete(String batchId) throws ServiceException;
	
	/**
	 * 根据Id查找用户
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public SysUser findSysUserById(Integer id) throws ServiceException;
	
	/**
	 * 根据编码，查找用户类型
	 * @param userTypeCode
	 * @return
	 * @throws ServiceException
	 */
	public UserType findUserTypeByCode(String userTypeCode)throws ServiceException;
	
	/**
	 * 重置密码
	 * @param batchId
	 * @throws ServiceException
	 */
	public void updateResetPassword(String batchId) throws ServiceException;
	
	/**
	 * 保存用户信息，同时同步各业务系统
	 * @return
	 */
	public void saveOrUpdateSysUser(SysUser sysUser)throws ServiceException;
	
	/**
	 * 查询所有的用户
	 * @param <T>
	 * @param sysUser
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @throws ServiceException
	 */
	public <T> Pager findAllUser(SysUser sysUser, String currentPage,
			String pageSize) throws ServiceException;
}
