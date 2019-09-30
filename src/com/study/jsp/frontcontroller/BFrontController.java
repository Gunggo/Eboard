package com.study.jsp.frontcontroller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.jsp.command.*;

@WebServlet("*.bo")
public class BFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BFrontController() {
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

		HttpSession session = null;
		session = request.getSession();
		int curPage = 1;
		int bGno = 1;

		if(session.getAttribute("cpage") != null) {
			curPage = (int)session.getAttribute("cpage");
		}

		if (com.equals("/write_view.bo")) {
			viewPage = "write_view.jsp";
		} else if (com.equals("/write.bo")) {
			command = new BWriteCommand();
			command.execute(request, response);
			viewPage = "list.bo";
		} else if (com.equals("/list.bo")) {
			command = new BListCommand();
			command.execute(request, response);
			viewPage = "index.jsp";
		} else if (com.equals("/search.bo")) {
			command = new BSearchCommand();
			command.execute(request, response);
			viewPage = "index.jsp";
		} else if (com.equals("/content_view.bo")) {
			command = new BContentCommand();
			command.execute(request, response);
			viewPage = "content_view.jsp";
		} else if (com.equals("/modify_view.bo")) {
			command = new BContentCommand();
			command.execute(request, response);
			viewPage = "modify_view.jsp";
		} else if (com.equals("/modify.bo")) {
			command = new BModifyCommand();
			command.execute(request, response);

			command = new BContentCommand();
			command.execute(request, response);
			viewPage = "content_view.jsp";
		} else if (com.equals("/delete.bo")) {
			command = new BDeleteCommand();
			command.execute(request, response);
			viewPage = "list.bo?page="+curPage;
		} else if (com.equals("/reply_view.bo")) {
			command = new BReplyViewCommand();
			command.execute(request, response);
			viewPage = "reply_view.jsp";
		} else if (com.equals("/reply.bo")) {
			command = new BReplyCommand();
			command.execute(request, response);
			viewPage = "list.bo?page="+curPage;
		} else if (com.equals("/comment.bo")) {
			command = new BCommentCommand();
			command.execute(request, response);
		} else if (com.equals("/getReply.bo")) {
			command = new BGetReplyCommand();
			command.execute(request, response);
		} else if (com.equals("/delReply.bo")) {
			command = new BDelReplyCommand();
			command.execute(request, response);
		} else if (com.equals("/upReply.bo")) {
			command = new BUpReplyCommand();
			command.execute(request, response);
		}
		if (viewPage != null) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
			dispatcher.forward(request, response);
		}
	}
}