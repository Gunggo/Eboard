package com.study.jsp.adminCommand;

import com.study.jsp.boardCommand.BCommand;
import com.study.jsp.dao.ADao;
import com.study.jsp.dao.MDao;
import com.study.jsp.dto.MDto;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

public class AUsercheckCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String keyword = "";
        String se = "";
        if (request.getParameter("keyWord") != null) {
            keyword = request.getParameter("keyWord");
        }
        if (request.getParameter("searchType") != null) {
            se = request.getParameter("searchType");
        }

        PrintWriter out = null;
        out = response.getWriter();
        ADao manger = ADao.getInstance();

        List<MDto> list = manger.getMember(keyword, se);

//        String id, String pw, String name, String eMail, Timestamp rDate, String address, int block
        String checkBk = "";
        String json = "{\"userList\":[";
        for (int i = 0; i < list.size(); i++) {
            String id = list.get(i).getId();
            String pw = list.get(i).getPw();
            String name = list.get(i).getName();
            String eMail = list.get(i).geteMail();
            Date rDate = list.get(i).getrDate();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.KOREA);
            String address = list.get(i).getAddress();
            int block = list.get(i).getBlock();
            if (block == 0) {
                checkBk = "X";
            } else {
                checkBk = "O";
            }

            json += "[{\"userId\":\"" + id + "\"},";
            json += "{\"userPw\":\"" + pw + "\"},";
            json += "{\"userName\":\"" + name + "\"},";
            json += "{\"userEmail\":\"" + eMail + "\"},";
            json += "{\"userRdate\":\"" + df.format(rDate) + "\"},";
            json += "{\"userAddress\":\"" + address + "\"},";
            json += "{\"userBlock\":\"" + checkBk + "\"}]";

            if (i != list.size() - 1) {
                json += ",";
            }
        }
        json += "]}";

        out.print(json);
    }
}
