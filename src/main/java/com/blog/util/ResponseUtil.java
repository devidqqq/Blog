package com.blog.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class ResponseUtil {
	
	public static void write(HttpServletResponse response,Object o) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter write = response.getWriter();
		write.println(o.toString());
		write.flush();
		write.close();
	}
}


