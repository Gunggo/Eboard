package com.study.jsp.boardCommand;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.jsp.dao.BDao;
import com.study.jsp.dto.BDto;
import com.study.jsp.dto.BPageInfo;

public class BListCommand implements BCommand{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = null;
		session = request.getSession();

		int nPage = 1;
		int bGno = 1;
		int check = 1;
		try {
			if (request.getParameter("page") != null) {
				String sPage = request.getParameter("page");
				nPage = Integer.parseInt(sPage);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (request.getParameter("bgno") != null) {
			String sGno = request.getParameter("bgno");
			bGno = Integer.parseInt(sGno);
			session.setAttribute("bgno", bGno);
		}

		BDao dao = BDao.getInstance();
		BPageInfo pinfo = dao.articlePage(nPage, bGno);
		request.setAttribute("page", pinfo);

		nPage = pinfo.getCurPage();

		session.setAttribute("cpage", nPage);
		ArrayList<BDto> dtos = dao.list(nPage, bGno, check);
		request.setAttribute("list", dtos);
		check = 2;
		ArrayList<BDto> dtost = dao.list(nPage, bGno, check);
		request.setAttribute("topList", dtost);
	}
}