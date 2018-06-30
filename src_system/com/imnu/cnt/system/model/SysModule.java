package com.imnu.cnt.system.model;

/**
 * SysModule entity.
 * 
 * @author MyEclipse Persistence Tools
 */

public class SysModule implements java.io.Serializable {

	// Fields

	private Integer moduleId;
	private String name;
	private String url;
	private String description;
	private Boolean isDeleted;

	// Constructors

	/** default constructor */
	public SysModule() {
	}

	/** minimal constructor */
	public SysModule(Integer moduleId, String name, String url,
			Boolean isDeleted) {
		this.moduleId = moduleId;
		this.name = name;
		this.url = url;
		this.isDeleted = isDeleted;
	}

	/** full constructor */
	public SysModule(Integer moduleId, String name, String url,
			String description, Boolean isDeleted) {
		this.moduleId = moduleId;
		this.name = name;
		this.url = url;
		this.description = description;
		this.isDeleted = isDeleted;
	}

	// Property accessors

	public Integer getModuleId() {
		return this.moduleId;
	}

	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
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
}