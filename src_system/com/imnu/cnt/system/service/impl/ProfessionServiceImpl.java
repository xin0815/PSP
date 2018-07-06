package com.imnu.cnt.system.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.Xiku;
import com.imnu.cnt.system.model.Zyek;
import com.imnu.cnt.system.service.ProfessionService;
import com.imnu.cnt.system.util.Pager;

@Service("ProfessionService")
public class ProfessionServiceImpl extends BaseServiceImpl implements ProfessionService{

	@Override
	public <T> Pager findall(Zyek zyek, String currentPage, String pageSize) throws ServiceException {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Zyek c ");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

	@Override
	public void saveOrUpdate(Zyek zyek) throws ServiceException {
		// TODO Auto-generated method stub
		baseDao.saveOrUpdate(zyek);
		
	}

	@Override
	public Zyek findByid(String code) {
		// TODO Auto-generated method stub
		List<Zyek> list =  baseDao.find("from Zyek where code = ?", code);
		if(list.size()>0 && list != null){
			return list.get(0);
		}
		else
			return null;
	}

	@Override
	public Pager findByname(String name, String currentPage, String pageSize) {
		StringBuffer hql = new StringBuffer("from Zyek c where c.name like ? ");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize,"%"+name+"%");
	}

	@Override
	public Zyek findByname(String name) {
		List<Zyek> list =  baseDao.find("from Zyek where name = ?", name);
		if(list.size()>0 && list != null){
			return list.get(0);
		}
		else
			return null;
	}

}
