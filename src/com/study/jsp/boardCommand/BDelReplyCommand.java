package com.study.jsp.boardCommand;

import com.study.jsp.dao.BDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class BDelReplyCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        BDao manger = BDao.getInstance();
        manger.delReply(Integer.parseInt(request.getParameter("num")));
    }
}
