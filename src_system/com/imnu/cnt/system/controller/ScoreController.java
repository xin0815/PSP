package com.imnu.cnt.system.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.imnu.cnt.system.service.ScoreService;
import com.imnu.cnt.system.util.ExcelTransformHtml;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

@Controller
@RequestMapping("score")
public class ScoreController {
	@Autowired private ScoreService scoreService;
	@RequestMapping("list")
	public String list()
	{
		return "system/Score";
	}
	@RequestMapping("exportExcel")
	public void export(String stuNumber,HttpServletRequest request,HttpServletResponse response) throws ParsePropertyException, InvalidFormatException{

        String templateFileName= request.getSession().getServletContext().getRealPath("/excel/score.xls");
        String destFileName= "studentscore.xlsx";

        
        XLSTransformer transformer = new XLSTransformer();
        InputStream in=null;
        OutputStream out=null;
        response.setHeader("Content-Disposition", "attachment;filename=" + destFileName);

        response.setContentType("application/vnd.ms-excel");
        try {
            in=new BufferedInputStream(new FileInputStream(templateFileName));
            Workbook workbook=transformer.transformXLS(in, scoreService.exportExcel(stuNumber));
            out=response.getOutputStream();
            //将内容写入输出流并把缓存的内容全部发出去
            workbook.write(out);
            
            out.flush();
        } 
        catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (in!=null){try {in.close();} catch (IOException e) {}}
            if (out!=null){try {out.close();} catch (IOException e) {}}
        }
    }
	@RequestMapping("excel2html")
	public void excel2html(String stuNumber,HttpServletRequest request,HttpServletResponse response) throws Exception{
		String templateFileName= request.getSession().getServletContext().getRealPath("/excel/score.xls");
        XLSTransformer transformer = new XLSTransformer();
        InputStream in=null;
        File file = null;
        OutputStream out= null;

        try {
        	file = File.createTempFile("test", "html");
            in=new BufferedInputStream(new FileInputStream(templateFileName));
            Workbook workbook=transformer.transformXLS(in, scoreService.exportExcel(stuNumber));
            //将内容写入输出流并把缓存的内容全部发出去
            out = new FileOutputStream(file);
            workbook.write(out);
            
            out.flush();
            String html = ExcelTransformHtml.getExcelInfo(file);
            response.getWriter().print(html);
        } 
        catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (in!=null){try {in.close();} catch (IOException e) {}}
            if (out!=null){try {out.close();} catch (IOException e) {}}
        }
	}
}
