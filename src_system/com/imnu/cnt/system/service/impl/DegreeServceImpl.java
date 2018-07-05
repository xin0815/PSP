package com.imnu.cnt.system.service.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.imnu.cnt.system.model.Degre;
import com.imnu.cnt.system.service.DegreeService;
import com.imnu.cnt.system.util.Pager;

@Service("DegreeService")
public class DegreeServceImpl extends BaseServiceImpl implements DegreeService {

	@Override
	public <Degree> Pager findall(Degre degree, String currentPage, String pageSize) {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Degre c where c.is_deleted=0");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

	@Override
	public void saveOrUpdate(Degre degree) {
		// TODO Auto-generated method stub
		baseDao.saveOrUpdate(degree);
		
	}

	@Override
	public Degre findByid(Integer DID) {
		// TODO Auto-generated method stub
		List<Degre> list =  baseDao.find("from Degre where DID = ?", DID);
		if(list.size()>0 && list != null){
			return list.get(0);
		}
		return null;
	}
	@Override
	public Pager findByname(String name,String currentPage,String pageSize) {
		// TODO Auto-generated method stub
		StringBuffer hql = new StringBuffer("from Degre c where c.DNAME like ? and c.is_deleted=0 ");
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize,"%"+name+"%");
	}
	
	

	


}
