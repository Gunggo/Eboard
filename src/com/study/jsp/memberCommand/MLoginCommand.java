package com.study.jsp.memberCommand;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.jsp.boardCommand.BCommand;
import com.study.jsp.dao.MDao;
import com.study.jsp.dto.MDto;


public class MLoginCommand implements BCommand {

    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) {
        try {

            request.setCharacterEncoding("UTF-8");

            String id = request.getParameter("id");
            String pw = request.getParameter("pw");
            String toReturn = "";
            pw += "*김밥천국";

            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.reset();
            digest.update(pw.getBytes("utf8"));
            toReturn = String.format("%064x", new BigInteger(1, digest.digest()));
            pw = toReturn;

            MDao dao = new MDao();
            int checkNum = dao.userCheck(id, pw);
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = response.getWriter();

            if (checkNum == -1) {
                writer.println("<html><head></head><body>");
                writer.println("<script language=\"javascript\">");
                writer.println("	alert(\"아이디가 존재하지 않습니다.\");");
                writer.println("	history.go(-1);");
                writer.println("</script>");
                writer.println("<body></html>");
                writer.close();
            }
            if (checkNum == 11) {
                writer.println("<html><head></head><body>");
                writer.println("<script language=\"javascript\">");
                writer.println("	alert(\"차단된 아이디입니다. 관리자에게 문의하세요.\");");
                writer.println("	history.go(-1);");
                writer.println("</script>");
                writer.println("<body></html>");
                writer.close();
            }
            HttpSession session = request.getSession();
            if (checkNum == 1) {
                MDto dto = dao.getMember(id);
                dto = dao.getMember(id);

                String name = dto.getName();
                session.setAttribute("id", id);
                session.setAttribute("name", name);
                session.setAttribute("ValidMem", "yes");

                writer.println("<html><head></head><body>");
                writer.println("<script language=\"javascript\">");
                writer.println("	document.location.href=\'list.bo\';");
                writer.println("</script>");
                writer.println("<body></html>");
                writer.close();
            } else if (checkNum == 0) {
                writer.println("<html><head></head><body>");
                writer.println("<script language=\"javascript\">");
                writer.println("	alert(\"비밀번호가 틀립니다..\");");
                writer.println("	history.go(-1);");
                writer.println("</script>");

                writer.println("<body></html>");
                writer.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getSHA256(String input) {

        String toReturn = null;
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            digest.reset();
            digest.update(input.getBytes("utf8"));
            toReturn = String.format("%064x", new BigInteger(1, digest.digest()));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return toReturn;
    }

}