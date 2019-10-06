package com.study.jsp.adminCommand;

import com.study.jsp.boardCommand.BCommand;
import com.study.jsp.dao.ADao;
import com.study.jsp.dto.BDto;
import com.study.jsp.dto.MDto;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class AkingCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String searchType = request.getParameter("searchType");
        String startDate = "";
        String endDate = "";

        if (request.getParameter("startDate") != null || request.getParameter("endDate") != null) {
            startDate = request.getParameter("startDate");
            endDate = request.getParameter("endDate");
        }

        PrintWriter out = null;
        out = response.getWriter();
        ADao manager = ADao.getInstance();

        List<MDto> list = manager.getActKing(searchType, startDate, endDate);

        String json = "{\"userList\":[";
        for (int i = 0; i < list.size(); i++) {
            String id = list.get(i).getId();
            String name = list.get(i).getName();
            String email = list.get(i).geteMail();
            Date rDate = list.get(i).getrDate();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA);
            int count = list.get(i).getCount();

            json += "[{\"userId\":\"" + id + "\"},";
            json += "{\"userName\":\"" + name + "\"},";
            json += "{\"userEmail\":\"" + email + "\"},";
            json += "{\"userRdate\":\"" + df.format(rDate) + "\"},";
            json += "{\"userCount\":\"" + count + "\"}]";

            if (i != list.size() - 1) {
                json += ",";
            }
        }
        json += "]}";

        out.print(json);
    }
}
