package com.imnu.cnt.system.model;

import java.util.HashSet;
import java.util.Set;

/**
 * SysRole entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SysRole implements java.io.Serializable {

	// Fields

	private Integer roleId;
	private String roleCode;
	private String roleName;
	private String description;
	private Boolean isDeleted;
	private Set sysRolePages = new HashSet(0);
	private Set sysUserRoles = new HashSet(0);

	// Constructors

	/** default constructor */
	public SysRole() {
	}

	// Property accessors

	public Integer getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public Set getSysRolePages() {
		return sysRolePages;
	}

	public void setSysRolePages(Set sysRolePages) {
		this.sysRolePages = sysRolePages;
	}

	public Set getSysUserRoles() {
		return sysUserRoles;
	}

	public void setSysUserRoles(Set sysUserRoles) {
		this.sysUserRoles = sysUserRoles;
	}

}