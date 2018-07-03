package com.imnu.cnt.system.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Timestamp;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class download {

@RequestMapping("download")
public static void download(HttpServletRequest request, HttpServletResponse response) throws Exception {

	String fileName = "prove.docx";
	String filePath = request.getSession().getServletContext().getRealPath("/doc/prove.docx");
	System.out.println(filePath);
    //设置响应头和客户端保存文件名

    response.setCharacterEncoding("utf-8");

    response.setContentType("multipart/form-data");

    response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);

    //用于记录以完成的下载的数据量，单位是byte

    long downloadedLength = 0l;

    try {

        //打开本地文件流

        InputStream inputStream = new FileInputStream(filePath);

        //激活下载操作

        OutputStream os = response.getOutputStream();

 

        //循环写入输出流

        byte[] b = new byte[2048];

        int length;

        while ((length = inputStream.read(b)) > 0) {

            os.write(b, 0, length);

            downloadedLength += b.length;

        }

 

        // 这里主要关闭。

        os.close();

        inputStream.close();

    } catch (Exception e){
        throw e;

    }
    //存储记录*/

}

}
