package com.study.jsp.frontcontroller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.jsp.adminCommand.*;

@WebServlet("*.ao")
public class AFrontController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AFrontController() {
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
        ACommand command = null;

        String uri = request.getRequestURI();
        String conPath = request.getContextPath();
        String com = uri.substring(conPath.length());

        HttpSession session = null;
        session = request.getSession();

        if (com.equals("/checkUser.ao")) {
            command = new AUsercheckCommand();
            command.execute(request, response);
        } else if (com.equals("/delUser.ao")) {
            command = new ADelUserCommand();
            command.execute(request, response);
        } else if (com.equals("/blockUser.ao")) {
            command = new ABlkUserCommand();
            command.execute(request, response);
        }
    }
}