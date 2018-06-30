package com.imnu.cnt.system.service;

import java.io.Serializable;
import java.util.List;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.util.Pager;

public interface BaseService {

	/**
	 * 保存实体
	 * 
	 * @param entity
	 */
	public void save(Object entity)throws ServiceException;
	/**
	 * 保存或更新实体
	 * 
	 * @param entity  
	 */
	public void saveOrUpdate(Object entity)throws ServiceException;

	/**
	 * 获得所有该对象的数据
	 * 
	 * @param <T>
	 * @param entityClass
	 * @return
	 */
	public <T> List<T> getAll(Class<T> entityClass)throws ServiceException;

	/**
	 * 删除实体
	 * 
	 * @param entity
	 */
	public void delete(Object entity)throws ServiceException;

	/**
	 * 修改实体
	 * 
	 * @param entity
	 */
	public void update(Object entity)throws ServiceException;

	/**
	 * 翻页查询
	 * 
	 * @param paramObject
	 * @param currentPage
	 * @param pageSize
	 * @param taxisfield
	 * @param taxis
	 * @return
	 */
	public <T> Pager find(Class<T> entityClass, Object paramObject,
			String currentPage, String pageSize, String taxisfield, String taxis)throws ServiceException;

	/**
	 * 翻页查询BYHQL
	 * 
	 * @param paramObject
	 * @param currentPage
	 * @param pageSize
	 * @param taxisfield
	 * @param taxis
	 * @return
	 */
	public <T> Pager findByHql(String hql, String currentPage, String pageSize,
			Object... paramObject)throws ServiceException;

	/**
	 * 唯一性验证
	 * 
	 * @param <T>
	 * @param entityClass
	 * @param entity
	 * @param uniquePropertyNames
	 * @return 返回true是没有重复，false是有重复
	 */
	public <T> boolean isUnique(Class<T> entityClass, Object entity,
			String uniquePropertyNames)throws ServiceException;

	/**
	 * 获取实体信息
	 * 
	 * @param id
	 * @return
	 */
	public <T> Object getEntity(Class<T> entityClass, Serializable id)throws ServiceException;

	/**
	 * 获取单实体对象
	 * 
	 */
	public <T> Object findEntityById(Class<T> entityObject, Serializable id)throws ServiceException;

	/**
	 * 通过语句获得对象集合
	 */
	public <T> List<?> findListByHQL(String hql)throws ServiceException;

}
