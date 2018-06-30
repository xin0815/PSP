package com.imnu.cnt.system.model;

/**
 * SysUserRole entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SysUserRole implements java.io.Serializable {

	// Fields

	private Integer userRoleId;
	private SysUser sysUser = new SysUser();
	private SysRole sysRole = new SysRole();
	private Boolean isDeleted;

	// Constructors

	/** default constructor */
	public SysUserRole() {
	}

	/** full constructor */
	public SysUserRole(SysUser sysUser, SysRole sysRole,
			Boolean isDeleted) {
		this.sysUser = sysUser;
		this.sysRole = sysRole;
		this.isDeleted = isDeleted;
	}

	// Property accessors

	public Integer getUserRoleId() {
		return this.userRoleId;
	}

	public void setUserRoleId(Integer userRoleId) {
		this.userRoleId = userRoleId;
	}

	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}

	public SysRole getSysRole() {
		return sysRole;
	}

	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

}