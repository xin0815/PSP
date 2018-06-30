package com.imnu.cnt.system.util;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.dao.support.DaoSupport;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;


public abstract class HibernateDaoSupport extends DaoSupport {

	@Resource
    private HibernateTemplate hibernateTemplate;


    public final void setSessionFactory(SessionFactory sessionFactory) {
      this.hibernateTemplate = createHibernateTemplate(sessionFactory);
    }

   
    protected HibernateTemplate createHibernateTemplate(SessionFactory sessionFactory) {
        return new HibernateTemplate(sessionFactory);
    }

    public final SessionFactory getSessionFactory() {
        return (this.hibernateTemplate != null ? this.hibernateTemplate.getSessionFactory() : null);
    }

   
    public final void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    
    public final HibernateTemplate getHibernateTemplate() {
      return this.hibernateTemplate;
    }

    protected final void checkDaoConfig() {
        if (this.hibernateTemplate == null) {
            throw new IllegalArgumentException("'sessionFactory' or 'hibernateTemplate' is required");
        }
    }


    protected final Session getSession()
        throws DataAccessResourceFailureException, IllegalStateException {

        return getSession(this.hibernateTemplate.isAllowCreate());
    }

    protected final Session getSession(boolean allowCreate)
        throws DataAccessResourceFailureException, IllegalStateException {

        return (!allowCreate ?
            SessionFactoryUtils.getSession(getSessionFactory(), false) :
                SessionFactoryUtils.getSession(
                        getSessionFactory(),
                        this.hibernateTemplate.getEntityInterceptor(),
                        this.hibernateTemplate.getJdbcExceptionTranslator()));
    }

   
    protected final DataAccessException convertHibernateAccessException(HibernateException ex) {
        return this.hibernateTemplate.convertHibernateAccessException(ex);
    }

    protected final void releaseSession(Session session) {
        SessionFactoryUtils.releaseSession(session, getSessionFactory());
    }

} 


