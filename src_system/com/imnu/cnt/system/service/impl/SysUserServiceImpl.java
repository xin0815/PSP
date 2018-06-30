package com.imnu.cnt.system.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.hibernate.usertype.UserType;
import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.service.SysModuleService;
import com.imnu.cnt.system.service.SysUserService;
import com.imnu.cnt.system.util.Constants;
import com.imnu.cnt.system.util.Pager;

@Service("sysUserService")
public class SysUserServiceImpl extends BaseServiceImpl implements
		SysUserService {
	@Resource(name = "sysModuleService")
	SysModuleService sysModuleService;
	public SysUser checkUserName(String userName) {
		List<?> userList = baseDao.find("from SysUser u where u.account= '"
				+ userName + "' and u.isDeleted = 0 ");
		if (userList.size() == 1) {
			return (SysUser) userList.get(0);
		}
		return null;
	}

	public Object find(String name, String password) {
		List<?> userList = baseDao.find("from SysUser u where u.account= '"
				+ name + "'  and u.password = '" + password
				+ "' and u.isDeleted = 0 ");
		if (userList.size() == 1)
			return userList.get(0);
		return null;
	}

	public <T> Pager find(SysUser sysUser, String currentPage, String pageSize)
			throws ServiceException {

		StringBuffer hql = new StringBuffer(
				"from SysUser c where c.isDeleted=0");
		if (!StringUtils.isEmpty(sysUser.getUserName())) {
			hql.append(" and c.userName like '%").append(sysUser.getUserName())
					.append("%'");
		}
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

	@Override
	public void batchDelete(String batchId) throws ServiceException {
		String hql = "update SysUser c set c.isDeleted=1 where c.userId=?";
		String idlist[] = batchId.split(",");
		for (String id : idlist) {
			if (!("".equals(id)) && id != null && !("null".equals(id))) {
				executeUpdate(hql, Integer.parseInt(id));
			}
		}
	}
	private void deleteSysUser(Connection conn, Integer userId) throws ServiceException {
		String sql = "update sys_user set IS_DELETED=?  where USER_ID=?";
		PreparedStatement ps = null;
		try {
			ps.setBoolean(0, Boolean.TRUE);
			ps.setInt(1, userId);
			ps.execute();
		} catch (SQLException e) {
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
	public SysUser findSysUserById(Integer id) throws ServiceException {
		String hql = "from SysUser c where c.userId=?";
		List list = baseDao.find(hql, new Integer[] { id });
		if (list != null && !list.isEmpty()) {
			return (SysUser) list.get(0);
		}
		return null;
	}

	@Override
	public UserType findUserTypeByCode(String userTypeCode)
			throws ServiceException {
		String hql = "from UserType t where t.isDeleted=0 and t.userTypeCode='"
				+ userTypeCode + "'";
		List<UserType> list = (List<UserType>) baseDao.find(hql);
		if (list != null && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public void updateResetPassword(String batchId) throws ServiceException {
		String hql = "update SysUser c set c.password="
				+ Constants.DEFAULT_PASSWORD + " where c.userId=?";
		String idlist[] = batchId.split(",");
		for (String id : idlist) {
			if (!("".equals(id)) && id != null && !("null".equals(id))) {
				executeUpdate(hql, Integer.parseInt(id));
			}
		}
	}

	@Override
	public void saveOrUpdateSysUser(SysUser sysUser) throws ServiceException {
		//保存
		saveOrUpdate(sysUser);
	}

	public <T> Pager findAllUser(SysUser sysUser, String currentPage,
			String pageSize) throws ServiceException {

		StringBuffer hql = new StringBuffer(
				"from SysUser c where c.isDeleted=0");
		if (!StringUtils.isEmpty(sysUser.getUserName())) {
			hql.append(" and c.userName like '%").append(sysUser.getUserName())
					.append("%'");//模糊查询	
		}
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

}
