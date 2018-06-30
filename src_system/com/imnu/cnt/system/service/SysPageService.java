package com.imnu.cnt.system.service;


import java.util.List;

import org.dom4j.Document;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysPage;

public interface SysPageService extends BaseService {

	public Document findPageTree()throws ServiceException;

	public String deleteSysPage(Integer id)throws ServiceException;

	public String findSysPage(Integer id)throws ServiceException;

	public void updateSysPage(SysPage page)throws ServiceException;

	public void newSysPage(SysPage page, String selectedItemID)throws ServiceException;

	public void newChildSysPage(SysPage page, String selectedItemID)throws ServiceException;
	
	public List<?> findbyHql(String hql,Object...values)throws ServiceException;
	
	public String findNextLevelCode(String selectedItemID)throws ServiceException;

	public String findNextChildLevelCode(String selectedItemID)throws ServiceException;
	
	SysPage getSysPageByUrl(String url);
}
