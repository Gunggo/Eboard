package com.study.jsp.boardCommand;

import com.study.jsp.dao.BDao;
import com.study.jsp.dto.BDto;
import com.study.jsp.dto.BPageInfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

public class BSearchCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) {

        int nPage = 1;
        String se = "";
        try {
            String sPage = request.getParameter("page");
            nPage = Integer.parseInt(sPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        se = request.getParameter("search");
        String keyWord = request.getParameter("keyWord");

        BDao dao = BDao.getInstance();
        BPageInfo pinfo = dao.searchPage(nPage, se, keyWord);
        System.out.println(pinfo);
        request.setAttribute("page", pinfo);

        nPage = pinfo.getCurPage();

        HttpSession session = null;
        session = request.getSession();
        session.setAttribute("cpage", nPage);

        ArrayList<BDto> dtos = dao.searchList(nPage, se, keyWord);
        request.setAttribute("list", dtos);
    }
}
