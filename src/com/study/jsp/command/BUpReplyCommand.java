package com.study.jsp.command;

import com.study.jsp.dao.BDao;
import com.study.jsp.dto.BCmtDto;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class BUpReplyCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        BDao manger = BDao.getInstance();
        String test = request.getParameter("num");
        int num = Integer.parseInt(request.getParameter("num"));
        String text = request.getParameter("text");

        System.out.println(num);
        System.out.println(text);

        manger.upReply(num, text);

    }
}
