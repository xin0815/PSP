package com.imnu.cnt.system.model;

/**
 * Student entity. @author MyEclipse Persistence Tools
 */

public class Student implements java.io.Serializable {

	// Fields

	private String stuNumber;
	private String stuName;
	private String stuSex;
	private String stuBirth;
	private String stuMinzu;
	private String stuMjmao;
	private String stuJiguan;
	private String stuLocation;
	private String stuFrom;
	private String stuBixiao;
	private String stuBxxs;
	private String stuRxfs;
	private String stuPycc;
	private String stuKeiei;
	private String stuGrade;
	private String stuXiku;
	private String stuZyek;
	private String stuXkek;
	private String stuBank;
	private String stuBiye;
	private String stuYu;
	private String stuRushi;
	private String stuBishi;

	// Constructors

	/** default constructor */
	public Student() {
	}

	/** full constructor */
	public Student(String stuName, String stuSex, String stuBirth, String stuMinzu, String stuMjmao, String stuJiguan,
			String stuLocation, String stuFrom, String stuBixiao, String stuBxxs, String stuRxfs, String stuPycc,
			String stuKeiei, String stuGrade, String stuXiku, String stuZyek, String stuXkek, String stuBank,
			String stuBiye, String stuYu, String stuRushi, String stuBishi) {
		this.stuName = stuName;
		this.stuSex = stuSex;
		this.stuBirth = stuBirth;
		this.stuMinzu = stuMinzu;
		this.stuMjmao = stuMjmao;
		this.stuJiguan = stuJiguan;
		this.stuLocation = stuLocation;
		this.stuFrom = stuFrom;
		this.stuBixiao = stuBixiao;
		this.stuBxxs = stuBxxs;
		this.stuRxfs = stuRxfs;
		this.stuPycc = stuPycc;
		this.stuKeiei = stuKeiei;
		this.stuGrade = stuGrade;
		this.stuXiku = stuXiku;
		this.stuZyek = stuZyek;
		this.stuXkek = stuXkek;
		this.stuBank = stuBank;
		this.stuBiye = stuBiye;
		this.stuYu = stuYu;
		this.stuRushi = stuRushi;
		this.stuBishi = stuBishi;
	}

	// Property accessors

	public String getStuNumber() {
		return this.stuNumber;
	}

	public void setStuNumber(String stuNumber) {
		this.stuNumber = stuNumber;
	}

	public String getStuName() {
		return this.stuName;
	}

	public void setStuName(String stuName) {
		this.stuName = stuName;
	}

	public String getStuSex() {
		return this.stuSex;
	}

	public void setStuSex(String stuSex) {
		this.stuSex = stuSex;
	}

	public String getStuBirth() {
		return this.stuBirth;
	}

	public void setStuBirth(String stuBirth) {
		this.stuBirth = stuBirth;
	}

	public String getStuMinzu() {
		return this.stuMinzu;
	}

	public void setStuMinzu(String stuMinzu) {
		this.stuMinzu = stuMinzu;
	}

	public String getStuMjmao() {
		return this.stuMjmao;
	}

	public void setStuMjmao(String stuMjmao) {
		this.stuMjmao = stuMjmao;
	}

	public String getStuJiguan() {
		return this.stuJiguan;
	}

	public void setStuJiguan(String stuJiguan) {
		this.stuJiguan = stuJiguan;
	}

	public String getStuLocation() {
		return this.stuLocation;
	}

	public void setStuLocation(String stuLocation) {
		this.stuLocation = stuLocation;
	}

	public String getStuFrom() {
		return this.stuFrom;
	}

	public void setStuFrom(String stuFrom) {
		this.stuFrom = stuFrom;
	}

	public String getStuBixiao() {
		return this.stuBixiao;
	}

	public void setStuBixiao(String stuBixiao) {
		this.stuBixiao = stuBixiao;
	}

	public String getStuBxxs() {
		return this.stuBxxs;
	}

	public void setStuBxxs(String stuBxxs) {
		this.stuBxxs = stuBxxs;
	}

	public String getStuRxfs() {
		return this.stuRxfs;
	}

	public void setStuRxfs(String stuRxfs) {
		this.stuRxfs = stuRxfs;
	}

	public String getStuPycc() {
		return this.stuPycc;
	}

	public void setStuPycc(String stuPycc) {
		this.stuPycc = stuPycc;
	}

	public String getStuKeiei() {
		return this.stuKeiei;
	}

	public void setStuKeiei(String stuKeiei) {
		this.stuKeiei = stuKeiei;
	}

	public String getStuGrade() {
		return this.stuGrade;
	}

	public void setStuGrade(String stuGrade) {
		this.stuGrade = stuGrade;
	}

	public String getStuXiku() {
		return this.stuXiku;
	}

	public void setStuXiku(String stuXiku) {
		this.stuXiku = stuXiku;
	}

	public String getStuZyek() {
		return this.stuZyek;
	}

	public void setStuZyek(String stuZyek) {
		this.stuZyek = stuZyek;
	}

	public String getStuXkek() {
		return this.stuXkek;
	}

	public void setStuXkek(String stuXkek) {
		this.stuXkek = stuXkek;
	}

	public String getStuBank() {
		return this.stuBank;
	}

	public void setStuBank(String stuBank) {
		this.stuBank = stuBank;
	}

	public String getStuBiye() {
		return this.stuBiye;
	}

	public void setStuBiye(String stuBiye) {
		this.stuBiye = stuBiye;
	}

	public String getStuYu() {
		return this.stuYu;
	}

	public void setStuYu(String stuYu) {
		this.stuYu = stuYu;
	}

	public String getStuRushi() {
		return this.stuRushi;
	}

	public void setStuRushi(String stuRushi) {
		this.stuRushi = stuRushi;
	}

	public String getStuBishi() {
		return this.stuBishi;
	}

	public void setStuBishi(String stuBishi) {
		this.stuBishi = stuBishi;
	}

}