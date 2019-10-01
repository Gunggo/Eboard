package com.study.jsp.adminCommand;

import com.study.jsp.dao.ADao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ADelUserCommand implements ACommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        ADao manger = ADao.getInstance();
        manger.delUser(request.getParameter("userId"));
    }
}
