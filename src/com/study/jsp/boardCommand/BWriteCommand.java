package com.study.jsp.boardCommand;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.study.jsp.dao.BDao;

import java.io.IOException;

public class BWriteCommand implements BCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		MultipartRequest multi = null;
		int sizeLimit = 10* 1024* 1024;
		String bGno = "1";
		String savePath = request.getSession().getServletContext().getRealPath("/upload");

		try {
			multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8",
					new DefaultFileRenamePolicy());
		} catch (IOException e) {
			e.printStackTrace();
		}
		if (request.getParameter("bgno") != null) {
			bGno = multi.getParameter("bgno");
		}

		String filename = multi.getFilesystemName("filename");
		String bName = (String) session.getAttribute("name");
		if (filename == null) {
			filename = "";
		}
		String bTitle = multi.getParameter("bTitle");
		String bContent = multi.getParameter("bContent");
		BDao dao = new BDao();
		dao.write(bName, bTitle, bContent, filename, bGno);
	}
}