package com.imnu.cnt.system.model;

/**
 * Klei entity. @author MyEclipse Persistence Tools
 */

public class Klei implements java.io.Serializable {

	// Fields

	private String code;
	private String name;

	// Constructors

	/** default constructor */
	public Klei() {
	}

	/** full constructor */
	public Klei(String name) {
		this.name = name;
	}

	// Property accessors

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

}