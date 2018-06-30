package com.imnu.cnt.system.service;

import java.util.List;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.util.Pager;

public interface SysModuleService extends BaseService {
	/**
	 * 查找关联项目
	 * 
	 * @param <T>
	 * @param sysModule
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @throws ServiceException
	 */
	public <T> Pager find(SysModule sysModule, String currentPage,
			String pageSize) throws ServiceException;

	/**
	 * 查找所有相关业务系统
	 * 
	 * @param sysModule
	 * @return
	 */
	public List<SysModule> find(SysModule sysModule) throws ServiceException;


	/**
	 * 根据id，查找相关项目
	 * 
	 * @param id
	 * @return
	 * @throws ServiceException
	 */
	public SysModule findSysModuleById(Integer id) throws ServiceException;

	/**
	 * 删除相关项目
	 * 
	 * @param batchId
	 * @throws ServiceException
	 */
	public void batchDelete(String batchId) throws ServiceException;
	/**
	 * 查找所有业务系统
	 * @return
	 */
	public List<SysModule> findAll();
	
	/**
	 * 查找需要同步的相关业务系统
	 * 
	 * @return
	 */
	public List<SysModule> findSynchroSysModule();
	
	/**
	 * 保存相关业务系统
	 * @param sysModule
	 * @return
	 */
	public void saveOrUpdateSysModule(SysModule sysModule);
	/**
	 * 查找公共应用服务平台
	 * @return
	 */
	public SysModule findPspSysModule();

}
