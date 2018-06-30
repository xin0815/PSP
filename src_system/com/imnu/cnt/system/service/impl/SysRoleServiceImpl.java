package com.imnu.cnt.system.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysRole;
import com.imnu.cnt.system.model.SysUser;
import com.imnu.cnt.system.model.SysUserRole;
import com.imnu.cnt.system.service.SysModuleService;
import com.imnu.cnt.system.service.SysRoleService;
import com.imnu.cnt.system.util.Pager;

@Service("sysRoleService")
public class SysRoleServiceImpl extends BaseServiceImpl implements
		SysRoleService {
	@Resource(name = "sysModuleService")
	SysModuleService sysModuleService;

	public <T> Pager find(SysRole sysRole, String currentPage, String pageSize)
			throws ServiceException {

		StringBuffer hql = new StringBuffer(
				"from SysRole c where c.isDeleted=0");
		if (!StringUtils.isEmpty(sysRole.getRoleName())) {
			hql.append(" and c.roleName like '%").append(sysRole.getRoleName())
					.append("%'");
		}
		return super.baseDao.pagedQuery(hql.toString(), currentPage, pageSize);
	}

	@Override
	public void batchDelete(String batchId) throws ServiceException {
		String hql = "update SysRole c set c.isDeleted=1 where c.roleId=?";
		String idlist[] = batchId.split(",");
		for (String id : idlist) {
			if (!("".equals(id)) && id != null && !("null".equals(id))) {
				executeUpdate(hql, Integer.parseInt(id));
			}
		}
	}

	@Override
	public SysRole findSysRoleById(Integer id) throws ServiceException {
		String hql = "from SysRole c where c.id=?";
		List list = baseDao.find(hql, new Integer[] { id });
		if (list != null && !list.isEmpty()) {
			return (SysRole) list.get(0);
		}
		return null;
	}

	@Override
	public List<SysUserRole> findSysUserRole(Integer roleId)
			throws ServiceException {
		String hql = "from SysUserRole sur left join fetch sur.sysUser su left join fetch sur.sysRole sr where sr.roleId=? and sur.isDeleted=0 and su.isDeleted=0";
		List list = baseDao.find(hql, roleId);
		if (list != null && !list.isEmpty()) {
			return list;
		}
		return Collections.EMPTY_LIST;
	}

	@Override
	public void saveOrUpdateRelationUser(Integer roleId, String relationUserIds)
			throws ServiceException {

		// 先删除角色和用户关联关系，后重新建立关系
		this.deleteSysUserRole(roleId);
		// 重新角色和用户关联关系
		this.batchSaveUserRole(roleId, relationUserIds);
		baseDao.flush();
		baseDao.clear();
	}

	private void batchSaveUserRole(Integer roleId, String _relationUserIds) {
		if (!StringUtils.isEmpty(_relationUserIds)) {
			SysRole sysRole = new SysRole();
			sysRole.setRoleId(roleId);
			List<SysUserRole> groupUserList = new ArrayList<SysUserRole>();
			String[] userIdArray = _relationUserIds.split(",");
			for (int i = 0; i < userIdArray.length; i++) {
				if (!StringUtils.isEmpty(userIdArray[i])) {
					SysUser user = this.findSysUserById(Integer
							.valueOf(userIdArray[i]));
					if (user != null) {
						SysUserRole userRole = new SysUserRole();
						userRole.setSysRole(sysRole);
						userRole.setSysUser(user);
						userRole.setIsDeleted(Boolean.FALSE);
						groupUserList.add(userRole);
					}
				}
			}
			baseDao.getHibernateTemplate().saveOrUpdateAll(groupUserList);
		}
	}

	private SysUser findSysUserById(Integer id) {
		String hql = "from SysUser c where c.isDeleted = 0 and c.userId=?";
		List list = baseDao.find(hql, id);
		if (list != null && !list.isEmpty()) {
			return (SysUser) list.get(0);
		}
		return null;
	}

	/**
	 * 根据角色id，删除该角色和所有用户的关联关系
	 * 
	 * @param roleId
	 * @throws ServiceException
	 */
	private void deleteSysUserRole(Integer roleId) throws ServiceException {
		String hql = "delete from SysUserRole c where c.sysRole.roleId = "
				+ roleId;
		executeUpdate(hql);
	}

	@Override
	public void saveOrUpdateSysRole(SysRole sysRole) throws ServiceException {
		baseDao.saveOrUpdate(sysRole);
	}

	@Override
	public SysRole findSysRoleByCode(String roleCode) {
		String hql = "from SysRole c where c.isDeleted=0 and c.roleCode='"+roleCode+"'";
		List list = baseDao.find(hql);
		if (list != null && !list.isEmpty()) {
			return (SysRole) list.get(0);
		}
		return null;
	}

	@Override
	public SysUserRole getSysUserRole(Integer userId, Integer roleId) {
		String hql = "from SysUserRole sur where sur.sysUser="+userId+" and sur.sysRole="+roleId;
		List list = baseDao.find(hql);
		if (list != null && !list.isEmpty()) {
			return (SysUserRole) list.get(0);
		}
		return null;
	}

}
