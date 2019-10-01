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

		int nPage = 1;
		int bGno = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}

		BDao dao = BDao.getInstance();
		BPageInfo pinfo = dao.articlePage(nPage);
		request.setAttribute("page", pinfo);

		nPage = pinfo.getCurPage();

		HttpSession session = null;
		session = request.getSession();
		session.setAttribute("cpage", nPage);
		if (request.getParameter("bgno") != null) {
			String sGno = request.getParameter("bgno");
			bGno = Integer.parseInt(sGno);
			session.setAttribute("bgno", bGno);
		}
		ArrayList<BDto> dtos = dao.list(nPage, bGno);
		request.setAttribute("list", dtos);
	}
}