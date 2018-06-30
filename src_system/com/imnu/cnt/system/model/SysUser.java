package com.imnu.cnt.system.model;


import java.util.HashSet;
import java.util.Set;

/**
 * SysUser entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SysUser implements java.io.Serializable {

	// Fields

	private Integer userId;
	private String userName;
	private String account;
	private String password;
	private String description;
	private String userType;
	private Boolean isDeleted;
	private Set sysUserPages = new HashSet(0);
	private Set sysUserRoles = new HashSet(0);

	// Constructors

	/** default constructor */
	public SysUser() {
	}

	/** minimal constructor */
	public SysUser(Integer userId, String account, String password,
			Boolean isDeleted) {
		this.userId = userId;
		this.account = account;
		this.password = password;
		this.isDeleted = isDeleted;
	}

	/** full constructor */
	public SysUser(Integer userId, String userName, String account,
			String password, 
			String description, String userType, Boolean isDeleted) {
		this.userId = userId;
		this.userName = userName;
		this.account = account;
		this.password = password;
		this.description = description;
		this.userType = userType;
		this.isDeleted = isDeleted;
	}

	// Property accessors

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAccount() {
		return this.account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Boolean getIsDeleted() {
		return this.isDeleted;
	}

	public void setIsDeleted(Boolean isDeleted) {
		this.isDeleted = isDeleted;
	}

	public Set getSysUserPages() {
		return sysUserPages;
	}

	public void setSysUserPages(Set sysUserPages) {
		this.sysUserPages = sysUserPages;
	}

	public Set getSysUserRoles() {
		return sysUserRoles;
	}

	public void setSysUserRoles(Set sysUserRoles) {
		this.sysUserRoles = sysUserRoles;
	}

}