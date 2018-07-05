package com.imnu.cnt.system.model;

/**
 * Score entity. @author MyEclipse Persistence Tools
 */

public class Score implements java.io.Serializable {

	// Fields

	private ScoreId id;
	private Integer cid;
	private String term;
	private String klei;
	private String teaNumber;
	private String kaoqin;
	private String pingji;
	private String qiji;
	private String total;
	private String jifen;
	private String jidian;
	private String totalScore;
	private String qizhu;
	private String xiuye;

	// Constructors

	/** default constructor */
	public Score() {
	}

	/** minimal constructor */
	public Score(ScoreId id) {
		this.id = id;
	}

	/** full constructor */
	public Score(ScoreId id, Integer cid, String term, String klei, String teaNumber, String kaoqin, String pingji,
			String qiji, String total, String jifen, String jidian, String totalScore, String qizhu, String xiuye) {
		this.id = id;
		this.cid = cid;
		this.term = term;
		this.klei = klei;
		this.teaNumber = teaNumber;
		this.kaoqin = kaoqin;
		this.pingji = pingji;
		this.qiji = qiji;
		this.total = total;
		this.jifen = jifen;
		this.jidian = jidian;
		this.totalScore = totalScore;
		this.qizhu = qizhu;
		this.xiuye = xiuye;
	}

	// Property accessors

	public ScoreId getId() {
		return this.id;
	}

	public void setId(ScoreId id) {
		this.id = id;
	}

	public Integer getCid() {
		return this.cid;
	}

	public void setCid(Integer cid) {
		this.cid = cid;
	}

	public String getTerm() {
		return this.term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getKlei() {
		return this.klei;
	}

	public void setKlei(String klei) {
		this.klei = klei;
	}

	public String getTeaNumber() {
		return this.teaNumber;
	}

	public void setTeaNumber(String teaNumber) {
		this.teaNumber = teaNumber;
	}

	public String getKaoqin() {
		return this.kaoqin;
	}

	public void setKaoqin(String kaoqin) {
		this.kaoqin = kaoqin;
	}

	public String getPingji() {
		return this.pingji;
	}

	public void setPingji(String pingji) {
		this.pingji = pingji;
	}

	public String getQiji() {
		return this.qiji;
	}

	public void setQiji(String qiji) {
		this.qiji = qiji;
	}

	public String getTotal() {
		return this.total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getJifen() {
		return this.jifen;
	}

	public void setJifen(String jifen) {
		this.jifen = jifen;
	}

	public String getJidian() {
		return this.jidian;
	}

	public void setJidian(String jidian) {
		this.jidian = jidian;
	}

	public String getTotalScore() {
		return this.totalScore;
	}

	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}

	public String getQizhu() {
		return this.qizhu;
	}

	public void setQizhu(String qizhu) {
		this.qizhu = qizhu;
	}

	public String getXiuye() {
		return this.xiuye;
	}

	public void setXiuye(String xiuye) {
		this.xiuye = xiuye;
	}

}