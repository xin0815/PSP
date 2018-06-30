

package com.imnu.cnt.system.util;

import java.io.File;


/**
 * 常量类
 * @author 额如乐
 *
 */
public class Constants {
	//系统用户类型   学生
	public static final String sys_userType_s = "01";
	public static final String sys_userType_t = "02";
	
	public static final String male = "男";
	public static final String female = "女";
	
	//角色编码   
	public static final String role_code_stu = "11";//学生
	public static final String role_code_xx = "13";//学校
	public static final String role_code_xy = "14";//学院
	public static final String role_code_bzr = "15";//班主任
	
	//默认密码
	public static final String DEFAULT_PASSWORD = "111111";
	
	public static final int uncheck = 1;//待审核
	public static final int check_success = 2;//审核通过
	public static final int check_cancel = 9;//退回
	
	public static final int spgrade = 1;//特殊困难
	public static final int pgrade = 2;//困难
	public static final int gpgrade = 3;//一般困难
	
	public static final int gagrade_first = 1;//一等国家助学金
	public static final int gagrade_second = 2;//二等国家助学金
	public static final int gagrade_third = 3;//三等国家助学金
	public static final int gamoney_first = 4000;//一等国家助学金金额
	public static final int gamoney_second = 3000;//二等国家助学金金额
	public static final int gamoney_third = 2000;//三等国家助学金金额
	
	public static final int salevel_firest =1;//校内奖学金  一等奖
	public static final int salevel_second =2;//校内奖学金  二等奖
	public static final int salevel_third = 3;//校内奖学金 三等奖
	public static final int salevel_single= 4;//校内奖学金 单项奖
	public static final int salevel_yxxsgb = 5;//校内奖学金  优秀学生干部
	public static final int single_ddfsj = 1;//校内奖学金   道德风尚奖
	public static final int single_kjcxj = 2;//校内奖学金 科技创新奖
	public static final int single_mztjj = 3;//校内奖学金 民族团结奖
	public static final int single_shgyhdj = 4;//校内奖学金 社会公益活动奖
	public static final int single_gljbj = 5;//校内奖学金  鼓励进步奖
	public static final int single_xxyxj = 6;//校内奖学金  学习优秀奖
	public static final int single_wtjnj = 7;//校内奖学金 文体技能奖
	
	
	
	public static final int jagrade_first = 1;//一等减免学费
	public static final int jagrade_second = 2;//二等减免学费
	public static final int jagrade_third = 3;//三等减免学费
	
	public static final int paacheck_tjrd = 3;//提交认定

	public static final int eatype1 = 1;//三好学生
	public static final int eatype2 = 2;//优秀班干部
	public static final int eatype3 = 3;//优秀毕业生
	
	public static File WEB_ROOT;
	public static File WEB_CLASSES;
	public static int maacheck;
	static {
		String cp = Constants.class.getClassLoader().getResource("").getFile();
		WEB_CLASSES = new File(cp);
		String tp = Constants.class.getClassLoader().getResource("").getFile();
		tp = tp.substring(0, tp.length() - "WEB-INF/classes/".length());
		WEB_ROOT = new File(tp);
		assert WEB_ROOT.exists() && WEB_ROOT.isDirectory();

	}
	
	public static int getGamoney(int gagrade){
		if(gagrade == gagrade_first){
			return gamoney_first;
		}else if(gagrade == gagrade_second){
			return gamoney_second;
		}else if(gagrade == gagrade_third){
			return gamoney_third;
		}
		return 0;
	}
	
	public static String getScholarshipTypeName(Integer salevel){
		if(salevel == null){
			return "";
		}
		if(Constants.salevel_firest == salevel){
			return "一等奖学金";
		}
		if(Constants.salevel_second == salevel){
			return "二等奖学金";
		}
		if(Constants.salevel_third == salevel){
			return "三等奖学金";
		}
		if(Constants.salevel_yxxsgb == salevel){
			return "优秀学生干部奖";
		}
		if(Constants.salevel_single == salevel){
			return "单项奖";
		}
		return "";
	}
	
	public static String getSingleTypeName(Integer singleLevel){
		if(singleLevel == null){
			return "";
		}
		if(Constants.single_ddfsj == singleLevel.intValue()){
			return "道德风尚奖";
		}
		if(Constants.single_kjcxj == singleLevel.intValue()){
			return "科技创新奖";
		}
		if(Constants.single_mztjj == singleLevel.intValue()){
			return "民族团结奖";
		}
		if(Constants.single_shgyhdj == singleLevel.intValue()){
			return "社会公益活动奖";
		}
		if(Constants.single_gljbj == singleLevel.intValue()){
			return "鼓励进步奖";
		}
		if(Constants.single_xxyxj == singleLevel.intValue()){
			return "学习优秀奖";
		}
		if(Constants.single_wtjnj == singleLevel.intValue()){
			return "文体技能奖";
		}
		return "";
	}

}
