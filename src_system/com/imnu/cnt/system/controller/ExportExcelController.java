package com.imnu.cnt.system.controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

@Controller
public class ExportExcelController {

    /**

     * 这里接管了response,我们自己把response flush出去,所以返回类型是void(不要用什么String,否则会报响应已提交过的异常哦)
     * @throws InvalidFormatException 
     * @throws ParsePropertyException 

     */
	@RequestMapping("/export")
    public void export(HttpServletRequest request,HttpServletResponse response) throws ParsePropertyException, InvalidFormatException{

        String templateFileName= request.getSession().getServletContext().getRealPath("/excel/score.xls");

        String destFileName= "studentscore.xls";

        //模拟数据

        /*List<Employee> staff = new ArrayList<Employee>();


        staff.add(new Employee());

        staff.add(new Employee());*/

        Map<String,Object> beans = new HashMap<String,Object>();

      //  beans.put("employees", staff);
        beans.put("employ", "内蒙古师范大学");

        XLSTransformer transformer = new XLSTransformer();

        InputStream in=null;

        OutputStream out=null;

        //设置响应

        response.setHeader("Content-Disposition", "attachment;filename=" + destFileName);

        response.setContentType("application/vnd.ms-excel");

        try {

            in=new BufferedInputStream(new FileInputStream(templateFileName));

            Workbook workbook=transformer.transformXLS(in, beans);

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

}