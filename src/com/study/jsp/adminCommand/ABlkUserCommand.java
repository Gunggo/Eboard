package com.study.jsp.adminCommand;

import com.study.jsp.boardCommand.BCommand;
import com.study.jsp.dao.ADao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ABlkUserCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ADao manger = ADao.getInstance();
        String userId = request.getParameter("userId");
        String block = request.getParameter("block");
        manger.blkUser(userId, block);
    }
}
