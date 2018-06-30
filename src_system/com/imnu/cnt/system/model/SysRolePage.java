package com.imnu.cnt.system.model;

/**
 * SysRolePageId entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SysRolePage implements java.io.Serializable {

	// Fields

	private Integer rolePageId;
	private SysRole sysRole = new SysRole();
	private SysPage sysPage = new SysPage();
	private Boolean isDeleted;

	// Constructors

	/** default constructor */
	public SysRolePage() {
	}

	/** full constructor */
	public SysRolePage(Integer rolePageId, SysRole sysRole, SysPage sysPage,
			Boolean isDeleted) {
		this.rolePageId = rolePageId;
		this.sysRole = sysRole;
		this.sysPage = sysPage;
		this.isDeleted = isDeleted;
	}

	// Property accessors

	public Integer getRolePageId() {
		return this.rolePageId;
	}

	public void setRolePageId(Integer rolePageId) {
		this.rolePageId = rolePageId;
	}

	public SysRole getSysRole() {
		return sysRole;
	}

	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
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