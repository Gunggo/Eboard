package com.study.jsp.command;

import com.study.jsp.dao.BDao;
import com.study.jsp.dto.BCmtDto;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class BUpReplyCommand implements BCommand {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        PrintWriter out = null;
        out = response.getWriter();
        BDao manger = BDao.getInstance();

        List<BCmtDto> list = manger.getReply(Integer.parseInt(request.getParameter("bNum")));

        String json = "{\"replyList\":[";
        for (int i = 0; i < list.size(); i++) {
            String id = list.get(i).getbName();
            String content = list.get(i).getbContent();
            Date date = list.get(i).getbDate();
            SimpleDateFormat df = new SimpleDateFormat("YYYY-MM-DD HH:MM");
            int reply_no = list.get(i).getcNum();

            json += "[{\"id\":\"" + id + "\"},";
            json += "{\"reply_date\":\"" + df.format(date) + "\"},";
            json += "{\"reply_content\":\"" + content + "\"},";
            json += "{\"reply_no\":\"" + reply_no + "\"}]";

            if (i != list.size() - 1) {
                json += ",";
            }
        }
        json += "]}";

        out.print(json);
    }
}
