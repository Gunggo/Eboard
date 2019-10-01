package com.study.jsp.boardCommand;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class BDownloadCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String fileName = request.getParameter("fileName");
        String savePath = request.getSession().getServletContext().getRealPath("/upload");
        String filePath = savePath + "/" + fileName;

        try {
            File file = new File(filePath);
            byte b[] = new byte[(int) file.length()];

            response.reset();
            response.setContentType("application/octet-stream");

            String encoding = new String(fileName.getBytes("UTF-8"),"8859_1");

            response.setHeader("Content-Disposition", "attachment;filename="+encoding);
            response.setHeader("Content-Length", String.valueOf(file.length()));

            if (file.isFile()) {
                FileInputStream fileInputStream = new FileInputStream(file);
                ServletOutputStream servletOutputStream = response.getOutputStream();

                int readNum = 0;
                while ((readNum = fileInputStream.read(b)) != -1) {
                    servletOutputStream.write(b, 0, readNum);
                }
                servletOutputStream.close();
                fileInputStream.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
