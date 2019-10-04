package com.study.jsp.memberCommand;

import com.study.jsp.dao.MDao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class MDelCommand implements com.study.jsp.boardCommand.BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");

        MDao dao = new MDao();
        dao.delUser(id);
    }
}
