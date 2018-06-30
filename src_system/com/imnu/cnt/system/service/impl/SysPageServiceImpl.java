package com.imnu.cnt.system.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Service;

import com.imnu.cnt.system.exception.ServiceException;
import com.imnu.cnt.system.model.SysModule;
import com.imnu.cnt.system.model.SysPage;
import com.imnu.cnt.system.service.SysModuleService;
import com.imnu.cnt.system.service.SysPageService;
import com.imnu.cnt.system.util.ValidationUtils;

@Service("sysPageService")
public class SysPageServiceImpl extends BaseServiceImpl implements
		SysPageService {
	@Resource(name = "sysModuleService")
	SysModuleService sysModuleService;
	@SuppressWarnings("unchecked")
	public Document findPageTree() {
		Document document = DocumentHelper.createDocument();
		Element tree = document.addElement("tree");
		tree.addAttribute("id", "0");
		Element obj[] = new Element[20];
		int count = 0;
		String hql = "select c from SysPage as c where c.isDeleted=0 order by c.levelCode ";
		List<SysPage> listSysPageAll = (List<SysPage>) baseDao.find(hql);
		for (int i = 0; i < listSysPageAll.size(); i++) {
			SysPage page = listSysPageAll.get(i);
			if ((page.getLevelCode().length() / 2 - 1) == 0) {
				obj[(page.getLevelCode().length() / 2 - 1)] = tree
						.addElement("item");
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
						"text", page.getPageName());
				obj[(page.getLevelCode().length() / 2 - 1)].addAttribute("id",
						page.getPageId().toString());
				if (count == 0) {
					obj[(page.getLevelCode().length() / 2 - 1)].addAttribute(
							"select", "1");
					count = 1;
				}
			} else {
				if (obj[page.getLevelCode().length() / 2 - 2] != null) {
					obj[page.getLevelCode().length() / 2 - 1] = obj[page
							.getLevelCode().length() / 2 - 2]
							.addElement("item");
				} else {
					obj[page.getLevelCode().length() / 2 - 1] = DocumentHelper
							.createElement("item");
				}
				obj[page.getLevelCode().length() / 2 - 1].addAttribute("text",
						page.getPageName());
				obj[page.getLevelCode().length() / 2 - 1].addAttribute("id",
						page.getPageId().toString());
			}
		}
		return document;
	}

	@SuppressWarnings("unchecked")
	public String deleteSysPage(Integer id)throws ServiceException {
		Object bean = findEntityById(SysPage.class, id);
		if (ValidationUtils.checkProperty(bean)) {
			SysPage page = (SysPage) bean;
			String levelCode = page.getLevelCode();
			if (ValidationUtils.checkProperty(levelCode)) {
				String hql = "select c.pageId from SysPage as c where c.levelCode like '"
						+ levelCode + "%'";
				List<Object> idList = (List<Object>) baseDao.find(hql);
				String deletehql = "delete  from SysRolePage as c  where c.sysPage.pageId in ( ";
				String updateSysPage = "update SysPage as c set c.isDeleted =1 where c.pageId in ( ";
				String idStr = "";
				for (int i = 0; i < idList.size(); i++) {
					if (ValidationUtils.checkProperty(idList.get(i))) {
						idStr += idList.get(i).toString() + " ,";
					}
				}
				idStr = StringUtils.removeEnd(idStr, ",")+")";
				executeUpdate(updateSysPage+idStr);
				executeUpdate(deletehql+idStr);
			} else {
				return "系统编码不存在";
			}
		} else {
			return "对应PAGE对象不存在";
		}
		return null;
	}

	private String efficacyProperty(Object obj, String rturnMessage) {
		return (ValidationUtils.checkProperty(obj) ? obj.toString()
				: rturnMessage);
	}

	public String findSysPage(Integer id) {
		String hql = "from SysPage p " + "left join fetch p.sysModule m "
				+ "where p.isDeleted=0 and p.pageId=? "
				+ "and (m.isDeleted=0 or m.isDeleted is null)";

		SysPage sysPage = (SysPage) this.baseDao.find(hql, id).get(0);
		if (ValidationUtils.checkProperty(sysPage)) {
			return id
					+ "*"
					+ efficacyProperty(sysPage.getPageName(), "")
					+ "*"
					+ (ValidationUtils.checkProperty(sysPage.getSysModule()) ? sysPage
							.getSysModule().getModuleId()
							: "") + "*"
					+ efficacyProperty(sysPage.getUrl(), "") + "*"
					+ efficacyProperty(sysPage.getDescription(), "") + "*"
//					+ efficacyProperty(sysPage.getFunctionDepict(), "") + "*"
//					+ efficacyProperty(sysPage.getFunctionMethod(), "") + "*"
					+ "*"
					+ "*"
					+ efficacyProperty(sysPage.getLevelCode(), "") + "*"
					+ efficacyProperty(sysPage.getImgSrc(), "");
			
		}
		return "null";
	}

	public void updateSysPage(SysPage page)throws ServiceException {
		executeUpdate("update SysPage as c set pageName='" + page.getPageName()
				+ "',url = '" + page.getUrl() + "',sysModule.moduleId = "
				+ page.getSysModule().getModuleId() + ",description = '"
				+ page.getDescription()
//				+ "',functionDepict='"
//				+ page.getFunctionDepict() + "',functionMethod='"
//				+ page.getFunctionMethod()
				+ "' , levelCode = '"
				+ page.getLevelCode() + "',imgSrc = '" + page.getImgSrc()
				+ "'  where c.pageId=" + page.getPageId() + " ");

	}

	public void newChildSysPage(SysPage page, String selectedItemID) throws ServiceException{
		SysPage bean = (SysPage) findEntityById(SysPage.class, new Integer(
				selectedItemID));

		SysModule module = null;
		if (ValidationUtils.checkProperty(page.getSysModule().getModuleId())) {
			module = (SysModule) findEntityById(SysModule.class, page
					.getSysModule().getModuleId());
		}
		if (!ValidationUtils.checkProperty(page.getLevelCode())) {
			page.setLevelCode(findNextChildLevelCode(selectedItemID));
		}

		page
				.setOrderNo(new Integer(page.getLevelCode().substring(
						page.getLevelCode().length() - 2,
						page.getLevelCode().length())));
//		page.setIsMenu(true);
		page.setSysModule(module);
		page.setSysPage(bean);
		page.setIsDeleted(false);
//		page.setIsSystem(false);
		baseDao.save(page);
	}

	public void newSysPage(SysPage page, String selectedItemID)throws ServiceException {
		SysPage bean = (SysPage) findEntityById(SysPage.class, new Integer(
				selectedItemID));
		SysModule module = null;
		if (ValidationUtils.checkProperty(page.getSysModule().getModuleId())) {
			module = (SysModule) findEntityById(SysModule.class, page
					.getSysModule().getModuleId());
		}

		if (!ValidationUtils.checkProperty(page.getLevelCode())) {
			page.setLevelCode(findNextLevelCode(selectedItemID));
		}

//		page.setIsMenu(true);
		page.setSysModule(module);
		page
				.setOrderNo(new Integer(page.getLevelCode().substring(
						page.getLevelCode().length() - 2,
						page.getLevelCode().length())));
		page.setSysPage(bean.getSysPage());
//		page.setIsSystem(false);
		page.setIsDeleted(false);
		baseDao.save(page);
		
	}
	

	private void insertSysPage(Connection conn, SysPage sysPage)
			throws ServiceException {
		String sql = "INSERT INTO [sys_page]([PAGE_ID],[PRE_PAGE_ID],[PAGE_NAME],[MODULE_ID],[URL],[LEVEL_CODE],[ORDER_NO],[DESCRIPTION],[IMG_SRC],[IS_DELETED])"
				+ " VALUES (?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sysPage.getPageId());
			if(sysPage.getSysPage() != null){
				ps.setInt(2, sysPage.getSysPage().getPageId());
			}else{
				ps.setNull(2, Types.INTEGER);
			}
			ps.setString(3, sysPage.getPageName());
			ps.setInt(4, sysPage.getSysModule().getModuleId());
			ps.setString(5, sysPage.getUrl());
			ps.setString(6, sysPage.getLevelCode());
			if(sysPage.getOrderNo() != null){
				ps.setInt(7, sysPage.getOrderNo());
			}else{
				ps.setNull(7, Types.INTEGER);
			}
			ps.setString(8, sysPage.getDescription());
			ps.setString(9, sysPage.getImgSrc());
			ps.setBoolean(10, sysPage.getIsDeleted());
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

	private void updateSysPage(Connection conn, SysPage sysPage)
			throws ServiceException {
		String sql = "update category set [PRE_PAGE_ID]=?,[PAGE_NAME]=?,[MODULE_ID]=?,[URL]=?,[LEVEL_CODE]=?,[ORDER_NO]=?,[DESCRIPTION]=?,[IMG_SRC]=?,[IS_DELETED]=?"
				+ "  where PAGE_ID=?";
		PreparedStatement ps = null;
		try {
			ps = conn.prepareStatement(sql);
			if(sysPage.getSysPage() != null){
				ps.setInt(1, sysPage.getSysPage().getPageId());
			}else{
				ps.setNull(1, Types.INTEGER);
			}
			ps.setString(2, sysPage.getPageName());
			ps.setInt(3, sysPage.getSysModule().getModuleId());
			ps.setString(4, sysPage.getUrl());
			ps.setString(5, sysPage.getLevelCode());
			if(sysPage.getOrderNo() != null){
				ps.setInt(6, sysPage.getOrderNo());
			}else{
				ps.setNull(6, Types.INTEGER);
			}
			ps.setString(7, sysPage.getDescription());
			ps.setString(8, sysPage.getImgSrc());
			ps.setBoolean(9, sysPage.getIsDeleted());
			ps.setInt(10, sysPage.getPageId());
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

	public List<?> findbyHql(String hql, Object... values) {
		return this.baseDao.find(hql, values);
	}

	public String findNextLevelCode(String selectedItemID) throws ServiceException{
		String nextlevelCode = "";
		SysPage bean = (SysPage) findEntityById(SysPage.class, new Integer(
				selectedItemID));

		String levelCode = bean.getLevelCode();
		List<?> list = baseDao
				.find("select max(d.levelCode) from SysPage as d where d.levelCode like '"
						+ levelCode.substring(0, levelCode.length() - 2)
						+ "__'");
		if (list.size() > 0) {
			levelCode = list.get(0).toString();
		}
		String nextLevelCode = levelCode.substring(0, levelCode.length() - 2);
		int nextCode = (new Integer(levelCode.substring(levelCode.length() - 2,
				levelCode.length())) + 2);
		if (nextCode < 10) {
			nextlevelCode = nextLevelCode + "0" + nextCode;
		} else if (nextCode > 99) {
			nextlevelCode = nextLevelCode + "00";
		} else {
			nextlevelCode = nextLevelCode + nextCode;
		}
		return nextlevelCode;

	}

	public String findNextChildLevelCode(String selectedItemID) throws ServiceException{
		SysPage bean = (SysPage) findEntityById(SysPage.class, new Integer(
				selectedItemID));
		String nextlevelCode = "";
		String levelCode = bean.getLevelCode();
		List<?> list = baseDao
				.find("select max(d.levelCode) from SysPage as d where d.levelCode like '"
						+ levelCode + "__'");
		if (list.size() > 0) {
			if (ValidationUtils.checkProperty(list.get(0))) {
				if (list.get(0).toString().length() == levelCode.length()) {
					levelCode = levelCode + "01";
					nextlevelCode = levelCode;
				} else {
					levelCode = list.get(0).toString();
					String nextLevelCode = levelCode.substring(0, levelCode
							.length() - 2);
					int nextCode = (new Integer(levelCode.substring(levelCode
							.length() - 2, levelCode.length())) + 2);

					if (nextCode < 10) {
						nextlevelCode = nextLevelCode + "0" + nextCode;
					} else if (nextCode > 99) {
						nextlevelCode = nextLevelCode + "00";
					} else {
						nextlevelCode = nextLevelCode + nextCode;
					}
				}
			} else {
				nextlevelCode = levelCode + "01";
			}
		}
		return nextlevelCode;
	}

	@Override
	public SysPage getSysPageByUrl(String url) {
		String hql = "from SysPage s where s.url='"+url+"'";
		List<SysPage> list = (List<SysPage>)baseDao.find(hql);
		if(list != null && !list.isEmpty()){
			return list.get(0);
		}
		return null;
	}
}
