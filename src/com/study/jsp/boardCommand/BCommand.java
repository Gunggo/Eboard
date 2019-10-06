package com.study.jsp.boardCommand;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface BCommand {
	void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;
}
