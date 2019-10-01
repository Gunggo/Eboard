package com.study.jsp.memberCommand;

import com.study.jsp.boardCommand.BCommand;
import com.study.jsp.dao.MDao;
import com.study.jsp.dto.MDto;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.Timestamp;

public class MSnsLoginCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");

            String id = request.getParameter("kakaoId");
            String name = request.getParameter("kakaoName");
            MDto dto = new MDto();
            MDao dao = new MDao();

            dto.setId(id);
            dto.setName(name);
            dto.setrDate(new Timestamp(System.currentTimeMillis()));

            dao.snsInsert(dto);

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();

            HttpSession session = request.getSession();

                session.setAttribute("id", id);
                session.setAttribute("name", name);
                session.setAttribute("ValidMem", "yes");
                session.setAttribute("snsLogin","yes");

                writer.println("<html><head></head><body>");
                writer.println("<script language=\"javascript\">");
                writer.println("	document.location.href=\'list.bo\';");
                writer.println("</script>");
                writer.println("<body></html>");
                writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
