package com.imnu.cnt.system.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Collections;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.service.SysModuleService;
import com.imnu.cnt.system.util.Pager;

@Service("sysModuleService")
public class SysModuleServiceImpl extends BaseServiceImpl implements
		SysModuleService {
	public <T> Pager find(SysModule sysModule, String currentPage,
			String pageSize) throws ServiceException {

		StringBuffer hql = new StringBuffer(
				"from SysModule c where c.isDeleted=0");
		if (!StringUtils.isEmpty(sysModule.getName())) {
			hql.append(" and c.name like '%").append(sysModule.getName())
					.append("%'");
		}
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

	public List<SysModule> find(SysModule sysModule) throws ServiceException {
		StringBuffer hql = new StringBuffer(
				"from SysModule c where c.isDeleted=0");
		if (!StringUtils.isEmpty(sysModule.getName())) {
			hql.append(" and c.name like '%").append(sysModule.getName())
					.append("%'");
		}
		List list = super.baseDao.find(hql.toString());
		if (list != null && !list.isEmpty()) {
			return list;
		}
		return Collections.EMPTY_LIST;
	}

	@Override
	public void batchDelete(String batchId) throws ServiceException {
		String hql = "update SysModule c set c.isDeleted=1 where c.moduleId=?";
		String idlist[] = batchId.split(",");
		for (String id : idlist) {
			if (!("".equals(id)) && id != null && !("null".equals(id))) {
				executeUpdate(hql, Integer.parseInt(id));
			}
		}
	}

	@Override
	public SysModule findSysModuleById(Integer id) throws ServiceException {
		String hql = "from SysModule c where c.moduleId=?";
		List list = baseDao.find(hql, new Integer[] { id });
		if (list != null && !list.isEmpty()) {
			return (SysModule) list.get(0);
		}
		return null;
	}

	public List<SysModule> findAll() {
		String hql = "from SysModule c where isDeleted=0";
		List list = baseDao.find(hql);
		if (list != null && !list.isEmpty()) {
			return list;
		}
		return Collections.EMPTY_LIST;
	}

	public List<SysModule> findSynchroSysModule() {
		String hql = "from SysModule where isSynchro=" + Boolean.TRUE
				+ " and isDeleted=0";
		List list = baseDao.find(hql);
		if (list != null && !list.isEmpty()) {
			return list;
		}
		return Collections.EMPTY_LIST;
	}


	private void insertSysModule(Connection conn, SysModule sysModule)
			throws ServiceException {
		String sql = "INSERT INTO [sys_module]([MODULE_ID],[NAME],[URL],[DESCRIPTION],[IS_DELETED],[IS_PSP_SYSTEM],[IS_SYNCHRO],[IP],[PORT],[DB_NAME],[DB_USER_NAME],[DB_PASSWORD])"
				+ " VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sysModule.getModuleId());
			ps.setString(2, sysModule.getName());
			ps.setString(3, sysModule.getUrl());
			ps.setString(4, sysModule.getDescription());
			ps.setBoolean(5, sysModule.getIsDeleted());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServiceException();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	private void updateSysModule(Connection conn, SysModule sysModule)
			throws ServiceException {
		String sql = "update [sys_module] set [NAME]=?,[URL]=?,[DESCRIPTION]=?,[IS_DELETED]=?,[IS_PSP_SYSTEM]=?,[IS_SYNCHRO]=?,[IP]=?,[PORT]=?,[DB_NAME]=?,[DB_USER_NAME]=?,[DB_PASSWORD]=?"
			+ " where [MODULE_ID]=?";
	PreparedStatement ps = null;
	try {
		ps = conn.prepareStatement(sql);
		ps.setString(1, sysModule.getName());
		ps.setString(2, sysModule.getUrl());
		ps.setString(3, sysModule.getDescription());
		ps.setBoolean(4, sysModule.getIsDeleted());
		ps.setInt(12, sysModule.getModuleId());
		ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServiceException();
		} finally {
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void saveOrUpdateSysModule(SysModule sysModule) {
		String type = "INSERT";
		if(sysModule.getModuleId() != null){
			type = "UPDATE";
		}
		baseDao.saveOrUpdate(sysModule);
	}
	
	public SysModule findPspSysModule() {
		String hql = "from SysModule where isPspSystem=" + Boolean.TRUE
				+ " and isDeleted=0";
		List<SysModule> list = (List<SysModule>)baseDao.find(hql);
		if (list != null && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}
}
