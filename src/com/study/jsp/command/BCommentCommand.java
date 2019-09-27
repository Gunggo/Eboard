package com.study.jsp.command;

import com.study.jsp.dao.BDao;
import com.study.jsp.dto.BCmtDto;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;

public class BCommentCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");

        BCmtDto dto = new BCmtDto();
        dto.setbNum(Integer.parseInt(request.getParameter("no")));
        dto.setbName(request.getParameter("id"));
        dto.setbContent(request.getParameter("reply_content"));

        BDao manager = BDao.getInstance();
        manager.insertReply(dto);


    }
}
