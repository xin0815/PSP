package com.imnu.cnt.system.model;

/**
 * ScoreId entity. @author MyEclipse Persistence Tools
 */

public class ScoreId implements java.io.Serializable {

	// Fields

	private String stuNumber;
	private String courseNumber;

	// Constructors

	/** default constructor */
	public ScoreId() {
	}

	/** full constructor */
	public ScoreId(String stuNumber, String courseNumber) {
		this.stuNumber = stuNumber;
		this.courseNumber = courseNumber;
	}

	// Property accessors

	public String getStuNumber() {
		return this.stuNumber;
	}

	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}

	public String getCourseNumber() {
		return this.courseNumber;
	}

	public void setCourseNumber(String courseNumber) {
		this.courseNumber = courseNumber;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof ScoreId))
			return false;
		ScoreId castOther = (ScoreId) other;

		return ((this.getStuNumber() == castOther.getStuNumber()) || (this.getStuNumber() != null
				&& castOther.getStuNumber() != null && this.getStuNumber().equals(castOther.getStuNumber())))
				&& ((this.getCourseNumber() == castOther.getCourseNumber())
						|| (this.getCourseNumber() != null && castOther.getCourseNumber() != null
								&& this.getCourseNumber().equals(castOther.getCourseNumber())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + (getStuNumber() == null ? 0 : this.getStuNumber().hashCode());
		result = 37 * result + (getCourseNumber() == null ? 0 : this.getCourseNumber().hashCode());
		return result;
	}

}