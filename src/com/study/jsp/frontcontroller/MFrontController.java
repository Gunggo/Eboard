package com.study.jsp.frontcontroller;

import com.study.jsp.boardCommand.BCommand;
import com.study.jsp.memberCommand.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("*.mo")
public class MFrontController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MFrontController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        actionDo(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        actionDo(request, response);
    }

    protected void actionDo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String viewPage = null;
        BCommand command = null;

        String uri = request.getRequestURI();
        String conPath = request.getContextPath();
        String com = uri.substring(conPath.length());

        if (com.equals("/loginOk.mo")) {
            command = new MLoginCommand();
            command.execute(request, response);
        } else if (com.equals("/joinOk.mo")) {
            command = new MJoinCommand();
            command.execute(request, response);
            viewPage = "login.jsp";
        } else if (com.equals("/modifyOk.mo")) {
            command = new MModifyCommand();
            command.execute(request, response);
            viewPage = "index.jsp";
        } else if (com.equals("/logout.mo")) {
            logout(request, response);
        } else if (com.equals("/snsLoginOk.mo")) {
            command = new MSnsLoginCommand();
            command.execute(request, response);
        } else if (com.equals("/delUser.mo")) {
            command = new MDelCommand();
            command.execute(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("UTF-8");

            response.setContentType("text/html; charset=UTF-8");
            HttpSession session = request.getSession();

            session.invalidate();
            response.sendRedirect("list.bo");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}