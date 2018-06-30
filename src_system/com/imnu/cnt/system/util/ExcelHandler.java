package com.imnu.cnt.system.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;




/**
 * Excel 处理器 1. 读取Excel模板 2. 构建Excel 3. 读取Excel 4.
 * 输出Excel（文件系统、HttpServletResponse）
 * 
 * @author 李松
 * 
 */
public class ExcelHandler {
	private Logger logger = LoggerFactory.getLogger(ExcelHandler.class);
	
	public static final String EXCEL_DIRECTORY = Constants.WEB_ROOT + "\\doc\\";
	public static final String EXCEL_SUFFIX = ".xls";
	public static final Integer PAGE_SIZE = 10000;
	
	public static final String CLASS_NAME_STRING = "java.lang.String";
	public static final String CLASS_NAME_INTEGER = "java.lang.Integer";
	public static final String CLASS_NAME_FLOAT = "java.lang.Float";
	public static final String CLASS_NAME_DOUBLE = "java.lang.Double";
	public static final String CLASS_NAME_BOOLEAN = "java.lang.Boolean";
	public static final String CLASS_NAME_BIGDECIMAL = "java.math.BigDecimal";
	
	
	/**
	 * 读取Excel模板
	 * @param templateName
	 * @return
	 */
	public HSSFWorkbook loadTemplate(String templateName) {
		return loadTemplate(new File(EXCEL_DIRECTORY + templateName + EXCEL_SUFFIX));
	}
	
	/**
	 * 读取指定文件的Excel
	 * @param data
	 * @return
	 */
	public HSSFWorkbook loadTemplate(File file) {
		logger.info("载入的文件.... [filename=" + file.getPath() + "]");
		HSSFWorkbook result = null;
		if (file.exists()) {
			try {
				result = loadTemplate(new FileInputStream(file));
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		} else {
			logger.info("载入的文件不存在！[filename=" + file.getPath() + "]");
		}
		return result;
	}
	
	/**
	 * 读取指定InputStream中的Excel文件
	 * @param in
	 * @return
	 */
	public HSSFWorkbook loadTemplate(InputStream in) {
		HSSFWorkbook result = null;
		try {
			result = new HSSFWorkbook(in);
		} catch (IOException e) {
			e.printStackTrace();
			logger.info("文件正被占用，无法载入！");
		}
		return result;
	}

	/**
	 * 在指定模版上，将数据添加到工作表中。
	 * 
	 * @param templateName
	 * @param data
	 */
	public HSSFWorkbook build(String templateName, List<List<Object>> data) {
		return build(templateName, data, 0, 0);
	}

	/**
	 * 在指定模版上，将数据添加到工作表的(x,y)位置上。
	 * 
	 * @param templateName
	 * @param data
	 * @param x
	 * @param y
	 */
	public HSSFWorkbook build(String templateName, List<List<Object>> data, Integer x,
			Integer y) {
		HSSFWorkbook workbook = loadTemplate(templateName);
		
		if (workbook == null) {
			logger.info("未能获得有效的工作簿模板！");
			return null;
		}
		
		build(workbook, data, x, y);
		
		return workbook;
	}

	/**
	 * 在指定工作簿中（x,y）位置填充数据（分页）
	 * @param workbook
	 * @param data
	 * @param x
	 * @param y
	 */
	private void build(HSSFWorkbook workbook, List<List<Object>> data,
			Integer x, Integer y) {
		List<HSSFSheet> sheels = new ArrayList<HSSFSheet>();
		Integer dataSize = data.size();
		Integer totalPage = dataSize / PAGE_SIZE + ((dataSize % PAGE_SIZE == 0)? 0 : 1);
		
		sheels.add(workbook.getSheetAt(0));
		for (int i = 1; i < totalPage; i++) {
			sheels.add(workbook.cloneSheet(0));
		}
		
		for (int i = 0; i < totalPage; i++) {
			HSSFSheet sheet = sheels.get(i);
			
			List<List<Object>> tempData = new ArrayList<List<Object>>();
			
			for (int j = i*PAGE_SIZE; j < (i+1)*PAGE_SIZE; j++) {
				try {
					tempData.add(data.get(j));
				} catch (Exception e) {
					// 下标越界，无关紧要。
				}
			}
			
			organizeSheel(tempData, sheet, x, y);
		}
	}

	/**
	 * 将data填充的列表展现的指定位置上。
	 * @param data
	 * @param sheet
	 * @param x
	 * @param y
	 */
	private void organizeSheel(List<List<Object>> data, HSSFSheet sheet, Integer x, Integer y) {
		for (int i = 0; i < data.size(); i++) {
			
			HSSFRow row = sheet.createRow(y + i);
			
			List<Object> l = data.get(i);
			
			
			for (int j = 0; j < l.size(); j++) {
				if(j == 0 && row.getRowNum() == 2)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "呼和浩特市四区");
				}
				if(j == 1 && row.getRowNum() == 2)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "玉泉区");
				}
				if(j == 0 && row.getRowNum() == 3)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "呼和浩特市四区");
				}
				if(j == 1 && row.getRowNum() == 3)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "回民区");
				}
				if(j == 0 && row.getRowNum() == 4)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "呼和浩特市四区");
				}
				if(j == 1 && row.getRowNum() == 4)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "赛罕区");
				}
				if(j == 0 && row.getRowNum() == 5)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "呼和浩特市四区");
				}
				if(j == 1 && row.getRowNum() == 5)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "新城区");
				}
				if(j == 0 && row.getRowNum() == 6)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旗县");
				}
				if(j == 1 && row.getRowNum() == 6)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "土左旗");
				}
				if(j == 0 && row.getRowNum() == 7)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旗县");
				}
				if(j == 1 && row.getRowNum() == 7)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "呼市郊区");
				}
				if(j == 0 && row.getRowNum() == 8)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旗县");
				}
				if(j == 1 && row.getRowNum() == 8)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "托县");
				}
				if(j == 0 && row.getRowNum() == 9)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旗县");
				}
				if(j == 1 && row.getRowNum() == 9)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "和林县");
				}
				
				if(j == 0 && row.getRowNum() == 10)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旗县");
				}
				if(j == 1 && row.getRowNum() == 10)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "武川县");
				}
				
				if(j == 0 && row.getRowNum() == 11)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旗县");
				}
				if(j == 1 && row.getRowNum() == 11)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "清水河");
				}
				
				if(j == 0 && row.getRowNum() == 12)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旅游景区");
				}
				if(j == 1 && row.getRowNum() == 12)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "昭君博物院");
				}
				if(j == 0 && row.getRowNum() == 13)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旅游景区");
				}
				if(j == 1 && row.getRowNum() == 13)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "老牛湾旅游区");
				}
				if(j == 0 && row.getRowNum() == 14)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "旅游景区");
				}
				if(j == 1 && row.getRowNum() == 14)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "哈素海旅游区");
				}
				
				if(j == 0 && row.getRowNum() == 15)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "工业园区");
				}
				if(j == 1 && row.getRowNum() == 15)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "托克托县电厂");
				}
				if(j == 0 && row.getRowNum() == 16)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "工业园区");
				}
				if(j == 1 && row.getRowNum() == 16)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "金山开发区");
				}
				if(j == 0 && row.getRowNum() == 17)
				{
					HSSFCell cell = row.createCell(0);
					setCellValue(cell, "工业园区");
				}
				if(j == 1 && row.getRowNum() == 17)
				{
					HSSFCell cell = row.createCell(1);
					setCellValue(cell, "蒙牛工业园区");
				}
				HSSFCell cell = row.createCell(j+x);
				Object o = l.get(j);
				
				setCellValue(cell, o);
				
			}
			
		}
	}
	/**
	 * 将data填充的Sheel的指定位置上。
	 * @param data
	 * @param sheet
	 * @param x
	 * @param y
	 */
	private void organizeSheel2(List<List<Object>> data, HSSFSheet sheet, Integer x, Integer y) {
		for (int i = 0; i < data.size(); i++) {
			HSSFRow row = sheet.createRow(y + i);
			
			List<Object> l = data.get(i);
			
			for (int j = 0; j < l.size(); j++) {
				HSSFCell cell = row.createCell(j);
				Object o = l.get(x + j);
				
				setCellValue(cell, o);
				
			}
		}
	}


	/**
	 * 按照指定单元格设置值（按照o的类型设置单元格类型）
	 * @param cell
	 * @param value
	 */
	private void setCellValue(HSSFCell cell, Object value) {
		if (CLASS_NAME_STRING.equals(value.getClass().getName())) {
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(value.toString());
		} else if (CLASS_NAME_BOOLEAN.equals(value.getClass().getName())) {
			cell.setCellType(HSSFCell.CELL_TYPE_BOOLEAN);
			cell.setCellValue(Boolean.parseBoolean(value.toString()));
		} else if (CLASS_NAME_INTEGER.equals(value.getClass().getName())) {
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell.setCellValue(Integer.parseInt(value.toString()));
		} else if (CLASS_NAME_FLOAT.equals(value.getClass().getName())) {
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell.setCellValue(Float.parseFloat(value.toString()));
		} else if (CLASS_NAME_DOUBLE.equals(value.getClass().getName())) {
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell.setCellValue(Double.parseDouble(value.toString()));
		} else if (CLASS_NAME_BIGDECIMAL.equals(value.getClass().getName())) {
			cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell.setCellValue(Double.parseDouble(value.toString()));
		}
	}
	
	/**
	 * 设置指定工作簿 - 工作表 - 行 - 列 的值（按照value的类型设置单元格类型）
	 * @param workbook
	 * @param shellIndex
	 * @param rowIndex
	 * @param cellIndex
	 * @param value
	 */
	public void setCellValue(HSSFWorkbook workbook, Integer shellIndex, Integer rowIndex, Integer cellnum, Object value) {
		HSSFSheet sheet = workbook.getSheetAt(shellIndex);
		HSSFRow row = sheet.getRow(rowIndex);
		HSSFCell cell = row.getCell(cellnum);
		setCellValue(cell, value);
	}

	/**
	 * 按照指定路径读取Excel文件，返回数据矩阵。
	 * 
	 * @param path
	 * @return
	 */
	public List<List<Object>> read(String path) {
		List<List<Object>> result = null;
		return result;
	}

	/**
	 * 按照读取指定Excel文件，返回数据矩阵。
	 * 
	 * @param file
	 * @return
	 */
	public List<List<Object>> read(File file) {
		List<List<Object>> result = null;
		return result;
	}

	/**
	 * 从InputStream中读取Excel文件，返回数据矩阵。
	 * 
	 * @param input
	 * @return
	 */
	public List<List<Object>> read(InputStream input) {
		List<List<Object>> result = null;
		return result;
	}

	/**
	 * 将工作簿输出到指定路径的文件。
	 * 
	 * @param path
	 * @param workbook
	 */
	public void output(String path, HSSFWorkbook workbook) {
		output(new File(path), workbook);
	}

	/**
	 * 将工作簿输出到指定的文件。
	 * 
	 * @param file
	 * @param workbook
	 */
	public void output(File file, HSSFWorkbook workbook) {
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
				logger.info("创建文件发送异常！[file=" + file.getPath() + "]");
			}
		}

		try {
			output(new FileOutputStream(file), workbook);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			logger.info("将Excel输出到指定file发送异常，文件不存在。");
		}

	}

	/**
	 * 将工作簿输出到指定OutputStream中。
	 * 
	 * @param output
	 * @param workbook
	 */
	public void output(OutputStream output, HSSFWorkbook workbook) {
		try {
			workbook.write(output);
			output.flush();
			output.close();
		} catch (IOException e) {
			e.printStackTrace();
			logger.info("将Excel输出到指定OutputStream中发送异常。");
		}
	}

	/**
	 * 将工作簿输出到HttpServletResponse。
	 * 
	 * @param response
	 * @param workbook
	 */
	public void output(HttpServletResponse response, HSSFWorkbook workbook) {
		OutputStream output = null;
		try {
			output = response.getOutputStream();
		} catch (IOException e1) {
			e1.printStackTrace();
			logger.info("获取HttpServletResponse的OutputStream发送异常。");
		}
		try {
			if (output != null) {
				workbook.write(output);
				output.flush();
				output.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
			logger.info("将Excel输出到指定OutputStream中发送异常。");
		}
	}

	/**
	 * Excel高级操作：将数据填充到指定模板的工作簿中，并输出到HttpServletResponse。
	 * @param response
	 * @param templateName
	 * @param title
	 * @param data
	 * @param x
	 * @param y
	 */
	public void jeeOperate(HttpServletResponse response, String templateName, String title, List<List<Object>> data, Integer x, Integer y) {
		
		HSSFWorkbook workbook = loadTemplate(templateName);
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		if (workbook == null) {
			workbook = new HSSFWorkbook();
			HSSFSheet sheet = workbook.createSheet();
			HSSFRow row = sheet.createRow(0);
			row.createCell(0);
			setCellValue(workbook, 0, 0, 0, "未找到指定模板！[templateName="
					+ templateName + "]");
		} else {
			
			if (title != null) {
				setCellValue(workbook, 0, 0, 0, title);
			}
		}

		build(workbook, data, x, y);
		
		String filename = templateName + ((title != null) ? "_" + title : "") +".xls";
		try {
			response.setHeader( "Content-Disposition", "attachment;filename=" + CommonUtil.toENCode(filename));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		response.setContentType("application/msexcel");
		try {
			response.flushBuffer();
		} catch (IOException e) {
			e.printStackTrace();
			logger.info("清空response缓存发生异常！");
		}
		
		output(response, workbook);		
	}
	/**
	 * 首页列表导出excel文件
	 * @author 李松
	 * 
	 */
	public void importWord(String[] strs,HttpServletResponse response) {
		
		 List list = new ArrayList();
		  if(strs != null)
		  {
			  for(String str:strs)
			     {
			    	if(!"".equals(str))
			    	{
			    		 String[] str2 = str.split(",");
				    	 List arr = new ArrayList();
				    	 for(String str1:str2)
				    	 {
				    		arr.add(str1); 
				    	 }
				    	 list.add(arr);
			    	}
			     }
		  }
		jeeOperate(response, "book1", null, list, 2, 2);
	}
	/**
	 * 首页预报校验导出excel文件
	 * @author 李松
	 * 
	 */
	public void importExcel(String[] strs,HttpServletResponse response) {
		
		 List list = new ArrayList();
		  if(strs != null)
		  {
			  for(String str:strs)
			     {
			    	if(!"".equals(str))
			    	{
			    		 String[] str2 = str.split(",");
				    	 List arr = new ArrayList();
				    	 for(String str1:str2)
				    	 {
				    		arr.add(str1); 
				    	 }
				    	 list.add(arr);
			    	}
			     }
		  }
		jeeOperate(response, "book1", null, list, 0, 1);
	}
	public void importExcel1(String title_name,String importName,String sheet_name,Map<Integer,String> map,HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		try {
			File file = new File(EXCEL_DIRECTORY.replaceAll("%20"," ")+importName+".xls");
			InputStream is = new FileInputStream(file);
			//查找文件位置
			HSSFWorkbook workbook = new HSSFWorkbook(is);
			workbook.setSheetName(0,sheet_name.toString());
			//创建一个工作表`
			HSSFSheet sheet =  workbook.getSheetAt(0);
			HSSFRow row = sheet.createRow((short)0);
			HSSFCell cell = row.createCell(0);
			HSSFCellStyle cellstyle = cell.getCellStyle();
			HSSFFont font = cellstyle.getFont(workbook);
			font.setFontHeight((short)240);
			cellstyle.setFont(font);
			cell.setCellStyle(cellstyle);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(title_name.toString());
			for(int i=0;i<map.size();i++){
				//创建一行
				row = sheet.createRow((short)i+1);
				String[] data = map.get(i).split(",");
				for(int n=0;n<data.length;n++){
					//创建一个单元格
					cell = row.createCell(n);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(data[n].toString());
				}
			}	
			response.setHeader( "Content-Disposition", "attachment;filename=excel.xls");
			response.setContentType("application/msexcel");
			response.flushBuffer();
			OutputStream os = response.getOutputStream();
			workbook.write(os);
			is.close();
			os.flush();
			os.close();
			System.out.println("导出成功");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public void importExcel2(String title_name,String importName,String sheet_name,Map<Integer,String> map,HttpServletResponse response){
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		try {
			File file = new File(EXCEL_DIRECTORY.replaceAll("%20"," ")+importName+".xls");
			InputStream is = new FileInputStream(file);
			//查找文件位置
			HSSFWorkbook workbook = new HSSFWorkbook(is);
			workbook.setSheetName(0,sheet_name.toString());
			//创建一个工作表`
			HSSFSheet sheet =  workbook.getSheetAt(0);
			HSSFRow row = sheet.createRow((short)0);
			HSSFCell cell = row.createCell(0);
			HSSFCellStyle cellstyle = cell.getCellStyle();
			HSSFFont font = cellstyle.getFont(workbook);
			font.setFontHeight((short)240);
			font.setBoldweight((short)100);
			cellstyle.setFont(font);
			cell.setCellStyle(cellstyle);
			cell.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell.setCellValue(title_name.toString());
			for(int i=0;i<map.size();i++){
				//创建一行
				row = sheet.createRow((short)i+3);
				String[] data = map.get(i).split(",");
				for(int n=0;n<data.length;n++){
					//创建一个单元格
				    cell = row.createCell(n);
					cell.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell.setCellValue(data[n].toString());
				}
			}	
			response.setHeader( "Content-Disposition", "attachment;filename=excel.xls");
			response.setContentType("application/msexcel");
			response.flushBuffer();
			OutputStream os = response.getOutputStream();
			workbook.write(os);
			is.close();
			os.flush();
			os.close();
			System.out.println("导出成功");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
