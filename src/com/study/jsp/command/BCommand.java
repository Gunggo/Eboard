package com.study.jsp.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

public interface BCommand {
	void execute(HttpServletRequest request, HttpServletResponse response) throws IOException;
}
