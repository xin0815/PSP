package com.imnu.cnt.system.model;

/**
 * Zyek entity. @author MyEclipse Persistence Tools
 */

public class Zyek implements java.io.Serializable {

	// Fields

	private String code;
	private String name;
	private String GCode;
	private String enName;

	// Constructors

	/** default constructor */
	public Zyek() {
	}

	/** full constructor */
	public Zyek(String name, String GCode, String enName) {
		this.name = name;
		this.GCode = GCode;
		this.enName = enName;
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

	public String getGCode() {
		return this.GCode;
	}

	public void setGCode(String GCode) {
		this.GCode = GCode;
	}

	public String getEnName() {
		return this.enName;
	}

	public void setEnName(String enName) {
		this.enName = enName;
	}

}