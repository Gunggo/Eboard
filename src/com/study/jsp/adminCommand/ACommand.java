package com.study.jsp.adminCommand;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface ACommand {
    void execute(HttpServletRequest request, HttpServletResponse response) throws IOException;
}
