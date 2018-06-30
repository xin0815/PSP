package com.imnu.cnt.system.util;


public class ValidationUtils extends
		org.springframework.validation.ValidationUtils {

	/**
	 * 验证该属性是否为空，或者为空字符串 为空或为空字符串返回false
	 * 
	 * @param 对象对应属性
	 * @return boolean
	 */
	public static boolean checkProperty(Object property) {
		if (property != null && !"".equals(property)
				&& !"null".equals(property)) {
			return true;
		} else {
			return false;
		}

	}
	
}
