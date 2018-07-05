package com.imnu.cnt.system.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


public class Degre implements Serializable{
	
	private Integer DID;
	
	
	private String DNAME;
	

	private Integer is_deleted;
	
	private String DNAME1;
	

	public String getDNAME1() {
		return DNAME1;
	}

	public void setDNAME1(String dNAME1) {
		DNAME1 = dNAME1;
	}

	public Degre() {
		super();
	}

	public Degre(Integer dID, String dNAME, Integer is_deleted) {
		super();
		DID = dID;
		DNAME = dNAME;
		this.is_deleted = is_deleted;
	}

	public Integer getDID() {
		return DID;
	}

	public void setDID(Integer dID) {
		DID = dID;
	}

	public String getDNAME() {
		return DNAME;
	}

	public void setDNAME(String dNAME) {
		DNAME = dNAME;
	}

	public Integer getIs_deleted() {
		return is_deleted;
	}

	public void setIs_deleted(Integer is_deleted) {
		this.is_deleted = is_deleted;
	}
	
}
