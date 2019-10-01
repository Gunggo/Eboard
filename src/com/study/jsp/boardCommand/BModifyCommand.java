package com.study.jsp.boardCommand;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.jsp.dao.BDao;

public class BModifyCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		String bName = (String)session.getAttribute("bName");
		String bId = request.getParameter("bId");
		String bTitle = request.getParameter("bTitle");
		String bContent = request.getParameter("bContent");

		BDao dao = new BDao();
		dao.modify(bId, bName, bTitle, bContent);
	}

}