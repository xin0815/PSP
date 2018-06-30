package com.imnu.cnt.system.dao;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.impl.CriteriaImpl;
import org.hibernate.metadata.ClassMetadata;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;
import org.springframework.util.Assert;
import org.springframework.util.ReflectionUtils;


import com.imnu.cnt.system.util.BeanUtils;
import com.imnu.cnt.system.util.HibernateDaoSupport;
import com.imnu.cnt.system.util.Pager;


/**
 * Hibernate Dao的泛型基�?.
 * <p/>
 * 继承于Spring�?<code>HibernateDaoSupport</code>,提供分页函数和若干便捷查询方法，并对返回值作了泛型类型转�?.
 * 
 * @see HibernateDaoSupport
 * @see HibernateEntityDao
 */
@Repository("baseDao")
public class BaseDao extends HibernateDaoSupport {

	/**
	 * 根据ID获取对象. 实际调用Hibernate的session.load()方法返回实体或其proxy对象. 如果对象不存在，抛出异常.
	 */
	public <T> T get(Class<T> entityClass, Serializable id) {
		return (T) getHibernateTemplate().load(entityClass, id);
	}

	public Object merge(Object entity) {
		return getHibernateTemplate().merge(entity);
	}

	public Object merge(String entityName, Object entity) {
		return getHibernateTemplate().merge(entityName, entity);
	}

	public void evict(Object entity) {
		getHibernateTemplate().evict(entity);
	}

	public void lock(String entityName, Object entity, LockMode lockMode) {
		getHibernateTemplate().lock(entityName, entity, lockMode);
	}

	public void lock(Object entity, LockMode lockMode) {
		getHibernateTemplate().lock(entity, lockMode);
	}

	/**
	 * 获取全部对象.
	 */
	public <T> List<T> getAll(Class<T> entityClass) {
		return getHibernateTemplate().loadAll(entityClass);
	}

	/**
	 * 获取全部对象,带排序字段与升降序参�?.
	 */
	public <T> List<T> getAll(Class<T> entityClass, String orderBy,
			boolean isAsc) {
		Assert.hasText(orderBy);
		if (isAsc)
			return getHibernateTemplate().findByCriteria(
					DetachedCriteria.forClass(entityClass).addOrder(
							Order.asc(orderBy)));
		else
			return getHibernateTemplate().findByCriteria(
					DetachedCriteria.forClass(entityClass).addOrder(
							Order.desc(orderBy)));
	}

	public List<?> find(String queryString) {
		Assert.hasText(queryString);
		return getHibernateTemplate().find(queryString);
	}

	/**
	 * 保存或更新对象.
	 */
	public void saveOrUpdate(Object o) {
		getSession().saveOrUpdate(o);
	}

	/**
	 * 保存对象
	 * 
	 * @param o
	 */
	public void save(Object o) {
		getHibernateTemplate().save(o);
	}

	/**
	 * 更新对象
	 * 
	 * @param o
	 */
	public void update(Object o) {
		getHibernateTemplate().update(o);
	}

	/**
	 * 删除对象.
	 */
	public void remove(Object o) {
		getHibernateTemplate().delete(o);
	}

	/**
	 * 根据ID删除对象.
	 */
	public <T> void removeById(Class<T> entityClass, Serializable id) {
		remove(get(entityClass, id));
	}

	public void flush() {
		getHibernateTemplate().flush();
	}

	public void clear() {
		getHibernateTemplate().clear();
	}

	/**
	 * 创建Query对象.
	 * 对于�?要first,max,fetchsize,cache,cacheRegion等诸多设置的函数,可以在返回Query后自行设�?.
	 * 留意可以连续设置,如下�?
	 * 
	 * <pre>
	 * dao.getQuery(hql).setMaxResult(100).setCacheable(true).list();
	 * </pre>
	 * 
	 * 调用方式如下�?
	 * 
	 * <pre>
	 *        dao.createQuery(hql)
	 *        dao.createQuery(hql,arg0);
	 *        dao.createQuery(hql,arg0,arg1);
	 *        dao.createQuery(hql,new Object[arg0,arg1,arg2])
	 * </pre>
	 * 
	 * @param values
	 *            可变参数.
	 */
	public Query createQuery(String hql, Object... values) {
		Assert.hasText(hql);
		Query query = getSession().createQuery(hql);
		for (int i = 0; i < values.length; i++) {
			query.setParameter(i, values[i]);
		}
		return query;
	}

	/**
	 * 创建Criteria对象.
	 * 
	 * @param criterions
	 *            可变的Restrictions条件列表,见{@link #createQuery(String,Object...)}
	 */
	public <T> Criteria createCriteria(Class<T> entityClass,
			Criterion... criterions) {
		Criteria criteria = getSession().createCriteria(entityClass);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}

	/**
	 * 创建Criteria对象，带排序字段与升降序字段.
	 * 
	 * @see #createCriteria(Class,Criterion[])
	 */
	public <T> Criteria createCriteria(Class<T> entityClass, String orderBy,
			boolean isAsc, Criterion... criterions) {
		// Assert.hasText(orderBy);
		Criteria criteria = createCriteria(entityClass, criterions);
		if (orderBy != null && !"".equals(orderBy)) {
			if (isAsc)
				criteria.addOrder(Order.asc(orderBy));
			else
				criteria.addOrder(Order.desc(orderBy));
		}
		return criteria;
	}

	/**
	 * 根据hql查询,直接使用HibernateTemplate的find函数.
	 * 
	 * @param values
	 *            可变参数,见{@link #createQuery(String,Object...)}
	 */
	public List find(String hql, Object... values) {
		Assert.hasText(hql);
		return getHibernateTemplate().find(hql, values);
	}

	/**
	 * 根据属�?�名和属性�?�查询对�?.
	 * 
	 * @return 符合条件的对象列�?
	 */
	public <T> List<T> findBy(Class<T> entityClass, String propertyName,
			Object value) {
		Assert.hasText(propertyName);
		return createCriteria(entityClass, Restrictions.eq(propertyName, value))
				.list();
	}

	/**
	 * 根据属�?�名和属性�?�查询对�?,带排序参�?.
	 */
	public <T> List<T> findBy(Class<T> entityClass, String propertyName,
			Object value, String orderBy, boolean isAsc) {
		Assert.hasText(propertyName);
		Assert.hasText(orderBy);
		return createCriteria(entityClass, orderBy, isAsc,
				Restrictions.eq(propertyName, value)).list();
	}

	/**
	 * 根据属�?�名和属性�?�查询唯�?对象.
	 * 
	 * @return 符合条件的唯�?对象 or null if not found.
	 */
	public <T> T findUniqueBy(Class<T> entityClass, String propertyName,
			Object value) {
		Assert.hasText(propertyName);
		return (T) createCriteria(entityClass,
				Restrictions.eq(propertyName, value)).uniqueResult();
	}

	/**
	 * 分页查询函数，使用hql.
	 * 
	 * @param pageNo
	 *            页号,�?1�?�?.
	 */
	public Pager pagedQuery(String hql, int pageNo, int pageSize,
			Object... values) {
		Assert.hasText(hql);
		// Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		// Count查询
		String countQueryString = (" select count (*) " + removeSelect(removeOrders(hql)))
				.replaceAll("fetch", "");
		List countlist = getHibernateTemplate().find(countQueryString, values);
		long totalCount = (Long) countlist.get(0);

		if (totalCount < 1)
			return new Pager(pageNo, pageSize);

		pageNo = Pager.validPageNo(pageNo, pageSize, totalCount);
		// 实际查询返回分页对象
		int startIndex = Pager.getStartOfPage(pageNo, pageSize);
		Query query = createQuery(hql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();

		return new Pager(pageNo, pageSize, totalCount, list);
	}

	/**
	 * 分页查询函数，使用hql语句分页. countHql 为统计条目数HQL语句方法
	 * 
	 * @param pageNo
	 *            页号.
	 */
	public Pager pagedQuery(String hql, String countHql, int pageNo,
			int pageSize, Object... values) {
		Assert.hasText(hql);
		// Count查询
		List countlist = getHibernateTemplate().find(countHql, values);
		long totalCount = (Long) countlist.get(0);
		if (totalCount < 1)
			return new Pager(pageNo, pageSize);
		pageNo = Pager.validPageNo(pageNo, pageSize, totalCount);
		// 实际查询返回分页对象
		int startIndex = Pager.getStartOfPage(pageNo, pageSize);
		Query query = createQuery(hql, values);
		List list = query.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();

		return new Pager(pageNo, pageSize, totalCount, list);
	}

	/**
	 * 分页查询函数，使用已设好查询条件与排序的<code>Criteria</code>.
	 * 
	 * @param pageNo
	 *            页号,�?1�?�?.
	 * @return 含�?�记录数和当前页数据的Page对象.
	 */
	public Pager pagedQuery(Criteria criteria, int pageNo, int pageSize) {
		Assert.notNull(criteria);
		// Assert.isTrue(pageNo >= 1, "pageNo should start from 1");
		CriteriaImpl impl = (CriteriaImpl) criteria;

		// 先把Projection和OrderBy条件取出�?,清空两�?�来执行Count操作
		Projection projection = impl.getProjection();
		List<CriteriaImpl.OrderEntry> orderEntries;
		try {
			orderEntries = (List) BeanUtils.forceGetProperty(impl,
					"orderEntries");
			BeanUtils.forceSetProperty(impl, "orderEntries", new ArrayList());
		} catch (Exception e) {
			throw new InternalError(" Runtime Exception impossibility throw ");
		}

		// 执行查询
		int totalCount = (Integer) criteria.setProjection(
				Projections.rowCount()).uniqueResult();

		// 将之前的Projection和OrderBy条件重新设回�?
		criteria.setProjection(projection);
		if (projection == null) {
			criteria.setResultTransformer(CriteriaSpecification.ROOT_ENTITY);
		}

		try {
			BeanUtils.forceSetProperty(impl, "orderEntries", orderEntries);
		} catch (Exception e) {
			throw new InternalError(" Runtime Exception impossibility throw ");
		}

		// 返回分页对象
		if (totalCount < 1)
			return new Pager(pageNo, pageSize);

		pageNo = Pager.validPageNo(pageNo, pageSize, totalCount);

		int startIndex = Pager.getStartOfPage(pageNo, pageSize);
		List list = criteria.setFirstResult(startIndex).setMaxResults(pageSize)
				.list();
		return new Pager(pageNo, pageSize, totalCount, list);
	}

	public Pager pagedQuery(Criteria criteria, String pageNo, String pageSize) {
		int intPageNo = 1;
		int intPageSize = 10;
		if (pageNo != null && !"".equals(pageNo))
			intPageNo = Integer.parseInt(pageNo);
		if (pageSize != null && !"".equals(pageSize))
			intPageSize = Integer.parseInt(pageSize);

		Pager pager = pagedQuery(criteria, intPageNo, intPageSize);

		return pager;

	}

	public Pager pagedQuery(String hql, String pageNo, String pageSize,
			Object... values) {
		int intPageNo = 1;
		int intPageSize = 100;
		if (pageNo != null && !"".equals(pageNo))
			intPageNo = Integer.parseInt(pageNo);
		if (pageSize != null && !"".equals(pageSize))
			intPageSize = Integer.parseInt(pageSize);
		Pager pager = pagedQuery(hql, intPageNo, intPageSize, values);
		return pager;

	}

	/**
	 * 分页查询函数，根据entityClass和查询条件参数创建默认的<code>Criteria</code>.
	 * 
	 * @param pageNo
	 *            页号,�?1�?�?.
	 * @return 含�?�记录数和当前页数据的Page对象.
	 */
	public Pager pagedQuery(Class entityClass, int pageNo, int pageSize,
			Criterion... criterions) {
		Criteria criteria = createCriteria(entityClass, criterions);
		return pagedQuery(criteria, pageNo, pageSize);
	}

	/**
	 * 分页查询函数，根据entityClass和查询条件参�?,排序参数创建默认�?<code>Criteria</code>.
	 * 
	 * @param pageNo
	 *            页号,�?1�?�?.
	 * @return 含�?�记录数和当前页数据的Page对象.
	 */
	public Pager pagedQuery(Class entityClass, int pageNo, int pageSize,
			String orderBy, boolean isAsc, Criterion... criterions) {
		Criteria criteria = createCriteria(entityClass, orderBy, isAsc,
				criterions);
		return pagedQuery(criteria, pageNo, pageSize);
	}

	/**
	 * 判断对象某些属�?�的值在数据库中是否唯一.
	 * 
	 * @param uniquePropertyNames
	 *            在POJO里不能重复的属�?�列�?,以�?�号分割 �?"name,loginid,password"
	 */
	public <T> boolean isUnique(Class<T> entityClass, Object entity,
			String uniquePropertyNames) {
		Assert.hasText(uniquePropertyNames);
		Criteria criteria = createCriteria(entityClass).setProjection(
				Projections.rowCount());
		criteria.add(Expression.eq("isDeleted", false));
		String[] nameList = uniquePropertyNames.split(",");
		try {
			// 循环加入唯一�?
			for (String name : nameList) {
				criteria.add(Restrictions.eq(name, PropertyUtils.getProperty(
						entity, name)));
			}

			// 以下代码为了如果是update的情�?,排除entity自身.

			String idName = getIdName(entityClass);

			// 取得entity的主键�??
			Serializable id = getId(entityClass, entity);

			// 如果id!=null,说明对象已存�?,该操作为update,加入排除自身的判�?
			if (id != null)
				criteria.add(Restrictions.not(Restrictions.eq(idName, id)));
		} catch (Exception e) {
			ReflectionUtils.handleReflectionException(e);
		}

		return (Integer) criteria.uniqueResult() == 0;
	}

	/**
	 * 取得对象的主键�??,辅助函数.
	 */
	public Serializable getId(Class entityClass, Object entity)
			throws NoSuchMethodException, IllegalAccessException,
			InvocationTargetException {
		Assert.notNull(entity);
		Assert.notNull(entityClass);
		return (Serializable) PropertyUtils.getProperty(entity,
				getIdName(entityClass));
	}

	/**
	 * 取得对象的主键名,辅助函数.
	 */
	public String getIdName(Class clazz) {
		Assert.notNull(clazz);
		ClassMetadata meta = getSessionFactory().getClassMetadata(clazz);
		Assert.notNull(meta, "Class " + clazz
				+ " not define in hibernate session factory.");
		String idName = meta.getIdentifierPropertyName();
		Assert.hasText(idName, clazz.getSimpleName()
				+ " has no identifier property define.");
		return idName;
	}

	/**
	 * 去除hql的select 子句，未考虑union的情�?,用于pagedQuery.
	 * 
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	private static String removeSelect(String hql) {
		Assert.hasText(hql);
		int beginPos = hql.toLowerCase().indexOf("from");
		Assert.isTrue(beginPos != -1, " hql : " + hql
				+ " must has a keyword 'from'");
		return hql.substring(beginPos);
	}

	/**
	 * 去除hql的orderby 子句，用于pagedQuery.
	 * 
	 * @see #pagedQuery(String,int,int,Object[])
	 */
	private static String removeOrders(String hql) {
		Assert.hasText(hql);
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	public void persist(Object entity) {
		getHibernateTemplate().persist(entity);
	}

	public List findBySQL(String sql) {
		return findBySQL(sql, null, null);
	}

	public List findBySQL(String sql, List entitys) {
		return findBySQL(sql, entitys, null);
	}

	public List findBySQL(final String sql, final List entitys, final List joins)
			throws DataAccessException {

		return (List) getHibernateTemplate().executeWithNativeSession(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException {
						SQLQuery sqlQuery = session.createSQLQuery(sql);
						if (entitys != null && !entitys.isEmpty()) {
							for (int i = 0; i < entitys.size(); i++) {
								if (entitys.get(i) instanceof Map) {
									Map entity = (Map) entitys.get(i);
									sqlQuery.addEntity((String) entity
											.get("alias"), (Class) entity
											.get("entityClass"));
								}
							}
						}
						if (joins != null && !joins.isEmpty()) {
							for (int i = 0; i < joins.size(); i++) {
								if (entitys.get(i) instanceof Map) {
									Map join = (Map) joins.get(i);
									sqlQuery.addJoin(
											(String) join.get("alias"),
											(String) join.get("path"));
								}
							}
						}
						return sqlQuery.list();
					}
				});
	}
}