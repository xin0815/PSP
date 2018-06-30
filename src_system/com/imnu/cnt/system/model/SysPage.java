package com.imnu.cnt.system.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.imnu.cnt.system.util.ValidationUtils;

/**
 * SysPage entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SysPage implements java.io.Serializable {

	// Fields

	private Integer pageId;
	private SysPage sysPage;
	private String pageName;
	private SysModule sysModule = new SysModule();
	private String url;
	private String levelCode;
	private Integer orderNo;
	private String description;
	private String imgSrc;
	private String activeBeginTime;
	private String activeEndTime;
	private Boolean isDeleted;
	private List sysPages = new ArrayList<SysPage>();
	private Set sysUserPages = new HashSet(0);
	private Set sysRolePages = new HashSet(0);
	private Boolean isShow;//一级菜单没有所属二级菜单时候，不显示该菜单
	
	public Boolean getIsShow() {
		if (ValidationUtils.checkProperty(sysPages) && sysPages.size() > 0) {
			return true;
		} else {
			if (ValidationUtils.checkProperty(url)) {
				return true;
			} else {
				return false;
			}
		}
	}

	// Constructors

	/** default constructor */
	public SysPage() {
	}

	/** minimal constructor */
	public SysPage(Integer pageId, SysPage sysPage, String pageName,
			SysModule module, Boolean isDeleted) {
		this.pageId = pageId;
		this.sysPage = sysPage;
		this.pageName = pageName;
		this.sysModule = module;
		this.isDeleted = isDeleted;
	}

	/** full constructor */
	public SysPage(Integer pageId, SysPage sysPage, String pageName,
			SysModule module, String url, String levelCode, Integer orderNo,
			String description, String imgSrc, Boolean isDeleted) {
		this.pageId = pageId;
		this.sysPage = sysPage;
		this.pageName = pageName;
		this.sysModule = module;
		this.url = url;
		this.levelCode = levelCode;
		this.orderNo = orderNo;
		this.description = description;
		this.imgSrc = imgSrc;
		this.isDeleted = isDeleted;
	}

	// Property accessors

	public Integer getPageId() {
		return this.pageId;
	}

	public void setPageId(Integer pageId) {
		this.pageId = pageId;
	}

	public String getPageName() {
		return this.pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}


	public SysPage getSysPage() {
		return sysPage;
	}

	public void setSysPage(SysPage sysPage) {
		this.sysPage = sysPage;
	}

	public SysModule getSysModule() {
		return sysModule;
	}

	public void setSysModule(SysModule sysModule) {
		this.sysModule = sysModule;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLevelCode() {
		return this.levelCode;
	}

	public void setLevelCode(String levelCode) {
		this.levelCode = levelCode;
	}

	public Integer getOrderNo() {
		return this.orderNo;
	}

	public void setOrderNo(Integer orderNo) {
		this.orderNo = orderNo;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImgSrc() {
		return this.imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public List getSysPages() {
		return sysPages;
	}

	public void setSysPages(List sysPages) {
		this.sysPages = sysPages;
	}

	public Set getSysUserPages() {
		return sysUserPages;
	}

	public void setSysUserPages(Set sysUserPages) {
		this.sysUserPages = sysUserPages;
	}

	public Set getSysRolePages() {
		return sysRolePages;
	}

	public void setSysRolePages(Set sysRolePages) {
		this.sysRolePages = sysRolePages;
	}

	public void setIsShow(Boolean isShow) {
		this.isShow = isShow;
	}

	public String getActiveBeginTime() {
		return activeBeginTime;
	}

	public void setActiveBeginTime(String activeBeginTime) {
		this.activeBeginTime = activeBeginTime;
	}

	public String getActiveEndTime() {
		return activeEndTime;
	}

	public void setActiveEndTime(String activeEndTime) {
		this.activeEndTime = activeEndTime;
	}

}