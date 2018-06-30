package com.imnu.cnt.system.service.impl;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.MatchMode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.imnu.cnt.system.dao.BaseDao;
import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.service.BaseService;
import com.imnu.cnt.system.util.BeanUtils;
import com.imnu.cnt.system.util.Pager;

@Service("baseService")
public class BaseServiceImpl implements BaseService {

	@Resource
	protected BaseDao baseDao;

	public void delete(Object entity) throws ServiceException{
			baseDao.remove(entity);
	}

	public <T> Pager find(Class<T> entityClass, Object paramObject,
			String currentPage, String pageSize, String taxisfield, String taxis) throws ServiceException{
			Criteria criteria = baseDao.createCriteria(entityClass, taxisfield,
					false,
					Example.create(paramObject).enableLike(MatchMode.ANYWHERE))
					.add(Expression.eq("isDeleted", false));
			return baseDao.pagedQuery(criteria, currentPage, pageSize);
	}

	public <T> Object getEntity(Class<T> entityClass, Serializable id)throws ServiceException {
			return baseDao.get(entityClass, id);
	}

	public <T> boolean isUnique(Class<T> entityClass, Object entity,
			String uniquePropertyNames) throws ServiceException{
			return baseDao.isUnique(entityClass, entity, uniquePropertyNames);
	}

	public void save(Object entity) throws ServiceException{
			baseDao.save(entity);
	}

	public void update(Object entity) throws ServiceException{
			baseDao.update(entity);
	}
	
	public <T> Pager findByHql(String hql, String currentPage, String pageSize,
			Object... paramObject) throws ServiceException{
			return baseDao.pagedQuery(hql, currentPage, pageSize, paramObject);
	}

	public <T> List<T> getAll(Class<T> entityClass)throws ServiceException {
			return baseDao.getAll(entityClass);
	}

	public <T> Object findEntityById(Class<T> entityObject, Serializable id) throws ServiceException{
		try {
			Object obj = null;
			obj = entityObject.newInstance();
			BeanUtils.copyProperties(obj, baseDao.get(entityObject, id));
			return obj;
		} catch (Exception e) {
			e.printStackTrace();
			throw new ServiceException("");
		} 
	}

	public int executeUpdate(String hql)throws ServiceException {
			Query query = baseDao.createQuery(hql);
			return query.executeUpdate();
	}

	public int executeUpdate(String hql, Object obj) throws ServiceException{
			Query query = baseDao.createQuery(hql, obj);
			return query.executeUpdate();
	}
	
	public int executeUpdate(String hql, Object... obj) throws ServiceException{
		Query query = baseDao.createQuery(hql, obj);
		return query.executeUpdate();
	}

	public <T> List<?> findListByHQL(String hql)throws ServiceException {
			return baseDao.find(hql);
	}

	public Object merge(Object entity) throws ServiceException{
			return baseDao.merge(entity);
	}

	public Object merge(String entityName, Object entity) throws ServiceException{
			return baseDao.merge(entityName, entity);
	}

	public void lock(String entityName, Object entity, LockMode lockMode) throws ServiceException{
			baseDao.lock(entityName, entity, lockMode);
	}

	public void lock(Object entity, LockMode lockMode)throws ServiceException {
			baseDao.lock(entity, lockMode);
	}
	public void persist(Object entity)throws ServiceException{
			baseDao.persist(entity);
	}

	
	public void saveOrUpdate(Object entity) throws ServiceException {
			baseDao.saveOrUpdate(entity);
	}
	
}
