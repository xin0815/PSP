package com.imnu.cnt.system.util;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFCellUtil;
import org.apache.poi.hssf.util.Region;

/**
 * 
 * @author 李松
 * 
 */
public class CommonUtil {
	
	public static Object getCellValue(HSSFCell cell) {
		if (cell == null) {
			return "";
		}
		int type = cell.getCellType();
		if (type == HSSFCell.CELL_TYPE_BLANK) {
			return "";
		} else if (type == HSSFCell.CELL_TYPE_BOOLEAN) {
			return cell.getBooleanCellValue();
		} else if (type == HSSFCell.CELL_TYPE_ERROR) {
			return "";
		} else if (type == HSSFCell.CELL_TYPE_FORMULA) {
			return "";
		} else if (type == HSSFCell.CELL_TYPE_NUMERIC) {
			return cell.getNumericCellValue();
		} else if (type == HSSFCell.CELL_TYPE_STRING) {
			return cell.getRichStringCellValue();
		} else {
			return "";
		}
	}
	
	/**
	 * 导出excel中，创建单元格
	 * @param sheet
	 * @param row
	 * @param cellIndex
	 * @param cellValue
	 * @param width
	 * @param style
	 * @param bRow
	 * @param bCell
	 * @param eRow
	 * @param eCell
	 */
	@SuppressWarnings("deprecation")
	public static void createCell(HSSFSheet sheet, HSSFRow row, int cellIndex,
			String cellValue, Integer width, HSSFCellStyle style, Integer bRow,
			Integer bCell, Integer eRow, Integer eCell) {
		HSSFCell cell = row.createCell(cellIndex);
		if(StringUtils.isBlank(cellValue) || "null".equals(cellValue)){
			cellValue = "";
		}
		cell.setCellValue(new HSSFRichTextString(cellValue));
		if (style != null) {
			cell.setCellStyle(style);
			
		}
		if (width != null) {
			sheet.setColumnWidth(cellIndex, 256 * width);
		}
		if (bRow != null && bCell != null && eRow != null && eCell != null) {
			Region region = new Region(bRow, (short) bCell.intValue(), eRow,
					(short) eCell.intValue());
			sheet.addMergedRegion(region);
			// 以下代码 解决合并单元格后边框问题
			setRegionStyle(sheet, region, style);

		}
	}
	/**
	 * 解决合并单元格后边框问题
	 * 
	 * @param sheet
	 * @param region
	 * @param cs
	 */
	public static void setRegionStyle(HSSFSheet sheet, Region region, HSSFCellStyle cs) {
		int toprowNum = region.getRowFrom();
		for (int i = region.getRowFrom(); i <= region.getRowTo(); i++) {
			HSSFRow row = HSSFCellUtil.getRow(i, sheet);
			for (int j = region.getColumnFrom(); j <= region.getColumnTo(); j++) {
				HSSFCell cell = HSSFCellUtil.getCell(row, (short) j);
				cell.setCellStyle(cs);
			}
		}
	}
	
	public static HSSFCellStyle getStyle(HSSFWorkbook wb,Boolean isTitle){
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);//左右居中
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//上下居中
		style.setBorderLeft((short)1);
		style.setBorderRight((short)1);
		style.setBorderTop((short)1);
		style.setBorderBottom((short)1);
		HSSFFont font = wb.createFont();
		font.setFontName("宋体_GB2312");//仿宋
		font.setFontHeightInPoints((short) 12);//字体大小
		style.setFont(font);
		
		if(isTitle){
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
		}
		return style;
	}
	public static HSSFCellStyle getLeftStyle(HSSFWorkbook wb,Boolean isTitle){
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_LEFT);//左右居中
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//上下居中
		style.setBorderLeft((short)1);
		style.setBorderRight((short)1);
		style.setBorderTop((short)1);
		style.setBorderBottom((short)1);
		HSSFFont font = wb.createFont();
		font.setFontName("宋体_GB2312");//仿宋
		font.setFontHeightInPoints((short) 12);//字体大小
		style.setFont(font);
		
		if(isTitle){
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//加粗
		}
		return style;
	}
	public static String parseScientific(String source) {
		String dest;
		try {
			BigDecimal decimal = new BigDecimal(source);
			DecimalFormat df = new DecimalFormat("0.########");
			dest = df.format(decimal.doubleValue());
		} catch (Exception e) {
			dest = source;
		}
		return dest;
	}
	
	public static boolean isFloat(String str) {
		try{
			Float f = Float.valueOf(str);
		}catch(NumberFormatException e){
			return false;
		}
        return true;
    }
	public static boolean isDouble(String str) {
		try{
			Double f = Double.valueOf(str);
		}catch(NumberFormatException e){
			return false;
		}
        return true;
    }
	public static boolean isInt(String str) {
		try{
			Integer f = Integer.valueOf(str);
		}catch(NumberFormatException e){
			return false;
		}
        return true;
    }
	
	public static boolean isNull(String property) {
		if (property != null && !"".equals(property.trim())
				&& !"null".equals(property.trim())) {
			return false;
		} else {
			return true;
		}

	}
	
	public static String dateToString(Date date,String format){
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	public static String strAdd(String a, String b){
		if(a == null && b != null){
			return b;
		}
		if(a != null && b == null){
			return a;
		}
		if(a == null && b == null){
			return "0";
		}
		Integer sum = Integer.valueOf(a) + Integer.valueOf(b);
		return String.valueOf(sum);
	}
	
	public static String strAddDiv(String a, String b){
		if(a == null && b != null){
			return b;
		}
		if(a != null && b == null){
			return a;
		}
		if(a == null && b == null){
			return "0";
		}
		Integer sum = Integer.valueOf(a) + Integer.valueOf(b);
		sum = sum/2;
		return String.valueOf(sum);
	}
	
	public static String ratio(String a, String b) {
		if(a == null && b != null){
			return "0.00";
		}
		if(a != null && b == null){
			return "100.00";
		}
		if(a == null && b == null){
			return "0.00";
		}
		try{
			Double ratio = 100*Double.valueOf(a)/Double.valueOf(b);
			String rs = String.valueOf(ratio);
			if(rs.indexOf('.') == -1){
				return rs + ".00";
			}
			
			rs = rs+"0000";
			
			rs = rs.substring(0, rs.indexOf('.')+3);
			return rs;
		}catch(ArithmeticException e){
			return "0.00";
		}
		
	}
	

	/**
	 * 获得当前日期后N天的日期。
	 * @param aDate
	 * @return （yyyy-MM-dd hh:mm:ss）
	 */
	public static String nowDateAddDates(Integer aDate) {
		SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, aDate);
		String d = dateFormatf.format(calendar.getTime());
		return d;
	}
	/**
	 * 将日期转换成指定日期
	 * @param  date 
	 * 		 indexTime
	 * @return （yyyy-MM-dd hh:mm:ss）
	 */
	public static String strdateToString(String date,Integer indexTime){
		SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd HH:00:00");
		Calendar c = Calendar.getInstance();
		String d = null;
		try {
			c.setTime(dateFormatf.parse(date));
			c.add(c.HOUR_OF_DAY,indexTime);
			d = dateFormatf.format(c.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return d;
	}
	
	/**
	 * 获得当前日期后N天的日期。
	 * @param aDate
	 * @return （yyyy-MM-dd hh:mm:ss）
	 */
	public static String dateToString(Date date) {
		SimpleDateFormat dateFormatf = new SimpleDateFormat("yyyy-MM-dd HH:00:00");
		return dateFormatf.format(date);
	}
	
	
	
	/**
	 * 获得当前日期后N天的日期。
	 * @param aDate 天数
	 * @param pattern 日期格式
	 * @return
	 */
	public static String nowDateAddDay4Format(Integer aDate, String pattern) {
		SimpleDateFormat dateFormatf = new SimpleDateFormat(pattern);
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, aDate);
		String d = dateFormatf.format(calendar.getTime());
		return d;
	}
	
	
	public static Map<String, Object> pagingCalculate(int size, int pageindex) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		int begin = size * (pageindex-1);
		int end = size * (pageindex);

		result.put("begin", begin);
		result.put("end", end);
		
		return result;
		
	}

	/**
	 * 字符编码转换（"ISO8859-1" --> "UTF-8"）
	 * @param fileName
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String toCNCode(String fileName)  {
		try {
			fileName = new String(fileName.getBytes("ISO8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return fileName;
	}
	
	/**
	 * 字符编码转换（"UTF-8" --> "ISO8859-1"）
	 * @param fileName
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String toENCode(String fileName) {
		try {
			fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return fileName;
	}
	
}
