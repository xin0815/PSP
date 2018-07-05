package com.imnu.cnt.system.model;

/**
 * Course entity. @author MyEclipse Persistence Tools
 */

public class Course implements java.io.Serializable {

	// Fields

	private String courseNumber;
	private String courseName;
	private String courseEnName;

	// Constructors

	/** default constructor */
	public Course() {
	}

	/** full constructor */
	public Course(String courseName, String courseEnName) {
		this.courseName = courseName;
		this.courseEnName = courseEnName;
	}

	// Property accessors

	public String getCourseNumber() {
		return this.courseNumber;
	}

	public void setCourseNumber(String courseNumber) {
		this.courseNumber = courseNumber;
	}

	public String getCourseName() {
		return this.courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCourseEnName() {
		return this.courseEnName;
	}

	public void setCourseEnName(String courseEnName) {
		this.courseEnName = courseEnName;
	}

}