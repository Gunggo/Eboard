package com.study.jsp.command;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.study.jsp.dao.MDao;
import com.study.jsp.dto.MDto;

public class modifyOk implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		try {
			request.setCharacterEncoding("UTF-8");
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			MDao dao = new MDao();
			MDto dto = dao.getMember(id);
			dto.setId(id);

			int ri = dao.updateMember(dto);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter writer = response.getWriter();

			if(ri == 1) {
				writer.println("<html><head></head><body>");
				writer.println("<script language=\"javascript\">");
				writer.println("	alert(\"정보가 수정되었습니다.\");");
				writer.println("	document.location.href=\'list.bo\';");
				writer.println("</script>");
				writer.println("<body></html>");
				writer.close();
			} else {
				writer.println("<html><head></head><body>");
				writer.println("<script language=\"javascript\">");
				writer.println("	alert(\"정보수정에 실패했습니다..\");");
				writer.println("	history.go(-1);");
				writer.println("</script>");
				writer.println("<body></html>");
				writer.close();
			}
		}  catch (IOException e) {
			e.printStackTrace();
		}
	}

}