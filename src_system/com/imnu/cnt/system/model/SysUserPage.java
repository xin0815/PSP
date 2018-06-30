package com.imnu.cnt.system.model;

/**
 * SysUserPage entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SysUserPage implements java.io.Serializable {

	// Fields

	private Integer userPageId;
	private SysUser sysUser = new SysUser();
	private SysPage sysPage = new SysPage();
	private Boolean isDeleted;

	// Constructors

	/** default constructor */
	public SysUserPage() {
	}

	/** full constructor */
	public SysUserPage(Integer userPageId, SysUser sysUser, SysPage sysPage,
			Boolean isDeleted) {
		this.userPageId = userPageId;
		this.sysUser = sysUser;
		this.sysPage = sysPage;
		this.isDeleted = isDeleted;
	}

	// Property accessors

	public Integer getUserPageId() {
		return this.userPageId;
	}

	public void setUserPageId(Integer userPageId) {
		this.userPageId = userPageId;
	}

	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}

	public SysPage getSysPage() {
		return sysPage;
	}

	public void setSysPage(SysPage sysPage) {
		this.sysPage = sysPage;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

}