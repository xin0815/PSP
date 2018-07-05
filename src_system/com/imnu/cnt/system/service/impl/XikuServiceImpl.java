package com.imnu.cnt.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Degre;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.service.DegreeService;
import com.imnu.cnt.system.service.XikuService;
import com.imnu.cnt.system.util.Pager;

@Service("XikuService")
public class XikuServiceImpl extends BaseServiceImpl implements XikuService{

	@Override
	public <T> Pager findall(Xiku xiku, String currentPage, String pageSize) throws ServiceException {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Xiku c ");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

	@Override
	public void saveOrUpdate(Xiku xiku) throws ServiceException {
		// TODO Auto-generated method stub
		baseDao.saveOrUpdate(xiku);
	}

	@Override
	public Xiku findByid(String code) {
		// TODO Auto-generated method stub
		List<Xiku> list =  baseDao.find("from Xiku where code = ?", code);
		if(list.size()>0 && list != null){
			return list.get(0);
		}
		else
			return null;
	}

	@Override
	public Pager findByname(String name, String currentPage, String pageSize) {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Xiku c where c.code like ? ");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize,"%"+name+"%");
	}

	@Override
	public Xiku findByname(String name) {
		List<Xiku> list =  baseDao.find("from Xiku where name = ?", name);
		if(list.size()>0 && list != null){
			return list.get(0);
		}
		else
			return null;
	}
	
}
