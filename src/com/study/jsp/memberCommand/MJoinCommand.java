package com.study.jsp.memberCommand;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.jsp.boardCommand.BCommand;
import com.study.jsp.dao.MDao;
import com.study.jsp.dto.MDto;

public class MJoinCommand implements BCommand {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) {

        try {
            request.setCharacterEncoding("UTF-8");
            String id = request.getParameter("id");
            String pw = request.getParameter("pw");
            String name = request.getParameter("name");
            String eMail = request.getParameter("eMail");
            String address = request.getParameter("address");
            pw += "*김밥천국";

            String toReturn = "";
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.reset();
            digest.update(pw.getBytes("utf8"));
            toReturn = String.format("%064x", new BigInteger(1, digest.digest()));
            pw = toReturn;

            MDao dao = new MDao();
            MDto dto = new MDto();

            dto.setId(id);
            dto.setPw(pw);
            dto.setName(name);
            dto.seteMail(eMail);
            dto.setAddress(address);
            dto.setrDate(new Timestamp(System.currentTimeMillis()));

            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();

            if (dao.confirmId(dto.getId()) == MDao.MEMBER_EXISTENT) {
                writer.println("<html><head></head><body>");
                writer.println("<script language=\"javascript\">");
                writer.println("	alert(\"아이디가 이미 존재 합니다.\");");
                writer.println("	history.back();");
                writer.println("</script>");
                writer.println("<body></html>");
                writer.close();
            } else {
                int ri = dao.insertMember(dto);
                if (ri == MDao.MEMBER_JOIN_SUCCESS) {
                    HttpSession session = request.getSession();
                    session.setAttribute("id", dto.getId());

                    writer.println("<html><head></head><body>");
                    writer.println("<script language=\"javascript\">");
                    writer.println("	alert(\"회원가입을 축하 합니다..\");");
                    writer.println("	document.location.href=\"login.jsp\";");
                    writer.println("</script>");
                    writer.println("<body></html>");
                    writer.close();
                } else {
                    writer.println("<html><head></head><body>");
                    writer.println("<script language=\"javascript\">");
                    writer.println("	alert(\"회원가입에 실패했습니다..\");");
                    writer.println("	document.location.href=\"login.jsp\");");
                    writer.println("</script>");
                    writer.println("<body></html>");
                    writer.close();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}